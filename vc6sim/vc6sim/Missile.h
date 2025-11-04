// Missile.h: interface for the CMissile class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_MISSILE_H__27F6ECAE_B480_4B77_8701_71644C8EB0DB__INCLUDED_)
#define AFX_MISSILE_H__27F6ECAE_B480_4B77_8701_71644C8EB0DB__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include "Const.h"
#include "tpdef.h"

class CMissile  
{
public:
	/******************************************************
	/////////////////////////飞行器结构参数///////////////
	******************************************************/
	double Sref;	//参考面积
	double Lref;	//参考长度
	double Mass;	//质量
	
	double P;		//发动机推力
	
	double G_CabinFuel;		//发动机燃烧前质心
	double G_Cabin;			//发动机燃烧后质心
	
	double JX;		//发动机燃烧前
	double JY;  
	double JZ; 
	
	double jx;	    //发动机燃烧后
	double jy; 
	double jz;
	
	double Jxy;  	//交叉转动惯量
	double Jyz; 
	double Jxz;

	double Tpstart1;
	double Tpstart2;
	double Tpstart3;

	double P0;
	double P1;
	double P2;

	double Mass0;
	double Mass1;
	double Mass2;
	///////////////////////////////////////////////////////
	/******************************************************
	/////////////////////////拉偏+干扰信息////////////////
	******************************************************/
	//气动比例拉偏
	// 0    1     2 // 3    4     5// 6    7    8 // 9    10    11
	//  力系数拉偏  // 舵效力矩拉偏//  稳定性拉偏 //  动导数拉偏
	double ep_air[12];
	
	//气动常值拉偏
	// 0    1     2 // 3    4     5
	//  力系数拉偏  // 力矩系数拉偏
	double ed_air[6];
	
	//质心位置拉偏
	//0  1  2
	//前 上 右
	double mdo[3];
	
	//拉偏结构体
	AeroBias mAeroBias;

	//发动机推力偏心
	double Angle_Horizontal,Angle_Vertical ; //推力矢量与弹体坐标系的夹角
	double thrust_error[3];					 //发动机的推力偏心在弹体坐标系下的投影（x,y,z）,单位（m）
	
	//干扰信息
	double ax_noise,ay_noise,az_noise;
	double wx_noise,wy_noise,wz_noise;
	float k_coeff_gyro,k_coeff_acce; //加入噪声的倍数，0表示不加
	int AcceDelay, GyroDelay;		 //0:0ms延迟  1:5ms延迟  2:10ms延迟  大于2:40ms延迟
   	int RUDDELAY;					 //0:0ms延迟  1:20ms延迟
	double GyroOut[9][3],AcceOut[9][3];
	///////////////////////////////////////////////////////

	/******************************************************
	/////////////////////////弹目运动信息///////////////
	******************************************************/

	//导弹初始信息，属于常量，只允许第一次赋值
	//	  0    1     2      3    4     5     6      7    8        9          10           11
	//（经度，纬度，高度，滚转，偏航，俯仰，北速，天速，东速，滚转角速度，偏航角速度，俯仰角速度）
	double state_g[12];//常量第一次赋值（地理坐标系：经度，纬度，高度，滚转，偏航，俯仰，北速，天速，东速，wx，wy，wz）
	
	double state_s[13];//用于计算实时更新（地心坐标系：Sx,Sy,Sz（地心系下位置）,Vx,Vy,Vz,q0,q1,q2,q3,弹体系：wx,wy,wz）
	
	//攻角，侧滑，马赫数
	double fluent[3];
	
	//地理系动力学模型输出 姿态 速度 位置（经，纬，高，北，天，东，滚转，偏航，俯仰）
	double LBH[9];  
	
	//机体系下的气动力系数（轴向力系数，法向力系数，侧向力系数，滚转力矩系数，偏航力矩系数，俯仰力矩系数）
	double C_air[6];
	
	//机体系下的加速度
	double at_air[3];
	
	//目标运动信息
	double Target_IniPos[3];//目标高度mHeg,射程mDistance,方位mYaw(-180°~180°)
	
	double TargetMove[3];	//目标运动速度(东向速度、北向速度、天向速度  m/s)
	
	double Target_Initx, Target_Inity, Target_Initz;//预估目标初始位置，东 北 天//中间变量，只为计算Target_IniPos_supositl
	
	double Target_IniPos_supositl[3], TargetMove_supositl[3];//预估目标初始位置（高度、射程、目标方位角）和运动信息（速度大小、方向）
	
	/***********************************************************
	/////////////////目标点数据结构/////////////////////////////
	************************************************************/
	AIM_DATA pBLHt;

	/******************************************************
	/////////////////////////风///////////////////////////
	******************************************************/
	//风场模型
	//   0          1          2              3           4        5             6            7             8
	//风场倍数 风场方向//切变风起始高度 切变风终止高度 切变大小 切变方向//垂直风起始高度 垂直风终止高度  垂直风大小
	double Wind_type[9];

