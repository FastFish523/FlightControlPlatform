// Missile.cpp: implementation of the CMissile class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "vc6sim.h"
#include "Missile.h"


#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

extern "C"
{
	//---------------------------navigation.c----------------
	
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
		unsigned char   *InitNaviModeFlag);   	//初始化模式
	
}

CMissile::CMissile()
{

}

CMissile::~CMissile()
{

}
/**************************************
函数名: sign
描述: 符号函数
输入: i
输出: i
**************************************/
double CMissile::sign(double i)
{
	if(i>=0)
	{
		return 1.0;
	}
    else
	{
		return -1.0;    
	}
}
/**************************************
函数名: ReadAerodynamicsData
描述: 读取三通道气动数据
输入: 三通道气动数据路径信息
输出: 无
**************************************/
void CMissile::ReadAerodynamicsData(CString dx, CString dy, CString dz)
{
	
	int i1,i2,i3,i4;
	char *ddx = dx.GetBuffer(0);
	char *ddy = dy.GetBuffer(0);
	char *ddz = dz.GetBuffer(0);
	char *dd = "\\AeroFile\\FT_9\\FT9_DataCmhCmr.dat";

	//读滚转通道气动数据
	fp=fopen(ddx,"r");
	
	for(i1=0;i1<ndx;i1++)	
	{
		for(i2=0;i2<nb;i2++)
		{
			for(i3=0;i3<nm;i3++)
			{
				for(i4=0;i4<na;i4++)			
					fscanf(fp,"%lf %lf %lf %lf %lf %lf  ",
					&caX[i1][i2][i3][i4],&cnX[i1][i2][i3][i4],&czX[i1][i2][i3][i4],
					&cmxX[i1][i2][i3][i4],&cmyX[i1][i2][i3][i4],&cmzX[i1][i2][i3][i4]);				
			}
		}
	}     
	fclose(fp);	
	
	//读偏航通道

	fp=fopen(ddy,"r");
	
	for(i1=0;i1<ndy;i1++)		
	{
		for(i2=0;i2<nb;i2++)
		{
			for(i3=0;i3<nm;i3++)
			{
				for(i4=0;i4<na;i4++)			
					fscanf(fp," %lf %lf %lf %lf %lf %lf ",
					&caY[i1][i2][i3][i4],&cnY[i1][i2][i3][i4],&czY[i1][i2][i3][i4],
					&cmxY[i1][i2][i3][i4],&cmyY[i1][i2][i3][i4],&cmzY[i1][i2][i3][i4]);					
			}
		}
	}	
	fclose(fp);
	
	//读俯仰通道
	
	fp=fopen(ddz,"r");
	
	for(i1=0;i1<ndz;i1++)	
	{
		for(i2=0;i2<nb;i2++)
		{
			for(i3=0;i3<nm;i3++)
			{
				for(i4=0;i4<na;i4++)			
					fscanf(fp," %lf %lf %lf %lf %lf %lf ",
					&caZ[i1][i2][i3][i4],&cnZ[i1][i2][i3][i4],&czZ[i1][i2][i3][i4],
					&cmxZ[i1][i2][i3][i4],&cmyZ[i1][i2][i3][i4],&cmzZ[i1][i2][i3][i4]);				
			}
		}
	}	
	fclose(fp);

////读弯矩和铰链力矩
	double temp;
	for(i1=0;i1<nDJ1;i1++)	//舵
	{
		//for(i2=0;i2<nbT1;i2++)//侧滑角
		{
			for(i3=0;i3<nmT1;i3++)//马赫数
			{
				for(i4=0;i4<naT1;i4++)	//攻角
				{
					fscanf(fp_wanju,"%lf %lf %lf %lf %lf %lf %lf %lf %lf",&temp,&mr1[i1][0][i3][i4],&mr2[i1][0][i3][i4],&mr3[i1][0][i3][i4]
						,&mr4[i1][0][i3][i4],&mh1[i1][0][i3][i4],&mh2[i1][0][i3][i4],&mh3[i1][0][i3][i4],&mh4[i1][0][i3][i4]);
					
					//弯矩
					mr1[i1][1][i3][i4] = mr1[i1][0][i3][i4];
				    mr2[i1][1][i3][i4] = mr2[i1][0][i3][i4];
					mr3[i1][1][i3][i4] = mr3[i1][0][i3][i4];
					mr4[i1][1][i3][i4] = mr4[i1][0][i3][i4];

					//铰链力矩
					mh1[i1][1][i3][i4] = mh1[i1][0][i3][i4];
				    mh2[i1][1][i3][i4] = mh2[i1][0][i3][i4];
					mh3[i1][1][i3][i4] = mh3[i1][0][i3][i4];
					mh4[i1][1][i3][i4] = mh4[i1][0][i3][i4];
			
				}
			}
		}
	}    
	fclose(fp_wanju);	
	
}
/**************************************
函数名: GeographyToEarth
描述: 地理系转地心固定系
输入: state_g[12]（地理坐标系：经度，纬度，高度，滚转，偏航，俯仰，北速，天速，东速，wx，wy，wz）
输出: state_s[13]（地心坐标系：Sx,Sy,Sz（地心系下位置）,Vx,Vy,Vz,q0,q1,q2,q3,弹体系：wx,wy,wz）
**************************************/
void CMissile::GeographyToEarth(double L, double B, double H, double roll, double yaw, double pitch, double Vn, double Vu, double Ve, double wx, double wy, double wz, double state_s[])
{
	double Vec_rotate_g[3]={0,0,0};//～～～～～～地理系四元数旋转角
	double Vec_rotate_e[3]={0,0,0};//～～～～～～地心系四元数旋转角
	
	double e=(R1*R1-R2*R2)/(R1*R1); //～～～～～～地球偏心率
	double W=sqrt(1-e*sin(B)*sin(B));
	double N=R1/W;					//～～～～～～计算地球上面某点的地球半径
	
	state_s[0]=-(N+H)*cos(B)*cos(L);	//弹在地心系下位置东经180，北纬90，东经90
	state_s[1]=(N*(1-e)+H)*sin(B);
	state_s[2]=(N+H)*cos(B)*sin(L);
	
	/////四元数计算初始值
	double T_g_e[3][3] = 
	{	cos(L)*cos(pi/2.-B), -cos(L)*sin(pi/2-B), sin(L),//地理系到地心系的转换矩阵
		sin(pi/2.-B)       , cos(pi/2.-B)       , 0.,
		-sin(L)*cos(pi/2.-B), sin(L)*sin(pi/2.-B), cos(L)
	};
	
	Vec_rotate_g[0]= cos(pitch)*cos(yaw);
	Vec_rotate_g[1]= sin(pitch);
	Vec_rotate_g[2]= -cos(pitch)*sin(yaw);//先滚转
	
	Vec_rotate_e[0]=T_g_e[0][0]*Vec_rotate_g[0]+T_g_e[0][1]*Vec_rotate_g[1]+T_g_e[0][2]*Vec_rotate_g[2];
	Vec_rotate_e[1]=T_g_e[1][0]*Vec_rotate_g[0]+T_g_e[1][1]*Vec_rotate_g[1]+T_g_e[1][2]*Vec_rotate_g[2];
	Vec_rotate_e[2]=T_g_e[2][0]*Vec_rotate_g[0]+T_g_e[2][1]*Vec_rotate_g[1]+T_g_e[2][2]*Vec_rotate_g[2];
	
	double	q0_roll=cos(roll/2);
	double	q1_roll=Vec_rotate_e[0]*sin(roll/2);
	double	q2_roll=Vec_rotate_e[1]*sin(roll/2);
	double	q3_roll=Vec_rotate_e[2]*sin(roll/2);
	
	Vec_rotate_g[0]=sin(yaw);
	Vec_rotate_g[1]=0;
	Vec_rotate_g[2]=cos(yaw);//在俯仰
	
	Ve=Ve+sqrt(state_s[0]*state_s[0]+state_s[2]*state_s[2])*WE;
	
	state_s[3]=T_g_e[0][0]*Vn+T_g_e[0][1]*Vu+T_g_e[0][2]*Ve;//地理系下速度－>地心系下速度
	state_s[4]=T_g_e[1][0]*Vn+T_g_e[1][1]*Vu+T_g_e[1][2]*Ve;
	state_s[5]=T_g_e[2][0]*Vn+T_g_e[2][1]*Vu+T_g_e[2][2]*Ve;
	
	Vec_rotate_e[0]=T_g_e[0][0]*Vec_rotate_g[0]+T_g_e[0][1]*Vec_rotate_g[1]+T_g_e[0][2]*Vec_rotate_g[2];
	Vec_rotate_e[1]=T_g_e[1][0]*Vec_rotate_g[0]+T_g_e[1][1]*Vec_rotate_g[1]+T_g_e[1][2]*Vec_rotate_g[2];
	Vec_rotate_e[2]=T_g_e[2][0]*Vec_rotate_g[0]+T_g_e[2][1]*Vec_rotate_g[1]+T_g_e[2][2]*Vec_rotate_g[2];
	
	double	q0_pitch=cos(pitch/2);
	double	q1_pitch=Vec_rotate_e[0]*sin(pitch/2);
	double	q2_pitch=Vec_rotate_e[1]*sin(pitch/2);
	double	q3_pitch=Vec_rotate_e[2]*sin(pitch/2);
	
	Vec_rotate_g[0]=0.;
	Vec_rotate_g[1]=1.;
	Vec_rotate_g[2]=0.;//后偏航
	
	Vec_rotate_e[0]=T_g_e[0][0]*Vec_rotate_g[0]+T_g_e[0][1]*Vec_rotate_g[1]+T_g_e[0][2]*Vec_rotate_g[2];
	Vec_rotate_e[1]=T_g_e[1][0]*Vec_rotate_g[0]+T_g_e[1][1]*Vec_rotate_g[1]+T_g_e[1][2]*Vec_rotate_g[2];
	Vec_rotate_e[2]=T_g_e[2][0]*Vec_rotate_g[0]+T_g_e[2][1]*Vec_rotate_g[1]+T_g_e[2][2]*Vec_rotate_g[2];
	
	double	q0_yaw=cos(yaw/2);
	double	q1_yaw=Vec_rotate_e[0]*sin(yaw/2);
	double	q2_yaw=Vec_rotate_e[1]*sin(yaw/2);
	double	q3_yaw=Vec_rotate_e[2]*sin(yaw/2);
	
	double	q0_L=cos(L/2.);
	double	q1_L=0.;
	double	q2_L=sin(L/2.);
	double	q3_L=0.;
	
	double	q0_B=cos((pi/2.-B)/2.);
	double	q1_B=sin(L)*sin((pi/2.-B)/2.);
	double	q2_B=0.;
	double	q3_B=cos(L)*sin((pi/2.-B)/2.);
	
	
	double Q1[4]={q0_roll*q0_pitch-q1_roll*q1_pitch-q2_roll*q2_pitch-q3_roll*q3_pitch, 
		q0_roll*q1_pitch+q1_roll*q0_pitch+q2_roll*q3_pitch-q3_roll*q2_pitch, 
		q0_roll*q2_pitch+q2_roll*q0_pitch+q3_roll*q1_pitch-q1_roll*q3_pitch, 
		q0_roll*q3_pitch+q3_roll*q0_pitch+q1_roll*q2_pitch-q2_roll*q1_pitch};
	
	double Q[4]={Q1[0]*q0_yaw-Q1[1]*q1_yaw-Q1[2]*q2_yaw-Q1[3]*q3_yaw,
		Q1[0]*q1_yaw+Q1[1]*q0_yaw+Q1[2]*q3_yaw-Q1[3]*q2_yaw,
		Q1[0]*q2_yaw+Q1[2]*q0_yaw+Q1[3]*q1_yaw-Q1[1]*q3_yaw,
		Q1[0]*q3_yaw+Q1[3]*q0_yaw+Q1[1]*q2_yaw-Q1[2]*q1_yaw};
	
	Q1[0]=Q[0];
	Q1[1]=Q[1];
	Q1[2]=Q[2];
	Q1[3]=Q[3];
	
	Q[0]=Q1[0]*q0_B-Q1[1]*q1_B-Q1[2]*q2_B-Q1[3]*q3_B;
	Q[1]=Q1[0]*q1_B+Q1[1]*q0_B+Q1[2]*q3_B-Q1[3]*q2_B;
	Q[2]=Q1[0]*q2_B+Q1[2]*q0_B+Q1[3]*q1_B-Q1[1]*q3_B;
	Q[3]=Q1[0]*q3_B+Q1[3]*q0_B+Q1[1]*q2_B-Q1[2]*q1_B;
	
	Q1[0]=Q[0];
	Q1[1]=Q[1];
	Q1[2]=Q[2];
	Q1[3]=Q[3];
	
	Q[0]=Q1[0]*q0_L-Q1[1]*q1_L-Q1[2]*q2_L-Q1[3]*q3_L;
	Q[1]=Q1[0]*q1_L+Q1[1]*q0_L+Q1[2]*q3_L-Q1[3]*q2_L;
	Q[2]=Q1[0]*q2_L+Q1[2]*q0_L+Q1[3]*q1_L-Q1[1]*q3_L;
	Q[3]=Q1[0]*q3_L+Q1[3]*q0_L+Q1[1]*q2_L-Q1[2]*q1_L;
	
	//当地体系到地心系的四元数Qeg[4]
	state_s[6]=Q[0];
	state_s[7]=Q[1];
	state_s[8]=Q[2];
	state_s[9]=Q[3];
	
	state_s[10]=wx;//弹体系下转动角速度(前上右)
	state_s[11]=wy;
	state_s[12]=wz;
}
/**************************************
函数名: EarthToGeography
描述: 地心固定系转地理系
输入: 时间，state，state_s
输出: LBH（地理坐标系：经度，纬度，高度，滚转，偏航，俯仰）
**************************************/
void CMissile::EarthToGeography(double T, double state[], double state_s[], double LBH[])
{
	double  L=1.,B=0.5,H=1000.,B_old=0.5,L_old=2.0,X=1000.;
	double  Y=1000.,Z=1000.,X_old=1000.,Y_old=1000.,N=1000.,W=1000.,e=1000.,K1=1000.,K2=1000.,L1=1000.;
	double	q0=state_s[6];
	double	q1=state_s[7];
	double	q2=state_s[8];
	double	q3=state_s[9];
	
	// 地心坐标中纬度平面的两个分量随地球自转的分量	
	Y= cos(WE*T)*state[2]+sin(WE*T)*state[0];
	X= -(-sin(WE*T)*state[2]+cos(WE*T)*state[0]);
	Z= state[1];
	
	if(fabs(Z)<0.0001)
		Z=0.0001*(sign(Z));
	
	L1=WE*T;
	
	K1=atan(Z/sqrt(X*X+Y*Y));  //地惯系下的经纬高
	K2=sqrt(X*X+Y*Y+Z*Z);
	e=(R1*R1-R2*R2)/R1/R1;
	while(sqrt((B-B_old)*(B-B_old)+(L-L_old)*(L-L_old))>0.1e-15)
	{
		B_old=B;
		L_old=L;
		W=sqrt(1.-e*sin(B)*sin(B));
		N=R1/W;
		B=atan(tan(K1)*(1.+R1*e/Z*sin(B)/W));
		L=atan(Y/X);
		H=K2*cos(K1)/cos(B)-N;		
	}
	
	if(X<0)
		L=pi+L;
	
	LBH[0]=L;
	LBH[1]=B;
	LBH[2]=H;
	
    double T_e_g[3][3];//地心固定系到地理系的坐标转换矩阵（由地惯系下的经度反推一下）
	T_e_g[0][0]= cos(L+L1)*cos(pi/2.-B);
	T_e_g[0][1]= sin(pi/2.-B) ;
	T_e_g[0][2]= -sin(L+L1)*cos(pi/2.-B);
	T_e_g[1][0]= -sin(pi/2.-B)*cos(L+L1);
   	T_e_g[1][1]= cos(pi/2.-B) ;
	T_e_g[1][2]= sin(pi/2.-B)*sin(L+L1);	
    T_e_g[2][0]= sin(L+L1) ;
    T_e_g[2][1]= 0.0;
    T_e_g[2][2]= cos(L+L1);
	
	LBH[3]=T_e_g[0][0]*state_s[3]+T_e_g[0][1]*state_s[4]+T_e_g[0][2]*state_s[5];/*地理系下北向速度*/
	LBH[4]=T_e_g[1][0]*state_s[3]+T_e_g[1][1]*state_s[4]+T_e_g[1][2]*state_s[5];/*地理系下天向速度*/
	LBH[5]=T_e_g[2][0]*state_s[3]+T_e_g[2][1]*state_s[4]+T_e_g[2][2]*state_s[5];/*地理系下东向速度*/
	
	LBH[5]=(LBH[5]-WE*sqrt(state[0]*state[0]+state[2]*state[2]));
	
	
	//---.体系的向量转换到地理惯性系
	double	vec_t[3]={1.,0.,0.},vec_e[3],vec_g[3],vec_g_new[3];
	
	vec_e[0]=(q0*q0+q1*q1-q2*q2-q3*q3)*vec_t[0]+2*(-q3*q0+q1*q2)*vec_t[1]+2*(q1*q3+q0*q2)*vec_t[2];
	vec_e[1]=(q0*q0-q1*q1+q2*q2-q3*q3)*vec_t[1]+2*(q3*q0+q1*q2)*vec_t[0]+2*(-q1*q0+q3*q2)*vec_t[2];
	vec_e[2]=2*(q1*q3-q0*q2)*vec_t[0]+2*(q2*q3+q0*q1)*vec_t[1]+(q0*q0-q1*q1-q2*q2+q3*q3)*vec_t[2];
	
	vec_g[0]=T_e_g[0][0]*vec_e[0]+T_e_g[0][1]*vec_e[1]+T_e_g[0][2]*vec_e[2];
	vec_g[1]=T_e_g[1][0]*vec_e[0]+T_e_g[1][1]*vec_e[1]+T_e_g[1][2]*vec_e[2];
	vec_g[2]=T_e_g[2][0]*vec_e[0]+T_e_g[2][1]*vec_e[1]+T_e_g[2][2]*vec_e[2];
	
    LBH[8]=asin(vec_g[1]);/*地理系下俯仰角*/
    //LBH[7]=asin(vec_g[2]/(-cos(LBH[8])));  //这里改用反正弦的方法同样可以求出偏航角
	
	LBH[7]=-atan(vec_g[2]/vec_g[0]);
	if(vec_g[0]<0)
		LBH[7]=pi-atan(vec_g[2]/vec_g[0]);
	while(LBH[7]<-pi)
		LBH[7]=LBH[7]+2.*pi;
	while(LBH[7]>=pi)
		LBH[7]=LBH[7]-2.*pi;
	
	vec_t[0]=0.0;
	vec_t[1]=1.0;
	vec_t[2]=0.0;
	
	vec_e[0]=(q0*q0+q1*q1-q2*q2-q3*q3)*vec_t[0]+2*(-q3*q0+q1*q2)*vec_t[1]+2*(q1*q3+q0*q2)*vec_t[2];
	vec_e[1]=(q0*q0-q1*q1+q2*q2-q3*q3)*vec_t[1]+2*(q3*q0+q1*q2)*vec_t[0]+2*(-q1*q0+q3*q2)*vec_t[2];
	vec_e[2]=2*(q1*q3-q0*q2)*vec_t[0]+2*(q2*q3+q0*q1)*vec_t[1]+(q0*q0-q1*q1-q2*q2+q3*q3)*vec_t[2];
	
	vec_g[0]=T_e_g[0][0]*vec_e[0]+T_e_g[0][1]*vec_e[1]+T_e_g[0][2]*vec_e[2];
	vec_g[1]=T_e_g[1][0]*vec_e[0]+T_e_g[1][1]*vec_e[1]+T_e_g[1][2]*vec_e[2];
	vec_g[2]=T_e_g[2][0]*vec_e[0]+T_e_g[2][1]*vec_e[1]+T_e_g[2][2]*vec_e[2];
	
	vec_g_new[0] = cos(LBH[7])*vec_g[0]-sin(LBH[7])*vec_g[2];
    vec_g_new[1] = vec_g[1];
	vec_g_new[2] = sin(LBH[7])*vec_g[0]+cos(LBH[7])*vec_g[2];
	LBH[6]=asin(vec_g_new[2]);/*地理系下滚转角*/ 
	if(vec_g_new[1]<=0)
	{
		if(vec_g_new[2]>0)
			LBH[6]= PI- LBH[6];
		else 
			LBH[6]= -PI- LBH[6];
	}

}
/**************************************
函数名: Target
描述: 求目标信息（此目标只单纯限定为匀速直线运动目标，比较受限，后期有很大改善空间）
输入: 时间，弹体经度，弹体纬度，目标经纬高，目标经纬高预估，目标运动，，目标运动预估
输出: pBLHt（）
**************************************/
void CMissile::Target(double time, double ML0, double MB0, double Target_IniPos[], double Target_IniPos_supositl[], double TargetMove[], double TargetMove_supositl[], PAIM_DATA pBLHt)
{
	//TargetMove[6]：0目标高度 1射程 2目标方位角 3目标速度 4目标速度高低角 5目标速度方位角
	//真实目标信息
	//目标初始位置（经纬高）
	pBLHt->InitialLon = ML0 - Target_IniPos[1]*sin(Target_IniPos[2])/(R0*cos(MB0));
	pBLHt->InitialLat = MB0 + Target_IniPos[1]*cos(Target_IniPos[2])/R0;
	pBLHt->InitialAlti = Target_IniPos[0];
	
	//目标速度
	pBLHt->Ve = TargetMove[0];//东向速度
	pBLHt->Vn = TargetMove[1];//北向速度
	pBLHt->Vu = TargetMove[2];//天向速度
	
	//目标位置更新（经纬高）
	pBLHt->Longitude = pBLHt->InitialLon + time*pBLHt->Ve/(R0*cos(MB0)); 
	pBLHt->Latitude = pBLHt->InitialLat + time*pBLHt->Vn/R0;
	pBLHt->Altitude = pBLHt->InitialAlti + time*pBLHt->Vu;
	
	//预估目标信息
	//目标初始位置（经纬高）
	pBLHt->InitialLon_supositl = ML0 - Target_IniPos_supositl[1]*sin(Target_IniPos_supositl[2])/(R0*cos(MB0));
	pBLHt->InitialLat_supositl = MB0 + Target_IniPos_supositl[1]*cos(Target_IniPos_supositl[2])/R0;
	pBLHt->InitialAlti_supositl = Target_IniPos_supositl[0];
	
	//目标速度
	pBLHt->Ve_supositl = TargetMove_supositl[0];//东向速度
	pBLHt->Vn_supositl = TargetMove_supositl[1];//北向速度
	pBLHt->Vu_supositl = TargetMove_supositl[2];//天向速度
	
	//目标位置更新（经纬高）
	pBLHt->Longitude_supositl = pBLHt->InitialLon_supositl + time*pBLHt->Ve_supositl/(R0*cos(MB0)); 
	pBLHt->Latitude_supositl = pBLHt->InitialLat_supositl + time*pBLHt->Vn_supositl/R0;
	pBLHt->Altitude_supositl = pBLHt->InitialAlti_supositl + time*pBLHt->Vu_supositl;
}
/**************************************
函数名: Dynamic
描述: 导弹动力学计算
输入: 
输出: 
**************************************/
void CMissile::Dynamic(double time, double fluent[], double du[], double state_s[], double C_air[], double at_air[], PNAVI_IMU pBombIMUData, double LBH[])
{
	double state_s1[13]={0},state_s2[13]={0},state_s3[13]={0};
	double d_state_e1[13]={0},d_state_e2[13]={0},d_state_e3[13]={0},d_state_e4[13]={0};
    double at_air1[3]={0,0,0},at_air2[3]={0,0,0},at_air3[3]={0,0,0},at_air4[3]={0,0,0};
	double Mxyz[5]= {0,0,0,0,0};
	double wx=0,wy=0,wz=0;
	double Wind_Ve[3]={0,0,0};
	int body_traj=1;
	
	//---->1
	EarthToGeography(time,state_s,state_s, LBH);
	Wind(time,Wind_type,LBH,state_s, Wind_Ve);//-计算干扰风的状态	
	Fluent(state_s,Wind_Ve,LBH, fluent);//-计算攻角/马赫数	
	Aerodynamics(time,LBH[2], mAeroBias,fluent,state_s,du, C_air, body_traj);
	
	Movement(time,state_s,C_air,fluent,LBH,at_air1, d_state_e1);//动力学模型  
	for(int i1=0;i1<13;i1++)
		state_s1[i1]=state_s[i1]+ step/2.0*d_state_e1[i1];
				
	//---->2
	EarthToGeography(time+step/2.0,state_s1,state_s, LBH);
	Wind(time,Wind_type,LBH,state_s1, Wind_Ve);
	Fluent(state_s1,Wind_Ve,LBH, fluent);
	Aerodynamics(time,LBH[2], mAeroBias,fluent,state_s,du, C_air, body_traj);
	
	Movement(time+step/2.0,state_s1,C_air,fluent,LBH,at_air2, d_state_e2);
	for(i1=0;i1<13;i1++)
		state_s2[i1]=state_s[i1]+ step/2.0*d_state_e2[i1]; 
	
	//---->3
	EarthToGeography(time+step/2.0,state_s2,state_s,  LBH);
	Wind(time,Wind_type,LBH,state_s2,  Wind_Ve);
	Fluent(state_s2,Wind_Ve,LBH,  fluent);
	Aerodynamics(time,LBH[2], mAeroBias,fluent,state_s,du,  C_air, body_traj);
	
	Movement(time+step/2.0,state_s2,C_air,fluent,LBH,at_air3, d_state_e3);
	for(i1=0;i1<13;i1++)
		state_s3[i1]=state_s[i1]+ step*d_state_e3[i1]; 
	
	//---->4
	EarthToGeography(time+step,state_s3,state_s,  LBH);
	Wind(time,Wind_type,LBH,state_s3,  Wind_Ve);
	Fluent(state_s3,Wind_Ve,LBH,  fluent);
	Aerodynamics(time,LBH[2], mAeroBias,fluent,state_s,du, C_air, body_traj);
	
	Movement(time+step,state_s3,C_air,fluent,LBH,at_air4, d_state_e4);
	for(i1=0;i1<13;i1++)
		state_s[i1]=state_s[i1]+step/6.0*(d_state_e1[i1]+2.*d_state_e2[i1]+2.*d_state_e3[i1]+d_state_e4[i1]);
	
	
	state_s[10] = state_s[10];//+wx_noise;
	state_s[11] = state_s[11];//+wy_noise;
	state_s[12] = state_s[12];//+wy_noise;
	
	at_air[0]=(at_air1[0]+2.0*at_air2[0]+2.0*at_air3[0]+at_air4[0])/6.0;  
	at_air[1]=(at_air1[1]+2.0*at_air2[1]+2.0*at_air3[1]+at_air4[1])/6.0;
	at_air[2]=(at_air1[2]+2.0*at_air2[2]+2.0*at_air3[2]+at_air4[2])/6.0;
	
	EarthToGeography(time+step,state_s,state_s, LBH);
}
/**************************************
函数名: Wind
描述: 地心固定系下风计算
输入: 
输出: 
**************************************/
void CMissile::Wind(double time, double Wind_type[], double LBH[], double state_s[], double Wind_Ve[])
{
	double V_wind_H[14]={22.5,24.0,26.0,27.5, 32.5,49.0,50.0,59.0,60.0,  71.0,78.0,78.0,78.0,75.0};
	double L=LBH[0],B=LBH[1],H=LBH[2];
	double kh1,kh2,kh3;
	double V_wind=0.,Wind_Vg[3]={0.0,0.0,0.0};
	int num_w_min,num_w_max;
	
	if (H<2000.)
	{
		kh1=(H-1000.)*(H-2000.)/(0.-1000.)/(0.-2000.);
		kh2=(H-0.)*(H-2000.)/(1000.-0.)/(1000.-2000.);
		kh3=(H-0.)*(H-1000.)/(2000.-0.)/(2000.-1000.);
		num_w_min=0;
		num_w_max=2;
	}
	else if((H>=2000.)&&(H<4000.))
	{
		kh1=(H-3000.)*(H-4000.)/(2000.-3000.)/(2000.-4000.);
		kh2=(H-2000.)*(H-4000.)/(3000.-2000.)/(3000.-4000.);
		kh3=(H-2000.)*(H-3000.)/(4000.-2000.)/(4000.-3000.);
		num_w_min=2;
		num_w_max=4;
	}
	else if((H>=4000.)&&(H<6000.))
	{	
		kh1=(H-5000.)*(H-6000.)/(4000.-5000.)/(4000.-6000.);
		kh2=(H-4000.)*(H-6000.)/(5000.-4000.)/(5000.-6000.);
		kh3=(H-4000.)*(H-5000.)/(6000.-4000.)/(6000.-5000.);
		num_w_min=4;
		num_w_max=6;
	}
	else if((H>=6000.)&&(H<8000.))
	{
		kh1=(H-7000.)*(H-8000.)/(6000.-7000.)/(6000.-8000.);
		kh2=(H-6000.)*(H-8000.)/(7000.-6000.)/(7000.-8000.);
		kh3=(H-6000.)*(H-7000.)/(8000.-6000.)/(8000.-7000.);
		num_w_min=6;
		num_w_max=8;
	}
	else if((H>=8000.)&&(H<10000.))
	{
		kh1=(H-9000.)*(H-10000.)/(8000.-9000.)/(8000.-10000.);
		kh2=(H-8000.)*(H-10000.)/(9000.-8000.)/(9000.-10000.);
		kh3=(H-8000.)*(H-9000.)/(10000.-8000.)/(10000.-9000.);
		num_w_min=8;
		num_w_max=10;
	}
	else
	{
		kh1=(H-11000.)*(H-12000.)/(10000.-11000.)/(10000.-12000.);
		kh2=(H-10000.)*(H-12000.)/(11000.-10000.)/(11000.-12000.);
		kh3=(H-10000.)*(H-11000.)/(12000.-10000.)/(12000.-11000.);
		num_w_min=10;
		num_w_max=12;
	}
	
	V_wind=kh1*V_wind_H[num_w_min]+kh2*V_wind_H[num_w_min+1]+kh3*V_wind_H[num_w_min+2];	
	Wind_Vg[0]=V_wind*cos(Wind_type[1]*DEG2RAD)*Wind_type[0];
	Wind_Vg[1]=0.;
	Wind_Vg[2]=-V_wind*sin(Wind_type[1]*DEG2RAD)*Wind_type[0]+sqrt(state_s[0]*state_s[0]+state_s[2]*state_s[2])*WE;
	
	if((H<Wind_type[2])&&(H>Wind_type[3]))
	{	
		Wind_Vg[0]=Wind_Vg[0]+Wind_type[4]*cos(Wind_type[5]*DEG2RAD); 
		Wind_Vg[2]=Wind_Vg[2]+Wind_type[4]*sin(-Wind_type[5]*DEG2RAD);
	}
	
	if((H<Wind_type[6])&&(H>Wind_type[7]))
	{	
		Wind_Vg[1]= Wind_type[8];
	}
	
	L=L+WE*time;
	double T_g_e[3][3]={cos(L)*cos(pi/2.-B), -cos(L)*sin(pi/2-B) , sin(L),//地理系到地心系的转换矩阵
		sin(pi/2.-B)        , cos(pi/2.-B)         , 0.,
		-sin(L)*cos(pi/2.-B), sin(L)*sin(pi/2.-B) , cos(L)};
	
	Wind_Ve[0]=T_g_e[0][0]*Wind_Vg[0]+T_g_e[0][1]*Wind_Vg[1]+T_g_e[0][2]*Wind_Vg[2];  //--北
	Wind_Ve[1]=T_g_e[1][0]*Wind_Vg[0]+T_g_e[1][1]*Wind_Vg[1]+T_g_e[1][2]*Wind_Vg[2];  //--天
	Wind_Ve[2]=T_g_e[2][0]*Wind_Vg[0]+T_g_e[2][1]*Wind_Vg[1]+T_g_e[2][2]*Wind_Vg[2];  //--东
}
/**************************************
函数名: Fluent
描述: 计算攻角，侧滑，马赫数
输入: 
输出: 
**************************************/
void CMissile::Fluent(double state_s[], double wind[], double LBH[], double fluent[])
{
	double a_real,b_real,m_real;
	
	double q0=state_s[6];  //体系－》地心系
	double q1=state_s[7];	
	double q2=state_s[8];
	double q3=state_s[9];
	
	double H=LBH[2];	//高度
	double Mach=20.0468*sqrt(288.15-0.65*H/100); //voice speed
	//---->地系下的速度
	double Vxg=state_s[3];
	double Vyg=state_s[4];
	double Vzg=state_s[5];
	double Vg[3]={Vxg,Vyg,Vzg};
	
	//---->地系下弹体相对风的速度
	double Vgf[3];
	for(int i1=0;i1<3;i1++)
		Vgf[i1]=Vg[i1]-wind[i1];
	
	//---->弹体系下的气流速度
	double Vtf[3];
	Vtf[0]=(q0*q0+q1*q1-q2*q2-q3*q3)*Vgf[0]+2*(q3*q0+q1*q2)*Vgf[1]+2*(q1*q3-q0*q2)*Vgf[2];
	Vtf[1]=2*(q1*q2-q0*q3)*Vgf[0]+(q0*q0-q1*q1+q2*q2-q3*q3)*Vgf[1]+2*(q1*q0+q3*q2)*Vgf[2];
	Vtf[2]=2*(q1*q3+q0*q2)*Vgf[0]+2*(q2*q3-q0*q1)*Vgf[1]+(q0*q0-q1*q1-q2*q2+q3*q3)*Vgf[2];
	
	//---->求迎角和侧滑角
	a_real=asin(-Vtf[1]/sqrt(Vtf[0]*Vtf[0]+Vtf[1]*Vtf[1]))*RAD2DEG;
	b_real=asin(Vtf[2]/sqrt(Vtf[0]*Vtf[0]+Vtf[2]*Vtf[2]+Vtf[1]*Vtf[1]))*RAD2DEG;
	m_real=sqrt(Vgf[0]*Vgf[0]+Vgf[1]*Vgf[1]+Vgf[2]*Vgf[2])/Mach;  //马赫数
	
	fluent[0]=a_real;
	fluent[1]=b_real;
	fluent[2]=m_real;
}
/**************************************
函数名: Movement
描述: 运动学方程
输入: 
输出: 
**************************************/
void CMissile::Movement(double time, double state_s[], double C_air[], double fluent[], double LBH[], double at_air1[], double d_state_s[])
{
	//static double dwx=0,dwy=0,dwz=0;
	double	m_real=fluent[2];
	double	L=LBH[0],B=LBH[1],H=LBH[2];
	
	double T_g_e[3][3]={ cos(L+WE*time)*cos(pi/2.-B),  -cos(L+WE*time)*sin(pi/2-B) , sin(L+WE*time),//地理系到地心系的转换矩阵
		sin(pi/2.-B)			   ,   cos(pi/2.-B)		           , 0.0,
		-sin(L+WE*time)*cos(pi/2.-B), sin(L+WE*time)*sin(pi/2.-B) , cos(L+WE*time)};
	
	double	q0=state_s[6];
	double	q1=state_s[7];
	double	q2=state_s[8];
	double	q3=state_s[9];
	
	double	R=sqrt(q0*q0+q1*q1+q2*q2+q3*q3);
	
	//---->四元数归一
	q0=q0/R;
	q1=q1/R;
	q2=q2/R;
	q3=q3/R;

	//---->坐标转换，地系到机体系
	
	double wx=state_s[10];
	double wy=state_s[11];
	double wz=state_s[12];
	
	//---->气动系数
	double Cx=C_air[0];    //前 上 右  
	double Cy=C_air[1];
	double Cz=C_air[2];
	double Cmx=C_air[3];
	double Cmy=C_air[4];
	double Cmz=C_air[5];
	
	//---->参数计算
	double LocalMach=20.0468*sqrt(288.15-0.65*H/100); //speed of voice
	double Vel=LocalMach*m_real;
	double G_e[3],G_g[3]={0.,-9.8012,0.};
	double Re=sqrt(state_s[0]*state_s[0]+state_s[1]*state_s[1]+state_s[2]*state_s[2]);
	
	double Gwe=WE*WE*sqrt(state_s[0]*state_s[0]+state_s[2]*state_s[2]);
	
	G_e[0]=T_g_e[0][0]*G_g[0]+T_g_e[0][1]*G_g[1]+T_g_e[0][2]*G_g[2]-Gwe*state_s[0]/sqrt(state_s[0]*state_s[0]+state_s[2]*state_s[2]);
	G_e[1]=T_g_e[1][0]*G_g[0]+T_g_e[1][1]*G_g[1]+T_g_e[1][2]*G_g[2];
	G_e[2]=T_g_e[2][0]*G_g[0]+T_g_e[2][1]*G_g[1]+T_g_e[2][2]*G_g[2]-Gwe*state_s[2]/sqrt(state_s[0]*state_s[0]+state_s[2]*state_s[2]);

	
	double rou=9.80665*(10.19716213*exp(log(0.101324*10000)-9.80665/(-6.5*0.001)/287.05287*log(1+(-6.5*0.001)*(H)/288.15)))/287.05287/(288.15-0.65*H/100); 
	double Q=rou*Vel*Vel/2.0; //the dynamical pressure
	
	double Mass,P,J[3],delt_cent;
	Engine(time,&Mass,&P,J,&delt_cent);     //发动机质心偏移
	double Jx,Jy,Jz;
	Jx = J[0];
	Jy = J[1];
	Jz = J[2];

	gOUT.Jx = Jx;
	gOUT.Jy = Jy;
	gOUT.Jz = Jz;
   
	Angle_Horizontal = 0.0/60.0/57.3,  Angle_Vertical = 0.0/60/57.3; //推力矢量与弹体坐标系的夹角
	memset(thrust_error,0,sizeof(thrust_error));//发动机的推力偏心在弹体坐标系下的投影（x,y,z）,单位（m）
	//thrust_error[3] = {-0.00,0.00,0.00};//
	
	double P_X = 0., P_Y = 0., P_Z = 0.;                      //推力在弹体坐标系下各轴的分量
	double M_px = 0., M_py = 0., M_pz = 0.;                   //推力偏心矩在弹体坐标系下的投影

	P_X = P*cos(Angle_Vertical)*cos(Angle_Horizontal);
	P_Y = P*sin(Angle_Vertical);
	P_Z = P*cos(Angle_Vertical)*sin(Angle_Horizontal);


	M_px = -P_Y * (thrust_error[2] + mdo[2]) + P_Z * (thrust_error[1] + mdo[1]);              //20150601 cjf 质心偏差对发动机力矩
    M_py =  P_X * (thrust_error[2] + mdo[2]) - P_Z * (thrust_error[0] + mdo[0] + delt_cent);
	M_pz = -P_X * (thrust_error[1] + mdo[1]) + P_Y * (thrust_error[0] + mdo[0] + delt_cent);

	//推力偏心对力的影响
	at_air1[0] = (P*cos(Angle_Vertical)*cos(Angle_Horizontal) + Cx*Q*Sref)/Mass + ax_noise;  //轴向
	at_air1[1] = (P*sin(Angle_Vertical) + Cy*Q*Sref)/Mass + ay_noise;					     //法向
	at_air1[2] = (P*cos(Angle_Vertical)*sin(Angle_Horizontal) + Cz*Q*Sref)/Mass + az_noise;  //侧向

	//将结构质心偏差引起的力矩变化放在AeroBase()函数中计算力矩系数时实现，20130814mwy
	//推力、推力偏心、质心偏心对力矩的影响
	STA.dwx= ( Cmx*Q*Sref*Lref - (Jz-Jy)*wz*wy+ Jyz*(wy*wy-wz*wz)+ Jxz*(STA.dwz+wx*wy)+ Jxy*(STA.dwy-wx*wz) + M_px)/Jx; 
	STA.dwy= ( Cmy*Q*Sref*Lref - (Jx-Jz)*wx*wz+ Jxz*(wz*wz-wx*wx)+ Jxy*(STA.dwx+wy*wz)+ Jyz*(STA.dwz-wx*wy) + M_py)/Jy;  
	STA.dwz= ( Cmz*Q*Sref*Lref - (Jy-Jx)*wy*wx+ Jxy*(wx*wx-wy*wy)+ Jyz*(STA.dwy+wx*wz)+ Jxz*(STA.dwx-wy*wz) + M_pz)/Jz;

    float Lx= 0.;  //在真实质心前为正
	/*加杆臂效应*/	
	double at_air[3];
	at_air[0] =at_air1[0];	
	at_air[1] =at_air1[1]+STA.dwz*Lx;   //俯仰	
	at_air[2] =at_air1[2]-STA.dwy*Lx;   //偏航
	
	//---->体系的加速度转换到地系
	double ae_air[3],ae[3];
	ae_air[0]=(q0*q0+q1*q1-q2*q2-q3*q3)*at_air1[0]+2*(-q3*q0+q1*q2)*at_air1[1]+2*(q1*q3+q0*q2)*at_air1[2];
	ae_air[1]=(q0*q0-q1*q1+q2*q2-q3*q3)*at_air1[1]+2*(q3*q0+q1*q2)*at_air1[0]+2*(-q1*q0+q3*q2)*at_air1[2];
	ae_air[2]=2*(q1*q3-q0*q2)*at_air1[0]+2*(q2*q3+q0*q1)*at_air1[1]+(q0*q0-q1*q1-q2*q2+q3*q3)*at_air1[2];	
	ae[0]=ae_air[0]+G_e[0];
	ae[1]=ae_air[1]+G_e[1];
	ae[2]=ae_air[2]+G_e[2];
	
	//---->机体系下的角加速度转换到地系下
	double 	dQ[4];
	dQ[0]=0.5*(-q1*wx-q2*wy-q3*wz);
	dQ[1]=0.5*(q0*wx-q3*wy+q2*wz);
	dQ[2]=0.5*(q3*wx+q0*wy-q1*wz);
	dQ[3]=0.5*(-q2*wx+q1*wy+q0*wz);
	
	d_state_s[0]=state_s[3];
	d_state_s[1]=state_s[4];
	d_state_s[2]=state_s[5];
	d_state_s[3]=ae[0];
	d_state_s[4]=ae[1];
	d_state_s[5]=ae[2];
	d_state_s[6]=dQ[0];
	d_state_s[7]=dQ[1];
	d_state_s[8]=dQ[2];
	d_state_s[9]=dQ[3];
	d_state_s[10]=STA.dwx;
	d_state_s[11]=STA.dwy;
	d_state_s[12]=STA.dwz;
	
	gOUT.alpha=fluent[0];
	gOUT.beta= fluent[1];
	gOUT.mach= fluent[2];
	gOUT.wx= wx;
	gOUT.wy= wy;
	gOUT.wz= wz;
	gOUT.accX= at_air1[0];
	gOUT.accY= at_air1[1];
	gOUT.accZ= at_air1[2];
	gOUT.Q= Q;
    gOUT.Vel= Vel; //只在Margin()函数中使用

	gOUT.cx= C_air[0];
	gOUT.cy= C_air[1];
	gOUT.cz= C_air[2];
	gOUT.Cmx=C_air[3];
	gOUT.Cmy=C_air[4];
	gOUT.Cmz=C_air[5];
}
/**************************************
函数名: Engine
描述: 发动机（燃烧过程中质量，推力，转动惯量及重心的计算）
输入: 
输出: 
**************************************/
void CMissile::Engine(double time, double *Mass, double *P, double J[], double *delt_cent)
{
	double delt_mass=0;
	double Tp1 = Tpstart2-Tpstart1;
	double Tp2 = Tpstart3-Tpstart2;
		
	//发动机燃烧质量和推力的变化
	if(time <= Tpstart1)//
	{
		*P = 0;
		*Mass = Mass0;
		J[0] = JX;
		J[1] = JY;
		J[2] = JZ;
		*delt_cent=0;
	}
	else if((time>Tpstart1)&&(time<=(Tpstart2)))
	{
		*P = P1;
		*Mass = Mass0 - ((Mass0 - Mass1)/Tp1)*(time-Tpstart1);	
		J[0] = JX +(JX-jx)/(Mass0-Mass2)*(*Mass-Mass0);
		J[1] = JY +(JY-jy)/(Mass0-Mass2)*(*Mass-Mass0);
		J[2] = JZ +(JZ-jz)/(Mass0-Mass2)*(*Mass-Mass0);
		 delt_mass=*Mass-Mass0;
		*delt_cent=(delt_mass)*(G_Cabin-G_CabinFuel)/(Mass0-Mass2)/1000;
	}
	else if((time>Tpstart2)&&(time<=Tpstart3))
	{
		*P = P2;
		*Mass = Mass1 - ((Mass1 - Mass2)/Tp2)*(time-Tpstart2);	
		J[0] = JX +(JX-jx)/(Mass0-Mass2)*(*Mass-Mass0);
		J[1] = JY +(JY-jy)/(Mass0-Mass2)*(*Mass-Mass0);
		J[2] = JZ +(JZ-jz)/(Mass0-Mass2)*(*Mass-Mass0);

	    delt_mass=*Mass-Mass0;
		*delt_cent=(delt_mass)*(G_Cabin-G_CabinFuel)/(Mass0-Mass2)/1000;
	}
	else
	{
		*P = 0;
		*Mass = Mass2;
		J[0] = jx;
		J[1] = jy;
		J[2] = jz;

		*delt_cent=-(G_Cabin-G_CabinFuel)/1000;
	}

	gOUT.P_out = *P;
	gOUT.Mass_out = *Mass;
}
/**************************************
函数名: Aerodynamics
描述: 空气动力学插值部分（包括气动插值与动导数插值）
输入: 
输出: 
**************************************/
int CMissile::Aerodynamics(double time, double heg, AeroBias mAeroBias, double fluent[], double state_s[], double du[], double C_air[], int body_traj)
{
	double Mxyz[5];
	double du1[3];
	double fluent1[3];
	double CairBase[6];
	double CairBias[6];
	double beta,alpha,mach;
	double dx,dy,dz;
	
	alpha= fluent[0];
	beta= fluent[1];
	mach= fluent[2];
	dx= du[1];
	dy= du[2];
	dz= du[0];
	
	double deltaRudder=5.0, deltaBeta=4.0, deltaAlpha=3.0;
	double mz2alpha=0, mz2deltaz=0;	
	double mx2beta=0, my2beta=0;
	
	AeroBase(time,fluent,du, CairBase,body_traj);
	AeroWxyz(heg,fluent,state_s, Mxyz);	
	
	du1[0]=du[0];
	du1[1]=du[1]+deltaRudder;
	du1[2]=du[2];
	AeroBase(time,fluent,du1, CairBias,body_traj);
	double mx2dx= (CairBias[3]-CairBase[3])/deltaRudder;  
	
	du1[0]=du[0];
	du1[1]=du[1];
	du1[2]=du[2]+deltaRudder;
	AeroBase(time,fluent,du1, CairBias,body_traj);
	double my2dy= (CairBias[4]-CairBase[4])/deltaRudder;
	double mx2dy= (CairBias[3]-CairBase[3])/deltaRudder;
	
	du1[0]=du[0]+deltaRudder;
	du1[1]=du[1];
	du1[2]=du[2];
	AeroBase(time,fluent,du1, CairBias,body_traj);
	double mz2dz= (CairBias[5]-CairBase[5])/deltaRudder;  
	
	fluent1[0]= fluent[0];
	fluent1[1]= fluent[1]+ deltaBeta;
	fluent1[2]= fluent[2];
	AeroBase(time,fluent1,du, CairBias,body_traj);
	mx2beta= (CairBias[3]-CairBase[3])/deltaBeta; 
	my2beta= (CairBias[4]-CairBase[4])/deltaBeta;
	
	fluent1[0]= fluent[0]+ deltaAlpha;
	fluent1[1]= fluent[1];
	fluent1[2]= fluent[2];
    AeroBase(time,fluent1,du, CairBias,body_traj);
	mz2alpha=(CairBias[5]-CairBase[5])/deltaAlpha;
	
	
	
	C_air[0]= CairBase[0];//*(1.0+mAeroBias.dragBias)+ed_air[0];
	C_air[1]= CairBase[1];//*(1.0+mAeroBias.liftBias)+ed_air[1];
	C_air[2]= CairBase[2];//*(1.0+mAeroBias.lateralBias)+ed_air[2];
	
	C_air[3]= CairBase[3]+ Mxyz[0]+Mxyz[3]+ mx2beta*beta*mAeroBias.mx2betaBias+ mx2dx*dx*mAeroBias.mx2dxBias+ed_air[3];
	C_air[4]= CairBase[4]+ Mxyz[1]+Mxyz[4]+ my2beta*beta*mAeroBias.my2betaBias+ my2dy*dy*mAeroBias.my2dyBias+ed_air[4];
	C_air[5]= CairBase[5]+ Mxyz[2]+mz2alpha*alpha*mAeroBias.mz2alphaBias+ mz2dz*dz*mAeroBias.mz2dzBias+ed_air[5];
	
	
	return 1;
}
/**************************************
函数名: AeroBase
描述: 气动插值（chach与chachR完成了铰链力矩与舵弯矩的插值，chach0和chach1完成气动数据插值）
输入: 
输出: 
**************************************/
int CMissile::AeroBase(double time, double fluent[], double du[], double C_air[], int body_traj)
{
	double alpha=fluent[0]; double beta=fluent[1];   double Mach=fluent[2];
	double duX=du[1];       double duY=du[2];        double duZ=du[0];
	
	double df0= 0;
	int i1,i2,i3,i4;
	double af2,bt2,duf2,dup2,dug2;
	double a0,b0,c0,d0;
	double ca11,cn11,cz11,cmx11,cmy11,cmz11;
	double ca12,cn12,cz12,cmx12,cmy12,cmz12;
	double ca13,cn13,cz13,cmx13,cmy13,cmz13;
	double ca10,cn10,cz10,cmx10,cmy10,cmz10;

	double mh11,mh22,mh33,mh44,mr11,mr22,mr33,mr44;//20130312

    double Mass,P,J[3],delt_cent;         //20150601 cjf 质心偏移
	Engine(time,&Mass,&P,J,&delt_cent);
	gOUT.delt_cent = delt_cent;
	
	chachR(0,fluent[2],du[1]-du[2]-du[0],0,fluent[0],a0,b0,c0,d0,i1,i2,i3,i4);
	mh11=chach(i1,0,i3,i4,a0,b0,c0,d0,mh1); 
	mr11=chach(i1,0,i3,i4,a0,b0,c0,d0,mr1);
	
	chachR(0,fluent[2],du[1]+du[2]-du[0],0,fluent[0],a0,b0,c0,d0,i1,i2,i3,i4);
	mh22=chach(i1,0,i3,i4,a0,b0,c0,d0,mh2);
	mr22=chach(i1,0,i3,i4,a0,b0,c0,d0,mr2);

	chachR(0,fluent[2],du[1]+du[2]+du[0],0,fluent[0],a0,b0,c0,d0,i1,i2,i3,i4);
	mh33=chach(i1,0,i3,i4,a0,b0,c0,d0,mh3);
	mr33=chach(i1,0,i3,i4,a0,b0,c0,d0,mr3);

	chachR(0,fluent[2],du[1]-du[2]+du[0],0,fluent[0],a0,b0,c0,d0,i1,i2,i3,i4);
	mh44=chach(i1,0,i3,i4,a0,b0,c0,d0,mh4);
	mr44=chach(i1,0,i3,i4,a0,b0,c0,d0,mr4);

  	gOUT.JLLjD1 = mh11;   //铰链力矩
	gOUT.JLLjD2 = mh22;
	gOUT.JLLjD3 = mh33;
	gOUT.JLLjD4 = mh44;

	gOUT.WjD1 = mr11;   //弯矩
	gOUT.WjD2 = mr22;
	gOUT.WjD3 = mr33;
	gOUT.WjD4 = mr44;

	
	if(beta>=0.0) 
	{
		af2=alpha;     
		bt2=beta;
		duf2=duZ;
		dup2=duY;
		dug2=duX;
	}
	else                      
	{
		af2=alpha;
		bt2=-beta;
		duf2=duZ;
		dup2=-duY;
		dug2=-duX;
	}
	
	//------->求解俯仰通道的插值数据		
	chach1(3,Mach,duf2,bt2,af2,a0,b0,c0,d0,i1,i2,i3,i4);
	ca11=chachO(i1,i2,i3,i4,a0,b0,c0,d0,caZ);
	cn11=chachO(i1,i2,i3,i4,a0,b0,c0,d0,cnZ);
	cz11=chachO(i1,i2,i3,i4,a0,b0,c0,d0,czZ);
	cmz11=chachO(i1,i2,i3,i4,a0,b0,c0,d0,cmzZ);
	cmy11=chachO(i1,i2,i3,i4,a0,b0,c0,d0,cmyZ);
	cmx11=chachO(i1,i2,i3,i4,a0,b0,c0,d0,cmxZ);
	
	//------->求解偏航通道的插值数据	
	chach1(2,Mach,dup2,bt2,af2,a0,b0,c0,d0,i1,i2,i3,i4);
	ca12=chachO(i1,i2,i3,i4,a0,b0,c0,d0,caY);
	cn12=chachO(i1,i2,i3,i4,a0,b0,c0,d0,cnY);
	cz12=chachO(i1,i2,i3,i4,a0,b0,c0,d0,czY);
	cmz12=chachO(i1,i2,i3,i4,a0,b0,c0,d0,cmzY);
	cmy12=chachO(i1,i2,i3,i4,a0,b0,c0,d0,cmyY);
	cmx12=chachO(i1,i2,i3,i4,a0,b0,c0,d0,cmxY);
	
	//------->求解滚动通道的插值数据	
	chach1(1,Mach,dug2,bt2,af2,a0,b0,c0,d0,i1,i2,i3,i4);
	ca13=chachO(i1,i2,i3,i4,a0,b0,c0,d0,caX);
	cn13=chachO(i1,i2,i3,i4,a0,b0,c0,d0,cnX);
	cz13=chachO(i1,i2,i3,i4,a0,b0,c0,d0,czX);
	cmz13=chachO(i1,i2,i3,i4,a0,b0,c0,d0,cmzX);
	cmy13=chachO(i1,i2,i3,i4,a0,b0,c0,d0,cmyX);
	cmx13=chachO(i1,i2,i3,i4,a0,b0,c0,d0,cmxX);
	
	//------->求解0舵偏系数
	df0=0;
	chach1(3,Mach,df0,bt2,af2,a0,b0,c0,d0,i1,i2,i3,i4);
	ca10=chachO(i1,i2,i3,i4,a0,b0,c0,d0,caZ);
	cn10=chachO(i1,i2,i3,i4,a0,b0,c0,d0,cnZ);
	cz10=chachO(i1,i2,i3,i4,a0,b0,c0,d0,czZ);
	cmz10=chachO(i1,i2,i3,i4,a0,b0,c0,d0,cmzZ);
	cmy10=chachO(i1,i2,i3,i4,a0,b0,c0,d0,cmyZ);
	cmx10=chachO(i1,i2,i3,i4,a0,b0,c0,d0,cmxZ);	
	

	//------->求解综合系数
	C_air[0]= ca11+ca12+ca13-2*ca10;
	C_air[1]= cn11+cn12+cn13-2*cn10;
	C_air[2]= cz11+cz12+cz13-2*cz10;
	C_air[3]= cmx11+cmx12+cmx13-2*cmx10;	
	C_air[4]= cmy11+cmy12+cmy13-2*cmy10;
	C_air[5]= cmz11+cmz12+cmz13-2*cmz10;
	
	  if(beta<0)                      
	{
		C_air[2]= -C_air[2];
		C_air[4]= -C_air[4];
		C_air[3]= -C_air[3];
	} 
	///////////////////
	double C_air_v[6];	
	C_air_v[0] = cos(alpha*DEG2RAD)*cos(beta*DEG2RAD)*C_air[0]- sin(alpha*DEG2RAD)*cos(beta*DEG2RAD)*C_air[1]+sin(beta*DEG2RAD)*C_air[2];
	C_air_v[1] = sin(alpha*DEG2RAD)*C_air[0]+ cos(alpha*DEG2RAD)*C_air[1];
	C_air_v[2] = -cos(alpha*DEG2RAD)*sin(beta*DEG2RAD)*C_air[0]+ sin(alpha*DEG2RAD)*sin(beta*DEG2RAD)*C_air[1]+cos(beta*DEG2RAD)*C_air[2];

	C_air_v[0] = C_air_v[0]*(1.0+mAeroBias.dragBias)+ed_air[0];  
	C_air_v[1] = C_air_v[1]*(1.0+mAeroBias.liftBias)+ed_air[1];  
	C_air_v[2] = C_air_v[2]*(1.0+mAeroBias.lateralBias)+ed_air[2];
	
	C_air[0] = cos(alpha*DEG2RAD)*cos(beta*DEG2RAD)*C_air_v[0]+sin(alpha*DEG2RAD)*C_air_v[1]
		       -cos(alpha*DEG2RAD)*sin(beta*DEG2RAD)*C_air_v[2];
	C_air[1] = -sin(alpha*DEG2RAD)*cos(beta*DEG2RAD)*C_air_v[0]+cos(alpha*DEG2RAD)*C_air_v[1]
			+sin(alpha*DEG2RAD)*sin(beta*DEG2RAD)*C_air_v[2];
	C_air[2] =  sin(beta*DEG2RAD)*C_air_v[0]+cos(beta*DEG2RAD)*C_air_v[2];


	  
    //	发动机燃烧质心变化，及结构质心偏差引起的力矩系数变化（在力系数拉偏之后添加）     //20150508 cjf
	C_air[3]= C_air[3] - C_air[2]*mdo[1]/Lref + C_air[1]*mdo[2]/Lref;     //Cmx
	C_air[4]= C_air[4] + C_air[2]*(delt_cent+mdo[0])/Lref - C_air[0]*mdo[2]/Lref;  //Cmy
	C_air[5]= C_air[5] - C_air[1]*(delt_cent+mdo[0])/Lref + C_air[0]*mdo[1]/Lref;  //Cmz



	if(body_traj==2)
	{
		C_air[3]= C_air[3];
		C_air[4]= C_air[4];
		C_air[5]= C_air[5];
		C_air[0]= -C_air_v[0];
		C_air[1]= C_air_v[1];
		C_air[2] = C_air_v[2];
	}

	gOUT.cd = -C_air_v[0];
	gOUT.cl =  C_air_v[1];
	gOUT.czw=  C_air_v[2];
	gOUT.Cl2Cd = C_air_v[1]/(-C_air_v[0]);

	return 0;

}
/**************************************
函数名: AeroWxyz
描述: 动导数插值
输入: 
输出: 
**************************************/
int CMissile::AeroWxyz(double heg, double fluent[], double state_s[], double Mxyz[])
{
	double Mach=fluent[2];
	double LocalMach= 20.0468*sqrt(288.15-0.65*heg/100); //speed of voice
	double Vel= LocalMach*Mach;
	
    double Mx_wx, Mx_wy, My_wx, My_wy, Mz_wz;
 	double wx,wy,wz;
	
	wx=state_s[10];
	wy=state_s[11];
	wz=state_s[12];
	
	
	int Num_Ma,Num_alpha;
	double aero_dot[3];
	insert_num(fluent[2],fluent[0],Num_Ma,Num_alpha);
	insert_data(fluent[2],fluent[0],Num_Ma,Num_alpha,aero_dot);
	Mx_wx=aero_dot[0];
	My_wy=aero_dot[1];
	Mz_wz=aero_dot[2];//insert_data函数中已将Mzalphadot与Mzwz叠加作为新的Mzwz
	Mx_wy=0;
	My_wx=0;
	
	
	Mxyz[0]= Mx_wx*(1+mAeroBias.mx2wxBias)*wx*Lref/Vel; 
	Mxyz[1]= My_wy*(1+mAeroBias.my2wyBias)*wy*Lref/Vel;
	Mxyz[2]= Mz_wz*(1+mAeroBias.mz2wzBias)*wz*Lref/Vel;
	Mxyz[3]= Mx_wy*wy*Lref/Vel;
	Mxyz[4]= My_wx*wx*Lref/Vel;
	
	return 1;
}
/**************************************
函数名: chachR
描述: 舵弯矩和铰链力矩插值
输入: 
输出: 
**************************************/
void CMissile::chachR(int dxdydz, double amach, double du1, double bt1, double af1, double &a0, double &b0, double &c0, double &d0, int &ii1, int &ii2, int &ii3, int &ii4)
{
	double *dou;
	int i=0;
	int nDou;	
	int jj11,jj22,jj33,jj44; //当前节点所在区间的后边界
	double amach_z,du1_z,bt1_z,af1_z;
	
	amach_z=amach;
	du1_z=du1;
	bt1_z=bt1;
	af1_z=af1;
	
	switch(dxdydz)
	{
	case 0:
		nDou= nDJ1;
		dou= new double[nDou];
		for( i=0;i<nDou;i++)
			dou[i]=DJ1[i];
		break;
	}
	//注意：此处与原来不同，将内插改为外插；	
	if(amach>=ama1[nmT1-1])		//确保每一个参数都在插值范围内
		amach=ama1[nmT1-1]-1.e-5;
	if(amach<=ama1[0]) 
		amach=ama1[0]+1.e-5;
	
	if(du1>=dou[nDou-1])  
		du1=dou[nDou-1]-1.e-5;
	if(du1<=dou[0])  
		du1=dou[0]+1.e-5;
	
	if(af1>=arf1[naT1-1])  
		af1=arf1[naT1-1]-1.e-5; 
	if(af1<=arf1[0]) 
		af1=arf1[0]+1.e-5;
	
	if(bt1>=btT1[nbT1-1])   
		bt1=btT1[nbT1-1]-1.e-5;
	if(bt1<=btT1[0])  
		bt1=btT1[0]+1.e-5;
	
	
	for(ii1=0;ii1<=nDou-1;ii1++)
	{
		if((du1>=dou[ii1])&&(du1<dou[ii1+1]))
			break;
	}
	jj11=ii1+1;	
	
	for(ii2=0;ii2<=nbT1-1;ii2++)
	{
		if((bt1>=btT1[ii2])&&(bt1<btT1[ii2+1]))
			break;
	}
	jj22=ii2+1;	
	
	for(ii3=0;ii3<=nmT1-1;ii3++)
	{
		if((amach>=ama1[ii3])&&(amach<ama1[ii3+1]))	
			break;
	}
	jj33=ii3+1;
	
	for(ii4=0;ii4<=naT1-1;ii4++)
	{
		if((af1>=arf1[ii4])&&(af1<arf1[ii4+1]))
			break;
	}
	
	jj44=ii4+1;
	
	a0=(du1_z-dou[ii1])/(dou[jj11]-dou[ii1]); //当前舵偏值在dou[ii1]~dou[jj1]区间内所占的比例系数
	b0=(bt1_z-btT1[ii2])/(btT1[jj22]-btT1[ii2]);
	c0=(amach_z-ama1[ii3])/(ama1[jj33]-ama1[ii3]);
	d0=(af1_z-arf1[ii4])/(arf1[jj44]-arf1[ii4]);	
	
	delete dou;
	dou=NULL;
}
/**************************************
函数名: chach
描述: 舵弯矩和铰链力矩插值
输入: 
输出: 
**************************************/
double CMissile::chach(int j1, int j2, int j3, int j4, double a0, double b0, double c0, double d0, double f[][nbT1][nmT1][naT1])
{
	//j1,j2,j3,j4当前节点所在区间的前边界，a0,b0,c0,d0当前节点在该区间内的比例系数
	
	int j11,j22,j33,j44;
	   double g0,g1,g01,g2,g3,g23,g0123,g4,g5,g45,g6,g7,g67,g4567,gg;
	   j11=j1+1;  j22=j2+1;  j33=j3+1;  j44=j4+1; //区间后边界
	   g0=f[j1][j2][j3][j4]+(f[j1][j22][j3][j4]-f[j1][j2][j3][j4])*b0;
	   g1=f[j11][j2][j3][j4]+(f[j11][j22][j3][j4]-f[j11][j2][j3][j4])*b0;
	   g01=g0+(g1-g0)*a0;
	   g2=f[j1][j2][j33][j4]+(f[j1][j22][j33][j4]-f[j1][j2][j33][j4])*b0;
	   g3=f[j11][j2][j33][j4]+(f[j11][j22][j33][j4]-f[j11][j2][j33][j4])*b0;
	   g23=g2+(g3-g2)*a0;
	   g0123=g01+(g23-g01)*c0;
	   g4=f[j1][j2][j3][j44]+(f[j1][j22][j3][j44]-f[j1][j2][j3][j44])*b0;
	   g5=f[j11][j2][j3][j44]+(f[j11][j22][j3][j44]-f[j11][j2][j3][j44])*b0;
	   g45=g4+(g5-g4)*a0;
	   g6=f[j1][j2][j33][j44]+(f[j1][j22][j33][j44]-f[j1][j2][j33][j44])*b0;
	   g7=f[j11][j2][j33][j44]+(f[j11][j22][j33][j44]-f[j11][j2][j33][j44])*b0;
	   g67=g6+(g7-g6)*a0;
	   g4567=g45+(g67-g45)*c0;
	   return gg=g0123+(g4567-g0123)*d0;
}
/**************************************
函数名: chachO
描述: 气动插值
输入: 
输出: 
**************************************/
double CMissile::chachO(int j1, int j2, int j3, int j4, double a0, double b0, double c0, double d0, double f[][nb][nm][na])
{
	int j11,j22,j33,j44;
	double g0,g1,g01,g2,g3,g23,g0123,g4,g5,g45,g6,g7,g67,g4567,gg;
	j11=j1+1;  j22=j2+1;  j33=j3+1;  j44=j4+1;
	g0=f[j1][j2][j3][j4]+(f[j1][j22][j3][j4]-f[j1][j2][j3][j4])*b0;
	g1=f[j11][j2][j3][j4]+(f[j11][j22][j3][j4]-f[j11][j2][j3][j4])*b0;
	g01=g0+(g1-g0)*a0;
	g2=f[j1][j2][j33][j4]+(f[j1][j22][j33][j4]-f[j1][j2][j33][j4])*b0;
	g3=f[j11][j2][j33][j4]+(f[j11][j22][j33][j4]-f[j11][j2][j33][j4])*b0;
	g23=g2+(g3-g2)*a0;
	g0123=g01+(g23-g01)*c0;
	g4=f[j1][j2][j3][j44]+(f[j1][j22][j3][j44]-f[j1][j2][j3][j44])*b0;
	g5=f[j11][j2][j3][j44]+(f[j11][j22][j3][j44]-f[j11][j2][j3][j44])*b0;
	g45=g4+(g5-g4)*a0;
	g6=f[j1][j2][j33][j44]+(f[j1][j22][j33][j44]-f[j1][j2][j33][j44])*b0;
	g7=f[j11][j2][j33][j44]+(f[j11][j22][j33][j44]-f[j11][j2][j33][j44])*b0;
	g67=g6+(g7-g6)*a0;
	g4567=g45+(g67-g45)*c0;
	return gg=g0123+(g4567-g0123)*d0;
}
/**************************************
函数名: chach1
描述: 气动插值
输入: 
输出: 
**************************************/
void CMissile::chach1(int dxdydz, double amach, double du1, double bt1, double af1, double &a0, double &b0, double &c0, double &d0, int &ii1, int &ii2, int &ii3, int &ii4)
{
	double* dou;
	int i=0;
	int nDou;	
	
	int jj11,jj22,jj33,jj44;
	double amach_z,du1_z,bt1_z,af1_z;
    amach_z=amach;
	du1_z=du1;
	bt1_z=bt1;
	af1_z=af1;
	
	switch(dxdydz)
	{
	case 1:
		nDou= ndx;
		dou= new double[nDou];
		for( i=0;i<nDou;i++)
			dou[i]=dx[i];
		break;
	case 2:          
		nDou= 3;         
		dou= new double[nDou];
		for( i=0;i<nDou;i++)
			dou[i]=dy[i];
		break;
	case 3:
		nDou= ndz;
		dou= new double[nDou];
		for( i=0;i<nDou;i++)
			dou[i]=dz[i];
		break;	
	}
	////确保每一个参数都在插值范围内	
	if(amach>=ama[nm-1])		
		amach=ama[nm-1]-1.e-5;
	if(amach<=ama[0]) 
		amach=ama[0]+1.e-5;
	
	if(du1>=dou[nDou-1])  
		du1=dou[nDou-1]-1.e-5;
	if(du1<=dou[0])  
		du1=dou[0]+1.e-5;
	
	if(af1>=arf[na-1])  
		af1=arf[na-1]-1.e-5;
	if(af1<=arf[0]) 
		af1=arf[0]+1.e-5;
	
	if(bt1>=bt[nb-1])   
		bt1=bt[nb-1]-1.e-5;
	if(bt1<=bt[0])  
		bt1=bt[0]+1.e-5;	
	
	for(ii1=0;ii1<=nDou-1;ii1++)
	{
		if((du1>=dou[ii1])&&(du1<dou[ii1+1]))
			break;
	}
	jj11=ii1+1;	
	
	for(ii2=0;ii2<=nb-1;ii2++)
	{
		if((bt1>=bt[ii2])&&(bt1<bt[ii2+1]))
			break;
	}
	jj22=ii2+1;	
	
	for(ii3=0;ii3<=nm-1;ii3++)
	{
		if((amach>=ama[ii3])&&(amach<ama[ii3+1]))	
			break;
	}
	jj33=ii3+1;
	
	for(ii4=0;ii4<=na-1;ii4++)
	{
		if((af1>=arf[ii4])&&(af1<arf[ii4+1]))
			break;
	}
	jj44=ii4+1;
	
	a0=(du1_z-dou[ii1])/(dou[jj11]-dou[ii1]);
	b0=(bt1_z-bt[ii2])/(bt[jj22]-bt[ii2]);
	c0=(amach_z-ama[ii3])/(ama[jj33]-ama[ii3]);	
	d0=(af1_z-arf[ii4])/(arf[jj44]-arf[ii4]);
	
	delete dou;
	dou=NULL;
}
/****************************************************************************************\
*函数原型:	IMU_Delay
*目的:		惯组延时		
*参数:		
*返回值:		
*备注:			
*修改记录:	日期		作者		备注
\****************************************************************************************/

