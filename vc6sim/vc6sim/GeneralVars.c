
#include "GeneralVarFun.h"

//--------------------------------------GeneralVars.c-------------------
int i_TransAlignment_COM=0;
float f_TimeSample=0.005; 
unsigned int NaviFirstFlag=0; 

int i_Tuochazhiling_COM=0;  
         
//-------------------------------------------com_nav_m.cpp--------------
double d_Posi_M[3]={0.0,0.0,0.0};
float f_Vnc_M_COM[3]={0.0,0.0,0.0},f_Atti_M_COM[3]={0.0,0.0,0.0}; 
float f_Cbn_M_COM[3][3],f_Qu_M_COM[4];

//------------------------------------------com_nav_s.cpp--------------	
float f_Ax=0.0, f_Ay=0.0, f_Az=0.0,f_Wx=0.0,f_Wy=0.0,f_Wz=0.0;
double d_Posi_COM[3]={0.0,0.0,0.0};
float f_Vnc_COM[3]={0.0,0.0,0.0},f_Atti_COM[3]={0.0,0.0,0.0};
int   i_InitialAlign=0;
float f_Fab[3],f_Fn_COM[3],f_Wibb[3],f_Winn[3],f_Winb_COM[3],f_Wnbb_COM[3];
float f_Qb_COM[4],f_Qu_COM[4],f_Cbn_COM[3][3];

int   i_1ppsReceived=0;
double d_Gps_Long=0.0,d_Gps_Lat=0.0;
float f_Gps_Alt=0.0;
float f_Gps_Ve=0.0,f_Gps_Vn=0.0,f_Gps_Vu=0.0,f_GpsPdop=0.0;
int   i_GpsStarNumber=0;
unsigned short	i_NaviMode=0;

double d_Posi_KF_COM[3]={0.0,0.0,0.0};
float f_Vnc_KF_COM[3]={0.0,0.0,0.0},f_Fn_KF_COM[3]={0.0,0.0,0.0};
double d_EarthR_M=0.0,d_EarthR_N=0.0;
float f_H=0.0;

//卡尔曼反馈需要的变量
unsigned int i_Flag_KFAngleBack=0;
unsigned int i_Flag_KFNormal=0;
unsigned int i_Count_WithoutNumber=0;

//判断GPS野值需要的变量
int		i_EnaberComNavSign=0;
float 	f_old_Gps_Ve=0.0;
float	f_old_Gps_Vn=0.0;
float	f_old_Gps_Vu=0.0;
int		i_old_GpsStarNumber=0;
float	f_old_GpsPdop=200.0;
double f_old_Gps_Lon=0.0;
double f_old_Gps_Lat=0.0;
float  f_old_Gps_Alt=0.0;
unsigned short 	i_old_NaviMode=0;
nNAVI_GPS pGpsDataTmp;


//20070409 GPS杆臂补偿
float f_Vn_pole_COM[3]={0.0,0.0,0.0},f_Vn_pole_KF_COM[3]={0.0,0.0,0.0};
float f_Rn_pole_COM[3]={0.0,0.0,0.0},f_Rn_pole_KF_COM[3]={0.0,0.0,0.0};
float f_Rx_gf_COM=0.0,f_Ry_gf_COM=0.0,f_Rz_gf_COM=0.0;
float f_Rx_td_COM=0.0,f_Ry_td_COM=0.587,f_Rz_td_COM=0.0;  //弹体纵轴上GPS与MEMS距离差


//-------------------GPS延迟置换需要的变量-----------
int i_Counter_Begin=0;
int i_Delay_Counter=0;

float	f_dVx_Sum = 0.0,f_dVy_Sum = 0.0,f_dVz_Sum = 0.0;		
float	f_dPosix_Sum = 0.0,f_dPosiy_Sum = 0.0,f_dPosiz_Sum = 0.0;


//------------------------com_filter.cpp--------------
int i_KF_Init_Flag_COM=0;
int i_KF_FeedBackTime_COM=1;
int i_KF_Run_Time=0; 


float f_KF_Periods=1.0;	 
	
float com_Xk[kno1];

float com_Xkk_1[kno1],  com_sys_a[kno1][kno1],  com_sys_g[kno1][kno2],  com_sys_h[kno3][kno1],
	  com_Z_measure[kno3],  com_QQ[kno2][kno2],  com_RR[kno3][kno3], com_Pk[kno1][kno1],  com_Pkk_1[kno1][kno1],
	  com_Kk[kno1][kno3],
	  com_disaT[kno1][kno1], com_disgT[kno1][kno2], com_distemp[kno1][kno1],
	  com_hx[kno3], com_temp18[kno1][1], com_temp6[kno3][1],
	  com_tmpe[kno1][kno1], com_tmpf[kno1][kno1],
	  com_tmpfk[kno1][kno1], com_tmpakz[kno3][kno1], 
	  com_tmpgk[kno3][kno1], com_tmpfq[kno2][kno1],
	  com_tmpbz[kno2][kno1], com_tmpgh[kno1][kno3],
	  com_tmphz[kno1][kno3], com_tmpdz[kno3][kno3], com_tmpd[kno3][kno3];

float com_sys_a_n[kno1][kno1],		com_sys_g_n[kno1][kno2],
	  com_sys_h_n[kno3][kno1],		com_QQ_n[kno2][kno2],
	  com_RR_n[kno3][kno3],			com_Z_measure_n[kno3][1],
	  com_Xk_n[kno1][1],			com_Xkk_1_n[kno1][1],
	  com_Pk_n[kno1][kno1],			com_Pkk_1_n[kno1][kno1],
	  com_Kk_n[kno1][kno3],			com_disaT_n[kno1][kno1],
	  com_disgT_n[kno1][kno2],		com_distemp_n[kno1][kno1],
	  com_hx_n[kno3][1],			com_temp18_n[kno1][1],
	  com_temp6_n[kno3][1],			com_tmpe_n[kno1][kno1],
	  com_tmpf_n[kno1][kno1],		com_tmpfk_n[kno1][kno1],
	  com_tmpakz_n[kno3][kno1],		com_tmpgk_n[kno3][kno1],
	  com_tmpfq_n[kno2][kno1],		com_tmpbz_n[kno2][kno1],
	  com_tmpgh_n[kno1][kno3],		com_tmphz_n[kno1][kno3],
	  com_tmpdz_n[kno3][kno3],		com_tmpd_n[kno3][kno3];
 
float f_KF_Phix_COM=0.0,f_KF_Phiy_COM=0.0,f_KF_Phiz_COM=0.0;
float f_GpsgetHead_V_Limit=3.0;

//--------------------自对准------------------
int i_first_pvgh=0;
int i_Init_Nav = 0;
float f_sinsg=9.80125;
int main_imu_intia_inject = 0; 

float	f_KF_Xk_COM[9]={0,0,0,0,0,0,0,0,0};

long int i_initk2 = 0;
long int i_initk = 0; 
float f_sumtmp[6]={0.0,0.0,0.0,0.0,0.0,0.0},f_init_GA_out[6]={0.0,0.0,0.0,0.0,0.0,0.0};
nNAVI_IMU pImudataTmp;
unsigned int Imu_Error_count = 0;
unsigned int Imu_Error_Flag = 0;

int i_Count_NaviFault=0;