	/******************************************************
	/////////////////////////控制相关////////////////////
	******************************************************/
	double fyfz[2];//俯仰和偏航弹体固有频率计算
	double a11, a21, a31, a22, a13, a33, a14, a24, a24t, a34, a25, a35;				//纵向动力系数
	double b11, b12, b14, b15, b17, b21, b22, b24, b24t, b25, b32, b34, b35, b36;	//侧向动力系数
	double mz_alpha, mz_deltaz, Cl_alpha, Cl_deltaz;								//纵向大导数
	double mx_beta, mx_deltaX, mx_deltaY;											//滚转大导数
	double my_beta, my_deltaY, Cz_beta, Cz_deltaY, my_deltaX;						//偏航大导数
	double du[3],du_c[3],du_ww[10][3];//舵机
	RUDDER_DATA pRudder_Command;
	CONTROL_PARA pControl_Para;
	SEEKER pSeeker;

	/******************************************************
	/////////////////////////文件操作//////////////////////
	******************************************************/
	//写文件
	FILE *fFcsTraj;
	FILE *fNavTraj;
	FILE *fAeroData;
	FILE *fRollChannel;
	FILE *fYawChannel;
	FILE *fPitchChannel;
	FILE *fbody_f;
	FILE *ffrequency;
	FILE *flongchennal;
	FILE *flateralchennal;
	FILE *fguide;
	FILE* fp_result;
	//读文件
	FILE* fp_acce;	//加表噪声
	FILE* fp_gyro;	//陀螺噪声
	FILE* fp_wanju;//舵机噪声
	FILE *fp;		//读气动数据

	/******************************************************
	/////////////////////////飞行器气动参数///////////////
	******************************************************/
	double caX[ndx][nb][nm][na];
	double cnX[ndx][nb][nm][na];
	double czX[ndx][nb][nm][na];
	double cmxX[ndx][nb][nm][na];
	double cmyX[ndx][nb][nm][na];
	double cmzX[ndx][nb][nm][na];
	
	double caY[ndy][nb][nm][na];
	double cnY[ndy][nb][nm][na];
	double czY[ndy][nb][nm][na];
	double cmxY[ndy][nb][nm][na];
	double cmyY[ndy][nb][nm][na];
	double cmzY[ndy][nb][nm][na];  
	
	double caZ[ndz][nb][nm][na];
	double cnZ[ndz][nb][nm][na];
	double czZ[ndz][nb][nm][na];
	double cmxZ[ndz][nb][nm][na];
	double cmyZ[ndz][nb][nm][na];
	double cmzZ[ndz][nb][nm][na];
	
	//弯矩与铰链力矩
	double mh1[nDJ1][nbT1][nmT1][naT1];
	double mh2[nDJ1][nbT1][nmT1][naT1];
	double mh3[nDJ1][nbT1][nmT1][naT1];
	double mh4[nDJ1][nbT1][nmT1][naT1];
	
	double mr1[nDJ1][nbT1][nmT1][naT1];
	double mr2[nDJ1][nbT1][nmT1][naT1];
	double mr3[nDJ1][nbT1][nmT1][naT1];
	double mr4[nDJ1][nbT1][nmT1][naT1];

	/******************************************************
	////////////////仿真参数+仿真结果存储/////////////////
	******************************************************/
	double time;
	float fRemote_Test_Gc[3];
	OUT1 gOUT;
	GUIDE gGUIDE;
	LONGCHENNAL gLONGCHENNAL;
	LATERALCHENNAL gLATERALCHENNAL;
	TEST gTest;
	//仿真中的静态变量
	STATIC STA;
	/******************************************************
	/////////////////////////IMU数据结构//////////////////
	*****************************************************/
	NAVI_IMU pBombIMUData;

	nNAVI_IMU nIMUData;

	/******************************************************
	////////////////////GPS接收机数据结构//////////////////
	*******************************************************/
	nNAVI_GPS nGpsData;

	/******************************************************
	///////////////自对准初始参数数据结构//////////////////
	*******************************************************/
	nSELFAIM_PARA nSelfAimData,nMainIMUData;//nMainIMUData母惯导参数
	
	/******************************************************
	导航信息数据结构
	*******************************************************/
	nNAVI_INS nNaviData;
	///////////////////////////////////////////////////////

	/******************************************************
	///////////组合导航中间结果数据结构/////////////////////
	*******************************************************/
	nNAVI_MIDRST nNaviMidRst;
	double sins[9];//double sins[9] = {0.,1.,2., /*俯仰、滚动、偏航*/3.,4.,5.,/*东速、北速、天速*/6.,7.,8.  }; //经度、纬度、高度  
	/******************************************************
	///////////用于制导控制的导航数据/////////////////////
	*******************************************************/
	NAVI_INS pNavi_G_Data;