void CMissile::IMU_Delay()
{
	GyroOut[8][0]= GyroOut[7][0];
	GyroOut[8][1]= GyroOut[7][1];
	GyroOut[8][2]= GyroOut[7][2];
	
	GyroOut[7][0]= GyroOut[6][0];
	GyroOut[7][1]= GyroOut[6][1];
	GyroOut[7][2]= GyroOut[6][2];

	GyroOut[6][0]= GyroOut[5][0];
	GyroOut[6][1]= GyroOut[5][1];
	GyroOut[6][2]= GyroOut[5][2];

	GyroOut[5][0]= GyroOut[4][0];
	GyroOut[5][1]= GyroOut[4][1];
	GyroOut[5][2]= GyroOut[4][2];

	GyroOut[4][0]= GyroOut[3][0];
	GyroOut[4][1]= GyroOut[3][1];
	GyroOut[4][2]= GyroOut[3][2];

	GyroOut[3][0]= GyroOut[2][0];
	GyroOut[3][1]= GyroOut[2][1];
	GyroOut[3][2]= GyroOut[2][2];
	
	GyroOut[2][0]= GyroOut[1][0];
	GyroOut[2][1]= GyroOut[1][1];
	GyroOut[2][2]= GyroOut[1][2];
	
	GyroOut[1][0]= GyroOut[0][0];
	GyroOut[1][1]= GyroOut[0][1];
	GyroOut[1][2]= GyroOut[0][2];
	
	GyroOut[0][0]= state_s[10];//wx
	GyroOut[0][1]= state_s[11];//wy 
	GyroOut[0][2]= state_s[12];//wz

	AcceOut[8][0]= AcceOut[7][0];
	AcceOut[8][1]= AcceOut[7][1];
	AcceOut[8][2]= AcceOut[7][2];
	
	AcceOut[7][0]= AcceOut[6][0];
	AcceOut[7][1]= AcceOut[6][1];
	AcceOut[7][2]= AcceOut[6][2];

	AcceOut[6][0]= AcceOut[5][0];
	AcceOut[6][1]= AcceOut[5][1];
	AcceOut[6][2]= AcceOut[5][2];

	AcceOut[5][0]= AcceOut[4][0];
	AcceOut[5][1]= AcceOut[4][1];
	AcceOut[5][2]= AcceOut[4][2];

	AcceOut[4][0]= AcceOut[3][0];
	AcceOut[4][1]= AcceOut[3][1];
	AcceOut[4][2]= AcceOut[3][2];
	
	AcceOut[3][0]= AcceOut[2][0];
	AcceOut[3][1]= AcceOut[2][1];
	AcceOut[3][2]= AcceOut[2][2];

	AcceOut[2][0]= AcceOut[1][0];
	AcceOut[2][1]= AcceOut[1][1];
	AcceOut[2][2]= AcceOut[1][2];
	
	AcceOut[1][0]= AcceOut[0][0];
	AcceOut[1][1]= AcceOut[0][1];
	AcceOut[1][2]= AcceOut[0][2]; 

    AcceOut[0][0]= at_air[0];//ax
    AcceOut[0][1]= at_air[1];//ay
    AcceOut[0][2]= at_air[2];//az
		
	if(GyroDelay==0)
	{
		
		nIMUData.wy =  GyroOut[0][0] +wy_noise;
		nIMUData.wz = GyroOut[0][1] +wz_noise;
		nIMUData.wx = GyroOut[0][2]+wx_noise;
		
		pBombIMUData.wx=GyroOut[0][0] +wy_noise;
		pBombIMUData.wy = GyroOut[0][1] +wz_noise;
		pBombIMUData.wz = GyroOut[0][2]+wx_noise;
	}
	else if(GyroDelay==1)
	{
				
		nIMUData.wy =  GyroOut[1][0] +wy_noise;
		nIMUData.wz = GyroOut[1][1] +wz_noise;
		nIMUData.wx = GyroOut[1][2]+wx_noise;

		pBombIMUData.wx=GyroOut[1][0] +wy_noise;
		pBombIMUData.wy = GyroOut[1][1] +wz_noise;
		pBombIMUData.wz = GyroOut[1][2]+wx_noise;
	
	}
	else if(GyroDelay==2)
	{
	
		nIMUData.wy =  GyroOut[2][0] +wy_noise;
		nIMUData.wz = GyroOut[2][1] +wz_noise;
		nIMUData.wx = GyroOut[2][2]+wx_noise;

		pBombIMUData.wx=GyroOut[2][0] +wy_noise;
		pBombIMUData.wy = GyroOut[2][1] +wz_noise;
		pBombIMUData.wz = GyroOut[2][2]+wx_noise;
	
	}
	else
	{
    
		nIMUData.wy =  GyroOut[7][0] +wy_noise;
		nIMUData.wz = GyroOut[7][1] +wz_noise;
		nIMUData.wx = GyroOut[7][2]+wx_noise;

		pBombIMUData.wx=GyroOut[7][0] +wy_noise;
		pBombIMUData.wy = GyroOut[7][1] +wz_noise;
		pBombIMUData.wz = GyroOut[7][2]+wx_noise;
	}

	if(AcceDelay==0)
	{	
        nIMUData.ay = AcceOut[0][0]+ay_noise;
		nIMUData.az = AcceOut[0][1]+az_noise;  
		nIMUData.ax = AcceOut[0][2]+ax_noise;

		pBombIMUData.ax = AcceOut[0][0]+ay_noise;
		pBombIMUData.ay= AcceOut[0][1]+az_noise;  
		pBombIMUData.az = AcceOut[0][2]+ax_noise;

	}

	else if(AcceDelay==1)
	{
	     
		nIMUData.ay = AcceOut[1][0]+ay_noise;//ax
		nIMUData.az = AcceOut[1][1]+az_noise;//ay 
		nIMUData.ax = AcceOut[1][2]+ax_noise;

		pBombIMUData.ax = AcceOut[1][0]+ay_noise;
		pBombIMUData.ay= AcceOut[1][1]+az_noise;  
		pBombIMUData.az = AcceOut[1][2]+ax_noise;
	}
	
	else if(AcceDelay==2)
	{
		nIMUData.ay = AcceOut[2][0]+ay_noise;//ax
		nIMUData.az = AcceOut[2][1]+az_noise; //ay 
		nIMUData.ax = AcceOut[2][2]+ax_noise;

		pBombIMUData.ax = AcceOut[2][0]+ay_noise;
		pBombIMUData.ay = AcceOut[2][1]+az_noise;  
		pBombIMUData.az = AcceOut[2][2]+ax_noise;
	}
	else 
	{
		nIMUData.ay = AcceOut[7][0]+ay_noise;//ax
		nIMUData.az = AcceOut[7][1]+az_noise;//ay  
		nIMUData.ax = AcceOut[7][2]+ax_noise;

		pBombIMUData.ax = AcceOut[7][0]+ay_noise;
		pBombIMUData.ay = AcceOut[7][1]+az_noise;  
		pBombIMUData.az = AcceOut[7][2]+ax_noise;
	}
	nIMUData.wy = GyroOut[0][0] +wy_noise;
	nIMUData.wz = GyroOut[0][1] +wz_noise;
	nIMUData.wx = GyroOut[0][2]+wx_noise;
	nIMUData.ay = AcceOut[0][0]+ay_noise;//ax
	nIMUData.az = AcceOut[0][1]+az_noise;//ay 
	nIMUData.ax = AcceOut[0][2]+ax_noise;
}
/****************************************************************************************\
*函数原型:	IMU_nonliner
*目的:		惯组零偏零漂非线性		
*参数:		
*返回值:		
*备注:			
*修改记录:	日期		作者		备注
\****************************************************************************************/
void CMissile::IMU_nonliner()
{
	float gyrod0 = 0.0;		
	float k10 = 0.01;  
	float k50 = 0.001;   //chen xin
	float gyrod0x = 60, gyrod0y = 60, gyrod0z = 60; 
	float k_g_x = 0, k_g_y = 0, k_g_z = 0;
	if(abs(nIMUData.ax)>9.8)///G敏感项
	{
		k_g_x = floor(abs(nIMUData.ax)/9.8);
		nIMUData.wx=nIMUData.wx + k_g_x*18/57.3/3600;		
	}		
	if(abs(nIMUData.ay)>9.8)
	{
		k_g_y = floor(abs(nIMUData.ay)/9.8);
		nIMUData.wy=nIMUData.wy + k_g_y*18/57.3/3600;	
	}
	if(abs(nIMUData.az)>9.8)
	{
		k_g_z = floor(abs(nIMUData.az)/9.8);
		nIMUData.wz=nIMUData.wz + k_g_z*18/57.3/3600;         
	}
	
	
	
	if(abs(nIMUData.ax)>9.8)///acc非线性
	{
		nIMUData.ax=(1.001)*nIMUData.ax ;		
	}		
	if(abs(nIMUData.ay)>9.8)
	{		
		nIMUData.ay=(1.001)*nIMUData.ay ;	
	}
	if(abs(nIMUData.az)>9.8)
	{		
		nIMUData.az=(1.001)*nIMUData.az ;         
	}
	
	if(abs(nIMUData.wx)<=0.1745)
	{
		nIMUData.wx=nIMUData.wx+DEG2RAD*k10;
		//	nIMUData.wx=nIMUData.wx+1.7452e-04;
	}		
	if(abs(nIMUData.wy)<=0.1745)
	{
		nIMUData.wy=nIMUData.wy+DEG2RAD*k10;
		//	nIMUData.wy=nIMUData.wy+1.7452e-04;
	}
	if(abs(nIMUData.wz)<=0.1745)
	{
		nIMUData.wz=nIMUData.wz+DEG2RAD*k10;
		//   nIMUData.wz=nIMUData.wz+1.7452e-04;
	}
	
	if((abs(nIMUData.wx)>0.1745)&&(abs(nIMUData.wx)< 3.4904))
	{
		nIMUData.wx=nIMUData.wx+nIMUData.wx*k50;
	}		
	
	if((abs(nIMUData.wy)>0.1745)&&(abs(nIMUData.wy)< 3.4904))
	{
		nIMUData.wy=nIMUData.wy+nIMUData.wy*k50;
	}
	
	if((abs(nIMUData.wz)>0.1745)&&(abs(nIMUData.wz)< 3.4904))
	{
		nIMUData.wz=nIMUData.wz+nIMUData.wz*k50;
	}
}
/****************************************************************************************\
*函数原型:	NAVAGATION_M
*目的:		导航		
*参数:		
*返回值:		
*备注:			
*修改记录:	日期		作者		备注
\****************************************************************************************/
void CMissile::NAVAGATION_M(int i)
{
	nBombSeverFlag=0;		
	nNaviEstimateFlag=0;
	nGpsPpsArrivedFlag=0;	
	nGpsDataReceivedFlag=0;	
	nComNaviStateFlag=2;		
	nWingSpreadFlag=0;		
	nInitNaviModeFlag='D';
	
	nGpsData.Longitude=LBH[0];
	nGpsData.Latitude =LBH[1];
	nGpsData.Altitude =LBH[2];              
	nGpsData.Ve=LBH[5];
	nGpsData.Vn=LBH[3];
	nGpsData.Vu=LBH[4];
	
	if(i%200 == 0 && i>2 )
	{
		nGpsData.Visible_Star = 6;
		nGpsData.pdop = 1;
		nGpsData.NaviMode = 15;
		nGpsDataReceivedFlag = 1;
		nGpsPpsArrivedFlag = 1;
	}
	else
	{
		nGpsPpsArrivedFlag = 0;	
	}
	
	PlDataUpdate=1;
	nMainIMUData.Longitude=LBH[0];
	nMainIMUData.Latitude=LBH[1];
	nMainIMUData.Altitude=LBH[2];  
	nMainIMUData.Ve=LBH[5]; 
	nMainIMUData.Vn=LBH[3]; 
	nMainIMUData.Vu=LBH[4]; 
	nMainIMUData.Pitch=LBH[8];
	nMainIMUData.Roll=LBH[6];
 	nMainIMUData.Yaw=LBH[7];

	NAVIGATION(
		&PlDataUpdate,		 	//载机数据更新标志
		&nBombSeverFlag,			 //脱插分离标志
		&nNaviEstimateFlag,			 //组合导航评估命令
		&nIMUData,				 	 //子惯导陀螺加表信息
		gyro_offset,			       //陀螺零位
		&nGpsData,                   //GPS信息
		&nGpsPpsArrivedFlag ,		 //收到GPS秒脉冲的标志
		&nGpsDataReceivedFlag,	     //收到GPS数据的标志
		&nMainIMUData,    		//主惯导参数
		&nNaviData,              	 //导航结果输出
		&nNaviMidRst,				 //导航中间结果输出					
		&nComNaviStateFlag,		     //组合导航状态标志
		&nInitNaviModeFlag); 


}
/****************************************************************************************\
*函数原型:	void guid_and_control()
*目的:		制导、控制模块调度		
*参数:		IMU输出，导航输出,飞行周期数，四个舵机控制指令，控制遥测参数，目标位置
*返回值:		
*备注:			
*修改记录:	日期		作者		备注
\****************************************************************************************/

