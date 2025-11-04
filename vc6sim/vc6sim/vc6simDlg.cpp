// vc6simDlg.cpp : implementation file
//

#include "stdafx.h"
#include "vc6sim.h"
#include "vc6simDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CAboutDlg dialog used for App About
extern "C"
{
	void INIT_NAV();
}

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();
	
	// Dialog Data
	//{{AFX_DATA(CAboutDlg)
	enum { IDD = IDD_ABOUTBOX };
	//}}AFX_DATA
	
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAboutDlg)
protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL
	
	// Implementation
protected:
	//{{AFX_MSG(CAboutDlg)
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
	//{{AFX_DATA_INIT(CAboutDlg)
	//}}AFX_DATA_INIT
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAboutDlg)
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
//{{AFX_MSG_MAP(CAboutDlg)
// No message handlers
//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CVc6simDlg dialog

CVc6simDlg::CVc6simDlg(CWnd* pParent /*=NULL*/)
: CDialog(CVc6simDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CVc6simDlg)
	m_err_e = 0.0;
	m_err_n = 0.0;
	m_err_zh = 0.0;
	m_stop_pitch = 0.0;
	m_stop_t = 0.0;
	m_stop_v = 0.0;
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CVc6simDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CVc6simDlg)
	DDX_Control(pDX, IDC_start_sim, m_start);
	DDX_Control(pDX, IDC_stop_v, m_stop_V);
	DDX_Control(pDX, IDC_stop_t, m_stop_T);
	DDX_Control(pDX, IDC_stop_pitch, m_stop_P);
	DDX_Control(pDX, IDC_err_zh, m_err_Z);
	DDX_Control(pDX, IDC_err_n, m_err_N);
	DDX_Control(pDX, IDC_err_e, m_err_E);
	DDX_Text(pDX, IDC_err_e, m_err_e);
	DDX_Text(pDX, IDC_err_n, m_err_n);
	DDX_Text(pDX, IDC_err_zh, m_err_zh);
	DDX_Text(pDX, IDC_stop_pitch, m_stop_pitch);
	DDX_Text(pDX, IDC_stop_t, m_stop_t);
	DDX_Text(pDX, IDC_stop_v, m_stop_v);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CVc6simDlg, CDialog)
//{{AFX_MSG_MAP(CVc6simDlg)
ON_WM_SYSCOMMAND()
ON_WM_PAINT()
ON_WM_QUERYDRAGICON()
ON_BN_CLICKED(IDC_para_Set, OnparaSet)
ON_BN_CLICKED(IDC_start_sim, Onstartsim)
	ON_BN_CLICKED(IDC_data_analize, Ondataanalize)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CVc6simDlg message handlers

BOOL CVc6simDlg::OnInitDialog()
{
	CDialog::OnInitDialog();
	
	// Add "About..." menu item to system menu.
	
	// IDM_ABOUTBOX must be in the system command range.
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);
	
	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		CString strAboutMenu;
		strAboutMenu.LoadString(IDS_ABOUTBOX);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}
	
	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon
	
	// TODO: Add extra initialization here
	return TRUE;  // return TRUE  unless you set the focus to a control
}

