#include<math.h>
#include<stdio.h>
#include "GeneralVarFun.h"

#define	AIM_TIME_MAX		(10*200)
#define	POS_ERR_TH			200.0
#define	VEL_ERR_TH			5.0
#define	ATTI_ERR_TH			15.0
#define PI 3.14159265358979323

/*
*函数介绍：
	INITIA_AIM(...) 组合导航卡尔曼滤波器函数
*输入参数：
	PlDataUpdate		主惯导数据更新标志
	pImuData			IMU数据
	pMainIMUData    	主惯导参数
	pGpsData_M			机上GPS信息
	InitNaviModeFlag	初始化导航模式
	pComNaviStateFlag	导航状态标志
*输出参数：
	f_Atti_COM			自对准姿态角(全局变量)
	d_Posi_M			初始位置
	f_Vnc_COM			初始速度
*返回值：
	无	
*/
void INITIA_AIM(unsigned char *PlDataUpdate,nNAVI_IMU *pImuData,float gyro_offset[3], nSELFAIM_PARA *pMainIMUData, nNAVI_GPS *pGpsData_M, unsigned char *InitNaviModeFlag, unsigned int *pComNaviStateFlag)        // 自对准初始参数
{

	int k;
	float 	imu_data[6]={0.0,0.0,0.0,0.0,0.0,0.0};

	static unsigned short	AimTime = 0;		//对准计时,单位:5ms
	static unsigned short	DataCheckCont = 0;	//数据有效性检查计数
	static unsigned short	AttiCheckCont = 0;	//姿态有效性检查计数

	float	PosErr = 0.;						//母惯导与GPS 位置 误差
	float	PosErrENU[3] = {0.,0.,0.};			//母惯导与GPS 东北天位置 误差
	
	float	VelErr = 0.;						//母惯导与GPS 速度 误差
	float	VelErrENU[3] = {0.,0.,0.};			//母惯导与GPS 东北天速度 误差

	static	float	PreAtti[3] = {0.,0.,0.};	//保存上一帧母惯导数据
	float	AttiErr[3] = {0.,0.,0.};			//母惯导连续两帧 姿态相对误差量
	
	AimTime++;
	if(AimTime>AIM_TIME_MAX)
		AimTime = AIM_TIME_MAX;
		
	d_Posi_M[0] = pMainIMUData->Longitude;
	d_Posi_M[1] = pMainIMUData->Latitude;
	d_Posi_M[2] = pMainIMUData->Altitude;

	f_Vnc_M_COM[0] = pMainIMUData->Ve;      
	f_Vnc_M_COM[1] = pMainIMUData->Vn;     
	f_Vnc_M_COM[2] = pMainIMUData->Vu;
     
	f_Atti_M_COM[0] = pMainIMUData->Pitch;
	f_Atti_M_COM[1] = pMainIMUData->Roll;
	f_Atti_M_COM[2] = pMainIMUData->Yaw;
	
	f_Rx_gf_COM = pMainIMUData->pole_X;
	f_Ry_gf_COM = pMainIMUData->pole_Y;
	f_Rz_gf_COM = pMainIMUData->pole_Z;
	
	
	if(i_InitialAlign == 0)
	{
		if(*InitNaviModeFlag=='D')
		{
		
			if(*PlDataUpdate == 0)
				return;
			
			if(i_first_pvgh == 0)
			{
				d_Posi_COM[0] = d_Posi_M[0];	//116.497878*DEGTORAD;
				d_Posi_COM[1] = d_Posi_M[1];	//39.743071*DEGTORAD;
				d_Posi_COM[2] = d_Posi_M[2];	//60.0;
				
				f_Vnc_COM[0] = f_Vnc_M_COM[0];      
				f_Vnc_COM[1] = f_Vnc_M_COM[1];      
				f_Vnc_COM[2] = f_Vnc_M_COM[2];
				
				f_Atti_COM[0] = f_Atti_M_COM[0];
				f_Atti_COM[1] = f_Atti_M_COM[1];		
				f_Atti_COM[2] = f_Atti_M_COM[2];     //航向角采用外置
					
				i_first_pvgh = 1;
			}
			
			INITIA_CBN();
			i_InitialAlign = 1;			
									
		}

		if(*InitNaviModeFlag=='K')
		{
		
			if(AimTime == AIM_TIME_MAX)		//对准时间超时
				*pComNaviStateFlag = 2;
				
			if(*PlDataUpdate == 0)
				return;
			
			if(i_first_pvgh == 0)
			{
				if( 	(fabs(d_Posi_M[0])<180.0*DEGTORAD)	//母惯导 位置、速度检查
					&& 	(fabs(d_Posi_M[1])<90.0*DEGTORAD)
               		&&	(d_Posi_M[2]>-2000.0)
               		&& 	(d_Posi_M[2]<40000.0)
               		&&	(fabs(f_Vnc_M_COM[0])<1000.0)
               		&& 	(fabs(f_Vnc_M_COM[1])<1000.0)
               		&& 	(fabs(f_Vnc_M_COM[2])<1000.0)
					&&	(pGpsData_M->Visible_Star>4) 		//GPS数据检查
					&&	(pGpsData_M->Visible_Star<13)
					&& 	(pGpsData_M->pdop<120.0) 
					&& 	(pGpsData_M->pdop>=0.0)
					&& 	((pGpsData_M->NaviMode & 0x0f) == 0x0f))
           		{
					PosErrENU[0] = (d_Posi_M[0] - pGpsData_M->Longitude)*cos(d_Posi_M[1])*(EARTHR+d_Posi_M[2]);
					PosErrENU[1] = (d_Posi_M[1] - pGpsData_M->Latitude)*(EARTHR+d_Posi_M[2]);
					PosErrENU[2] = (d_Posi_M[2] - pGpsData_M->Altitude);
					
					VelErrENU[0] = f_Vnc_M_COM[0] - pGpsData_M->Ve;
					VelErrENU[1] = f_Vnc_M_COM[1] - pGpsData_M->Vn;
					VelErrENU[2] = f_Vnc_M_COM[2] - pGpsData_M->Vu;

					PosErr = sqrt(PosErrENU[0]*PosErrENU[0]+PosErrENU[1]*PosErrENU[1]+PosErrENU[2]*PosErrENU[2]);
					VelErr = sqrt(VelErrENU[0]*VelErrENU[0]+VelErrENU[1]*VelErrENU[1]+VelErrENU[2]*VelErrENU[2]);
					
					if(		(fabs(f_Atti_M_COM[0]))<(90*DEGTORAD)	//母惯导 姿态 检查
						&&	(fabs(f_Atti_M_COM[1]))<(180*DEGTORAD)
						&&	f_Atti_M_COM[2]>((-1e-5)*DEGTORAD)
						&&	f_Atti_M_COM[2]<(361.0*DEGTORAD))
					{
						AttiCheckCont++;

						AttiErr[0] = fabs(f_Atti_M_COM[0]-PreAtti[0]);
						AttiErr[1] = fabs(f_Atti_M_COM[1]-PreAtti[1]);
						AttiErr[2] = fabs(f_Atti_M_COM[2]-PreAtti[2]);

						if(	AttiCheckCont>1)
						{
							if(		AttiErr[0]>(ATTI_ERR_TH*DEGTORAD)
								||	(AttiErr[1]>(ATTI_ERR_TH*DEGTORAD) && AttiErr[1]<((360-ATTI_ERR_TH)*DEGTORAD))
								||	(AttiErr[2]>(ATTI_ERR_TH*DEGTORAD) && AttiErr[2]<((360-ATTI_ERR_TH)*DEGTORAD)))
							{
								AttiCheckCont = 0;
							}
						}
						
					}
					else
					{
						AttiCheckCont = 0;
					}

					PreAtti[0] = f_Atti_M_COM[0];
					PreAtti[1] = f_Atti_M_COM[1];
					PreAtti[2] = f_Atti_M_COM[2];
					
					if(PosErr<POS_ERR_TH && VelErr<VEL_ERR_TH)
					{
						DataCheckCont++;
						if(DataCheckCont<3)
						{
							return;
						}
					}
					else
					{
						DataCheckCont = 0;
						AttiCheckCont = 0;
						return;
					}
					
           		}
           		else
       			{
					DataCheckCont = 0;
					AttiCheckCont = 0;
					return;
				}

				d_Posi_COM[0] = d_Posi_M[0];	//位置、速度初始化
				d_Posi_COM[1] = d_Posi_M[1];
				d_Posi_COM[2] = d_Posi_M[2];
				
				f_Vnc_COM[0] = f_Vnc_M_COM[0];      
				f_Vnc_COM[1] = f_Vnc_M_COM[1];      
				f_Vnc_COM[2] = f_Vnc_M_COM[2];

				if(AttiCheckCont<3)
				{
					f_Atti_M_COM[0] = 5.0*DEGTORAD;
					f_Atti_M_COM[1] = 0.0*DEGTORAD;
					f_Atti_M_COM[2] = atan(-f_Vnc_COM[0]/f_Vnc_COM[1]);
					
					if((f_Vnc_COM[0] >0.0) && (f_Vnc_COM[1] > 0.0))
						f_Atti_M_COM[2] += 2.0*PI;
					else if(f_Vnc_COM[1] < 0.0)
						f_Atti_M_COM[2] += PI;
				}
				
				f_Atti_COM[0] = f_Atti_M_COM[0];	//姿态初始化
				f_Atti_COM[1] = f_Atti_M_COM[1];		
				f_Atti_COM[2] = f_Atti_M_COM[2];
					
				i_first_pvgh = 1;
			}
			
			INITIA_CBN();

			if(fabs(gyro_offset[0])<0.0174532 && fabs(gyro_offset[1])<0.0174532 && fabs(gyro_offset[2])<0.0174532 )
			{
				f_init_GA_out[3] = gyro_offset[0];	// 外部装订x轴零位
				f_init_GA_out[4] = gyro_offset[1];	// 外部装订y轴零位
				f_init_GA_out[5] = gyro_offset[2];	// 外部装订z轴零位
			}
			
			i_InitialAlign = 1;			
									
		}

		if(*InitNaviModeFlag=='Z')			//自对准
		{

			if(i_first_pvgh == 0 && main_imu_intia_inject == 0 && *PlDataUpdate == 1)
			{
				d_Posi_COM[0] = d_Posi_M[0];	//116.497878*DEGTORAD;
				d_Posi_COM[1] = d_Posi_M[1];	//39.743071*DEGTORAD;
				d_Posi_COM[2] = d_Posi_M[2];	//60.0;
				
				f_Vnc_COM[0] = f_Vnc_M_COM[0];      
				f_Vnc_COM[1] = f_Vnc_M_COM[1];      
				f_Vnc_COM[2] = f_Vnc_M_COM[2];
				
				f_Atti_COM[0] = f_Atti_M_COM[0];
				f_Atti_COM[1] = f_Atti_M_COM[1];		
				f_Atti_COM[2] = f_Atti_M_COM[2];     //航向角采用外置

				main_imu_intia_inject = 1;
						
			}	
			
			if((pGpsData_M->Visible_Star>4) &&(pGpsData_M->Visible_Star<13)
			&& (pGpsData_M->pdop<120.0) && (pGpsData_M->pdop>=0.0)
			&& ((pGpsData_M->NaviMode & 0x0f) == 0x0f))
			{//为地面装订初始位置数据，20101119
				
					d_Posi_COM[0] = pGpsData_M->Longitude;
					d_Posi_COM[1] = pGpsData_M->Latitude;
					d_Posi_COM[2] = pGpsData_M->Altitude;
					
				
					f_Vnc_COM[0] = 0.0;       //飞机静止时速度为0.0
					f_Vnc_COM[1] = 0.0;      
					f_Vnc_COM[2] = 0.0;	
					
					i_first_pvgh =1;
			}
			
		
			imu_data[0]=pImuData->ax;   
			imu_data[1]=pImuData->ay;
			imu_data[2]=pImuData->az;
	
			imu_data[3]=pImuData->wx;   
			imu_data[4]=pImuData->wy;
			imu_data[5]=pImuData->wz;   
				
			i_initk2+=1;
				
			if( (i_initk2*f_TimeSample)<THROWING_TIME)   return;
				
			i_initk+=1;
			for(k=0;k<6;k++)    f_sumtmp[k]+=imu_data[k];
				
			if( (i_initk*f_TimeSample)<ALIGNMENT_TIME)   return;
				
			for(k=0;k<6;k++)   
			{
			   f_init_GA_out[k]=f_sumtmp[k]/i_initk;

			} 
			
			if(fabs(gyro_offset[0])<0.0174532 && fabs(gyro_offset[1])<0.0174532 && fabs(gyro_offset[2])<0.0174532 )
			{
				f_init_GA_out[3] = gyro_offset[0];	// 外部装订x轴零位
				f_init_GA_out[4] = gyro_offset[1];	// 外部装订y轴零位
				f_init_GA_out[5] = gyro_offset[2];	// 外部装订z轴零位
			}

			
			if((sqrt(f_init_GA_out[0]*f_init_GA_out[0]+
			          f_init_GA_out[1]*f_init_GA_out[1]+
			           f_init_GA_out[2]*f_init_GA_out[2])<5.0)
			   ||(sqrt(f_init_GA_out[0]*f_init_GA_out[0]+
			            f_init_GA_out[1]*f_init_GA_out[1]+
			             f_init_GA_out[2]*f_init_GA_out[2])>15.0))
			   			{
			   			 NaviFirstFlag = 2;  //如果加表输出大于15m/s小于5m/s组合导航上报异常
			   			}
			if(fabs(f_init_GA_out[3])>1.0*DEGTORAD||
			   fabs(f_init_GA_out[4])>1.0*DEGTORAD||
			   fabs(f_init_GA_out[5])>1.0*DEGTORAD)
			   {
			   	 NaviFirstFlag = 2;     //如果陀螺零位大于1deg/s组合导航上报异常
			   }
			
			
			
			f_sinsg=SINSG0*EARTHR*EARTHR/(EARTHR+d_Posi_COM[2])/(EARTHR+d_Posi_COM[2]);
						
			f_Atti_COM[0]=atan2(f_init_GA_out[1],sqrt(f_init_GA_out[0]*f_init_GA_out[0]+f_init_GA_out[2]*f_init_GA_out[2]));
			f_Atti_COM[1]=atan2(-f_init_GA_out[0],f_init_GA_out[2]);
	
			for(k=0;k<6;k++)  f_sumtmp[k]=0.0;
							
			INITIA_CBN();
			i_initk2=0;
			i_initk=0;
					
			i_InitialAlign = 1;

		
		}
					
	}    	
  	  			
	if( (fabs(f_Atti_COM[0] - f_Atti_M_COM[0]) < 45.0*DEGTORAD) )
	{
	
	*pComNaviStateFlag =1;
	
	}

 	 if((fabs(f_Atti_COM[1] - f_Atti_M_COM[1]) < 45.0*DEGTORAD) )
	 {
	 
	 	*pComNaviStateFlag =1;
	 
	 }
  	  if((f_Atti_COM[2]<361.0*DEGTORAD)&&(f_Atti_COM[2]>(-1e-9)*DEGTORAD) )
	   {
	
			*pComNaviStateFlag =1;
	
		}



	//自对准判断：水平姿态小于45deg  航向介于0-360  杆臂小于15m
  	if(   (fabs(f_Atti_COM[0] - f_Atti_M_COM[0]) < 45.0*DEGTORAD)
 	   && (fabs(f_Atti_COM[1] - f_Atti_M_COM[1]) < 45.0*DEGTORAD)  
  	   && (f_Atti_COM[2]<361.0*DEGTORAD)&&(f_Atti_COM[2]>(-1e-3)*DEGTORAD)
  	   && (fabs(f_Rx_gf_COM)<15.0)&& (fabs(f_Ry_gf_COM)<15.0)
  	   && (fabs(f_Rz_gf_COM)<15.0)    )
    {
 	   *pComNaviStateFlag =1;
    }
    
    else
    {
       i_initk2 = 0.0;
       i_initk = 0.0; 
 	   NaviFirstFlag = 2;       
    }
    
 		
    if(NaviFirstFlag == 2)
    {
       *pComNaviStateFlag = 2;  ///上报组合导航异常
    }
    
 	i_TransAlignment_COM = 1;    		
  	return;		

}
     