void CMissile::guid_and_control(PNAVI_IMU pIMU, PNAVI_INS pNavi, unsigned int period, PRUDDER_DATA pRudderCommand, PCONTROL_PARA pControlPara, PAIM_DATA pBLHt, PSEEKER pSeeker)
{
	//body coordinate:       x axis:轴向   y axis:法向   z axis:侧向
	//navigation coordinate: x axis:east   y axis:north  z axis:up 
	//偏航角：弹体轴向与指北方向的夹角  北偏西为正
	
    float Time = 0.0;               // flight time
	float time_control = START_CONTROL_TIME;       // time: start to control
	
	float roll_c = 0,ay_c = 0,az_c = 0;
    float Vel = 0.0;
    float temp =0.0;
	
	float density = 0.0,Q = 0.0;
	
	Time = period*Control_Step;
		
	//----- 计算 空气密度 飞行速度 马赫数
	if(pNavi->Altitude<11000.)
	{
		density=1.225f*pow((1.0f-2.25577*0.00001f*pNavi->Altitude),4.25588); //the density of air
	}
	else
	{
		density=0.3639176f*exp(1.576885*0.0001*(11000.0-pNavi->Altitude)); 	
	}
	
	Vel = sqrt(pNavi->Ve*pNavi->Ve+pNavi->Vn*pNavi->Vn+pNavi->Vu*pNavi->Vu);
	Q   = density*Vel*Vel/2.0;
	
	gGUIDE.Vel= Vel;
	
	//----------------制导律设计

	Guidance_Law_LDR(Time,time_control,pIMU,pNavi,pControlPara,pBLHt, &roll_c, &ay_c, &az_c,pSeeker);
	
	//----------------控制律设计
	Control_Law(Time,time_control,Q,pIMU, pNavi,roll_c,ay_c,az_c, pRudderCommand);
	
	
	pControlPara->Para3= Q;
	pControlPara->Para4= ay_c;
	pControlPara->Para5= az_c;
	pControlPara->Para6= roll_c;
	pControlPara->Para7= fRemote_Test_Gc[0];
	pControlPara->Para8= fRemote_Test_Gc[1];
	pControlPara->Para9= fRemote_Test_Gc[2];
}
/****************************************************************************************\
*函数原型:	void Guidance_Law_LDR()
*目的:		导引指令解算		
*参数:		飞行时间，启控时间，动压，IMU输出，导航输出，遥测输出，目标信息，三通道导引指令
*返回值:		
*备注:	    导引方案中制导采用方案弹道，末段为比例导引。方案弹道在俯仰方向上的指令
*           是无风条件下的固定攻角对应的过载，偏航为比例导引，方案段为BTT,末段为STT
*修改记录:	日期		作者		备注
\****************************************************************************************/
void CMissile::Guidance_Law_LDR(float Time, float time_control, PNAVI_IMU pIMU, PNAVI_INS pNavi, PCONTROL_PARA pControlPara, PAIM_DATA pBLHt, float *pRoll_c, float *pAy_c, float *pAz_c, PSEEKER pSeeker)
{
	float Vel = 0.0, Q = 0.0, Density = 0.0, LocalMach = 0.0;   
	float FlightMach = 0.;
	float nyy[2]={0};
	float Guid_Com[3]={0};
	
	if(pNavi->Altitude<11000.)
	{
		Density = 1.225*pow((1.0-2.25577*0.00001*pNavi->Altitude),4.25588); //the Density of air
	}		
	else
	{
		Density = 0.3639176*exp(1.576885*0.0001*(11000.0-pNavi->Altitude));
	}
	
	Vel = sqrt(pNavi->Ve*pNavi->Ve + pNavi->Vn*pNavi->Vn + pNavi->Vu*pNavi->Vu);
	Q =   Density*Vel*Vel/2.0;
	LocalMach  = 20.0468*sqrt(288.15-0.65*pNavi->Altitude/100);
	FlightMach = Vel/LocalMach;
	
    Trajectory(Time,pNavi,FlightMach,Q,nyy);  
	
	Guidance(pNavi,Time, time_control, Q, pBLHt,Guid_Com, nyy,pSeeker);
	
	*pRoll_c = Guid_Com[2];
	*pAy_c   = Guid_Com[0];
	*pAz_c   = Guid_Com[1];
	
	
	pControlPara->Para1= asin(pNavi->Vu / Vel); 
	pControlPara->Para2= nyy[1];
	pControlPara->Para10 = FlightMach;
	
	gOUT.theta = asin(pNavi->Vu / Vel);
}