void CVc6simDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialog::OnSysCommand(nID, lParam);
	}
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CVc6simDlg::OnPaint() 
{
	if (IsIconic())
	{
		CPaintDC dc(this); // device context for painting
		
		SendMessage(WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc(), 0);
		
		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;
		
		// Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

// The system calls this to obtain the cursor to display while the user drags
//  the minimized window.
HCURSOR CVc6simDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

void CVc6simDlg::Init_nav()
{
	INIT_NAV();
	missile.nBombSeverFlag=0;		
	missile.nNaviEstimateFlag=0;		           
	missile.nGpsPpsArrivedFlag=0;	
	missile.nGpsDataReceivedFlag=0;								
	missile.nComNaviStateFlag=2;		
	missile.nWingSpreadFlag=0;		
	missile.nInitNaviModeFlag='D';	
	missile.PlDataUpdate=0;		
	memset(&missile.gyro_offset,0,sizeof(missile.gyro_offset));//载机数据更新标志
}

void CVc6simDlg::Init_sim()
{
	missile.time=0;
	memset(&missile.du,0,sizeof(missile.du));
	memset(&missile.du_c,0,sizeof(missile.du_c));
	memset(&missile.du_ww,0,sizeof(missile.du_ww));
	memset(&missile.GyroOut,0,sizeof(missile.GyroOut));
	memset(&missile.AcceOut,0,sizeof(missile.AcceOut));
	memset(&missile.sins,0,sizeof(missile.sins));
	memset(&missile.fRemote_Test_Gc,0,sizeof(missile.fRemote_Test_Gc));
	memset(&missile.GyroOut,0,sizeof(missile.AcceOut));

	memset(&missile.state_g,0,sizeof(missile.state_g));
	memset(&missile.state_s,0,sizeof(missile.state_s));
	memset(&missile.fluent,0,sizeof(missile.fluent));
	memset(&missile.LBH,0,sizeof(missile.LBH));
	memset(&missile.C_air,0,sizeof(missile.C_air));
	memset(&missile.at_air,0,sizeof(missile.at_air));
	memset(&missile.STA,0,sizeof(missile.STA));
	missile.STA.T_transition=START_CONTROL_TIME;


	missile.ax_noise=0;missile.ay_noise=0;missile.az_noise=0;
	missile.wx_noise=0;missile.wy_noise=0;missile.wz_noise=0;

	memset(&missile.mAeroBias,0,sizeof(missile.mAeroBias));
	memset(&missile.pBLHt,0,sizeof(missile.pBLHt));
	memset(&missile.pRudder_Command,0,sizeof(missile.pRudder_Command));
	memset(&missile.pControl_Para,0,sizeof(missile.pControl_Para));
	memset(&missile.pSeeker,0,sizeof(missile.pSeeker));
	memset(&missile.gOUT,0,sizeof(missile.gOUT));
	memset(&missile.gGUIDE,0,sizeof(missile.gGUIDE));
	memset(&missile.gLONGCHENNAL,0,sizeof(missile.gLONGCHENNAL));
	memset(&missile.gLATERALCHENNAL,0,sizeof(missile.gLATERALCHENNAL));
	memset(&missile.gTest,0,sizeof(missile.gTest));
	memset(&missile.pBombIMUData,0,sizeof(missile.pBombIMUData));
	memset(&missile.nIMUData,0,sizeof(missile.nIMUData));
	memset(&missile.nGpsData,0,sizeof(missile.nGpsData));
	memset(&missile.nSelfAimData,0,sizeof(missile.nSelfAimData));
	memset(&missile.nMainIMUData,0,sizeof(missile.nMainIMUData));
	memset(&missile.nNaviData,0,sizeof(missile.nNaviData));
	memset(&missile.nNaviMidRst,0,sizeof(missile.nNaviMidRst));
	memset(&missile.pNavi_G_Data,0,sizeof(missile.pNavi_G_Data));

	Init_nav();

	//////////////////////////////////////////////////文件相关
	
	missile.fFcsTraj = fopen(".\\simuResult\\fcsTraj.dat","w");
	
	missile.fNavTraj = fopen(".\\simuResult\\sinTraj.dat","w");
	
	missile.fAeroData = fopen(".\\simuResult\\AeroData.dat","w");
	
	missile.fRollChannel = fopen(".\\simuResult\\roll.dat","w");
	
	missile.fYawChannel = fopen(".\\simuResult\\yaw.dat","w");
	
	missile.fPitchChannel = fopen(".\\simuResult\\Pitch.dat","w");
	
	missile.fbody_f = fopen(".\\simuResult\\body_f.dat","w");
	
	missile.ffrequency = fopen(".\\simuResult\\frequency.dat","w"); 
	
	missile.flongchennal = fopen(".\\simuResult\\longchannel.dat","w"); 
	
	missile.flateralchennal = fopen(".\\simuResult\\lateralchannel.dat","w"); 
	
	missile.fguide = fopen(".\\simuResult\\guidance.dat","w"); 
	
	missile.fp_result = fopen(".\\simuResult\\result.txt","a+");
	
	missile.fp_acce = fopen(".\\data\\acce_data.txt","r");
	
	missile.fp_gyro = fopen(".\\data\\gyro_data.txt","r");
	
	missile.fp_wanju = fopen(".\\AeroFile\\FT_9\\FT9_DataCmhCmr.dat","r");
	///////////////////////////////////////////////////////////////////////////
	int iTemp_start;
	char cReadLine[100];
	struct tm *newtime;
	time_t long_time;
	time( &long_time ); 
	newtime = localtime( &long_time );
	iTemp_start = newtime->tm_sec;
	srand( iTemp_start);
    iTemp_start = 5000+rand()%1000;
	
	for(int iRead_File=0;iRead_File<iTemp_start;iRead_File++)     //目的是从iTemp_start行开始读噪声数据
	{
        fgets( cReadLine, 100, missile.fp_acce);
		fgets( cReadLine, 100, missile.fp_gyro);
	}
	/////////////////////////////////////装订结构参数
	missile.Sref = PARA_SET.m_Serf;
	missile.Lref = PARA_SET.m_L;
	missile.Mass = PARA_SET.m_mass0;
	missile.P = PARA_SET.m_P0;
	missile.G_CabinFuel = PARA_SET.m_G_Cabin0;
	missile.G_Cabin = PARA_SET.m_G_Cabin1;
	missile.JX = PARA_SET.m_jx0;
	missile.jx = PARA_SET.m_jx1;
	
	missile.JY = PARA_SET.m_jy0;
	missile.jy = PARA_SET.m_jy1;
	
	missile.JZ = PARA_SET.m_jz0;
	missile.jz = PARA_SET.m_jz1;
	
	
	missile.Jxy = 0.0;
	missile.Jxz = 0.0;
	missile.Jyz = 0.0;
	
	missile.Tpstart1 = PARA_SET.m_Tpstart1;
	missile.Tpstart2 = PARA_SET.m_Tpstart2;
	missile.Tpstart3 = PARA_SET.m_Tpstart3;
	
	missile.P0 = PARA_SET.m_P0;
	missile.P1 = PARA_SET.m_P1;
	missile.P2 = PARA_SET.m_P2;
	
	missile.Mass0 = PARA_SET.m_mass0;
	missile.Mass1 = PARA_SET.m_mass1;
	missile.Mass2 = PARA_SET.m_mass2;
	
	
	
	////////////////////////////////////装订拉偏与干扰
	missile.mdo[0] = PARA_SET.m_mdox;
	missile.mdo[1] = PARA_SET.m_mdox;
	missile.mdo[2] = PARA_SET.m_mdox;
	
	int flag = 0;
	flag=PARA_SET.m_ep_flag;
	
	switch (flag)
	{
	case 0://负比例拉偏
		missile.ep_air[0] = 0.1;//力系数拉偏，ep_air[0]～ep_air[2],-0.1表示负拉偏10％
		missile.ep_air[1] = -0.1;
		missile.ep_air[2] = 0.0;
		
		missile.ep_air[3] = -0.1;//舵效力矩拉偏，ep_air[3]～ep_air[5],-0.1表示负拉偏10％
		missile.ep_air[4] = -0.1;
		missile.ep_air[5] = -0.1;
		
		missile.ep_air[6] = 0.1;//稳定性拉偏，ep_air[6]～ep_air[8],-0.1表示负拉偏10％
		missile.ep_air[7] = 0.1;
		missile.ep_air[8] = 0.1;
		
		missile.ep_air[9] = 0.0;//动导数拉偏，ep_air[9]～ep_air[11],-0.1表示负拉偏10％
		missile.ep_air[10] = -0.0;
		missile.ep_air[11] = -0.0;
		
		break;
	case 1://0比例拉偏
		missile.ep_air[0] = 0.0;//力系数拉偏，ep_air[0]～ep_air[2],-0.1表示负拉偏10％
		missile.ep_air[1] = -0.0;
		missile.ep_air[2] = 0.0;
		
		missile.ep_air[3] = -0.0;//舵效力矩拉偏，ep_air[3]～ep_air[5],-0.1表示负拉偏10％
		missile.ep_air[4] = -0.0;
		missile.ep_air[5] = -0.0;
		
		missile.ep_air[6] = 0.0;//稳定性拉偏，ep_air[6]～ep_air[8],-0.1表示负拉偏10％
		missile.ep_air[7] = 0.0;
		missile.ep_air[8] = 0.0;
		
		missile.ep_air[9] = 0.0;//动导数拉偏，ep_air[9]～ep_air[11],-0.1表示负拉偏10％
		missile.ep_air[10] = -0.0;
		missile.ep_air[11] = -0.0;
		
		break;
	case 2://正比例拉偏
		missile.ep_air[0] = -0.1;//力系数拉偏，ep_air[0]～ep_air[2],-0.1表示负拉偏10％
		missile.ep_air[1] = 0.1;
		missile.ep_air[2] = 0.0;
		
		missile.ep_air[3] = 0.1;//舵效力矩拉偏，ep_air[3]～ep_air[5],-0.1表示负拉偏10％
		missile.ep_air[4] = 0.1;
		missile.ep_air[5] = 0.1;
		
		missile.ep_air[6] = -0.1;//稳定性拉偏，ep_air[6]～ep_air[8],-0.1表示负拉偏10％
		missile.ep_air[7] = -0.1;
		missile.ep_air[8] = -0.1;
		
		missile.ep_air[9] = 0.0;//动导数拉偏，ep_air[9]～ep_air[11],-0.1表示负拉偏10％
		missile.ep_air[10] = -0.0;
		missile.ep_air[11] = -0.0;
		
		break;
	default:
		missile.ep_air[0] = 0.0;//力系数拉偏，ep_air[0]～ep_air[2],-0.1表示负拉偏10％
		missile.ep_air[1] = -0.0;
		missile.ep_air[2] = 0.0;
		
		missile.ep_air[3] = -0.0;//舵效力矩拉偏，ep_air[3]～ep_air[5],-0.1表示负拉偏10％
		missile.ep_air[4] = -0.0;
		missile.ep_air[5] = -0.0;
		
		missile.ep_air[6] = 0.0;//稳定性拉偏，ep_air[6]～ep_air[8],-0.1表示负拉偏10％
		missile.ep_air[7] = 0.0;
		missile.ep_air[8] = 0.0;
		
		missile.ep_air[9] = 0.0;//动导数拉偏，ep_air[9]～ep_air[11],-0.1表示负拉偏10％
		missile.ep_air[10] = -0.0;
		missile.ep_air[11] = -0.0;
		break;
	}
	
	flag=PARA_SET.m_ed_flag;
	
	switch (flag)
	{
	case 0://负常值拉偏
		missile.ed_air[0] = -0.0;
		missile.ed_air[1] = -0.0;
		missile.ed_air[2] = -0.0;
		missile.ed_air[3] = -0.0;
		missile.ed_air[4] = -0.0;
		missile.ed_air[5] = -0.0;
		break;
	case 1://0常值拉偏
		missile.ed_air[0] = 0.0;
		missile.ed_air[1] = 0.0;
		missile.ed_air[2] = 0.0;
		missile.ed_air[3] = 0.0;
		missile.ed_air[4] = 0.0;
		missile.ed_air[5] = 0.0;
		break;
	case 2://正常值拉偏
		missile.ed_air[0] = 0.0;
		missile.ed_air[1] = 0.0;
		missile.ed_air[2] = 0.0;
		missile.ed_air[3] = 0.0;
		missile.ed_air[4] = 0.0;
		missile.ed_air[5] = 0.0;
		break;
	default:
		missile.ed_air[0] = 0.0;
		missile.ed_air[1] = 0.0;
		missile.ed_air[2] = 0.0;
		missile.ed_air[3] = 0.0;
		missile.ed_air[4] = 0.0;
		missile.ed_air[5] = 0.0;
		break;
	}
	
	flag=PARA_SET.m_gz_z_flag;
	
	switch (flag)
	{
	case 0://噪声倍数0
		missile.k_coeff_gyro = 0.0;
		missile.k_coeff_acce = 0.0;
		break;
	case 1://噪声倍数0.5
		missile.k_coeff_gyro = 0.5;
		missile.k_coeff_acce = 0.5;
		break;
	case 2://噪声倍数1
		missile.k_coeff_gyro = 1.0;
		missile.k_coeff_acce = 1.0;
		break;
	default:
		missile.k_coeff_gyro = 0.0;
		missile.k_coeff_acce = 0.0;
		break;
	}
	
	flag=PARA_SET.m_gz_d_flag;
	
	switch (flag)
	{
	case 0://惯组延时0
		missile.AcceDelay = 0;
		missile.GyroDelay = 0;
		break;
	case 1://惯组延时5
		missile.AcceDelay = 1;
		missile.GyroDelay = 1;
		break;
	case 2://惯组延时10
		missile.AcceDelay = 2;
		missile.GyroDelay = 2;
		break;
	default:
		missile.AcceDelay = 0;
		missile.GyroDelay = 0;
		break;
	}
	
	flag=PARA_SET.m_rudder_flag;
	
	switch (flag)
	{
	case 0://舵机延时0
		missile.RUDDELAY = 0;
		break;
	case 1://舵机延时10
		missile.RUDDELAY = 1;
		break;
	case 2://舵机延时20
		missile.RUDDELAY = 2;
		break;
	default:
		missile.RUDDELAY = 0;
		break;
	}
	
	
	missile.mAeroBias.dragBias    = missile.ep_air[0];
	missile.mAeroBias.liftBias    = missile.ep_air[1];
	missile.mAeroBias.lateralBias = missile.ep_air[2];
	
	missile.mAeroBias.mx2dxBias = missile.ep_air[3];
	missile.mAeroBias.my2dyBias = missile.ep_air[4];
	missile.mAeroBias.mz2dzBias = missile.ep_air[5];
	
	missile.mAeroBias.mx2betaBias = missile.ep_air[6];
	missile.mAeroBias.my2betaBias = missile.ep_air[7];
	missile.mAeroBias.mz2alphaBias = missile.ep_air[8];
	
	missile.mAeroBias.mx2wxBias = missile.ep_air[9];
	missile.mAeroBias.my2wyBias = missile.ep_air[10];
	missile.mAeroBias.mz2wzBias = missile.ep_air[11];
	
	////////////////////////////////////////////////装订弹运动信息
	missile.state_g[0] = PARA_SET.m_lon*DEG2RAD; 
	missile.state_g[1] = PARA_SET.m_lat*DEG2RAD;
	missile.state_g[2] = PARA_SET.m_height;//经 纬 高
	
	missile.state_g[3] = PARA_SET.m_roll*DEG2RAD;
	missile.state_g[4] = PARA_SET.m_yaw*DEG2RAD;
	missile.state_g[5] = PARA_SET.m_pitch*DEG2RAD;//滚转 偏航 俯仰
	
	missile.state_g[6] = PARA_SET.m_v*cos(PARA_SET.m_vud*DEG2RAD);//北速
	missile.state_g[7] = PARA_SET.m_v*sin(PARA_SET.m_vud*DEG2RAD);//天速
	missile.state_g[8] = PARA_SET.m_v*sin(-PARA_SET.m_ved*DEG2RAD);//东速
	
	missile.state_g[9] = PARA_SET.m_wx*DEG2RAD;
	missile.state_g[10] = PARA_SET.m_wy*DEG2RAD;
	missile.state_g[11] = PARA_SET.m_wz*DEG2RAD; //角速度
	
	///////////////////////////////////////////////////装订目标运动信息
	
	missile.Target_IniPos[0] = PARA_SET.m_height_t;//目标高度
	missile.Target_IniPos[1] = PARA_SET.m_distance;//目标射程(二维平面)
	missile.Target_IniPos[2] = PARA_SET.m_yaw_t*DEG2RAD;//目标方位
	
	missile.TargetMove[0] = PARA_SET.m_v_t*sin(PARA_SET.m_ved_t*DEG2RAD);//东速
	missile.TargetMove[1] = PARA_SET.m_v_t*cos(PARA_SET.m_ved_t*DEG2RAD);//北速
	missile.TargetMove[2] = 0.0;//天速
	
	missile.Target_Initx = -missile.Target_IniPos[1]*sin(missile.Target_IniPos[2]);	//东
	missile.Target_Inity = missile.Target_IniPos[1]*cos(missile.Target_IniPos[2]);//北
	missile.Target_Initz = missile.Target_IniPos[0];//天
	
	
	missile.Target_IniPos_supositl[0] = missile.Target_Initz +  Target_IniPos_error[2]; //预估目标初始位置（叠加载机装订误差）//目标高度
	missile.Target_IniPos_supositl[1] = sqrt(pow(missile.Target_Initx+Target_IniPos_error[0],2) + pow(missile.Target_Inity+Target_IniPos_error[1],2)); //射程
	missile.Target_IniPos_supositl[2] = -atan2((missile.Target_Initx+Target_IniPos_error[0]),(missile.Target_Inity+Target_IniPos_error[1])); //目标方位角
	
	missile.TargetMove_supositl[0] = missile.TargetMove[0] + TargetMove_error[0]; //预估东向速度//预估目标运动信息（叠加目标运动估计误差）
	missile.TargetMove_supositl[1] = missile.TargetMove[1] + TargetMove_error[1]; //预估北向速度
	missile.TargetMove_supositl[2] = missile.TargetMove[2] + TargetMove_error[2]; //预估天向速度
	
	//////////////////////////////////////////////////////装订风
	flag=PARA_SET.m_wind_type_flag;
	
	switch (flag)
	{
	case 0://无风
		missile.Wind_type[0] = 0.0*0.2*PARA_SET.m_wind_ratio_flag;
		missile.Wind_type[1] = 0.0;
		missile.Wind_type[2] = 3000.0;
		missile.Wind_type[3] = 2000.0;
		missile.Wind_type[4] = 0.0;
		missile.Wind_type[5] = 270.0;
		missile.Wind_type[6] = 3500.0;
		missile.Wind_type[7] = 2500.0;
		missile.Wind_type[8] = 0.0;
		break;
	case 1://逆风
		missile.Wind_type[0] = 1.0*0.2*PARA_SET.m_wind_ratio_flag;;
		missile.Wind_type[1] = 180.0;
		missile.Wind_type[2] = 3000.0;
		missile.Wind_type[3] = 2000.0;
		missile.Wind_type[4] = 0.0;
		missile.Wind_type[5] = 270.0;
		missile.Wind_type[6] = 3500.0;
		missile.Wind_type[7] = 2500.0;
		missile.Wind_type[8] = 0.0;
		break;
	case 2://顺风
		missile.Wind_type[0] = 1.0*0.2*PARA_SET.m_wind_ratio_flag;;
		missile.Wind_type[1] = 0.0;
		missile.Wind_type[2] = 3000.0;
		missile.Wind_type[3] = 2000.0;
		missile.Wind_type[4] = 0.0;
		missile.Wind_type[5] = 270.0;
		missile.Wind_type[6] = 3500.0;
		missile.Wind_type[7] = 2500.0;
		missile.Wind_type[8] = 0.0;
		break;
	case 3://侧风
		missile.Wind_type[0] = 1.0*0.2*PARA_SET.m_wind_ratio_flag;;
		missile.Wind_type[1] = 90.0;
		missile.Wind_type[2] = 3000.0;
		missile.Wind_type[3] = 2000.0;
		missile.Wind_type[4] = 0.0;
		missile.Wind_type[5] = 270.0;
		missile.Wind_type[6] = 3500.0;
		missile.Wind_type[7] = 2500.0;
		missile.Wind_type[8] = 0.0;
		break;
	default:
		missile.Wind_type[0] = 0.0*0.2*PARA_SET.m_wind_ratio_flag;
		missile.Wind_type[1] = 0.0;
		missile.Wind_type[2] = 3000.0;
		missile.Wind_type[3] = 2000.0;
		missile.Wind_type[4] = 0.0;
		missile.Wind_type[5] = 270.0;
		missile.Wind_type[6] = 3500.0;
		missile.Wind_type[7] = 2500.0;
		missile.Wind_type[8] = 0.0;
		break;
	}
	//////////////////////////////////////////////读气动数据
	missile.ReadAerodynamicsData(PARA_SET.FilePathName_qd_gz, PARA_SET.FilePathName_qd_ph, PARA_SET.FilePathName_qd_fy);
	//////////////////////////////////////////////参数初始化
	missile.GeographyToEarth(missile.state_g[0], missile.state_g[1], missile.state_g[2],
		missile.state_g[3], missile.state_g[4], missile.state_g[5], missile.state_g[6], 
		missile.state_g[7], missile.state_g[8], missile.state_g[9], missile.state_g[10], 
		missile.state_g[11], missile.state_s);
	
	missile.EarthToGeography(0,missile.state_s,missile.state_s, missile.LBH);
	
	missile.Target(missile.time,missile.state_g[0],missile.state_g[1],missile.Target_IniPos,missile.Target_IniPos_supositl,
	missile.TargetMove,missile.TargetMove_supositl,&missile.pBLHt);//target information 目标位置和速度信息
}

void CVc6simDlg::Ondataanalize() 
{
	// TODO: Add your control notification handler code here


	CVc6simDlg::OnOK();
	
}

void CVc6simDlg::OnparaSet() 
{
	// TODO: Add your control notification handler code here
	
	GetCurrentDirectory(100,Directory);
	PARA_SET.DoModal();
	SetCurrentDirectory(Directory);
}

void CVc6simDlg::Onstartsim() 
{
	// TODO: Add your control notification handler code here
	Init_sim();

	m_start.SetWindowText("仿真中...");
	
	for(int i = 0; missile.LBH[2] > missile.pBLHt.Altitude; i++)//主循环，以高度为截止条件
	{
		unsigned int ControlTime = i;
		missile.time = ControlTime*step;
		
		missile.Target(missile.time,missile.state_g[0],missile.state_g[1],missile.Target_IniPos,missile.Target_IniPos_supositl,
			missile.TargetMove,missile.TargetMove_supositl,&missile.pBLHt);//target information 目标位置和速度信息
		
		missile.gOUT.Targetx = (missile.pBLHt.Longitude - missile.state_g[0])*R0*cos(missile.state_g[1]);	//以发射点为原点的目标运动轨迹
		missile.gOUT.Targety = (missile.pBLHt.Latitude - missile.state_g[1])*R0;
		missile.gOUT.Targetz = missile.pBLHt.Altitude - missile.Target_IniPos[0];
		
		missile.gOUT.Targetx_supositl = (missile.pBLHt.Longitude_supositl - missile.state_g[0])*R0*cos(missile.state_g[1]);
		missile.gOUT.Targety_supositl = (missile.pBLHt.Latitude_supositl - missile.state_g[1])*R0;
		missile.gOUT.Targetz_supositl = missile.pBLHt.Altitude_supositl - missile.Target_IniPos_supositl[0];
		
		missile.Dynamic(missile.time,missile.fluent,missile.du,missile.state_s,missile.C_air,missile.at_air,&missile.pBombIMUData,missile.LBH);
		
		//加IMU噪声
		
		if(missile.k_coeff_gyro>0||missile.k_coeff_acce>0)
		{
			if(!feof(missile.fp_acce))
			{
				fscanf(missile.fp_acce,"%lf %lf %lf\n",&missile.ax_noise,&missile.ay_noise,&missile.az_noise);
				missile.ay_noise =missile.ay_noise +9.8;
			}
			
			if(!feof(missile.fp_gyro))
			{
				fscanf(missile.fp_gyro,"%lf %lf %lf\n",&missile.wx_noise,&missile.wy_noise,&missile.wz_noise);
			}
			missile.ax_noise = missile.ax_noise*missile.k_coeff_acce;
			missile.ay_noise = missile.ay_noise*missile.k_coeff_acce;
			missile.az_noise = missile.az_noise*missile.k_coeff_acce;
			missile.wx_noise = missile.wx_noise*missile.k_coeff_gyro;
			missile.wy_noise = missile.wy_noise*missile.k_coeff_gyro;
			missile.wz_noise = missile.wz_noise*missile.k_coeff_gyro;
		}
		///加IMU延时
		missile.IMU_Delay();
		///加零偏零漂非线性
		missile.IMU_nonliner();
		
		///导航解算
		missile.NAVAGATION_M(i);
		//导航解算结果
		missile.sins[6]=missile.nNaviData.Longitude;
		missile.sins[7]=missile.nNaviData.Latitude;
		missile.sins[8]=missile.nNaviData.Altitude;  
		missile.sins[3]=missile.nNaviData.Ve; 
		missile.sins[4]=missile.nNaviData.Vn; 
		missile.sins[5]=missile.nNaviData.Vu; 
		missile.sins[0]=missile.nNaviData.Pitch;
		missile.sins[1]=missile.nNaviData.Roll;
		missile.sins[2]=missile.nNaviData.Yaw;
		if(PARA_SET.b_Dynamic_navigation == false)
		{
			//----> 导航解算 位置 姿态 速度
			missile.pNavi_G_Data.Latitude= missile.sins[7]; 
			missile.pNavi_G_Data.Longitude= missile.sins[6]; 
			missile.pNavi_G_Data.Altitude= missile.sins[8];  
			missile.pNavi_G_Data.Pitch= missile.sins[0];  
			missile.pNavi_G_Data.Yaw= missile.sins[2];    
			missile.pNavi_G_Data.Roll= missile.sins[1];   
			missile.pNavi_G_Data.Ve= missile.sins[3];        
			missile.pNavi_G_Data.Vn= missile.sins[4];        
			missile.pNavi_G_Data.Vu= missile.sins[5];  
		}
		else
		{
			//----> 动力学解算 位置 姿态 速度		
			missile.pNavi_G_Data.Latitude= missile.LBH[1]; 
			missile.pNavi_G_Data.Longitude= missile.LBH[0]; 
			missile.pNavi_G_Data.Altitude= missile.LBH[2];  
			missile.pNavi_G_Data.Pitch= missile.LBH[8];  
			missile.pNavi_G_Data.Yaw= missile.LBH[7];    
			missile.pNavi_G_Data.Roll= missile.LBH[6];   
			missile.pNavi_G_Data.Ve= missile.LBH[5];        
			missile.pNavi_G_Data.Vn= missile.LBH[3];        
			missile.pNavi_G_Data.Vu= missile.LBH[4];
			
			missile.pBombIMUData.wx = missile.state_s[10];
			missile.pBombIMUData.wy = missile.state_s[11];
			missile.pBombIMUData.wz = missile.state_s[12];
			
			missile.pBombIMUData.ax = missile.at_air[0];
			missile.pBombIMUData.ay = missile.at_air[1];  
			missile.pBombIMUData.az = missile.at_air[2];
		}
		
		missile.guid_and_control(&missile.pBombIMUData,&missile.pNavi_G_Data,ControlTime,&missile.pRudder_Command,&missile.pControl_Para,&missile.pBLHt,&missile.pSeeker);
		
		
		missile.du_c[0]= (-missile.pRudder_Command.Rudder1- missile.pRudder_Command.Rudder2+ missile.pRudder_Command.Rudder3+ missile.pRudder_Command.Rudder4)/4.0;  //升降舵
		missile.du_c[1]= ( missile.pRudder_Command.Rudder1+ missile.pRudder_Command.Rudder2+ missile.pRudder_Command.Rudder3+ missile.pRudder_Command.Rudder4)/4.0;  //滚动舵
		missile.du_c[2]= (-missile.pRudder_Command.Rudder1+ missile.pRudder_Command.Rudder2+ missile.pRudder_Command.Rudder3- missile.pRudder_Command.Rudder4)/4.0;  //偏航舵 
		
		missile.Rudder(step,missile.du,missile.du_c);
		missile.Rudder_Delay();
		
		missile.gOUT.x=(missile.LBH[0]-missile.state_g[0])*R0*cos(missile.state_g[1]);	
		missile.gOUT.y=(missile.LBH[1]-missile.state_g[1])*R0;	
		
		if( i%10 == 0 )
		{
			//---->稳定域度计算
			missile.Margin(missile.time,missile.LBH,missile.du,missile.fluent,missile.state_s,missile.C_air,missile.fyfz);
			
			fprintf(missile.fFcsTraj,"%8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f\n ",  
				missile.time,                                // 1：时间
				missile.gOUT.x,missile.gOUT.y,missile.LBH[2],// 2：东向距离； 3：北向距离； 4：高度
				missile.LBH[0]*RAD2DEG,missile.LBH[1]*RAD2DEG,missile.LBH[2],// 5：经度； 6：纬度； 7：高度
				missile.LBH[3],missile.LBH[4],missile.LBH[5],                // 8：北速； 9：天速； 10：东速
				missile.LBH[6],missile.LBH[7],missile.LBH[8],                // 11：滚转角； 12：偏航角； 13：俯仰角；
				missile.gOUT.wx,missile.gOUT.wy,missile.gOUT.wz,             // 14：滚转角速度； 15：偏航角速度；16：俯 仰角速度；
				missile.gOUT.alpha,missile.gOUT.beta,missile.gOUT.mach,      // 17：攻角； 18：侧滑角； 19：马赫数；
				missile.du[0],missile.du[1],missile.du[2],                   // 20：升降舵； 21：滚动舵； 22：偏航舵； 
				missile.gOUT.accX,missile.gOUT.accY,missile.gOUT.accZ,       // 23：纵向加速度； 24：法向加速度； 25：侧向加速度；
				missile.gOUT.accY_c,missile.gOUT.accZ_c,missile.gOUT.WOMAX,  // 26：指令法向加速度； 27：指令侧向加速度； 28：允许过载；
				missile.du_c[0],missile.du_c[1],missile.du_c[2],             // 29：指令升降舵； 30：指令滚动舵； 31：偏航舵指令；
				missile.gOUT.theta, missile.gOUT.Q,            		 //	32：弹道倾角， 33：动压	
				missile.gOUT.Targetx,missile.gOUT.Targety,missile.gOUT.Targetz,  // 34：目标东向距离 35：目标北向距离 36：目标高度
				missile.gOUT.W_Nav_X,missile.gOUT.W_Nav_Y,missile.gOUT.W_Nav_Z, //37：东向角速率 38：北向角速率 39：天向角速率 地理系
				missile.gOUT.W_Bomb_X,missile.gOUT.W_Bomb_Y,missile.gOUT.W_Bomb_Z,	//40：轴向角速率 41：侧向角速率 42：法向角速率 体系	
				missile.gOUT.Targetx_supositl,missile.gOUT.Targety_supositl,missile.gOUT.Targetz_supositl, //预估的 43：目标东向距离  44：目标北向距离  45：目标高度
				missile.gOUT.Jx,missile.gOUT.Jy,missile.gOUT.Jz,missile.gGUIDE.R,missile.gOUT.P_out,missile.gOUT.Mass_out//46 47 48 49 50 51
				);
			
			fprintf(missile.fAeroData,"%4.4f    %8.7f %8.7f %8.7f  %8.7f %8.7f %8.7f  %8.7f %8.7f   %8.7f %8.7f %8.7f  %8.7f %8.7f %8.7f  %8.7f %8.7f   %8.7f %8.7f %8.7f\n ",  
				missile.time, 
				missile.gOUT.cx, missile.gOUT.cy, missile.gOUT.cz,		//2,3,4
				missile.gOUT.Cmx, missile.gOUT.Cmy, missile.gOUT.Cmz,	//5,6,7
				missile.gOUT.Cl2Cd, missile.gOUT.Q,				//8,9
				missile.gOUT.cd, missile.gOUT.cl, missile.gOUT.czw,		//10,11,12
				missile.gOUT.JLLjD1,missile.gOUT.JLLjD2,missile.gOUT.JLLjD3,missile.gOUT.JLLjD4, //13 14 15 16
				missile.gOUT.WjD1,missile.gOUT.WjD2,missile.gOUT.WjD3,missile.gOUT.WjD4);//17 18 19 20  
			
			fprintf(missile.fNavTraj,"%8.7f    %8.7f %8.7f %8.7f   	%8.7f %8.7f %8.7f    %8.7f %8.7f %8.7f\n ",    
				missile.time,missile.sins[6],missile.sins[7],missile.sins[8],missile.sins[3],missile.sins[4],missile.sins[5],missile.sins[0],missile.sins[1],missile.sins[2]);  
			//    1     2        3       4       5      6       7        8       9       10
			
			fprintf(missile.fRollChannel,"%4.4f     %8.7f %8.7f %8.7f     %8.7f %8.7f %8.7f     %8.7f %8.7f %8.7f   %8.7f\n ",  
				missile.time,missile.gOUT.roll_c, missile.gOUT.roll, missile.gOUT.wx,   //4
				missile.gOUT.Roll_Kp,missile.gOUT.Roll_Ki,missile.gOUT.Roll_Kd,  // 7
				missile.gOUT.AIX,missile.gOUT.b17,missile.gOUT.b11,missile.gOUT.Q);	//11
			fprintf(missile.fYawChannel,"%4.4f  %8.7f %8.7f %8.7f   %8.7f %8.7f %5.5f    %5.5f  %5.5f  %5.5f      %5.5f   %5.5f  %5.5f\n",
				missile.time, 
				missile.gOUT.wy,missile.gOUT.Yaw_oyf,
				missile.gOUT.Yaw_Kp,missile.gOUT.Yaw_Ki,missile.gOUT.Yaw_Kd, 
				missile.gOUT.Yaw_pi,missile.gOUT.Yaw_gravity,missile.gOUT.Yaw_WO2,missile.gOUT.Yaw_SLY,missile.gOUT.AIY,missile.gOUT.Yaw_Kwy,missile.gOUT.Q); 		
			fprintf(missile.fPitchChannel,"%4.4f   %8.7f %8.7f     %8.7f %8.7f %5.5f    %5.5f  %5.5f   %5.5f        %5.5f   %8.7f %8.7f\n",
				missile.time,                            //time  
				missile.gOUT.wz, missile.gOUT.Pitch_oyf,         //wf   
				missile.gOUT.Pitch_Kp, missile.gOUT.Pitch_Ki, missile.gOUT.Pitch_Kd, 
				missile.gOUT.Pitch_n_final, missile.gOUT.ny2_guide, missile.gOUT.g0_compensator, missile.gOUT.ny2_compensator,missile.gOUT.Pitch_SLZ,missile.gOUT.Pitch_Kwz); //OMLM   比例项  重量补偿项  允许过载			
			
			fprintf(missile.fbody_f,"%4.4f    %5.5f  %5.5f\n ",  missile.time, missile.fyfz[0], missile.fyfz[1]);
			fprintf(missile.ffrequency, "%8.7f    %8.7f %8.7f %8.7f   	%8.7f %8.7f %8.7f\n ",
				missile.time, missile.gTest.ay, missile.gTest.ay_c, missile.gTest.az, missile.gTest.az_c, missile.gTest.roll, missile.gTest.roll_c);
			
			fprintf(missile.flongchennal, "%5.5f %5.5f     %8.7f %8.7f %8.7f %8.7f     %8.7f    %5.5f  %5.5f  %5.5f  %5.5f     %7.7f  %7.7f    %5.5f  %5.5f   %5.5f  %5.5f   %5.5f  %5.5f   %5.5f  %5.5f\n ", 
				missile.time, missile.gOUT.Q, missile.gLONGCHENNAL.a11, missile.gLONGCHENNAL.a21, missile.gLONGCHENNAL.a31, missile.gLONGCHENNAL.a22, //6
				missile.gLONGCHENNAL.a13,missile.gLONGCHENNAL.a33,missile.gLONGCHENNAL.a14,missile.gLONGCHENNAL.a24,missile.gLONGCHENNAL.a24t,//11
				missile.gLONGCHENNAL.a34,missile.gLONGCHENNAL.a25,missile.gLONGCHENNAL.a35,missile.gLONGCHENNAL.AIZ,missile.gOUT.Vel,             //16
				missile.gLONGCHENNAL.mz_alpha,missile.gLONGCHENNAL.mz_deltaz,missile.gLONGCHENNAL.Cl_alpha,missile.gLONGCHENNAL.Cl_deltaz,    //20
				missile.gOUT.alpha);
			
			
			fprintf(missile.flateralchennal, "%4.4f   %8.7f     %8.7f %8.7f %8.7f     %8.7f %8.7f  %8.7f  %8.7f %8.7f %8.7f  %8.7f   %8.7f   %8.7f %8.7f  %8.7f  %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f %8.7f\n ", 
				missile.time, missile.gOUT.Q, missile.gLATERALCHENNAL.pitch, missile.gLATERALCHENNAL.b11, missile.gLATERALCHENNAL.b12,     //5
				missile.gLATERALCHENNAL.b14, missile.gLATERALCHENNAL.b15,missile.gLATERALCHENNAL.b17, missile.gLATERALCHENNAL.b21,   //9
				missile.gLATERALCHENNAL.b22, missile.gLATERALCHENNAL.b24,missile.gLATERALCHENNAL.b32, missile.gLATERALCHENNAL.b34,    //13
				missile.gLATERALCHENNAL.b35, missile.gLATERALCHENNAL.b36,missile.gLATERALCHENNAL.a33, missile.gLATERALCHENNAL.b24t,   //17
				missile.gOUT.Vel,missile.gLATERALCHENNAL.b25,missile.gOUT.wy,                                                        //20
				missile.gLATERALCHENNAL.my_beta,missile.gLATERALCHENNAL.my_deltaY,missile.gLATERALCHENNAL.Cz_beta,missile.gLATERALCHENNAL.Cz_deltaY,   //24
				missile.gLATERALCHENNAL.mx_beta,missile.gLATERALCHENNAL.mx_deltaY,missile.gLATERALCHENNAL.my_deltaX,missile.gLATERALCHENNAL.mx_deltaX,missile.gLATERALCHENNAL.b15);//29
			
			
			fprintf(missile.fguide,"%4.4f    %5.5f  %5.5f  %5.5f  %5.5f %5.5f  %5.5f %5.5f  %5.5f %5.5f %5.5f %5.5f %d %d %d %5.5f\n ", 
				missile.time,missile.gGUIDE.R, missile.gGUIDE.Vel,  //1 2 3
				missile.gOUT.theta,missile.gOUT.fai_v,      //4 5 弹道倾角，弹道偏角 
				missile.gOUT.MT_long_angle,missile.gOUT.MT_lat_angle,// 6 7 弹目连线与北向夹角，弹目连线与水平面夹角
				missile.gOUT.Ky,missile.gOUT.Kz,//8 9
				missile.gOUT.Vel,//10只在Margin()函数中使用
				missile.gOUT.timeleft,missile.gOUT.angle_error,//11 12
				missile.gOUT.SeekerOn,missile.gOUT.CatchTarget,missile.gOUT.midcourse,missile.gOUT.Q//13 14 15 16
				);
		}
		
	}
	
	double  dx=(missile.LBH[0]-missile.pBLHt.Longitude)*R1*cos(missile.LBH[1])+(missile.LBH[2]-missile.pBLHt.Altitude)/(-missile.LBH[4])*missile.LBH[5];
	double	dy=(missile.LBH[1]-missile.pBLHt.Latitude)*R1+(missile.LBH[2]-missile.pBLHt.Altitude)/(-missile.LBH[4])*missile.LBH[3];
	double S_err = sqrt(dx*dx+dy*dy);

	UpdateData(TRUE);

	m_err_e=dx;
	m_err_n=dy;
	m_err_zh=S_err;
	
	m_stop_pitch=missile.gOUT.theta*57.3;
	m_stop_v=missile.gGUIDE.Vel;
	m_stop_t=missile.time;
	
	m_start.SetWindowText("开始仿真");
	UpdateData(FALSE);

	fclose(missile.fFcsTraj);
	fclose(missile.fNavTraj);
	fclose(missile.fAeroData);	
	
	fclose(missile.fRollChannel);
	fclose(missile.fYawChannel);
	fclose(missile.fPitchChannel);
	
	fclose(missile.fbody_f);
	fclose(missile.ffrequency);
	fclose(missile.flongchennal);
	fclose(missile.flateralchennal);
	fclose(missile.fguide);
	fclose(missile.fp_acce);
	fclose(missile.fp_gyro);
	
}



