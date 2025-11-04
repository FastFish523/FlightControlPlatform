#ifndef CONST_T
#define CONST_T

#define Control_Step  0.005         //控制周期
#define START_CONTROL_TIME  0.3    //启控时间


#define pi 3.14159265358979323
#define PI 3.14159265358979323
#define WE 7292115.1467e-11 
/////////////定义气动节点/////////////////
#define  ndz 5         //俯仰舵偏的节点数
#define  ndy 3         //偏航舵偏的节点数
#define  ndx 3         //滚动舵偏的节点数
#define  nb  3         //侧滑角的节点数
#define  nm  4         //马赫数的节点数
#define  na  10       //攻角的节点数

const double ama[nm]= {0.4,0.6,0.8,1.05};			//马赫数
const double bt[nb]=  { 0.0, 4.0,10.0};				//侧滑
const double dz[ndz]= {-20.0,-10.0, 0.0, 10.0,20.0};//升降舵
const double dy[ndy]= { -10.0,  0.0,  10.0};		//偏航舵
const double dx[ndx]= { -10.0,  0.0,  10.0};		//滚转舵
const double arf[na]= {-6.0, -2.0, 0.0, 2.0, 4.0, 8.0, 12.0, 16.0, 20.0, 23};//攻角
//舵弯矩、铰链力矩
#define   nDJ1  6
#define   nbT1  2  
#define   nmT1  4 
#define   naT1  14 

const double ama1[nmT1] = { 0.5, 0.7, 0.8, 1.05};
const double btT1[nbT1] =  {0.0, 5.0};
const double DJ1[nDJ1] = { -25.0, -20.0, -15.0 , 15.0, 20.0, 25.0};
const double arf1[naT1] = { -4.,-2.,0.,2.,4.,6.,8.,10.,12.,16.,18.,20.,23.,25.};

/////////////////////////飞行器气动参数/////////////////////////
extern	double caX[ndx][nb][nm][na];
extern	double cnX[ndx][nb][nm][na];
extern	double czX[ndx][nb][nm][na];
extern	double cmxX[ndx][nb][nm][na];
extern	double cmyX[ndx][nb][nm][na];
extern	double cmzX[ndx][nb][nm][na];

extern	double caY[ndy][nb][nm][na];
extern	double cnY[ndy][nb][nm][na];
extern	double czY[ndy][nb][nm][na];
extern	double cmxY[ndy][nb][nm][na];
extern	double cmyY[ndy][nb][nm][na];
extern	double cmzY[ndy][nb][nm][na];  

extern	double caZ[ndz][nb][nm][na];
extern	double cnZ[ndz][nb][nm][na];
extern	double czZ[ndz][nb][nm][na];
extern	double cmxZ[ndz][nb][nm][na];
extern	double cmyZ[ndz][nb][nm][na];
extern	double cmzZ[ndz][nb][nm][na];

extern	double mh1[nDJ1][nbT1][nmT1][naT1];
extern	double mh2[nDJ1][nbT1][nmT1][naT1];
extern	double mh3[nDJ1][nbT1][nmT1][naT1];
extern	double mh4[nDJ1][nbT1][nmT1][naT1];

extern	double mr1[nDJ1][nbT1][nmT1][naT1];
extern	double mr2[nDJ1][nbT1][nmT1][naT1];
extern	double mr3[nDJ1][nbT1][nmT1][naT1];
extern	double mr4[nDJ1][nbT1][nmT1][naT1];
//////////////////////////////////////////////////////////////////
/////////////定义常量/////////////////
const double R0= 6371000.0; 
const double R1= 6378140.0;
const double R2= 6356750.0;
const double DEG2RAD =pi/180.0;	
const double RAD2DEG =180/pi;
const double step= 0.005;
////////////动导数/////////////////////
const double Ma_aero[4]={0.5,0.7,0.9,1.05};
const double alpha_aero[3]={0,6,15};
const double Mzwz[4][3]=
{
	{-1.669,-1.991,-2.563},
	{-2.003,-2.461,-3.271},
	{-2.308,-2.591,-3.624},
	{-2.936,-3.097,-4.371}
};
const double Mywy[4][3]=
{
	{-1.669,-1.991,-2.563},
	{-2.003,-2.461,-3.271},
	{-2.308,-2.591,-3.624},
	{-2.936,-3.097,-4.371}	
	
};
const double Mxwx[4][3]=
{
	{-0.02088,-0.04401,-0.06899},
	{-0.02127,-0.04376,-0.07061},
	{-0.02037,-0.04467,-0.01052},
	{-0.02028,-0.04382,-0.07356}
	
};
//误差
const double GPS_error[3] = {0.0,   0.0,   0.0};//东，北，天
const double Target_IniPos_error[3] = { 120.0, -120.0, -50.0 };//载机装订目标初始位置误差——东向误差，北向误差，天向误差   
const double TargetMove_error[3] = { 6.0, -6.0, -.0};//目标运动估计速度误差——(东向速度误差、北向速度误差、天向速度误差 m/s)
////////////////////////////////////

#endif