void CMissile::Trajectory(float time, PNAVI_INS pNavi, float FlightMach, float Q, float nyy[])
{
	double AlphaMax = 16.0, Alpha_Flight = 12.0,TempMa = 0;
	double Cn_0 = 0.,Cn_01 = 0.,Cn_02 = 0.,Cn_Alpha = 0.,Cn_Alpha1 = 0.,Cn_Alpha2 = 0.;
	double Cn_RudderZ = 0.,Cn_RudderZ1 = 0.,Cn_RudderZ2 = 0.;
	
	
    double Mass,P,J[3],delt_cent;
	Engine(time,&Mass,&P,J,&delt_cent);
    //固定攻角+比例导引
	if(FlightMach <= 0.5)
	{   
		TempMa = 0.3;
		
		Cn_01 =  0.017440713;            //0.3Ma，0度攻角对应的升力系数(体系)
		Cn_Alpha1 = 0.205924799;         //0.3Ma，0度攻角附近(0～16度)升力曲线斜率   
		
		Cn_02 = 0.013453612;                  //0.5Ma，0度攻角对应的升力系数(体系)
		Cn_Alpha2 = 0.2096025045625;	     //0.5Ma，0度攻角附近(0～16度)升力曲线斜率   
		
		Cn_RudderZ1 = 0.0755843146;         //0.3Ma，单位舵产生的升力(由-5度舵计算得到)
		Cn_RudderZ2 = 0.0760182744;         //0.5Ma，单位舵产生的升力(由-5度舵计算得到)
		
		Cn_0 = Cn_01 + (Cn_02 - Cn_01)/0.2*(FlightMach - TempMa);                        
		Cn_Alpha = Cn_Alpha1 + (Cn_Alpha2 - Cn_Alpha1)/0.2*(FlightMach - TempMa);         
		Cn_RudderZ = Cn_RudderZ1 + (Cn_RudderZ2 - Cn_RudderZ1)/0.2*(FlightMach - TempMa); 
	}
	
	
	else if(FlightMach>0.5 && FlightMach<=0.7)
	{
		
		TempMa= 0.5;
		
		Cn_01 = 0.013453612;                   //0.5Ma，0度攻角对应的升力系数(体系)
		Cn_Alpha1 = 0.2096025045625;          //0.5Ma，0度攻角附近(12～18度)升力曲线斜率   
		
		Cn_02 = 0.017596222;                  //0.7Ma，0度攻角对应的升力系数(体系)
		Cn_Alpha2 = 0.214587931125;          //0.7Ma，0度攻角附近(12～18度)升力曲线斜率   
		
		Cn_RudderZ1 =  0.0760182744;         //0.5Ma，单位舵产生的升力(由-5度舵计算得到)
		Cn_RudderZ2 =  0.0766339104;         //0.7Ma，单位舵产生的升力(由-5度舵计算得到)
		
		Cn_0 = Cn_01 + (Cn_02 - Cn_01)/0.2*(FlightMach - TempMa);                        
		Cn_Alpha = Cn_Alpha1 + (Cn_Alpha2 - Cn_Alpha1)/0.2*(FlightMach - TempMa);         
		Cn_RudderZ = Cn_RudderZ1 + (Cn_RudderZ2 - Cn_RudderZ1)/0.2*(FlightMach - TempMa); 
		
	} 
	
	else if(FlightMach>0.7 && FlightMach<=0.9) 
	{
		TempMa = 0.7;
		
		Cn_01 =  0.017596222;                       //0.7Ma,0度攻角对应的升力系数(体系)
		Cn_Alpha1= 0.214587931125;                    //0.7Ma,0度攻角附近(12～18度)升力曲线斜率 
		
		Cn_02 =  0.04493136;                       //0.9Ma,0度攻角对应的升力系数(体系)
		Cn_Alpha2 =  0.2261409981875;                    //0.9Ma,0度攻角附近(12～18度)升力曲线斜率 
		
		Cn_RudderZ1 =  0.0766339104;                  //0.7Ma，单位舵产生的升力(由-5度舵计算得到)
		Cn_RudderZ2 =  0.073419292;                  //0.9Ma，单位舵产生的升力(由-5度舵计算得到)
		
		Cn_0 = Cn_01 + (Cn_02 - Cn_01)/0.2*(FlightMach - TempMa);                         
		Cn_Alpha = Cn_Alpha1 + (Cn_Alpha2 - Cn_Alpha1)/0.2*(FlightMach - TempMa);          
		Cn_RudderZ = Cn_RudderZ1 + (Cn_RudderZ2 - Cn_RudderZ1)/0.2*(FlightMach - TempMa);  
	}
	else if(FlightMach > 0.9)
	{
		TempMa= 0.9;
		
		Cn_01 =  0.04493136;                       //0.9Ma,0度攻角对应的升力系数(体系)
		Cn_Alpha1=  0.2261409981875;                    //0.9Ma,0度攻角附近(12～18度)升力曲线斜率 
		
		Cn_02 =  0.087578174;                       //1.05Ma,0度攻角对应的升力系数(体系)
		Cn_Alpha2=  0.252691966125;	                  //1.05Ma,0度攻角附近(12～18度)升力曲线斜率 
		
		Cn_RudderZ1 =  0.073419292;                 //0.9Ma，单位舵产生的升力(由-5度舵计算得到)
		Cn_RudderZ2 =  0.0818459428;                 //1.05Ma，单位舵产生的升力(由-5度舵计算得到)
		
		Cn_0 = Cn_01 + (Cn_02 - Cn_01)/0.15*(FlightMach - TempMa);                          
		Cn_Alpha = Cn_Alpha1 + (Cn_Alpha2 - Cn_Alpha1)/0.15*(FlightMach - TempMa);          
		Cn_RudderZ = Cn_RudderZ1 + (Cn_RudderZ2 - Cn_RudderZ1)/0.15*(FlightMach - TempMa);  
	}
	
	nyy[1] =        (Cn_0 + Cn_Alpha*(AlphaMax - 0) + Cn_RudderZ*(-1./1.6)*AlphaMax)*Q*Sref/Mass;        //无风时航弹16°攻角对应的法向过载        
	nyy[0] =        (Cn_0 + Cn_Alpha*(Alpha_Flight - 0) + Cn_RudderZ*(-1./1.6)*Alpha_Flight)*Q*Sref/Mass;  //无风时航弹10°攻角对应的法向过载
}

