#ifndef tttttt
#define tttttt
#define Uint8	unsigned char
//////////////////////////////////////////////////////////////
/***********************************************************
/////////////////目标点数据结构/////////////////////////////
************************************************************/
typedef struct 
{
	double  InitialLon;     //初始经度
	double  InitialLat;     //初始纬度
	double  InitialAlti;    //初始高度
	double  Longitude; 		//经度
	double  Latitude; 		//纬度
	float   Altitude;		//高度
	double  Ve;             //东速
	double  Vn;             //北速
	double  Vu;             //天速
	
	double  InitialLon_supositl;     //初始经度（预估目标）
	double  InitialLat_supositl;     //初始纬度（预估目标）
	double  InitialAlti_supositl;    //初始高度（预估目标）
	double  Longitude_supositl; 	 //经度（预估目标）
	double  Latitude_supositl; 		 //纬度（预估目标）
	float   Altitude_supositl;		 //高度（预估目标）
	double  Ve_supositl;             //东速（预估目标）
	double  Vn_supositl;             //北速（预估目标）
	double  Vu_supositl;             //天速（预估目标）
}*PAIM_DATA, AIM_DATA;
///////////////////////////////////////////////////////
/******************************************************
/////////////////////////IMU数据结构//////////////////
*****************************************************/
typedef struct 
{  
	float           ax;
	float           ay;  
	float           az; 
	float           wx;
	float           wy;
	float           wz;
	unsigned short  DataCount;  
}*PNAVI_IMU, NAVI_IMU;
/////////////////////////////////////
typedef struct 
{  
	float           ax;              //x加速度
	float           ay;              //y加速度  
	float           az;              //z加速度
	float           wx;              //x角速度
	float           wy;              //y角速度
	float           wz;              //z角速度
	Uint8          XGyroTemp;	     //x轴陀螺温度
	Uint8          YGyroTemp;	     //y轴陀螺温度
	Uint8          ZGyroTemp;	     //z轴陀螺温度
	Uint8          AccTemp;		     //加速度计温度
	unsigned short   iFrameCount;    //帧计数
} *nPNAVI_IMU, nNAVI_IMU;
///////////////////////////////////////////////////////

/******************************************************
////////////////////GPS接收机数据结构//////////////////
*******************************************************/
typedef struct 
{   
	unsigned char   Visible_Star;    //可见星数
	double          second;          //秒信息
	double          Longitude;       //经度(GEOG)
	double          Latitude;        //纬度(GEOG)      
	float           Altitude;        //高度(GEOG)
	float           Ve;              //东速(GEOG)
	float           Vn;              //北速(GEOG)
	float           Vu;              //天速(GEOG)
	float           pdop;            // pdop值
	unsigned short  NaviMode;        //卫星状态
}*nPNAVI_GPS, nNAVI_GPS;
///////////////////////////////////////////////////////

/******************************************************
///////////////自对准初始参数数据结构//////////////////
*******************************************************/
typedef struct 
{
	float           Pitch;           //俯仰角
	float           Roll;            //滚转角 
	float           Yaw;             //航向角
	float           Ve;              //东向速度
	float           Vn;              //北向速度
	float           Vu;              //天向速度
	double			Longitude;       //起飞点经度
	double           Latitude;       //起飞点纬度
	float           Altitude;        //起飞点高度
	/* 杆臂参数 */
	float           pole_X;            
	float           pole_Y;            
	float           pole_Z;            
} *nPSELFAIM_PARA,  nSELFAIM_PARA;
////////////////////////////////////////////////////////

