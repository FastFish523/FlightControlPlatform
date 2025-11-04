/*--------------------------------------------------------------*/
/*		      			 FT-10弹上程序导航部分					*/
/*         		 			 2013-06-20        		    		*/
/*				 			  控制室   							*/
/*--------------------------------------------------------------*/
#include<stdio.h>
#include<math.h>
#include "GeneralVarFun.h"

void INIT_NAV()
{
	int ii;
	//--------------------------------------GeneralVars.c-------------------
	i_TransAlignment_COM=0;
	f_TimeSample=0.005;
	NaviFirstFlag=0;
	i_Tuochazhiling_COM=0;

 	//-------------------------------------------com_nav_m.cpp--------------
 		for (ii=0;ii<3;ii++)
 		{
 			d_Posi_M[ii]=0.;f_Vnc_M_COM[ii]=0.;f_Atti_M_COM[ii]=0.;
 		}
 		//------------------------------------------com_nav_s.cpp--------------	
 		f_Ax=0.0;f_Ay=0.0;f_Az=0.0;f_Wx=0.0;f_Wy=0.0;f_Wz=0.0;
 		for (ii=0;ii<3;ii++)
 		{
 			d_Posi_COM[ii]=0.;f_Vnc_COM[ii]=0.;f_Atti_COM[ii]=0.;
 			d_Posi_KF_COM[ii]=0.;f_Vnc_KF_COM[ii]=0.;f_Fn_KF_COM[ii]=0.;
 		}
 		i_InitialAlign=0;
 	
 		i_1ppsReceived=0;
 	
 		d_Gps_Long=0.0;d_Gps_Lat=0.0;
 		f_Gps_Alt=0.0;f_Gps_Ve=0.0;f_Gps_Vn=0.0;f_Gps_Vu=0.0;f_GpsPdop=0.0;
 		i_GpsStarNumber=0;
 		i_NaviMode=0;
 		d_EarthR_M=0.0;d_EarthR_N=0.0;f_H=0.0;
 		
 		
 		//卡尔曼反馈需要的变量
 		i_Flag_KFAngleBack=0;
 		i_Flag_KFNormal=0;
 		i_Count_WithoutNumber=0;
 		
 		//判断GPS野值需要的变量
 		i_EnaberComNavSign=0;
 		f_old_Gps_Ve=0.0;
 		f_old_Gps_Vn=0.0;
 		f_old_Gps_Vu=0.0;
 		i_old_GpsStarNumber=0;
 		f_old_GpsPdop=200.0;
 		f_old_Gps_Lon=0.0;
 		f_old_Gps_Lat=0.0;
 	    f_old_Gps_Alt=0.0;
 		i_old_NaviMode=0;
 	
 		//20070409 GPS杆臂补偿
 		for (ii=0;ii<3;ii++)
 		{
 		f_Vn_pole_COM[ii]=0;f_Vn_pole_KF_COM[ii]=0;
 		f_Rn_pole_COM[ii]=0;f_Rn_pole_KF_COM[ii]=0;
 		}
 		f_Rx_gf_COM=0.0;f_Ry_gf_COM=0.0;f_Rz_gf_COM=0.0;
 		f_Rx_td_COM=0.0;f_Ry_td_COM=0.587;f_Rz_td_COM=0.0;
 	
 		//-------------------GPS延迟置换需要的变量-----------
 		i_Counter_Begin=0;
 		i_Delay_Counter=0;
 		f_dVx_Sum = 0.0;f_dVy_Sum = 0.0;f_dVz_Sum = 0.0;		
 		f_dPosix_Sum = 0.0;f_dPosiy_Sum = 0.0;f_dPosiz_Sum = 0.0;
 		
 		//------------------------com_filter.cpp--------------
 		i_KF_Init_Flag_COM=0;
 		i_KF_FeedBackTime_COM=1;
 		i_KF_Run_Time=0; 
 		f_KF_Periods=1.0;	 
 		f_KF_Phix_COM=0.0;f_KF_Phiy_COM=0.0;f_KF_Phiz_COM=0.0;
 	    f_GpsgetHead_V_Limit=3.0;
 		
 		
 		//--------------------自对准------------------
 		i_first_pvgh=0;
 		i_Init_Nav = 0;
 		f_sinsg=9.80125;
 		main_imu_intia_inject = 0; 
 		for (ii=0;ii<9;ii++)
 		{
 			f_KF_Xk_COM[ii]=0;
 		}
 		for (ii=0;ii<6;ii++)
 		{
 			f_sumtmp[ii]=0;f_init_GA_out[ii]=0;
 		}
 		
 		i_initk2 = 0;
 		i_initk = 0; 
 	
 		Imu_Error_count = 0;
 		Imu_Error_Flag = 0;
 		
 		i_Count_NaviFault=0;

		memset(&pGpsDataTmp,0,sizeof(pGpsDataTmp));
		memset(&pImudataTmp,0,sizeof(pImudataTmp));
}
/*
*函数介绍： NAVIGATION(...) 为导航程序主函数
*输入参数：
			unsigned char   *PlDataUpdate,			//母惯导信息标志
			unsigned char *pBombSeverFlag,			//脱插分离标志
            unsigned int	*pNaviEstimateFlag,		//组合导航评估命令
			NAVI_IMU 		*pIMUData,				//子惯导陀螺加表信息
			float			gyro_offset[3],			//陀螺零位
			NAVI_GPS 		*pGpsData,              //GPS信息
			unsigned int  *pGpsPpsArrivedFlag ,		//收到GPS秒脉冲的标志
			unsigned int  *pGpsDataReceivedFlag,	//收到GPS数据的标志
			SELFAIM_PARA	*pMainIMUData,         	//主惯导参数
			unsigned char	*InitNaviModeFlag); 	//初始化导航模式
			 		     

输出参数:
			NAVI_INS 		*pNaviData,             //导航结果输出
			NAVI_MIDRST	*pNaviMidRst,				//导航中间结果输出
			unsigned int 	*pComNaviStateFlag,		//组合导航状态标志				  
返回值：　　无				  				
*/
void NAVIGATION(unsigned char   *PlDataUpdate,		 	//载机数据更新标志
				unsigned char   *pBombSeverFlag,		//脱插分离标志
                unsigned int   	*pNaviEstimateFlag,		//组合导航评估命令
				nNAVI_IMU 		*pIMUData,			    //子惯导陀螺加表信息
				float			gyro_offset[3],			//陀螺零位
				nNAVI_GPS 		*pGpsData,            	//GPS信息
				unsigned int  	*pGpsPpsArrivedFlag ,   //收到GPS秒脉冲的标志
				unsigned int  	*pGpsDataReceivedFlag,  //收到GPS数据的标志
				nSELFAIM_PARA	*pMainIMUData,    		//主惯导参数
				nNAVI_INS 		*pNaviData,          	//导航结果输出
				nNAVI_MIDRST 	*pNaviMidRst,	      	//组合导航中间结果输出
				unsigned int   	*pComNaviStateFlag,  	//组合导航状态标志
                unsigned char   *InitNaviModeFlag)   	//初始化模式
{    
     static float T10s=0;
     
     if((fabs(pIMUData->ax)>150.0)||(fabs(pIMUData->ay)>150.0)||
       (fabs(pIMUData->az)>150.0)||(fabs(pIMUData->wx)>400.0/57.3)||
       (fabs(pIMUData->wy)>400.0/57.3)||(fabs(pIMUData->wz)>400.0/57.3))
     	{
         	Imu_Error_count++;
         	if(Imu_Error_count == 3)
         	{
           		NaviFirstFlag = 2;
         	}
         	if(Imu_Error_Flag == 0)
         	{
         		pImudataTmp.ax=0.0;
         		pImudataTmp.ay=0.0;
         		pImudataTmp.az=9.8;
         		pImudataTmp.wx=0.0;
         		pImudataTmp.wy=0.0;
         	    pImudataTmp.wz=0.0;   //上电第一桢数据出错将 IMUDATA 赋 0
         		Imu_Error_Flag = 1;
         	}
         	if(Imu_Error_Flag == 1)
         	{
         	  pIMUData->ax = pImudataTmp.ax;
         		pIMUData->ay = pImudataTmp.ay;
         		pIMUData->az = pImudataTmp.az;
         		pIMUData->wx = pImudataTmp.wx;
         		pIMUData->wy = pImudataTmp.wy;
         		pIMUData->wz = pImudataTmp.wz;   //将上一桢数据赋给IMUDATA
         	}

     	}  
     else
     {
         Imu_Error_count = 0;
         Imu_Error_Flag = 1;
         pImudataTmp.ax				  =  pIMUData->ax;
		 pImudataTmp.ay				  =  pIMUData->ay; 
		 pImudataTmp.az				  =  pIMUData->az; 
		 pImudataTmp.wx				  =  pIMUData->wx;
		 pImudataTmp.wy				  =  pIMUData->wy;
		 pImudataTmp.wz				  =  pIMUData->wz;		
    	 pImudataTmp.XGyroTemp        =  pIMUData->XGyroTemp;	//将这一时刻的IMU数据保存
     }            

	if(i_Init_Nav == 0)
	{
		i_TransAlignment_COM = 0;   //初始化状态标志
		i_InitialAlign = 0;			//初始化状态标志 之　初始对准标志
		i_KF_Init_Flag_COM = 0;		//初始化状态标志
		i_first_pvgh = 0;
		main_imu_intia_inject = 0;
		
		
		*pGpsPpsArrivedFlag  = 0;     //收到GPS秒脉冲标志清零
		*pGpsDataReceivedFlag = 0;   //收到GPS数据标志清零
		i_1ppsReceived = 0;	//  收到秒脉冲内部标志
		i_KF_Run_Time = 0;	//  Kalman闭环补偿计数器
		
		*pComNaviStateFlag = 0;
	
		//-------------------GPS延迟置换需要的变量-----------
		i_Counter_Begin = 0;
		i_Delay_Counter = 0;

	
		f_dVx_Sum = 0.0;
		f_dVy_Sum = 0.0;
		f_dVz_Sum = 0.0;
		
		f_dPosix_Sum = 0.0;
		f_dPosiy_Sum = 0.0;
		f_dPosiz_Sum = 0.0;

		i_Init_Nav = 5;
	}
				
	if(i_TransAlignment_COM == 0)
	{
		INITIA_AIM(PlDataUpdate,&pImudataTmp,gyro_offset, pMainIMUData,pGpsData,InitNaviModeFlag, pComNaviStateFlag);           //进行初始对准   		
	}

	if(i_TransAlignment_COM == 1)  ///自对准完成标志
	{
		i_Tuochazhiling_COM = *pBombSeverFlag;
		
		T10s=T10s+0.005; 
		
		NAV_COM(	&pImudataTmp,
					pGpsData,
					pGpsPpsArrivedFlag ,
					pGpsDataReceivedFlag,				  
					pNaviData,
					pBombSeverFlag,
					pNaviEstimateFlag,
					pComNaviStateFlag);
	}

	if(*PlDataUpdate == 1)
	{
		*PlDataUpdate = 0;
		//*******************************************
		//											*
		//       在此添加处理母惯导数据的代码		*
		//											*
		//*******************************************
	}
	
	//导航中间结果输出

	pNaviMidRst->Phix = f_KF_Phix_COM;	
	pNaviMidRst->Phiy = f_KF_Phiy_COM;	
	pNaviMidRst->Phiz = f_KF_Phiz_COM;	
	pNaviMidRst->P11 = com_Pk[0][0];
	pNaviMidRst->P22 = com_Pk[1][1];				
	pNaviMidRst->P33 = com_Pk[2][2];	
	pNaviMidRst->P44 = com_Pk[3][3];				
	pNaviMidRst->P55 = com_Pk[4][4];	
	pNaviMidRst->P66 = com_Pk[5][5];
	
	if(T10s<10.0)
	{				

		pNaviMidRst->P77 = f_init_GA_out[3];	
		pNaviMidRst->P88 = f_init_GA_out[4];				
		pNaviMidRst->P99 = f_init_GA_out[5];
	}
	else
	{	
		T10s=20.0;					
		pNaviMidRst->P77 = com_Pk[6][6];	
		pNaviMidRst->P88 = com_Pk[7][7];				
		pNaviMidRst->P99 = com_Pk[8][8];
	}
		
		pIMUData->wx -=  f_init_GA_out[3];
		pIMUData->wy -=  f_init_GA_out[4];
		pIMUData->wz -=  f_init_GA_out[5];
		
}