void CMissile::Guidance(PNAVI_INS pNavi, float Time, float time_control, float Q, PAIM_DATA pBLHt, float command[], float nyy[], PSEEKER pSeeker)
{
	float  sinR = 0.0, cosR = 0.0, sinY = 0.0, cosY = 0.0, sinP = 0.0, cosP = 0.0;  
	float  Cbn[9] = {0.0};                                                          //Cbn: 导航系到体系  
	float  Renu[3] = {0,0,0},Wenu[3] = {0.0};    //相对距离(东 北 天)  视线欧拉角  视线角速度在地理坐标系下的投影   视线角速度在弹体坐标系下的投影

	//static float Wxyz1[3] = {0,0,0};
	float  Vel = 0.0;                                                               //导航速度

    //static float  ay_c = 0.0, az_c = 0.0, roll_c = 0.0;                             //法向指令过载 侧向 指令滚转角

	//static float ay_c_last = 0.0, az_c_last = 0.0,roll_c_last=0.0;                  //记录上一时刻过载

	//static float T_transition = START_CONTROL_TIME;	

	float Ky = 3.0, Kz = 4.0;
	float g0_compensator = 9.8;
	float NMax = 0.0, NSumc = 0.0;  
    float az_c_max=0.0;
	float V_T_North = 0.0, V_T_East = 0.0, V_T_Up = 0.0;
	float deltaR = 0.0;

	//估计弹目相对信息
	//static float MT_info_supositl[4] = {0.0};
	
    double Mass,P,J[3],delt_cent;
	Engine(Time,&Mass,&P,J,&delt_cent);

	NMax=nyy[1];
	
	sinR = sin(pNavi->Roll);
	cosR = cos(pNavi->Roll);
	sinY = sin(pNavi->Yaw);
	cosY = cos(pNavi->Yaw);
	sinP = sin(pNavi->Pitch);
	cosP = cos(pNavi->Pitch);
	
	Cbn[0] = -sinY*cosP;  //Cbn = 2-3-1转换矩阵*"东-北-天"-->"北-天-东"转换矩阵
	Cbn[1] = cosP*cosY;
	Cbn[2] = sinP;
	Cbn[3] = cosY*sinR + sinP*sinY*cosR;
    Cbn[4] = -cosY*sinP*cosR + sinY*sinR;
    Cbn[5] = cosP*cosR;
	Cbn[6] = cosY*cosR - sinY*sinP*sinR;   
	Cbn[7] = cosY*sinP*sinR + sinY*cosR;
	Cbn[8] = -cosP*sinR;

	//----- 导航输入
	Vel=sqrt(pNavi->Ve*pNavi->Ve + pNavi->Vn*pNavi->Vn + pNavi->Vu*pNavi->Vu);

	//evaluate left time, left distance and angle of line-sight预估剩余飞行时间，剩余弹目距离，视线角
	MT_evaluate(pNavi,pBLHt,STA.MT_info_supositl,Wenu,Renu);

	deltaR = STA.MT_info_supositl[0];       //弹目距离

	Ky = pBLHt ->Altitude_supositl/1500. + 2.5;
	Kz = pBLHt ->Altitude_supositl/1500. + 3.0;

	STA.Wxyz1[0] = Cbn[0]*Wenu[0] + Cbn[1]*Wenu[1] + Cbn[2]*Wenu[2];                     
	STA.Wxyz1[1] = Cbn[3]*Wenu[0] + Cbn[4]*Wenu[1] + Cbn[5]*Wenu[2];                    
	STA.Wxyz1[2] = Cbn[6]*Wenu[0] + Cbn[7]*Wenu[1] + Cbn[8]*Wenu[2];



	if(Target_IniPos[1]<5000)
	{

	//比例导引===================================================
	if(Time <= START_CONTROL_TIME+1)
	{
		STA.ay_c = 0;
		STA.az_c = 0;	
		
	}
	else
	{
		STA.ay_c =  Ky*Vel*STA.Wxyz1[2] + 1.0*g0_compensator*Cbn[5];
		STA.az_c = -Kz*Vel*STA.Wxyz1[1] + 1.0*g0_compensator*Cbn[8];	
	}
	//比例导引===================================================
	}
	else
	{
	//终端约束落角设置为最远射程的50°随着射程的递减而递增至大约90°
    double Theta0=-48/57.3;
	if(Time <= START_CONTROL_TIME)
	{
		STA.ay_c = 0;
		STA.az_c = 0;	
	}
	
	else if(deltaR>2500)
	{
		
		//高低角: MT_info_supositl[3]    剩余飞行时间: MT_info_supositl[1]
		STA.ay_c =  3*Vel*STA.Wxyz1[2] + g0_compensator*Cbn[5] + 2*Vel*(STA.MT_info_supositl[3]-Theta0)/STA.MT_info_supositl[1];//弹道成型制导律+比例导引+重力补偿
		STA.az_c = -Kz*Vel*STA.Wxyz1[1] + g0_compensator*Cbn[8];
			
	}
	else
	{
		STA.ay_c =  Ky*Vel*STA.Wxyz1[2] + g0_compensator*Cbn[5];
		STA.az_c = -Kz*Vel*STA.Wxyz1[1] + g0_compensator*Cbn[8];
			
	}
	//终端约束落角设置为最远射程的50°随着射程的递减而递增至大约90°
	}

    if((Time - STA.T_transition) < 2.0)                                        //STT制导过渡过程 
	{
		STA.ay_c = (0.8*STA.ay_c_last + Control_Step*STA.ay_c) / (0.8 + Control_Step );
		STA.roll_c = (0.8*STA.roll_c_last + STA.roll_c*Control_Step)/(0.8 + Control_Step);
		STA.az_c = (0.8*STA.az_c_last + Control_Step*STA.az_c) / (0.8 + Control_Step );//az_c*(0.3864*atan(1.4451*(Time - (T_transition+5))-4.3982)+0.4756);
	}
	else
	{
		STA.roll_c = 0.0;
	}	

	
	if(deltaR >= 120.0)         // 无导引段，根据制导回路的截至频率可调deltaR   //mwy20130813使区间闭合
	{
		STA.ay_c_last = STA.ay_c;
		STA.az_c_last = STA.az_c; 
		STA.roll_c_last = STA.roll_c;
	}
	else 
	{
		STA.ay_c = STA.ay_c_last;
		STA.az_c = STA.az_c_last;
 	}


	command[0]=STA.ay_c;
	command[1]=STA.az_c;
	command[2]=STA.roll_c;

	//地理系下视线角速率
	gOUT.W_Nav_X = Wenu[0];
	gOUT.W_Nav_Y = Wenu[1];
	gOUT.W_Nav_Z = Wenu[2];
	
	//体系下视线角速率
	gOUT.W_Bomb_X = STA.Wxyz1[0];
	gOUT.W_Bomb_Y = STA.Wxyz1[1];
	gOUT.W_Bomb_Z = STA.Wxyz1[2];

	gGUIDE.R = deltaR;
	gOUT.theta = asin(pNavi->Vu / Vel);													//4 弹道倾角，速度方向与水平面夹角 
	gOUT.fai_v = -asin(pNavi->Ve/sqrt(pNavi->Ve*pNavi->Ve + pNavi->Vn*pNavi->Vn));		//5 弹道偏角，速度方向与北向夹角（偏西为正）

	gOUT.Ky = Ky; //8
	gOUT.Kz = Kz; //9


	gOUT.accY_c = STA.ay_c;
	gOUT.accZ_c = STA.az_c;
	gOUT.roll_c = STA.roll_c;
}

