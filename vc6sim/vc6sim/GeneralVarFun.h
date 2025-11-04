#include <stdio.h>

#ifndef __GENERALVARFUN_H_
#define __GENERALVARFUN_H_

#include "tpdef.h"
/**********************宏定义**********************************************/

#define kno1 9
#define kno2 6
#define kno3 6

#define DEGTORAD  (3.1415926/180.0)
#define EARTHR  6378137.0 
#define SINSG0  9.80125
#define WIE  (15.0411*DEGTORAD/3600.0)
#define E    (1.0/298.257)

#define THROWING_TIME 5
#define ALIGNMENT_TIME 50

/**************************全局变量声明************************************/
//--------------------------------------GeneralVars.c-------------------
extern int   i_TransAlignment_COM;
extern float f_TimeSample;
extern unsigned int NaviFirstFlag;   

extern int i_Tuochazhiling_COM;         
//-------------------------------------------com_nav_m.cpp--------------
extern double d_Posi_M[3];
extern float f_Vnc_M_COM[3],f_Atti_M_COM[3]; 
extern float f_Cbn_M_COM[3][3],f_Qu_M_COM[4];
 //------------------------------------------com_nav_s.cpp--------------	
extern float f_Ax, f_Ay, f_Az, f_Wx, f_Wy, f_Wz;
extern double d_Posi_COM[3];
extern float f_Vnc_COM[3],f_Atti_COM[3];
extern int   i_InitialAlign;
extern float f_Fab[3],f_Fn_COM[3],f_Wibb[3],f_Winn[3],f_Winb_COM[3],f_Wnbb_COM[3];
extern float f_Qb_COM[4],f_Qu_COM[4],f_Cbn_COM[3][3];

extern int   i_1ppsReceived;
extern double d_Gps_Long,d_Gps_Lat;
extern float f_Gps_Alt;
extern double f_old_Gps_Lon,f_old_Gps_Lat;
extern float f_old_Gps_Alt;

extern float f_Gps_Ve,f_Gps_Vn,f_Gps_Vu,f_GpsPdop;
extern int   i_GpsStarNumber;
extern unsigned short	i_NaviMode;

extern double d_Posi_KF_COM[3];
extern float f_Vnc_KF_COM[3],f_Fn_KF_COM[3];
extern double d_EarthR_M,d_EarthR_N;
extern float f_H;

//卡尔曼反馈需要的变量
extern unsigned int i_Flag_KFAngleBack;
extern unsigned int i_Flag_KFNormal;
extern unsigned int i_Count_WithoutNumber;

//判断GPS野值需要的变量
extern int		i_EnaberComNavSign;
extern float 	f_old_Gps_Ve;
extern float	f_old_Gps_Vn;
extern float 	f_old_Gps_Vu;
extern int		i_old_GpsStarNumber;
extern float	f_old_GpsPdop;
extern unsigned short	i_old_NaviMode;
extern nNAVI_GPS pGpsDataTmp;

//20070409 GPS杆臂补偿
extern float f_Vn_pole_COM[3],f_Vn_pole_KF_COM[3];
extern float f_Rn_pole_COM[3],f_Rn_pole_KF_COM[3];
extern float f_Rx_gf_COM,f_Ry_gf_COM,f_Rz_gf_COM;
extern float f_Rx_td_COM,f_Ry_td_COM,f_Rz_td_COM;
extern float f_KF_Xk_COM[9];
//-------------------GPS延迟置换需要的变量-----------
extern int i_Counter_Begin;
extern int i_Delay_Counter;
extern float f_dVx_Sum,f_dVy_Sum,f_dVz_Sum;		
extern float f_dPosix_Sum,f_dPosiy_Sum,f_dPosiz_Sum;

//------------------------com_filter.cpp--------------
extern int   i_KF_Init_Flag_COM;
extern int   i_KF_FeedBackTime_COM;
extern int   i_KF_Run_Time; 


extern float f_KF_Periods;	 
	
extern float  com_Xk[kno1];

