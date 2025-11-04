#include <math.h>
#include <stdio.h>
#include "GeneralVarFun.h"


#define PI 3.14159265358979323
/*
*函数介绍：
	NAV_COM(...) 组合导航函数
*输入参数：
	pImuData			IMU数据
	pGpsData_M			机上GPS信息
	GpsPpsArrivedFlag	GPS秒脉冲到标志
	GpsDataReceivedFlag	GPS数据收到标志
	pComNaviStateFlag	导航状态标志
	pBombSeverFlag		脱插分离标志
	*pNaviEstimateFlag  组合导航状态评估指令
	*pComNaviStateFlag  组合导航状态标志
*输出参数：
	pNaviData			导航结果
*返回值：
	无	
*/  

void NAV_COM( 		nNAVI_IMU 		*pIMUData,                    //惯组数据
				  	nNAVI_GPS 		*pGpsData,                   //GPS数据
					unsigned int 	*GpsPpsArrivedFlag,         //GPS脉冲到来标志位
					unsigned int   	*GpsDataReceivedFlag,       //GPS数据到来标志位
					nNAVI_INS 		*pNaviData,               //组合导航数据
					unsigned char   *pBombSeverFlag,       	// 脱插分离标志
					unsigned int    *pNaviEstimateFlag,     //组合导航评估指令
					unsigned int    *pComNaviStateFlag )    //组合导航状态标志位	
{
	
	float  f_Ddegree = 0.0, f_Cddeg = 0.0, f_Sddeg = 0.0;
	float  f_Fntemp[3] = {0.0,0.0,0.0}, f_Vntemp[3] = {0.0,0.0,0.0};
	double f_Positemp = 0.0;		
    float  f_Ts = 0.0;
    float  f_Sinsg = 0.0;
    int k=0;
	int i=0;
	
	float f_W_pole[3]={0.0,0.0,0.0};
	float f_Rx=0.0,f_Ry=0.0,f_Rz=0.0;			//位置杆臂参数
	
	
	f_Ts = f_TimeSample;                   
    
	f_Ax = pIMUData->ax;
	f_Ay = pIMUData->ay;
	f_Az = pIMUData->az;

	f_Wx = pIMUData->wx;
	f_Wy = pIMUData->wy;
	f_Wz = pIMUData->wz;

    if(i_InitialAlign == 1)  //初始对准完成标志
    {
    	    
		f_Fab[0] = f_Ax;
	    f_Fab[1] = f_Ay;
	    f_Fab[2] = f_Az; 
	    
	    f_Wibb[0] = f_Wx - f_init_GA_out[3];	
	    f_Wibb[1] = f_Wy - f_init_GA_out[4];	//扣除陀螺零位
	    f_Wibb[2] = f_Wz - f_init_GA_out[5];

//		f_Wibb[0] = f_Wx - 0.0;	
//	    f_Wibb[1] = f_Wy - 0.0;	//扣除陀螺零位
//	    f_Wibb[2] = f_Wz - 0.0;
	
		d_EarthR_M = EARTHR*(1-2*E+3*E*sin(d_Posi_COM[1])*sin(d_Posi_COM[1]));
		d_EarthR_N = EARTHR*(1+E*sin(d_Posi_COM[1])*sin(d_Posi_COM[1]));
		f_H = d_Posi_COM[2];
	
	   
	  	f_Winn[0] = -f_Vnc_COM[1]/(d_EarthR_M+f_H);
	   	f_Winn[1] = WIE*cos(d_Posi_COM[1])+f_Vnc_COM[0]/(d_EarthR_N+f_H);
	   	f_Winn[2] = WIE*sin(d_Posi_COM[1])+tan(d_Posi_COM[1])*f_Vnc_COM[0]/(d_EarthR_N+f_H);
	   	
	   	f_Winb_COM[0] = f_Cbn_COM[0][0]*f_Winn[0]+f_Cbn_COM[1][0]*f_Winn[1]+f_Cbn_COM[2][0]*f_Winn[2];
	   	f_Winb_COM[1] = f_Cbn_COM[0][1]*f_Winn[0]+f_Cbn_COM[1][1]*f_Winn[1]+f_Cbn_COM[2][1]*f_Winn[2];
	   	f_Winb_COM[2] = f_Cbn_COM[0][2]*f_Winn[0]+f_Cbn_COM[1][2]*f_Winn[1]+f_Cbn_COM[2][2]*f_Winn[2];
	
	   	for(k=0;k<3;k++)  
	   	{
	   		f_Wnbb_COM[k] = (f_Wibb[k]-f_Winb_COM[k])*f_Ts;  
		}
		
		f_Ddegree = f_Wnbb_COM[0]*f_Wnbb_COM[0]+f_Wnbb_COM[1]*f_Wnbb_COM[1]+f_Wnbb_COM[2]*f_Wnbb_COM[2];
	
		f_Cddeg = 1.0-f_Ddegree/8.0+f_Ddegree*f_Ddegree/384.0;
	   	f_Sddeg = 0.5-f_Ddegree/48.0+f_Ddegree*f_Ddegree/3840.0;
	
	   	f_Qb_COM[0] = f_Cddeg*f_Qu_COM[0]-f_Sddeg*(f_Wnbb_COM[0]*f_Qu_COM[1]+f_Wnbb_COM[1]*f_Qu_COM[2]+f_Wnbb_COM[2]*f_Qu_COM[3]);
	   	f_Qb_COM[1] = f_Cddeg*f_Qu_COM[1]+f_Sddeg*(f_Wnbb_COM[0]*f_Qu_COM[0]+f_Wnbb_COM[2]*f_Qu_COM[2]-f_Wnbb_COM[1]*f_Qu_COM[3]);
	   	f_Qb_COM[2] = f_Cddeg*f_Qu_COM[2]+f_Sddeg*(f_Wnbb_COM[1]*f_Qu_COM[0]-f_Wnbb_COM[2]*f_Qu_COM[1]+f_Wnbb_COM[0]*f_Qu_COM[3]);
	   	f_Qb_COM[3] = f_Cddeg*f_Qu_COM[3]+f_Sddeg*(f_Wnbb_COM[2]*f_Qu_COM[0]+f_Wnbb_COM[1]*f_Qu_COM[1]-f_Wnbb_COM[0]*f_Qu_COM[2]);
	
	   	f_Ddegree = sqrt(f_Qb_COM[0]*f_Qb_COM[0]+f_Qb_COM[1]*f_Qb_COM[1]+f_Qb_COM[2]*f_Qb_COM[2]+f_Qb_COM[3]*f_Qb_COM[3]);
	  
	    for(k=0;k<4;k++)
	    {
	    	f_Qu_COM[k] = f_Qb_COM[k]/f_Ddegree;
	    }
	
		f_Cbn_COM[0][0] = f_Qu_COM[0]*f_Qu_COM[0]+f_Qu_COM[1]*f_Qu_COM[1]-f_Qu_COM[2]*f_Qu_COM[2]-f_Qu_COM[3]*f_Qu_COM[3];
	    f_Cbn_COM[1][1] = f_Qu_COM[2]*f_Qu_COM[2]-f_Qu_COM[3]*f_Qu_COM[3]+f_Qu_COM[0]*f_Qu_COM[0]-f_Qu_COM[1]*f_Qu_COM[1];
	    f_Cbn_COM[2][2] = f_Qu_COM[3]*f_Qu_COM[3]-f_Qu_COM[2]*f_Qu_COM[2]-f_Qu_COM[1]*f_Qu_COM[1]+f_Qu_COM[0]*f_Qu_COM[0];
	    f_Cbn_COM[0][1] = 2.0  * (f_Qu_COM[1]*f_Qu_COM[2]-f_Qu_COM[0]*f_Qu_COM[3]);
	    f_Cbn_COM[0][2] = 2.0  * (f_Qu_COM[1]*f_Qu_COM[3]+f_Qu_COM[0]*f_Qu_COM[2]);
	    f_Cbn_COM[1][0] = 2.0  * (f_Qu_COM[1]*f_Qu_COM[2]+f_Qu_COM[0]*f_Qu_COM[3]);
	    f_Cbn_COM[1][2] = 2.0  * (f_Qu_COM[2]*f_Qu_COM[3]-f_Qu_COM[0]*f_Qu_COM[1]);
	    f_Cbn_COM[2][0] = 2.0  * (f_Qu_COM[1]*f_Qu_COM[3]-f_Qu_COM[0]*f_Qu_COM[2]);
	    f_Cbn_COM[2][1] = 2.0  * (f_Qu_COM[2]*f_Qu_COM[3]+f_Qu_COM[0]*f_Qu_COM[1]);

		f_Atti_COM[0] = atan(f_Cbn_COM[2][1]/sqrt(f_Cbn_COM[2][0]*f_Cbn_COM[2][0]+f_Cbn_COM[2][2]*f_Cbn_COM[2][2]));
		f_Atti_COM[1] = atan2(-f_Cbn_COM[2][0],f_Cbn_COM[2][2]);
		f_Atti_COM[2] = atan2(-f_Cbn_COM[0][1],f_Cbn_COM[1][1]);
		if(f_Atti_COM[2]<0.0)  
		{
			f_Atti_COM[2] += 2.0*PI;
		}
	
	   	f_Fn_COM[0] = f_Cbn_COM[0][0]*f_Fab[0]+f_Cbn_COM[0][1]*f_Fab[1]+f_Cbn_COM[0][2]*f_Fab[2];
	   	f_Fn_COM[1] = f_Cbn_COM[1][0]*f_Fab[0]+f_Cbn_COM[1][1]*f_Fab[1]+f_Cbn_COM[1][2]*f_Fab[2];
	   	f_Fn_COM[2] = f_Cbn_COM[2][0]*f_Fab[0]+f_Cbn_COM[2][1]*f_Fab[1]+f_Cbn_COM[2][2]*f_Fab[2];
	     
	   	d_Posi_COM[2]  = d_Posi_COM[2]+f_Ts*f_Vnc_COM[2];
	   	d_Posi_COM[1]  = d_Posi_COM[1]+f_Ts*f_Vnc_COM[1]/(d_EarthR_M+f_H);	
	   	f_Positemp = (double)(f_Vnc_COM[0]/((d_EarthR_N+f_H)*cos(d_Posi_COM[1])));	
	   	d_Posi_COM[0]  = d_Posi_COM[0]+f_Ts*f_Positemp;
	   	f_Positemp = f_Positemp+2.0*WIE;
		
	
		f_Sinsg = 9.7803+0.051799*sin(d_Posi_COM[1])*sin(d_Posi_COM[1])-0.94114*0.000001*d_Posi_COM[2]; 
	
	   	f_Fntemp[0] = f_Fn_COM[0]+f_Positemp*sin(d_Posi_COM[1])*f_Vnc_COM[1]-f_Positemp*cos(d_Posi_COM[1])*f_Vnc_COM[2];
	   	f_Fntemp[1] = f_Fn_COM[1]-f_Positemp*sin(d_Posi_COM[1])*f_Vnc_COM[0]-f_Vnc_COM[1]*f_Vnc_COM[2]/(d_EarthR_M+f_H);
	   	f_Fntemp[2] = f_Fn_COM[2]+f_Positemp*cos(d_Posi_COM[1])*f_Vnc_COM[0]-f_Sinsg+f_Vnc_COM[1]*f_Vnc_COM[1]/(d_EarthR_M+f_H);
	   
	   	f_Vntemp[0] = f_Vnc_COM[0]+f_Ts*f_Fntemp[0];
	   	f_Vntemp[1] = f_Vnc_COM[1]+f_Ts*f_Fntemp[1];
	   	f_Vntemp[2] = f_Vnc_COM[2]+f_Ts*f_Fntemp[2];
	   
	   	f_Vnc_COM[0] = f_Vntemp[0];
	   	f_Vnc_COM[1] = f_Vntemp[1];
	   	f_Vnc_COM[2] = f_Vntemp[2];
	   	
	  	
		//20070405 GPS杆臂效应补偿 		
		if(i_Tuochazhiling_COM == 0)
		{
			f_Rx = f_Rx_gf_COM;
			f_Ry = f_Ry_gf_COM;
			f_Rz = f_Rz_gf_COM;
		}
		else if(i_Tuochazhiling_COM == 1)
		{
			f_Rx = f_Rx_td_COM;
			f_Ry = f_Ry_td_COM;
			f_Rz = f_Rz_td_COM;
		}
	
		f_W_pole[0] =  f_Wibb[1]*f_Rz-f_Wibb[2]*f_Ry;
		f_W_pole[1] = -f_Wibb[0]*f_Rz+f_Wibb[2]*f_Rx;
		f_W_pole[2] =  f_Wibb[0]*f_Ry-f_Wibb[1]*f_Rx;
	
		f_Vn_pole_COM[0] = f_Cbn_COM[0][0]*f_W_pole[0]+f_Cbn_COM[0][1]*f_W_pole[1]+f_Cbn_COM[0][2]*f_W_pole[2];
	    f_Vn_pole_COM[1] = f_Cbn_COM[1][0]*f_W_pole[0]+f_Cbn_COM[1][1]*f_W_pole[1]+f_Cbn_COM[1][2]*f_W_pole[2];
	    f_Vn_pole_COM[2] = f_Cbn_COM[2][0]*f_W_pole[0]+f_Cbn_COM[2][1]*f_W_pole[1]+f_Cbn_COM[2][2]*f_W_pole[2];
	
	
		f_Rn_pole_COM[0] = f_Cbn_COM[0][0]*f_Rx+f_Cbn_COM[0][1]*f_Ry+f_Cbn_COM[0][2]*f_Rz; //单位：米
		f_Rn_pole_COM[1] = f_Cbn_COM[1][0]*f_Rx+f_Cbn_COM[1][1]*f_Ry+f_Cbn_COM[1][2]*f_Rz;
		f_Rn_pole_COM[2] = f_Cbn_COM[2][0]*f_Rx+f_Cbn_COM[2][1]*f_Ry+f_Cbn_COM[2][2]*f_Rz;
		
		//end
	
	
		//秒脉冲到来时保存导航信息  	
	   	if(*GpsPpsArrivedFlag == 1)
		{
			*GpsPpsArrivedFlag = 0;
			i_1ppsReceived = 1;
			
			for(i=0; i<3; i++)
			{
				d_Posi_KF_COM[i] = d_Posi_COM[i];
				f_Vnc_KF_COM[i]  = f_Vnc_COM[i];
				f_Fn_KF_COM[i]   = f_Fn_COM[i];
				f_Vn_pole_KF_COM[i] = f_Vn_pole_COM[i];
				f_Rn_pole_KF_COM[i] = f_Rn_pole_COM[i];
			}
						
			f_dVx_Sum = 0.0;            
			f_dVy_Sum = 0.0;
			f_dVz_Sum = 0.0;
			
			f_dPosix_Sum = 0.0;
			f_dPosiy_Sum = 0.0;
			f_dPosiz_Sum = 0.0;
			
			i_Delay_Counter = 0;
			
			i_Counter_Begin = 1;
		}
		
		
		if(i_Counter_Begin == 1)
		{
			i_Delay_Counter++;
			
			if(i_Delay_Counter > 200)       //数据丢了，脉冲也丢了
			{
				f_dVx_Sum = 0.0;
				f_dVy_Sum = 0.0;
				f_dVz_Sum = 0.0;
				
				f_dPosix_Sum = 0.0;
				f_dPosiy_Sum = 0.0;
				f_dPosiz_Sum = 0.0;
			
				i_Delay_Counter = 0;
				
				i_1ppsReceived = 0;	
				i_Counter_Begin = 0;	
			}	
			
			f_dVx_Sum = f_dVx_Sum + f_Fntemp[0] * f_Ts;
			f_dVy_Sum = f_dVy_Sum + f_Fntemp[1] * f_Ts;
			f_dVz_Sum = f_dVz_Sum + f_Fntemp[2] * f_Ts;	
				
			f_dPosix_Sum = f_dPosix_Sum + f_Ts*f_Vnc_COM[0]/((d_EarthR_N+f_H)*cos(d_Posi_COM[1]));
			f_dPosiy_Sum = f_dPosiy_Sum + f_Ts*f_Vnc_COM[1]/(d_EarthR_M+f_H);
			f_dPosiz_Sum = f_dPosiz_Sum + f_Ts*f_Vnc_COM[2];
			
		}
		
		if(*GpsDataReceivedFlag == 1 && i_1ppsReceived == 0)  //秒脉冲丢了，但来了数据  
		{
			*GpsDataReceivedFlag = 0;
			i_Counter_Begin = 0;
			
			i_Delay_Counter = 0;
		}
			
		if(*GpsDataReceivedFlag == 1 && i_1ppsReceived == 1)    
		{
			*GpsDataReceivedFlag = 0;
			i_1ppsReceived = 0;
			
			i_Counter_Begin = 0;
			
			i_Delay_Counter = 0;
	
			//读取1PPS时刻的GPS信息		
			d_Gps_Long = pGpsData->Longitude;
			d_Gps_Lat  = pGpsData->Latitude;
			f_Gps_Alt  = pGpsData->Altitude;
			f_Gps_Ve   = pGpsData->Ve;
			f_Gps_Vn   = pGpsData->Vn;
			f_Gps_Vu   = pGpsData->Vu;
			f_GpsPdop  = pGpsData->pdop;
			i_GpsStarNumber = pGpsData->Visible_Star;
			i_NaviMode = pGpsData->NaviMode; 
			
			//判断GPS信息的值是否超限
            if( (fabs(d_Gps_Long)>180.0*DEGTORAD) || (fabs(d_Gps_Lat)>90.0*DEGTORAD)
               ||(f_Gps_Alt<-2000.0) || (f_Gps_Alt>40000.0)
               ||(fabs(f_Gps_Ve)>1000.0) || (fabs(f_Gps_Vn)>1000.0)|| (fabs(f_Gps_Vu)>1000.0))    
            {
            	i_GpsStarNumber = 1;
            	f_GpsPdop = 200.0;        //如果GPS数据超限将星数和PDOP置为1和20，纯惯导导航
            }
		
			if(i_Count_WithoutNumber == -1)
			{
				i_EnaberComNavSign = 1;
				i_Count_WithoutNumber = 0;
			}
			//GPS失锁超过3秒后重捕，组合导航标志位直接置1，姿态修正标志位置1	
			else if((i_Count_WithoutNumber>=3)&&(i_GpsStarNumber>4) && (f_GpsPdop<120.0) 
					&& (f_GpsPdop>-1) && (i_GpsStarNumber<13) && ((i_NaviMode & 0x0f) == 0x0f))
				{
					i_EnaberComNavSign = 1;
				} 
				else
				{
					if(fabs(f_old_Gps_Ve - f_Gps_Ve)<50.0*(i_Count_WithoutNumber+1) && fabs(f_old_Gps_Vn - f_Gps_Vn)<50.0*(i_Count_WithoutNumber+1) 
					&& fabs(f_old_Gps_Vu - f_Gps_Vu)<50.0*(i_Count_WithoutNumber+1) 
					&& fabs(f_Gps_Ve*(i_Count_WithoutNumber+1)-(d_Gps_Long-f_old_Gps_Lon)*(d_EarthR_N+f_H)*cos(d_Posi_COM[1]))<50	 
					&& fabs(f_Gps_Vn*(i_Count_WithoutNumber+1)-(d_Gps_Lat-f_old_Gps_Lat)*(d_EarthR_M+f_H))<50
					&& fabs(f_Gps_Vu*(i_Count_WithoutNumber+1)-(f_Gps_Alt-f_old_Gps_Alt))<50)
					{
						i_EnaberComNavSign = 1;			
					}
					else
					{
						i_EnaberComNavSign = 0; //GPS野值标志位
					}
				}

			//判断是否满足组合导航条件
			if((i_GpsStarNumber>4) && (f_GpsPdop<120.0) && (f_GpsPdop>-1) && (i_GpsStarNumber<13)
			&& ((i_NaviMode & 0x0f) == 0x0f) && (i_EnaberComNavSign == 1))
			{///
					
				f_old_Gps_Ve = f_Gps_Ve;
				f_old_Gps_Vn = f_Gps_Vn; 
				f_old_Gps_Vu = f_Gps_Vu;
				f_old_Gps_Lon = d_Gps_Long;
				f_old_Gps_Lat = d_Gps_Lat;
				f_old_Gps_Alt = f_Gps_Alt;
					
				KALMAN_FILTER_COM();
				
				if(*pNaviEstimateFlag == 1)	//组合导航状态评估
			    {//如果失锁时间小于3秒按组合导航判据判断			
					if(i_Count_WithoutNumber<3)
					{
				            //进行组合导航状态判断
				           if(fabs(com_Z_measure[3]) < 5.0
		  	   	               && fabs(com_Z_measure[4]) < 5.0
		  	   	                && fabs(com_Z_measure[5]) < 5.0)     //收星正常情况水平姿态小于70deg，组合导航与GPS速度之差小于10m/s
				                {
					                 *pComNaviStateFlag = 1;
				                }        
				           		else
				                {
					           	
					           		i_Count_NaviFault++;
				                }
				     }
			         else//如果大于等于三秒按纯惯导判断
			         {
			               	if(fabs(f_Vnc_COM[0] ) < 400.0
		  	   	                  && fabs(f_Vnc_COM[1] ) < 400.0
		  	   	                   && fabs(f_Vnc_COM[2]) < 400.0)
			                      {
			                          *pComNaviStateFlag = 1;
			                      }
			                      else
			                      {
			                       
			                          i_Count_NaviFault++;
			                      }
		             }
		        }//
				
				if(NaviFirstFlag==2)
				{
				     *pComNaviStateFlag = 2;
				}
								 										 										 										 						
				i_Count_WithoutNumber = 0;     
			}///
			else///
			{
			    if(*pNaviEstimateFlag == 1)	//组合导航状态评估
	            {
	              	//纯惯导状态判断
	              	if( fabs(f_Vnc_COM[0]) < 400.0
  	   	                  && fabs(f_Vnc_COM[1]) < 400.0
  	   	                   && fabs(f_Vnc_COM[2]) < 400.0)
	                      {
	                          *pComNaviStateFlag = 1;
	                      }
	                      else
	                      {
	                    
	                          i_Count_NaviFault++;
	                      }
	            }
	            
			    i_Count_WithoutNumber++;  //失锁时间计数器
			        
			    if(i_Count_WithoutNumber >= 3)
			    {
						i_Flag_KFAngleBack = 1;
				}
				else
				{
						i_Flag_KFAngleBack = 0;					
				}
			}///
	        
	        	*pNaviEstimateFlag =0; //评估指令置零
				//保存前一时刻GPS信息

				i_old_GpsStarNumber = i_GpsStarNumber;
				f_old_GpsPdop = f_GpsPdop;
				i_old_NaviMode = i_NaviMode;
				
				if(i_Count_NaviFault>=10)
			    {
					i_Count_NaviFault=20;
					*pComNaviStateFlag = 2;
			    }

		}////
		

			pNaviData->Longitude = d_Posi_COM[0]; 
			pNaviData->Latitude  = d_Posi_COM[1];      
			pNaviData->Altitude  = d_Posi_COM[2];
	
			pNaviData->Ve = f_Vnc_COM[0];  
			pNaviData->Vn = f_Vnc_COM[1];            
			pNaviData->Vu = f_Vnc_COM[2];
				
			pNaviData->Pitch = f_Atti_COM[0];   
			pNaviData->Roll  = f_Atti_COM[1];
			pNaviData->Yaw   = f_Atti_COM[2]; 

				
								
	}//INS end
	    
  	return;
}       


	