void CMissile::MT_evaluate(PNAVI_INS pNavi, PAIM_DATA pBLHt, float MT_eval_info[], float Wenu[], float Renu[])
{
	//	float Renu[3] = {0.0},ER[3] = {0.0};
	float ER[3] = {0.0};
	float deltaVel = 0.0; 
	
	//相对距离
	Renu[0] = R0*cos(pNavi->Latitude)*(pBLHt->Longitude - pNavi->Longitude);       
	Renu[1] = R0*(pBLHt->Latitude - pNavi->Latitude);                           
	Renu[2] = pBLHt->Altitude - pNavi->Altitude;  
	MT_eval_info[0] = sqrt(Renu[0]*Renu[0] + Renu[1]*Renu[1] + Renu[2]*Renu[2]);//弹目距离
	
	//相对速度
	deltaVel = sqrt((pBLHt->Vu - pNavi->Vu)*(pBLHt->Vu - pNavi->Vu) + (pBLHt->Ve - pNavi->Ve)*(pBLHt->Ve - pNavi->Ve) + (pBLHt->Vn - pNavi->Vn)*(pBLHt->Vn - pNavi->Vn));
	
	//剩余飞行时间
	MT_eval_info[1] = MT_eval_info[0]/deltaVel;//考虑GPS定位误差，取最保守值
	
	//视线方位角、高低角
	MT_eval_info[2] = atan2(-Renu[0], Renu[1]);//方位角:北偏西为正，定义区间：-180~180(与导航保持一致)  考虑GPS定位误差
    MT_eval_info[3] = atan(Renu[2]/sqrt(Renu[0]*Renu[0] + Renu[1]*Renu[1]));//高低角:定义区间：-90~90（与导航保持一致）  考虑GPS定位误差
	
	
	
	//相对视线角速度
	ER[0] = Renu[0]/MT_eval_info[0];
	ER[1] = Renu[1]/MT_eval_info[0];
	ER[2] = Renu[2]/MT_eval_info[0];
	
	gOUT.MT_long_angle= asin(ER[2]); //MT_eval_info[3]
	gOUT.MT_lat_angle= -asin(ER[0]/sqrt(ER[0]*ER[0]+ER[1]*ER[1]));  //MT_eval_info[2]
	
	
	Wenu[0] = (ER[1]*(pBLHt->Vu - pNavi->Vu) - ER[2]*(pBLHt->Vn - pNavi->Vn))/MT_eval_info[0];     //东西向                          
	Wenu[1] = (ER[2]*(pBLHt->Ve - pNavi->Ve) - ER[0]*(pBLHt->Vu - pNavi->Vu))/MT_eval_info[0];     //南北向                        
	Wenu[2] = (ER[0]*(pBLHt->Vn - pNavi->Vn) - ER[1]*(pBLHt->Ve - pNavi->Ve))/MT_eval_info[0];	 //天向
}
/****************************************************************************************\
*函数原型:	void Control_Law()
*目的:		计算三通道指令舵偏，并将指令分解到四个舵机上		
*参数:		飞行时间，启控时间，动压，IMU输出，导航输出，三通道导引指令，四个舵机控制指令
*返回值:		
*备注:			
*修改记录:	日期		作者		备注
\****************************************************************************************/
void CMissile::Control_Law(float Time, float time_control, float Q, PNAVI_IMU pIMU, PNAVI_INS pNavi, float roll_c, float ay_c, float az_c, PRUDDER_DATA pRudderCommand)
{
	float rudderX=0, rudderY=0,rudderZ=0;
	rudderX = Roll_Control(Time,time_control,Q,pIMU,pNavi,roll_c);
	rudderY = Yaw_Control(Time,time_control,Q,pIMU,pNavi,az_c);
	rudderZ = Pitch_Control(Time,time_control,Q,pIMU,pNavi,ay_c);
	Rudder_Allocation(Time,time_control,rudderX,rudderY,rudderZ, pRudderCommand);
}
/****************************************************************************************\
*函数原型:	void Roll_Control()
*目的:		计算滚转通道的指令舵偏		
*参数:		飞行时间，启控时间，动压，IMU输出，导航输出，滚转通道指令
*返回值:	滚转通道的指令舵偏
*备注:			
*修改记录:	日期		作者		备注
\****************************************************************************************/
float CMissile::Roll_Control(float Time, float time_control, float Q, PNAVI_IMU pIMU, PNAVI_INS pNavi, float roll_c)
{
	double Tp1 = Tpstart2-Tpstart1;
	double Tp2 = Tpstart3-Tpstart2;

	//static float GAI=0.0;
	float GAM=0.0,DGAI=0.0,EG=0.0;
	float KpX=0.0,KiX=0.0,Kwx=0.0,AIX=0.0;
	float MaxGAM=0.0,MaxDGAI=0.0,MaxGAI=0.0,MaxEG=0.0;  
	float rudderX = 0.0;

	//static float DXP=0.0;
    float MaxDDX=0.0,DDX=0.0,ADX=0.0,rudder_MX=0.0;
    //static float Roll_0 = 0;
    
	float jj=0;
    AIX=1.0;
	

	if(Time <= Tpstart1)
	{
		Kwx= 0.201*57.3;
		KpX= 1.1198*57.3;
	    KiX= 0.0017782*57.3;	
		
	}
	else if((Time>Tpstart1)&&(Time<=(Tpstart2+1)))
	{
		Kwx= 0.006847*57.3*pow(Q/20000,-0.9622);
		KiX= 0.004195*57.3*pow(Q/20000,0.1277);
		KpX= 0.04103*57.3*pow(Q/20000, -0.9414);
	
	}
	else if((Time>Tpstart2+1)&&(Time<=(Tp2 + Tpstart2)))
	{
		
		Kwx= 0.007952*57.3*pow(Q/20000,-0.7942);
		KiX= 0.0007893*57.3*pow(Q/20000, 1.329);
		KpX= 0.04931*57.3*pow(Q/20000,-0.7323);


	}
	else
	{
			KpX= 14210*pow(Q,-0.8945);//*2.5;
	        Kwx= KpX/3;
	        KiX= KpX*2;	
	
	}


	gOUT.Q=Q;
	gOUT.Roll_Ki=KiX;
	gOUT.Roll_Kp=KpX;
	gOUT.Roll_Kd=Kwx;

	
	MaxGAM	=  20.0f*DEG2RAD;               //导航输入限幅
	MaxDGAI	=  0.6f;		                //调参   限制跳跃  超调  
	MaxGAI	=  10.0f/AIX;                   //调参
	MaxEG	=  13.0f/AIX;	                //调参	
	
	

    MaxDDX = 100.0f*Control_Step/AIX;//80.0f*Control_Step/AIX;       //指令舵限制100度/秒

	GAM	= -roll_c + pNavi->Roll;
	
	if(fabs(fabs(pNavi->Roll)-3.14)<15.0*DEG2RAD)//实际滚转角接近180°时，做如下处理
	{
		GAM = 25.0*DEG2RAD*sign(STA.Roll_0);
	}	             

	if(fabs(GAM)>(MaxGAM))  		        //误差限幅
	{
		GAM = MaxGAM*sign(GAM);	
	}
	
	DGAI= KiX*GAM;				            //滚转角积分控制
	
	if(fabs(DGAI)>(MaxDGAI))		        //单步积分量限制 调节滚转时间  快慢与超调折中 
	{
		DGAI = MaxDGAI*sign(DGAI);		
	}

	STA.GAI= STA.GAI + DGAI*Control_Step;			//总积分	
	
	if(fabs(STA.GAI)>MaxGAI)			        //总积分量限制
	{
		STA.GAI = MaxGAI*sign(STA.GAI);		
	}

	EG= STA.GAI + KpX*GAM;			            //比例＋积分控制	
	
	if(fabs(EG)>MaxEG)				        //控制限幅
	{
		EG = MaxEG*sign(EG);
	}

	rudder_MX=(Kwx*pIMU->wx+EG);
	DDX= rudder_MX-STA.DXP;                     //舵偏增量
	if (fabs(DDX)>MaxDDX)                   //舵偏增量限幅
		DDX = MaxDDX * sign(DDX);  
	
	ADX= DDX + STA.DXP;                         //实际k时刻舵偏
	STA.DXP = ADX;                              //实际上时刻舵偏
	rudder_MX=ADX;

    if(Time<=time_control)
	{
		STA.DXP=0.0;
		STA.GAI=0.0;
		STA.Roll_0=pNavi->Roll;
	}

    rudderX=rudder_MX*AIX;
   
    fRemote_Test_Gc[0]=KpX;
		
	return rudderX;   
}
/****************************************************************************************\
*函数原型:	void Yaw_Control()
*目的:		计算偏航通道的指令舵偏		`
*参数:		飞行时间，启控时间，动压，IMU输出，导航输出，偏航通道指令
*返回值:	偏航通道的指令舵偏
*备注:			
*修改记录:	日期		作者		备注
\****************************************************************************************/
float CMissile::Yaw_Control(float Time, float time_control, float Q, PNAVI_IMU pIMU, PNAVI_INS pNavi, float az_c)
{
	double Tp1 = Tpstart2-Tpstart1;
	double Tp2 = Tpstart3-Tpstart2;

	//static float IEY=0.0,E4Y=0.0,DYP=0.0;

	//static float Pre_wyF = 0.0;
	float SLAY =0.0,wy_Diff = 0.0,A4 =0.9531;

	float MaxE2Y=0.0,MaxIEY=0.0,MaxE4Y=0.0,MaxADY1=0.0,MaxEY=0.0;
	float KpY=0.0,KiY=0.0,KdY=0.0,Kwy=0.0,Knz=0.0;

	float E1Y=0.0,DKAY=0.0,DADY=0.0,E2Y=0.0,IY=0.0;
	float ADY1=0.0,ADY2=0.0,EY=0.0,AIY=0.0;
	float rudderY = 0.0;
	
	float MaxDDY=0.0,DDY=0.0,ADY=0.0,rudder_MY=0.0;
   
	if(Time<time_control)
	{
		STA.IEY=0.,STA.E4Y=0.,STA.DYP=0.0,STA.Pre_wyF = 0.0;
	}


    AIY=1.0;
	    
if(Time <= Tpstart1)
	{
		Kwy=2.583*57.3;
		KpY=1.76*57.3;
		KiY=1.06*57.3;	
		Knz=0;

		
	}
	else if((Time>Tpstart1)&&(Time<=(Tpstart2+1)))
	{
		
		Kwy= 0.07214*57.3*pow(Q/20000,-1.019);
		KiY = 0.003644*57.3*pow(Q/20000,-1.235)*1.4;
		KpY= 0.001773*57.3*pow(Q/20000, -1.148)*1.4;	
		Knz=0;

	}
	else if((Time>Tpstart2+1)&&(Time<=(Tp2 + Tpstart2)))
	{
		Kwy= 0.086*57.3*pow(Q/20000, -1.204);
		KiY= 0.004975*57.3*pow(Q/20000,-1.12);
		KpY= 0.002201*57.3*pow(Q/20000,-2.923);
		Knz= 0*57.3*pow(Q/20000, -0.7939); 

	}
	else
	{
		KpY=100*pow(Q,-0.7153);
		Kwy=KpY*57.3;
		KiY=KpY*11;	
		Knz=0;
		
	}
	
	//////////
	
	gOUT.Yaw_Kp=KpY;
	gOUT.Yaw_Ki=KiY;
	gOUT.Yaw_Kd=Kwy; 
	
  	IY =    0.6f;     	                    //放大系数
	MaxE2Y = 6.5f/AIY;			            //单步积分限幅
	MaxIEY = 9.5f/AIY;			            //总积分限幅
	MaxE4Y = 10.0f/AIY;			            //比例＋积分＋角速度反馈限幅 
	MaxADY1= 11.0f/AIY*IY;		            //调参
	MaxDDY = 80.0f*Control_Step/AIY*IY;    //100度/秒
	MaxEY  = 11.0f/AIY;			            //总限幅  	
	

	E1Y= -pIMU->az+az_c;


	wy_Diff = pIMU->wy -STA.Pre_wyF*A4;
	STA.Pre_wyF = STA.Pre_wyF +wy_Diff;
	SLAY = STA.Pre_wyF -wy_Diff/Control_Step;
	DKAY=1.0f/Control_Step;

	if((SLAY<0.)&&(STA.Pre_wyF>0.))
	{
		DKAY = 0.5f*DKAY;
	}
	if((SLAY>0.)&&(STA.Pre_wyF<0.))
	{
		DKAY = 0.5f*DKAY;
	}
	
	DADY=wy_Diff*DKAY;                  
	

	E2Y=KiY*E1Y;
	
	if(fabs(E2Y)>MaxE2Y)
	{
		E2Y=sign(E2Y)*MaxE2Y;
	}
	
	STA.IEY=STA.IEY+E2Y*Control_Step;
	if(fabs(STA.IEY)>MaxIEY)
	{
		STA.IEY=sign(STA.IEY)*MaxIEY;
	}
	
	STA.E4Y=STA.IEY+KpY*E1Y+KdY*STA.Pre_wyF;
	if(fabs(STA.E4Y)>MaxE4Y)
	{
		STA.E4Y=sign(STA.E4Y)*MaxE4Y;
	}
	
	ADY=STA.E4Y;                           //wy 起增稳作用(意义不大)
	ADY=ADY*IY;	                       //IY为放大系数
	ADY1=ADY-DADY;                     //减去角速度微分的控制量  
	
	if(fabs(ADY1)>MaxADY1)
	{
		ADY1=MaxADY1*sign(ADY1);    //减去角速度微分的舵偏限幅
	}
	
	ADY2=ADY1+DADY;                    //加上角速度微分的舵偏
	
	EY=ADY2/IY;                        //wy 起增稳作用
	
	if(fabs(EY)>MaxEY)                 //校正网络舵偏限幅
	{
		EY= MaxEY*sign(EY);	
	}
	
	rudder_MY=(Kwy*pIMU->wy+EY);
	DDY= rudder_MY-STA.DYP;                     //舵偏增量
	if (fabs(DDY)>MaxDDY)                   //舵偏增量限幅
		DDY = MaxDDY * sign(DDY);  

	
	
	ADY= DDY + STA.DYP;                         //实际k时刻舵偏
	STA.DYP = ADY;                              //实际上时刻舵偏
	rudder_MY=ADY;

	if (Knz<0) 
	{
		Knz=0;
	}
	rudderY=rudder_MY*AIY+pIMU->az*Knz; 

	fRemote_Test_Gc[1]=KpY;
	
	return rudderY;                    //指令舵偏
}
/****************************************************************************************\
*函数原型:	void Pitch_Control()
*目的:		计算俯仰通道的指令舵偏		
*参数:		飞行时间，启控时间，动压，IMU输出，导航输出，俯仰通道指令
*返回值:	俯仰通道的指令舵偏
*备注:			
*修改记录:	日期		作者		备注
\****************************************************************************************/
float CMissile::Pitch_Control(float Time, float time_control, float Q, PNAVI_IMU pIMU, PNAVI_INS pNavi, float ay_c)
{
//---->俯仰通道控制模块
	double Tp1 = Tpstart2-Tpstart1;
	double Tp2 = Tpstart3-Tpstart2;

//	static float DZP=0.0,IEZ=0.0,E4Z=0.0;
//	static float Pre_wzF = 0.0;


	float SLAZ =0.0,wz_Diff = 0.0,A4 =0.9531;

	float MaxE2Z=0.0,MaxIEZ=0.0,MaxE4Z=0.0,MaxADZ1=0.0,MaxEZ=0.0;
	float KpZ=0.0,KiZ=0.0,KdZ=0.0,Kwz=0.0;
	float E1Z=0.0,DKAZ=0.0,DADZ=0.0,E2Z=0.0,IZ=0.0;
	float ADZ1=0.0,ADZ2=0.0,EZ=0.0,AIZ=0.0;

	float rudderZ = 0.0;
	
	float MaxDDZ=0.0,DDZ=0.0,ADZ=0.0,rudder_MZ=0.0;
			
	if(Time<time_control)
	{
		STA.DZP=0.,STA.IEZ=0.,STA.E4Z=0.,STA.Pre_wzF = 0.0;
	}


	AIZ=1.0;

//--------------------------------------------------------------
		
	double ka=0;

	////////////////////////////////////////
	if(Time <= Tpstart1)
	{
		KpZ=3.47*57.3;
		Kwz=2.793*57.3;
		KiZ=2.35*57.3;	
		ka= 0;
	//	E1Z= pNavi->Pitch-1.1*(86.87*pow(Time, -0.04732)-76.87)/57.3;
		
	}
	else if((Time>Tpstart1)&&(Time<=(Tpstart2+1)))
	{
		
		Kwz= 0.07347*57.3*pow(Q/20000, -1.036);
		KiZ= 0.008621*57.3*pow(Q/20000, -1.04)*1.4;
		KpZ= 0.002631*57.3*pow(Q/20000,-1.19)*1.4; 
		ka=  0;
	//	E1Z= pNavi->Pitch-1.1*(86.87*pow(Time, -0.04732)-76.87)/57.3;
	}
	else if((Time>Tpstart2+1)&&(Time<=(Tp2 + Tpstart2)))
	{
		Kwz= 0.0877*57.3*pow(Q/20000, -1.161);
		KiZ= 0.008548*57.3*pow(Q/20000, -1.151);
		KpZ= 0.004987*57.3*pow(Q/20000, -3.522);
		ka=  0; 
		//E1Z= pIMU->ay-ay_c;
		
		
		
	}
	else
	{
		KpZ=100*pow(Q,-0.7153);
		Kwz=KpZ*57.3;
		KiZ=KpZ*11;	
		ka=0;
		
	}
	E1Z= pIMU->ay-ay_c;
	/////////////////////////////////////////////
	gOUT.Pitch_Kp=KpZ;
	gOUT.Pitch_Ki=KiZ;
	gOUT.Pitch_Kd=Kwz;


	
//--------------------------------------------------------------


	IZ =    1.0f;     	                    //放大系数
	MaxE2Z = 11.0/AIZ;			            //单步积分限幅
	MaxIEZ = 12.0/AIZ;			            //总积分限幅
	MaxE4Z = 12.5/AIZ;			            //比例＋积分＋角速度反馈限幅 
	MaxADZ1= 13.5/AIZ*IZ;		            //调参
	MaxDDZ = 100.0*Control_Step/AIZ*IZ;     //100度/秒
	MaxEZ  = 13.5/AIZ;			            //总限幅 ，为了减少耦合




	wz_Diff = pIMU->wz -STA.Pre_wzF*A4;
	STA.Pre_wzF = STA.Pre_wzF +wz_Diff;
	SLAZ = STA.Pre_wzF -wz_Diff/Control_Step;
	
	DKAZ=1.0f/Control_Step;
	
	if((SLAZ<0.)&&(STA.Pre_wzF>0.))
	{
		DKAZ = 0.5f*DKAZ;
	}
	if((SLAZ>0.)&&(STA.Pre_wzF<0.))
	{
		DKAZ = 0.5f*DKAZ;
	}
	
	DADZ=wz_Diff*DKAZ;
	
	E2Z=KiZ*E1Z;
	
	if(fabs(E2Z)>MaxE2Z)
	{
		E2Z=sign(E2Z)*MaxE2Z;
	}
	
	STA.IEZ=STA.IEZ+E2Z*Control_Step;
	if(fabs(STA.IEZ)>MaxIEZ)
	{
		STA.IEZ=sign(STA.IEZ)*MaxIEZ;
	}
	
	STA.E4Z=STA.IEZ+KpZ*E1Z+KdZ*STA.Pre_wzF;  
	
	if(fabs(STA.E4Z)>MaxE4Z)
	{
		STA.E4Z=sign(STA.E4Z)*MaxE4Z;
	}
	
	ADZ=STA.E4Z;
	ADZ=ADZ*IZ;
	ADZ1=ADZ-DADZ;
	
	if(fabs(ADZ1)>MaxADZ1)
	{
		ADZ1=MaxADZ1*sign(ADZ1);
	}
	
	ADZ2=ADZ1+DADZ;

	EZ=ADZ2/IZ;       
	
	if(fabs(EZ)>MaxEZ)
	{
		EZ= MaxEZ*sign(EZ);
	}
	
	rudder_MZ=(Kwz*pIMU->wz+EZ);
	DDZ= rudder_MZ-STA.DZP;                     //舵偏增量
	if (fabs(DDZ)>MaxDDZ)                   //舵偏增量限幅
		DDZ = MaxDDZ * sign(DDZ);  
	
	ADZ= DDZ + STA.DZP;                         //实际k时刻舵偏
	STA.DZP = ADZ;                              //实际上时刻舵偏
	rudder_MZ=ADZ;
	rudderZ=rudder_MZ*AIZ+pIMU->ay*ka;

    fRemote_Test_Gc[2]=KpZ;

	
	return rudderZ;                         //指令舵偏
}
/****************************************************************************************\
*函数原型:	void Rudder_Allocation()
*目的:		将三通道舵偏指令分解到四个舵机上
*参数:		飞行时间，启控时间，三通道指令舵偏，四个舵机的控制信号
*返回值:	
*备注:			
*修改记录:	日期		作者		备注
\****************************************************************************************/
void CMissile::Rudder_Allocation(float Time, float time_control, float rudderX, float rudderY, float rudderZ, PRUDDER_DATA pRudderCommand)
{
	float rudderYZ=0.0;

	if((fabs(rudderX)+fabs(rudderY)+fabs(rudderZ))>30.0f)
	{
		if(fabs(rudderX)>15.0)  
		{
			rudderX = 15.0f*rudderX/fabs(rudderX);	
		}
		rudderYZ = 30 - fabs(rudderX);
		if(rudderYZ > fabs(rudderZ))
		{
			rudderY = (rudderYZ - fabs(rudderZ))*rudderY/fabs(rudderY);		
		}
		else 
		{
			rudderZ = rudderYZ*rudderZ/fabs(rudderZ);
			rudderY = 0;			
		}	
	}
	
	if(Time<time_control)                               //-- 无控段 
	{
		rudderX=0.0;
		rudderZ=0.0;
		rudderY=0.0;
	}	
	
	pRudderCommand->Rudder1=rudderX-rudderY-rudderZ; 	//1号舵输出
	pRudderCommand->Rudder2=rudderX+rudderY-rudderZ;	//2号舵输出
	pRudderCommand->Rudder3=rudderX+rudderY+rudderZ;	//3号舵输出
	pRudderCommand->Rudder4=rudderX-rudderY+rudderZ;	//4号舵输出	
}
/****************************************************************************************\
*函数原型:	Rudder
*目的:		舵机惯性环节
*参数:		
*返回值:	
*备注:			
*修改记录:	日期		作者		备注
\****************************************************************************************/
void CMissile::Rudder(double step, double du[], double du_command[])
{
	double ddu1[3]={0,0,0},ddu2[3]={0,0,0},ddu3[3]={0,0,0},ddu4[3]={0,0,0};
	double du1[3]={0,0,0}, du2[3]={0,0,0}, du3[3]={0,0,0}, du4[3]={0,0,0}; 
	double nose_ru=(rand()%2000-1000)/100;      //舵机噪声 0.01度的白噪声  20151103 cjf
	
	Rudder_RK(du,du_command,ddu1);
	for(int i1=0;i1<3;i1++)
		du1[i1]=du[i1]+ step/2*ddu1[i1];	
	Rudder_RK(du1,du_command,ddu2);
	for(i1=0;i1<3;i1++)
		du2[i1]=du[i1]+ step/2*ddu2[i1];	
	Rudder_RK(du2,du_command,ddu3);
	for(i1=0;i1<3;i1++)
		du3[i1]=du[i1]+ step*ddu2[i1];	
	Rudder_RK(du3,du_command,ddu4);
	for(i1=0;i1<3;i1++)
		du[i1]=du[i1]+step/6.0*(ddu1[i1]+2*ddu2[i1]+2*ddu3[i1]+ddu4[i1]);//+1*nose_ru/500;
}