/******************************************************
导航信息数据结构
*******************************************************/
typedef struct
{                     //地理坐标系
	float           Pitch;           //机体轴系俯仰角
	float           Roll;            //机体轴系滚转角
	float           Yaw;             //机体轴系方位角
	float           Ve;              //东向速度
	float           Vn;              //北向速度
	float           Vu;              //天向速度
	double	    	Longitude;       //经度
	double    	    Latitude;        //纬度
	float           Altitude;        //高度
} *nPNAVI_INS,  nNAVI_INS;
///////////////////////////////////////////////////////
/**********************************************************
定义载体的导航信息数据结构,东北天地理坐标系为参考坐标系
***********************************************************/
typedef struct {
	/*地理坐标系*/
	float           Pitch;         /*机体轴系俯仰角*/
	float           Roll;          /*机体轴系滚转角*/ 
	float           Yaw;           /*机体轴系方位角*/
	float           Ve;            /*东向速度*/
	float           Vn;            /*北向速度*/
	float           Vu;            /*天向速度*/
	double			Longitude;     /*经度*/
	double      	Latitude;      /*纬度*/
	float           Altitude;      /*高度*/
	
	/* 当前时刻导航坐标系的比力分量 */
	float           Fe;            /*e轴比力*/
	float           Fn;            /*n轴比力*/
	float           Fu;            /*u轴比力*/
}*PNAVI_INS,NAVI_INS;
/***********************************************************
GPS数据结构
************************************************************/
typedef struct {   
	unsigned char    Visible_Star; 
	double           second;       
	double           Longitude; 
	double           Latitude;  //GEOG      
	float            Altitude;  
	float            Ve;
	float            Vn;
	float            Vu; 
	float            pdop;   
	unsigned short   NaviMode;         
}*PNAVI_GPS, NAVI_GPS;
/******************************************************
///////////组合导航中间结果数据结构/////////////////////
*******************************************************/
typedef struct
{
	float           Phix;            //失准角
	float           Phiy;            //失准角
	float           Phiz;            //失准角	
	float           P11;             //P矩阵	
	float           P22;             //P矩阵	
	float           P33;             //P矩阵	
	float           P44;             //P矩阵	
	float           P55;             //P矩阵	
	float           P66;             //P矩阵	
	float           P77;             //P矩阵	
	float           P88;             //P矩阵	
	float           P99;             //P矩阵	
}*nPNAVI_MIDRST,nNAVI_MIDRST;
////////////////////////////////////////////////////////
/***********************************************************
机体杆臂参数数据结构
************************************************************/
typedef struct {
	float  x; 	//x	
	float  y; 	//y	
	float  z;	//z
}*PPOLE_PARA, POLE_PARA;
/**********************************************************
定义载机传递对准数据
***********************************************************/
typedef struct {	
	float           ax;
	float           ay;  
	float           az; 
	float           wx;
	float           wy;
	float           wz;  
	/*地理坐标系*/
	float           Pitch;         /*机体轴系俯仰角*/
	float           Roll;          /*机体轴系滚转角*/ 
	float           Yaw;           /*机体轴系方位角*/
	float           Ve;            /*东向速度*/
	float           Vn;            /*北向速度*/
	float           Vu;            /*天向速度*/
	double			Longitude;     /*经度*/
	double      	Latitude;      /*纬度*/
	float           Altitude;      /*高度*/
}*PBCTRANSFERAIM_DATA,BCTRANSFERAIM_DATA;
/**********************************************************
导航中间结果数据结构
***********************************************************/
typedef struct
{
	float           Phix;            /*失准角*/	
	float           Phiy;            /*失准角*/	
	float           Phiz;            /*失准角*/	
	
	float           P11;            /*失准角*/	
	float           P22;            /*失准角*/	
	float           P33;            /*失准角*/	
	
	float           P44;            /*失准角*/	
	float           P55;            /*失准角*/	
	float           P66;            /*失准角*/	
	
	float           P77;            /*失准角*/	
	float           P88;            /*失准角*/	
	float           P99;            /*失准角*/	
} *PNAVI_KALMAN,NAVI_KALMAN;
//舵机的指令舵偏信息
typedef struct{
	float Rudder1;
	float Rudder2;
	float Rudder3;	
	float Rudder4;
}*PRUDDER_DATA, RUDDER_DATA;
/******************************************************
控制参数数据结构
*******************************************************/
typedef struct{
	float Para1;
	float Para2;
	float Para3;	
	float Para4;
	float Para5;
	float Para6;	
	float Para7;
	float Para8;
	float Para9;	
	float Para10;
}*PCONTROL_PARA, CONTROL_PARA;
/******************************************************
导引头数据结构
*******************************************************/
typedef struct{
	unsigned short  SeekerOn;         //给导引头供电热点池激活指令
	unsigned short  SeekerWork;       //导引头闭锁指令
	float  CatchTarget;               //导引头接收到光电信号标志
	float  Seeker_V_Wz;               //回采导引头俯仰角速率信号
	float  Seeker_V_Wy;               //回采导引头偏航角速率信号
	
}*PSEEKER, SEEKER;
/******************************************************
////////////////仿真参数+仿真结果存储/////////////////
******************************************************/
typedef struct
{
double dwx,dwy,dwz;//角速率增量
double Wxyz1[3];//机体坐标系下视线角
float  ay_c , az_c, roll_c, ay_c_last, az_c_last,roll_c_last;//制导指令
float T_transition;//平滑制导指令的一个中间变量
float MT_info_supositl[4];//预估剩余飞行时间，剩余弹目距离，视线角
float GAI,DXP,Roll_0;//滚转通道限幅
float IEY,E4Y,DYP,Pre_wyF;//偏航通道限幅
float DZP,IEZ,E4Z,Pre_wzF;//俯仰通道限幅

}STATIC,*_pSTATIC;
//////////////////
typedef struct
{
	double time;
	double x;
	double y;
	double lon;
	double lat;
	double heg;
	double Ve;
	double Vn;
	double Vu;
	double pitch;
	double roll;
	double yaw;
	double wx;
	double wy;
	double wz;
	
	double accX;
	double accY;
	double accZ;
	
	double alpha;
	double beta;
	double mach;
	
	double accY_c;
	double accZ_c;
	
	double cx;
	double cy;
	double cz;
	double Cmx;
	double Cmy;
	double Cmz;
	double cd;
	double cl;
	double czw;
	double Cl2Cd;
	double Q;
	
	double roll_c;
	double Roll_Kp;	
	double Roll_Ki; 
	double Roll_Kd;
	double AIX; 
	double b11;
	double b17;
	
	double Yaw_oyf;
	double Yaw_Kp;
	double Yaw_Ki;
	double Yaw_Kd;
	double Yaw_Kwy;
	double Yaw_WO2;
	double Yaw_pi;//比例项 
	double Yaw_gravity;//重量补偿项
	double Yaw_SLY;
	double AIY;
	
	double Pitch_oyf;
	double Pitch_Kp;
	double Pitch_Ki;
	double Pitch_Kd;
	double Pitch_Kwz;
	double Pitch_n_final;
	double ny2_guide;      //补偿项 
	double g0_compensator; //重力补偿项
	double ny2_compensator;//弹道补偿项
	double Pitch_SLZ;
	double AIZ;
	
	double WOMAX;//允许过载
	double Vel;
	double theta;
	double fai_v;
	double MT_long_angle;
	double MT_lat_angle;
	double Ky;
	double Kz;
	
	double JLLjD1;
	double JLLjD2;
	double JLLjD3;
	double JLLjD4;
	
	double WjD1;
	double WjD2;
	double WjD3;
	double WjD4;
	
	double Targetx;
	double Targety;
	double Targetz;
	
	double Targetx_supositl;
	double Targety_supositl;
	double Targetz_supositl;
	
	double  W_Nav_X;
	double  W_Nav_Y;
	double  W_Nav_Z;
	
	double  W_Bomb_X;
	double  W_Bomb_Y;
	double  W_Bomb_Z;
	
	float timeleft;
	float angle_error;
	
	double P_out;
	double Mass_out;
	double Jx;
	double Jy;
	double Jz;
	double delt_cent;
	
	short SeekerOn;
	short CatchTarget;
	int midcourse;
	}OUT1,*_pOUT;
	///////////////////////////////////////////////////////
	
	typedef struct LONGCHENNAL{  //longitudinal channel
		double time;
		double Vel;
		double mach;
		double Q;
		double alpha;
		double pitch;
		double AIZ;
		double a11;
		double a13;
		double a14;
		double a15;
		double a21;
		double a22;
		double a24;
		double a24t;
		double a25;
		double a31;
		double a33;
		double a34;
		double a35;
		double a36;	
		double mz_alpha;
		double mz_deltaz;
		double Cl_alpha;
		double Cl_deltaz;
	}LONGCHENNAL,*_pLONGCHENNAL;
	
	
	typedef struct LATERALCHENNAL{  //lateral  channel
		double time;
		double Vel;
		double mach;
		double alpha;
		double pitch;
		double b11;
		double b12;
		double b14;
		double b17;
		double b21;
		double b22;
		double b24;
		double b24t;
		double b25;
		double b27;
		double b32;
		double b34;
		double b36;
		double b35;
		double b37;	
		double a33;
		double b15;
		double my_beta;
		double my_deltaY;
		double Cz_beta;
		double Cz_deltaY;
		double mx_beta;
		double mx_deltaY;
		double my_deltaX;
		double mx_deltaX;
	}LATERALCHENNAL,*_pLATERALCHENNAL;
	
	typedef struct{
		double time;
		double R;
		double Vel;
	}GUIDE,*_GUIDE;
	
	typedef struct TEST{
		double time;
		double ay_c;
		double ay;
		double az_c;
		double az;
		double roll_c;
		double roll;
	}TEST,*_pTEST;
	
	typedef struct TESTroll{
		double time;
		double KpV;
		double KiV;
		double KdV;
		double allV;
	}TESTroll,*_pTESTroll;
	
	typedef struct TESTyaw{
		double time;
		double kpV;
		double kiV;
		double kdV;
		double allV;
		double back;
	}TESTyaw,*_pTESTyaw;
	
	typedef struct TESTpitch{
		double time;
		double kpV;
		double kiV;
		double kdV;
		double allV;
		double back;
	}TESTpitch,*_pTESTpitch;
	
	//拉偏结构体
	typedef struct AeroBias
	{
		double dragBias;//阻力拉偏
		double liftBias;//升力拉偏
		double lateralBias;	//侧力拉偏 
		
		double mx2betaBias;//稳定性拉偏
		double my2betaBias;
		double mz2alphaBias;
		
		double mx2dxBias;//舵效拉偏
		double my2dyBias;
		double mz2dzBias;
		
		double mx2wxBias;//动导数拉偏
		double my2wyBias;
		double mz2wzBias;
	}AeroBias,*_pAeroBias;
	
	
	
#endif