	/******************************************************
	///////////组合导航相关标志位/////////////////////
	*******************************************************/
	unsigned char	nBombSeverFlag;		
	unsigned int	nNaviEstimateFlag;		           
	unsigned int	nGpsPpsArrivedFlag;	
	unsigned int	nGpsDataReceivedFlag;								
	unsigned int 	nComNaviStateFlag;		
	unsigned int	nWingSpreadFlag;		
	unsigned char	nInitNaviModeFlag;	
	unsigned char   PlDataUpdate;				 //载机数据更新标志
	float			gyro_offset[3];              //陀螺零位


public:
	
	void insert_data(double Ma,double alpha,int Num_Ma,int Num_alpha,  double aero_dot[3]);
	void insert_num(double Ma,double alpha,   int &Num_Ma,int &Num_alpha);
	void Margin(double time,double LBH[],double du[],double fluent[],double state_s[],double C_air[], double fyfz[]);
	void Rudder_Delay();
	void Rudder_RK(double du[],double du_command[],double ddu[]);
	void Rudder(double step,double du[], double du_command[]);
	void Rudder_Allocation(float Time,float time_control,float rudderX, float rudderY,float rudderZ,  PRUDDER_DATA pRudderCommand);
	float Pitch_Control(float Time,float time_control,float Q,PNAVI_IMU pIMU,PNAVI_INS pNavi,float ay_c);
	float Yaw_Control(float Time,float time_control,float Q,PNAVI_IMU pIMU,PNAVI_INS pNavi,float az_c);
	float Roll_Control(float Time,float time_control,float Q,PNAVI_IMU pIMU,PNAVI_INS pNavi,float roll_c);
	void MT_evaluate(PNAVI_INS pNavi,PAIM_DATA pBLHt,float MT_eval_info[],float Wenu[],float Renu[]);
	void Guidance(PNAVI_INS pNavi,float Time, float time_control,float Q,PAIM_DATA  pBLHt,float command[3],float nyy[2],PSEEKER pSeeker);
	void Trajectory(float time,PNAVI_INS pNavi,float FlightMach,float Q,float nyy[2]);
	void Control_Law(float Time,float time_control,float Q,PNAVI_IMU pIMU,PNAVI_INS pNavi,float roll_c,float ay_c,float az_c,PRUDDER_DATA pRudderCommand);
	void Guidance_Law_LDR(float Time,float time_control,PNAVI_IMU pIMU, PNAVI_INS pNavi, PCONTROL_PARA pControlPara,PAIM_DATA  pBLHt,float* pRoll_c,float* pAy_c,float* pAz_c,PSEEKER pSeeker);
	void guid_and_control(PNAVI_IMU pIMU, PNAVI_INS pNavi,unsigned int	period, PRUDDER_DATA pRudderCommand, PCONTROL_PARA pControlPara,PAIM_DATA  pBLHt,PSEEKER pSeeker);
	void NAVAGATION_M(int i);
	void IMU_nonliner();
	void IMU_Delay();
	void chach1(int dxdydz, double amach,double du1,double bt1,double af1,double &a0,double &b0,double &c0,double &d0,int &ii1,int &ii2,int &ii3,int &ii4);
	double chachO(int j1,int j2,int j3,int j4,double a0,double b0,double c0,double d0,double f[ndx][nb][nm][na]);
	double chach(int j1,int j2,int j3,int j4,double a0,double b0,double c0,double d0,double f[nDJ1][nbT1][nmT1][naT1]);
	void chachR(int dxdydz, double amach,double du1,double bt1,double af1,double &a0,double &b0,double &c0,double &d0,int &ii1,int &ii2,int &ii3,int &ii4);
	int AeroWxyz(double heg,double fluent[],double state_s[], double Mxyz[]);
	int AeroBase(double time,double fluent[],double du[], double C_air[],int body_traj);
	int Aerodynamics(double time,double heg,AeroBias mAeroBias,double fluent[],double state_s[],double du[],  double C_air[],int body_traj);
	void Engine(double time, double *Mass, double *P, double J[], double *delt_cent);
	void Movement(double time,double state_s[],double C_air[],double fluent[],double LBH[],double at_air1[],  double d_state_s[]);
	void Fluent(double state_s[],double wind[],double LBH[],  double fluent[]);
	void Wind(double time,double Wind_type[],double LBH[],double state_s[],  double Wind_Ve[]);
	void Dynamic(double time, double fluent[],double du[],double state_s[], double C_air[],double at_air[],PNAVI_IMU pBombIMUData,double LBH[]);
	void Target(double time,double ML0,double MB0, double Target_IniPos[], double Target_IniPos_supositl[],double TargetMove[],double TargetMove_supositl[],PAIM_DATA pBLHt);
	double sign(double i);
	void EarthToGeography(double T,double state[],double state_s[],double LBH[]);
	void GeographyToEarth(double L,double B,double H,double roll,double yaw,double pitch,double Vn,double Vu,double Ve,double wx,double wy,double wz,double state_s[]);
	void ReadAerodynamicsData(CString dx, CString dy, CString dz);
		
	CMissile();
		
	virtual ~CMissile();
	
};

#endif // !defined(AFX_MISSILE_H__27F6ECAE_B480_4B77_8701_71644C8EB0DB__INCLUDED_)