void CMissile::Rudder_RK(double du[], double du_command[], double ddu[])
{
	ddu[0]= 40*(du_command[0]-du[0]);
	ddu[1]= 40*(du_command[1]-du[1]);
	ddu[2]= 40*(du_command[2]-du[2]);
}
/****************************************************************************************\
*函数原型:	Rudder_Delay
*目的:		舵机延时
*参数:		
*返回值:	
*备注:			
*修改记录:	日期		作者		备注
\****************************************************************************************/
void CMissile::Rudder_Delay()
{
		du_ww[7][0]= du_ww[6][0];  //升降舵
		du_ww[7][1]= du_ww[6][1];  //滚动舵
		du_ww[7][2]= du_ww[6][2];  //偏航舵
		
		du_ww[6][0]= du_ww[5][0];  //升降舵
		du_ww[6][1]= du_ww[5][1];  //滚动舵
		du_ww[6][2]= du_ww[5][2];  //偏航舵
		
		
		du_ww[5][0]= du_ww[4][0];  //升降舵
		du_ww[5][1]= du_ww[4][1];  //滚动舵
		du_ww[5][2]= du_ww[4][2];  //偏航舵
		
		du_ww[4][0]= du_ww[3][0];  //升降舵
		du_ww[4][1]= du_ww[3][1];  //滚动舵
		du_ww[4][2]= du_ww[3][2];  //偏航舵
		
		du_ww[3][0]= du_ww[2][0];  //升降舵
		du_ww[3][1]= du_ww[2][1];  //滚动舵
		du_ww[3][2]= du_ww[2][2];  //偏航舵 
		
		du_ww[2][0]= du_ww[1][0];  //升降舵
		du_ww[2][1]= du_ww[1][1];  //滚动舵
		du_ww[2][2]= du_ww[1][2];  //偏航舵 
		
		du_ww[1][0]= du_ww[0][0];  //升降舵
		du_ww[1][1]= du_ww[0][1];  //滚动舵
		du_ww[1][2]= du_ww[0][2];  //偏航舵 
		
		du_ww[0][0]= du[0];  //升降舵
		du_ww[0][1]= du[1];  //滚动舵
		du_ww[0][2]= du[2];  //偏航舵 

		if(RUDDELAY == 1)  //20140104mwy 
		{
			//舵机延迟10ms
			du[0]= du_ww[2][0];  //升降舵
			du[1]= du_ww[2][1];  //滚动舵
			du[2]= du_ww[2][2];  //偏航舵 
		}

		if(RUDDELAY == 2)  //20140104mwy 
		{
		//舵机延迟20ms
		du[0]= du_ww[4][0];  //升降舵
		du[1]= du_ww[4][1];  //滚动舵
		du[2]= du_ww[4][2];  //偏航舵 
		}
}
/****************************************************************************************\
*函数原型:	Margin
*目的:		计算控制系统设计时必要参数
*参数:		
*返回值:	
*备注:			
*修改记录:	日期		作者		备注
\****************************************************************************************/
void CMissile::Margin(double time, double LBH[], double du[], double fluent[], double state_s[], double C_air[], double fyfz[])
{
	double a11,a21,a31,a22, a13,a33, a14,a24,a24t,a34, a25,a35;	
	double b11,b12,b14,b15,b17,b21,b22,b24,b24t,b25,b32,b34,b35,b36;
	double duc[3],fluent1[3],C_air1[6];  //Cx,Cy,Cz,Cmx,Cmy,Cmz
	double deltaVel=5.0/340.0, deltaRudder=1.0, deltaBeta=2.0, deltaAlpha=1.0;
	double mz_alpha=0, mz_deltaz=0;	
	double mx_beta=0, my_beta=0, mx_deltaY=0,mx_deltaX=0, my_deltaY=0,my_deltaX=0;
	
    double Mx_wx, Mx_wy, My_wx, My_wy, Mz_wz, Mz_alphadot,My_betadot;
	double Mach= fluent[2];
	double pitch= LBH[8];
	double heg= LBH[2];

	double Cz_beta=0,Cz_deltaY=0,Cl_alpha=0,Cl_deltaz=0;

	double Jx,Jy,Jz;

	double Mass,P,J[3],delt_cent;
	Engine(time,&Mass,&P,J,&delt_cent);
	Jx = J[0];
	Jy = J[1];
	Jz = J[2];

	int Num_Ma,Num_alpha;
	double aero_dot[3];
	insert_num(fluent[2],fluent[0],Num_Ma,Num_alpha);
	insert_data(fluent[2],fluent[0],Num_Ma,Num_alpha,aero_dot);

	Mx_wx=aero_dot[0];
	My_wy=aero_dot[1];
	Mz_wz=aero_dot[2];//insert_data函数中已将Mzalphadot与Mzwz叠加作为新的Mzwz
	Mx_wy=0;
	My_wx=0;

	Mz_alphadot=0.0;
	My_betadot=	0.0;
	
	b11= 1.0*Mx_wx*(1+mAeroBias.mx2wxBias)*gOUT.Q*Sref*Lref*Lref/gOUT.Vel/Jx;  ////czg201202
	b12= Mx_wy*gOUT.Q*Sref*Lref*Lref/gOUT.Vel/Jx;
	b21= My_wx*gOUT.Q*Sref*Lref*Lref/gOUT.Vel/Jy;
	b22= My_wy*(1+mAeroBias.my2wyBias)*gOUT.Q*Sref*Lref*Lref/gOUT.Vel/Jy;////czg201202



	int body_traj=2;
	Aerodynamics(time,heg,mAeroBias,fluent,state_s,du,  C_air,body_traj);//-气动系数插值
	
	duc[0]=du[0];
	duc[1]=du[1]+deltaRudder;//deltaX
	duc[2]=du[2];	
	Aerodynamics(time,heg,mAeroBias,fluent,state_s,duc,  C_air1,body_traj);
	b17=(C_air1[3]-C_air[3])/deltaRudder*gOUT.Q*Sref*Lref/Jx*RAD2DEG; 
	mx_deltaX=(C_air1[3]-C_air[3])/deltaRudder*RAD2DEG; 
	my_deltaX=(C_air1[4]-C_air[4])/deltaRudder*RAD2DEG; 
	gOUT.b11=b11;  
	gOUT.b17=b17;
	
	fluent1[0]= fluent[0];
	fluent1[1]= fluent[1]+ deltaBeta;
	fluent1[2]= fluent[2];
	Aerodynamics(time,heg,mAeroBias,fluent1,state_s,du,  C_air1,body_traj);
	mx_beta= (C_air1[3]-C_air[3])/deltaBeta*RAD2DEG;  //单位：弧度
	my_beta= (C_air1[4]-C_air[4])/deltaBeta*RAD2DEG;
	Cz_beta= (C_air1[2]-C_air[2])/deltaBeta*RAD2DEG;
	b14= mx_beta*gOUT.Q*Sref*Lref/Jx;  
	b24= my_beta*gOUT.Q*Sref*Lref/Jy;  
	
	b34= ( P-Cz_beta * gOUT.Q*Sref)/(Mass*gOUT.Vel);   

	duc[0]=du[0];
	duc[1]=du[1];
	duc[2]=du[2]+deltaRudder;
	Aerodynamics(time,heg,mAeroBias,fluent,state_s,duc,  C_air1,body_traj);
	mx_deltaY= (C_air1[3]-C_air[3])/deltaRudder*RAD2DEG;
	my_deltaY= (C_air1[4]-C_air[4])/deltaRudder*RAD2DEG;
	Cz_deltaY= (C_air1[2]-C_air[2])/deltaRudder*RAD2DEG;
	
	b15=mx_deltaY*gOUT.Q*Sref*Lref/Jx;  
	b25=my_deltaY*gOUT.Q*Sref*Lref/Jy; 
	b24t=My_betadot*gOUT.Q*Sref*Lref*Lref/gOUT.Vel/Jy;  	
	b32= -cos(pitch-fluent[0]*DEG2RAD)/cos(pitch);
	b35= -Cz_deltaY * gOUT.Q*Sref/(Mass*gOUT.Vel);  
	b36= -9.8*cos(pitch)/gOUT.Vel;

	gLATERALCHENNAL.pitch = pitch;
	
	fluent1[0]= fluent[0];
	fluent1[1]= fluent[1];
	fluent1[2]= fluent[2]+ deltaVel;
	Aerodynamics(time,heg,mAeroBias,fluent1,state_s,du,  C_air1,body_traj);

	double a=20.0468*sqrt(288.15-0.65*heg/100); //speed of voice
	double X_v= gOUT.Q/(0.5*gOUT.Vel)*C_air1[0]*Sref+ gOUT.Q*(C_air1[0]-C_air[0])/deltaVel*Sref/a;
    a11= -X_v/Mass;
	double Mz_v= gOUT.Q*Lref/(0.5*gOUT.Vel)*C_air1[5]*Sref+ gOUT.Q*Lref*(C_air1[5]-C_air[5])/deltaVel*Sref/a;  
    a21= Mz_v/Jz;
	double Y_v= gOUT.Q/(0.5*gOUT.Vel)*C_air1[1]*Sref+ gOUT.Q*(C_air1[1]-C_air[1])/deltaVel*Sref/a;
	a31= Y_v/(Mass*gOUT.Vel);	
	a22= Mz_wz*(1+mAeroBias.mz2wzBias)*gOUT.Q*Sref*Lref*Lref/(gOUT.Vel*Jz);	
	a13= -9.8*cos(pitch-fluent[0]*DEG2RAD);
	a33= 9.8*sin(pitch-fluent[0]*DEG2RAD)/gOUT.Vel;

	gOUT.theta = pitch-fluent[0]*DEG2RAD;
	
	fluent1[0]= fluent[0]+ deltaAlpha;
	fluent1[1]= fluent[1];
	fluent1[2]= fluent[2];
	Aerodynamics(time,heg,mAeroBias,fluent1,state_s,du,  C_air1,body_traj);
	mz_alpha= (C_air1[5]-C_air[5])/deltaAlpha*RAD2DEG;
	Cl_alpha= (C_air1[1]-C_air[1])/deltaAlpha*RAD2DEG;

	a14= -(Cl_alpha * gOUT.Q*Sref + P*fluent[0]/57.3)/Mass;  //20130817mwy fluent[0]攻角单位为度
	a24= mz_alpha*gOUT.Q*Sref*Lref/Jz;
	a24t= Mz_alphadot*gOUT.Q*Sref*Lref*Lref/gOUT.Vel/Jz;
	
	a34= (Cl_alpha * gOUT.Q*Sref + P)/(Mass*gOUT.Vel); //20130830mwy
	
	duc[0]=du[0]+deltaRudder;
	duc[1]=du[1];
	duc[2]=du[2];
	Aerodynamics(time,heg,mAeroBias,fluent,state_s,duc,  C_air1,body_traj);
	mz_deltaz= (C_air1[5]-C_air[5])/deltaRudder*RAD2DEG;
	Cl_deltaz= (C_air1[1]-C_air[1])/deltaRudder*RAD2DEG;
	a25=mz_deltaz*gOUT.Q*Sref*Lref/Jz; 
	a35= Cl_deltaz * gOUT.Q*Sref/(Mass*gOUT.Vel);

	double km=(-a25*a34+a35*a24)/(a22*a34+a24);
	double tm=1/sqrt(-a24-a22*a34);
	double kesi=(-a22+a34)/2/sqrt(-a24-a22*a34);
	double t1=a25/(a25*a34-a35*a24);
	double p1=a35/(a25*a34-a35*a24);
	double p2=a35*a22/(a25*a34-a35*a24);

	double kmb=(-b25*b34+b35*b24)/(b22*b34+b24);
	double tmb=1/sqrt(-b24-b22*b34);
	double kesib=(-b22+b34)/2/sqrt(-b24-b22*b34);
	double t1b=b25/(b25*b34-b35*b24);
	double p1b=b35/(b25*b34-a35*b24);
	double p2b=b35*b22/(b25*b34-b35*b24);

	double wc=1/tm;
	
	double kmx=b17/(-b11);
	double tmx=1/(-b11);
	
	//a11,a21,a31,a22, a13,a33, a14,a24,a24t,a34, a25,a35;
	gLONGCHENNAL.time= time;
	gLONGCHENNAL.Q= gOUT.Q;
	gLONGCHENNAL.a11= a11;
	gLONGCHENNAL.a21= a21;
	gLONGCHENNAL.a31= a31;
	gLONGCHENNAL.a22= a22;
	gLONGCHENNAL.a13= a13;
	gLONGCHENNAL.a33= a33;
	gLONGCHENNAL.a14= a14;
	gLONGCHENNAL.a24= a24;
	gLONGCHENNAL.a24t= a24t;
	gLONGCHENNAL.a34= a34;
	gLONGCHENNAL.a25= a25;
	gLONGCHENNAL.a35= a35;
	
	//b11,b12,b14,b15,b17,b21,b22,b24,b24t,b25,b32,b34,b35,b36;
	gLATERALCHENNAL.b11=b11;
	gLATERALCHENNAL.b12=b12;
	gLATERALCHENNAL.b14=b14;
	gLATERALCHENNAL.b15=b15;
	gLATERALCHENNAL.b17=b17;
	gLATERALCHENNAL.b21=b21;
	gLATERALCHENNAL.b22=b22;
	gLATERALCHENNAL.b24=b24;
	gLATERALCHENNAL.b24t=b24t;
	gLATERALCHENNAL.b25=b25;
	gLATERALCHENNAL.b32=b32;
	gLATERALCHENNAL.b34=b34;
	gLATERALCHENNAL.b35=b35;
	gLATERALCHENNAL.b36=b36;
	gLATERALCHENNAL.a33=a33;
	gLATERALCHENNAL.alpha= fluent[0];

	//---->稳定域度计算(//单位：度)

	gLONGCHENNAL.Cl_alpha=Cl_alpha/57.3;
	gLONGCHENNAL.Cl_deltaz=Cl_deltaz/57.3;
	gLONGCHENNAL.mz_alpha=mz_alpha/57.3;
	gLONGCHENNAL.mz_deltaz=mz_deltaz/57.3;

	gLATERALCHENNAL.Cz_beta=Cz_beta/57.3;
	gLATERALCHENNAL.Cz_deltaY=Cz_deltaY/57.3;
	gLATERALCHENNAL.my_beta=my_beta/57.3;
	gLATERALCHENNAL.my_deltaY=my_deltaY/57.3;
	gLATERALCHENNAL.mx_beta=mx_beta/57.3;  
	gLATERALCHENNAL.mx_deltaY=mx_deltaY/57.3;
	gLATERALCHENNAL.my_deltaX=my_deltaX/57.3;
	gLATERALCHENNAL.mx_deltaX=mx_deltaX/57.3;

	
	//---->弹体频率计算	HZ俯仰
	fyfz[1] = sqrt(-(a24+a22*a34))/(2.0*pi);
	//---->弹体频率计算	HZ偏航
	fyfz[0]= sqrt(-b24+b22*b34)/(2.0*pi);
	
	//重新查一次值使力在速度系下转为机体系
	Aerodynamics(time,LBH[2], mAeroBias,fluent,state_s,du,C_air,1);
	gOUT.cx = C_air[0];
	gOUT.cy = C_air[1];
	gOUT.cz = C_air[2];
	gOUT.Cmx = C_air[3];
	gOUT.Cmy = C_air[4];
	gOUT.Cmz = C_air[5];
}