extern float com_Xkk_1[kno1],  com_sys_a[kno1][kno1],  com_sys_g[kno1][kno2],  com_sys_h[kno3][kno1],
	  com_Z_measure[kno3],  com_QQ[kno2][kno2],  com_RR[kno3][kno3], com_Pk[kno1][kno1],  com_Pkk_1[kno1][kno1],
	  com_Kk[kno1][kno3],
	  com_disaT[kno1][kno1], com_disgT[kno1][kno2], com_distemp[kno1][kno1],
	  com_hx[kno3], com_temp18[kno1][1], com_temp6[kno3][1],
	  com_tmpe[kno1][kno1], com_tmpf[kno1][kno1],
	  com_tmpfk[kno1][kno1], com_tmpakz[kno3][kno1], 
	  com_tmpgk[kno3][kno1], com_tmpfq[kno2][kno1],
	  com_tmpbz[kno2][kno1], com_tmpgh[kno1][kno3],
	  com_tmphz[kno1][kno3], com_tmpdz[kno3][kno3], com_tmpd[kno3][kno3];


extern float 	com_sys_a_n[kno1][kno1],		com_sys_g_n[kno1][kno2],
	  			com_sys_h_n[kno3][kno1],		com_QQ_n[kno2][kno2],
	  			com_RR_n[kno3][kno3],		com_Z_measure_n[kno3][1],
	  			com_Xk_n[kno1][1],			com_Xkk_1_n[kno1][1],
	  			com_Pk_n[kno1][kno1],		com_Pkk_1_n[kno1][kno1],
	  			com_Kk_n[kno1][kno3],		com_disaT_n[kno1][kno1],
	  			com_disgT_n[kno1][kno2],		com_distemp_n[kno1][kno1],
	  			com_hx_n[kno3][1],			com_temp18_n[kno1][1],
	  			com_temp6_n[kno3][1],		com_tmpe_n[kno1][kno1],
	  			com_tmpf_n[kno1][kno1],		com_tmpfk_n[kno1][kno1],
	  			com_tmpakz_n[kno3][kno1],		com_tmpgk_n[kno3][kno1],
	  			com_tmpfq_n[kno2][kno1],		com_tmpbz_n[kno2][kno1],
	  			com_tmpgh_n[kno1][kno3],		com_tmphz_n[kno1][kno3],
	  			com_tmpdz_n[kno3][kno3],		com_tmpd_n[kno3][kno3];
 
extern float f_KF_Phix_COM,f_KF_Phiy_COM,f_KF_Phiz_COM;


extern float f_GpsgetHead_V_Limit;

//--------------------自对准------------------
extern char ch_InitializationMode;
extern int i_first_pvgh;
extern int i_Init_Nav;
extern int main_imu_intia_inject;

extern float f_sinsg; 

extern long int i_initk2;
extern long int i_initk; 
extern float f_sumtmp[6],f_init_GA_out[6];

extern nNAVI_IMU pImudataTmp;

extern int i_Count_NaviFault; //导航异常计数器

extern unsigned int Imu_Error_count;
extern unsigned int Imu_Error_Flag;
/**************************函数声明***************************************/
//--------------------------------------com_nav_s----------

void NAV_COM(	nNAVI_IMU 		*pIMUData, 
				nNAVI_GPS 		*pGpsData,
				unsigned int 	*GpsPpsArrivedFlag,
				unsigned int   	*GpsDataReceivedFlag,
				nNAVI_INS 		*pNaviData,
				unsigned char   *pBombSeverFlag,       	// 脱插分离标志
				unsigned int   *pNaviEstimateFlag,
				unsigned int   *pComNaviStateFlag ); 

//--------------------------------------com_nav_m.c----------
//void INITIA_AIM(nNAVI_IMU *pImuData, nSELFAIM_PARA *InitialAlignData, nNAVI_GPS *pGpsData_M, unsigned char *InitNaviModeFlag ,unsigned int *pComNaviStateFlag);        // 自对准初始参数
void INITIA_AIM(unsigned char *PlDataUpdate,nNAVI_IMU *pImuData,float gyro_offset[3], nSELFAIM_PARA *InitialAlignData, nNAVI_GPS *pGpsData_M, unsigned char *InitNaviModeFlag ,unsigned int *pComNaviStateFlag);        // 自对准初始参数
void INITIA_CBN(void);
//--------------------------------------filter_init.c--------
void KF_ARRAY_INIT_COM(void);
void INITIALIZATION_KF_COM(void);
//--------------------------------------com_filter.c---------
void KALMAN_FILTER_COM(void);
void KF_FEEDBACK_COM(void);

void INIT_NAV();

#endif 