/*
*函数介绍：
	INITIA_CBN(...) 初始化姿态阵函数
*输入参数：
	f_Atti_COM			姿态角(全局变量)
*输出参数：
	f_Qu_COM			姿态四元数(全局变量)
	f_Cbn_COM			姿态矩阵
*返回值：
	无	
*/     
void INITIA_CBN(void)
{
  	double  sa[3] = {0.0, 0.0, 0.0}, ca[3] = {0.0, 0.0, 0.0};
  	int k = 0;
  
	for(k=0;k<3;k++)
  	{ 
  		sa[k]=sin(f_Atti_COM[k]/2.0);
       	ca[k]=cos(f_Atti_COM[k]/2.0);
    }

    f_Qu_COM[0]=ca[2]*ca[0]*ca[1]-sa[2]*sa[0]*sa[1];
  	f_Qu_COM[1]=ca[2]*sa[0]*ca[1]-sa[2]*ca[0]*sa[1];
  	f_Qu_COM[2]=ca[2]*ca[0]*sa[1]+sa[2]*sa[0]*ca[1];
  	f_Qu_COM[3]=ca[2]*sa[0]*sa[1]+sa[2]*ca[0]*ca[1];

	for(k=0;k<3;k++)
	{ 
		sa[k]=sin(f_Atti_COM[k]);
       	ca[k]=cos(f_Atti_COM[k]);
    }
    
  	f_Cbn_COM[0][0]=ca[1]*ca[2]-sa[1]*sa[0]*sa[2];
  	f_Cbn_COM[1][0]=ca[1]*sa[2]+sa[1]*sa[0]*ca[2];
  	f_Cbn_COM[2][0]=-sa[1]*ca[0];
  	f_Cbn_COM[0][1]=-ca[0]*sa[2];
  	f_Cbn_COM[1][1]=ca[0]*ca[2];
  	f_Cbn_COM[2][1]=sa[0];
  	f_Cbn_COM[0][2]=sa[1]*ca[2]+ca[1]*sa[0]*sa[2];
  	f_Cbn_COM[1][2]=sa[1]*sa[2]-ca[1]*sa[0]*ca[2];
  	f_Cbn_COM[2][2]=ca[1]*ca[0];

  	return;
}
     
     