void CMissile::insert_num(double Ma, double alpha, int &Num_Ma, int &Num_alpha)
{
	if(Ma>=Ma_aero[3])
		Ma=Ma_aero[3]-1.e-5;
	if(Ma<=Ma_aero[0])
		Ma=Ma_aero[0]+1.e-5;
	if(alpha>=alpha_aero[2])
		alpha=alpha_aero[2]-1.e-5;
	if(alpha<=alpha_aero[0])
		alpha=alpha_aero[0]+1.e-5;
	
	for(Num_Ma=0;Num_Ma<4;Num_Ma++)
	{
		if((Ma>=Ma_aero[Num_Ma])&&(Ma<Ma_aero[Num_Ma+1]))
			break;
	}
	
	for(Num_alpha=0;Num_alpha<3;Num_alpha++)
	{
		if((alpha>=alpha_aero[Num_alpha])&&(alpha<alpha_aero[Num_alpha+1]))
			break;
	}
}

void CMissile::insert_data(double Ma, double alpha, int Num_Ma, int Num_alpha, double aero_dot[])
{
	double temp1,temp2;
	double temp3,temp4;
	double temp5,temp6;
	
	if(Ma>=Ma_aero[3])
		Ma=Ma_aero[3]-1.e-5;
	if(Ma<=Ma_aero[0])
		Ma=Ma_aero[0]+1.e-5;
	if(alpha>=alpha_aero[2])
		alpha=alpha_aero[2]-1.e-5;
	if(alpha<=alpha_aero[0])
		alpha=alpha_aero[0]+1.e-5;
	
	
	temp1=Mxwx[Num_Ma][Num_alpha]+(alpha-alpha_aero[Num_alpha])*(Mxwx[Num_Ma][Num_alpha+1]-Mxwx[Num_Ma][Num_alpha])/(alpha_aero[Num_alpha+1]-alpha_aero[Num_alpha]);
	temp2=Mxwx[Num_Ma+1][Num_alpha]+(alpha-alpha_aero[Num_alpha])*(Mxwx[Num_Ma+1][Num_alpha+1]-Mxwx[Num_Ma+1][Num_alpha])/(alpha_aero[Num_alpha+1]-alpha_aero[Num_alpha]);
	aero_dot[0]=temp1+(Ma-Ma_aero[Num_Ma])*(temp2-temp1)/(Ma_aero[Num_Ma+1]-Ma_aero[Num_Ma]);
	
	
	temp3=Mywy[Num_Ma][Num_alpha]+(alpha-alpha_aero[Num_alpha])*(Mywy[Num_Ma][Num_alpha+1]-Mywy[Num_Ma][Num_alpha])/(alpha_aero[Num_alpha+1]-alpha_aero[Num_alpha]);
	temp4=Mywy[Num_Ma+1][Num_alpha]+(alpha-alpha_aero[Num_alpha])*(Mywy[Num_Ma+1][Num_alpha+1]-Mywy[Num_Ma+1][Num_alpha])/(alpha_aero[Num_alpha+1]-alpha_aero[Num_alpha]);
	aero_dot[1]=temp3+(Ma-Ma_aero[Num_Ma])*(temp4-temp3)/(Ma_aero[Num_Ma+1]-Ma_aero[Num_Ma]);
	
	temp5=Mzwz[Num_Ma][Num_alpha]+(alpha-alpha_aero[Num_alpha])*(Mzwz[Num_Ma][Num_alpha+1]-Mzwz[Num_Ma][Num_alpha])/(alpha_aero[Num_alpha+1]-alpha_aero[Num_alpha]);
	temp6=Mzwz[Num_Ma+1][Num_alpha]+(alpha-alpha_aero[Num_alpha])*(Mzwz[Num_Ma+1][Num_alpha+1]-Mzwz[Num_Ma+1][Num_alpha])/(alpha_aero[Num_alpha+1]-alpha_aero[Num_alpha]);
	aero_dot[2]=temp5+(Ma-Ma_aero[Num_Ma])*(temp6-temp5)/(Ma_aero[Num_Ma+1]-Ma_aero[Num_Ma]);
}


