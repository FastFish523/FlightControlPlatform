// Para_set.cpp : implementation file
//

#include "stdafx.h"
#include "vc6sim.h"
#include "Para_set.h"
#include "Missile.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CPara_set dialog


CPara_set::CPara_set(CWnd* pParent /*=NULL*/)
	: CDialog(CPara_set::IDD, pParent)
{
	//{{AFX_DATA_INIT(CPara_set)
	m_mass0 = 41.2;
	m_mass1 = 38.2;
	m_mass2 = 33.2;
	m_P0 = 0.0;
	m_P1 = 2400.0;
	m_P2 = 800.0;
	m_Serf = 0.018146;
	m_L = 1.8;
	m_jx0 = 0.14;
	m_jx1 = 0.118;
	m_jx2 = 0.118;
	m_jy0 = 8.6;
	m_jy1 = 7.339;
	m_jy2 = 7.339;
	m_jz0 = 8.6;
	m_jz1 = 7.351;
	m_jz2 = 7.351;
	m_G_Cabin0 = 1043.0;
	m_G_Cabin1 = 963.26;
	m_G_Cabin2 = 963.26;
	m_mdox = 0.0;
	m_mdoy = 0.0;
	m_mdoz = 0.0;
	m_ed_flag = 0;
	m_ep_flag = 0;
	m_gz_z_flag = 0;
	m_gz_d_flag = 0;
	m_rudder_flag = 0;
	m_distance = 4000.0;
	m_height = 0.5;
	m_height_t = 0.0;
	m_lat = 39.3;
	m_lon = 108.0;
	m_pitch = 20.0;
	m_roll = 0.0;
	m_ved = 0.0;
	m_ved_t = 0.0;
	m_v = 32.0;
	m_v_t = 0.0;
	m_vud = 20.0;
	m_vud_t = 0.0;
	m_wx = 0.0;
	m_wy = 0.0;
	m_wz = -10.0;
	m_yaw = -5.0;
	m_yaw_t = 5.0;
	m_wind_type_flag = 0;
	m_wind_ratio_flag = 0;
	m_Tpstart1 = 0.5;
	m_Tpstart2 = 3.5;
	m_Tpstart3 = 18.5;
	//}}AFX_DATA_INIT
	b_Dynamic_navigation=FALSE;
}


void CPara_set::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CPara_set)
	DDX_Control(pDX, IDC_SIM_TYPE, m_sim_type);
	DDX_Control(pDX, IDC_qd_fy, m_qd_fy);
	DDX_Control(pDX, IDC_qd_ph, m_qd_ph);
	DDX_Control(pDX, IDC_qd_gz, m_qd_gz);
	DDX_Control(pDX, IDC_WIND_RATIO, m_wind_ratio);
	DDX_Control(pDX, IDC_WIND_TYPE, m_wind_type);
	DDX_Control(pDX, IDC_rudder_delay_flag, m_rudder_delay_flag);
	DDX_Control(pDX, IDC_gz_zaosheng_flag, m_gz_zaosheng_flag);
	DDX_Control(pDX, IDC_gz_Delay_flag, m_gz_delag_flag);
	DDX_Control(pDX, IDC_ep_air_flag, m_ep_air_flag);
	DDX_Control(pDX, IDC_ed_air_flag, m_ed_air_flag);
	DDX_Text(pDX, IDC_Mass0, m_mass0);
	DDX_Text(pDX, IDC_Mass1, m_mass1);
	DDX_Text(pDX, IDC_Mass2, m_mass2);
	DDX_Text(pDX, IDC_P0, m_P0);
	DDX_Text(pDX, IDC_P1, m_P1);
	DDX_Text(pDX, IDC_P2, m_P2);
	DDX_Text(pDX, IDC_Serf, m_Serf);
	DDX_Text(pDX, IDC_L, m_L);
	DDX_Text(pDX, IDC_JX0, m_jx0);
	DDX_Text(pDX, IDC_JX1, m_jx1);
	DDX_Text(pDX, IDC_JX2, m_jx2);
	DDX_Text(pDX, IDC_JY0, m_jy0);
	DDX_Text(pDX, IDC_JY1, m_jy1);
	DDX_Text(pDX, IDC_JY2, m_jy2);
	DDX_Text(pDX, IDC_JZ0, m_jz0);
	DDX_Text(pDX, IDC_JZ1, m_jz1);
	DDX_Text(pDX, IDC_JZ2, m_jz2);
	DDX_Text(pDX, IDC_G_Cabin0, m_G_Cabin0);
	DDX_Text(pDX, IDC_G_Cabin1, m_G_Cabin1);
	DDX_Text(pDX, IDC_G_Cabin2, m_G_Cabin2);
	DDX_Text(pDX, IDC_mdox, m_mdox);
	DDX_Text(pDX, IDC_mdoy, m_mdoy);
	DDX_Text(pDX, IDC_mdoz, m_mdoz);
	DDX_CBIndex(pDX, IDC_ed_air_flag, m_ed_flag);
	DDX_CBIndex(pDX, IDC_ep_air_flag, m_ep_flag);
	DDX_CBIndex(pDX, IDC_gz_zaosheng_flag, m_gz_z_flag);
	DDX_CBIndex(pDX, IDC_gz_Delay_flag, m_gz_d_flag);
	DDX_CBIndex(pDX, IDC_rudder_delay_flag, m_rudder_flag);
	DDX_Text(pDX, IDC_DIST, m_distance);
	DDX_Text(pDX, IDC_HEG, m_height);
	DDX_Text(pDX, IDC_HEG_T, m_height_t);
	DDX_Text(pDX, IDC_LAT, m_lat);
	DDX_Text(pDX, IDC_LON, m_lon);
	DDX_Text(pDX, IDC_PITCH, m_pitch);
	DDX_Text(pDX, IDC_ROLL, m_roll);
	DDX_Text(pDX, IDC_VE, m_ved);
	DDX_Text(pDX, IDC_VE_T, m_ved_t);
	DDX_Text(pDX, IDC_VN, m_v);
	DDX_Text(pDX, IDC_VN_T, m_v_t);
	DDX_Text(pDX, IDC_VU, m_vud);
	DDX_Text(pDX, IDC_VU_T, m_vud_t);
	DDX_Text(pDX, IDC_WX, m_wx);
	DDX_Text(pDX, IDC_WY, m_wy);
	DDX_Text(pDX, IDC_WZ, m_wz);
	DDX_Text(pDX, IDC_YAW, m_yaw);
	DDX_Text(pDX, IDC_YAW_T, m_yaw_t);
	DDX_CBIndex(pDX, IDC_WIND_TYPE, m_wind_type_flag);
	DDX_CBIndex(pDX, IDC_WIND_RATIO, m_wind_ratio_flag);
	DDX_Text(pDX, IDC_t1, m_Tpstart1);
	DDX_Text(pDX, IDC_t2, m_Tpstart2);
	DDX_Text(pDX, IDC_t3, m_Tpstart3);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CPara_set, CDialog)
	//{{AFX_MSG_MAP(CPara_set)
	ON_CBN_SELCHANGE(IDC_ed_air_flag, OnSelchangeedairflag)
	ON_CBN_SELCHANGE(IDC_ep_air_flag, OnSelchangeepairflag)
	ON_CBN_SELCHANGE(IDC_gz_zaosheng_flag, OnSelchangegzzaoshengflag)
	ON_CBN_SELCHANGE(IDC_gz_Delay_flag, OnSelchangegzDelayflag)
	ON_CBN_SELCHANGE(IDC_rudder_delay_flag, OnSelchangerudderdelayflag)
	ON_CBN_SELCHANGE(IDC_WIND_TYPE, OnSelchangeWindType)
	ON_CBN_SELCHANGE(IDC_WIND_RATIO, OnSelchangeWindRatio)
	ON_BN_CLICKED(IDC_qd_gz_bt, Onqdgzbt)
	ON_BN_CLICKED(IDC_qd_pg_bt, Onqdpgbt)
	ON_BN_CLICKED(IDC_qd_fy_bt, Onqdfybt)
	ON_CBN_SELCHANGE(IDC_SIM_TYPE, OnSelchangeSimType)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CPara_set message handlers

void CPara_set::OnOK() 
{
	// TODO: Add extra validation here
	UpdateData(TRUE);
	
	CDialog::OnOK();
}

BOOL CPara_set::OnInitDialog() 
{
	CDialog::OnInitDialog();
	
	// TODO: Add extra initialization here
	m_ep_air_flag.SetCurSel(0);

	m_ed_air_flag.SetCurSel(0);

	m_gz_zaosheng_flag.SetCurSel(0);

	m_gz_delag_flag.SetCurSel(0);

	m_rudder_delay_flag.SetCurSel(0);

	m_wind_type.SetCurSel(0);

	m_wind_ratio.SetCurSel(0);

	m_sim_type.SetCurSel(0);

	CString aaa,bbb,ccc;
	aaa=_T(".\\AeroFile\\DGN_FD\\dyCorrect.dat");
	bbb=_T(".\\AeroFile\\DGN_FD\\dxCorrect.dat");
	ccc=_T(".\\AeroFile\\DGN_FD\\dzCorrect.dat");
	FilePathName_qd_gz=bbb;
	FilePathName_qd_ph=aaa;
	FilePathName_qd_fy=ccc;
	m_qd_ph.SetWindowText(aaa);
	m_qd_gz.SetWindowText(bbb);
 	m_qd_fy.SetWindowText(ccc);

	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}

void CPara_set::OnSelchangeedairflag() 
{
	// TODO: Add your control notification handler code here
	m_ed_flag = m_ed_air_flag.GetCurSel();
	
}

void CPara_set::OnSelchangeepairflag() 
{
	// TODO: Add your control notification handler code here
	m_ep_flag = m_ep_air_flag.GetCurSel();
}

void CPara_set::OnSelchangegzzaoshengflag() 
{
	// TODO: Add your control notification handler code here
	m_gz_z_flag = m_gz_zaosheng_flag.GetCurSel();
}

void CPara_set::OnSelchangegzDelayflag() 
{
	// TODO: Add your control notification handler code here
	m_gz_d_flag = m_gz_delag_flag.GetCurSel();
	
}

void CPara_set::OnSelchangerudderdelayflag() 
{
	// TODO: Add your control notification handler code here
	m_rudder_flag = m_rudder_delay_flag.GetCurSel();
	
}

void CPara_set::OnSelchangeWindType() 
{
	// TODO: Add your control notification handler code here
	m_wind_type_flag = m_wind_type.GetCurSel();
	
}

void CPara_set::OnSelchangeWindRatio() 
{
	// TODO: Add your control notification handler code here
	m_wind_ratio_flag = m_wind_ratio.GetCurSel();
	
}

void CPara_set::Onqdgzbt() 
{
	// TODO: Add your control notification handler code here
	
	CFileDialog dlg(TRUE);
	if (dlg.DoModal()==IDOK)
	{
		FilePathName_qd_gz = dlg.GetPathName();
	}
	m_qd_gz.SetWindowText(FilePathName_qd_gz);

}

void CPara_set::Onqdpgbt() 
{
	// TODO: Add your control notification handler code here
	CFileDialog dlg(TRUE);
	if (dlg.DoModal()==IDOK)
	{
		FilePathName_qd_ph = dlg.GetPathName();
	}
	m_qd_ph.SetWindowText(FilePathName_qd_ph);
}

void CPara_set::Onqdfybt() 
{
	// TODO: Add your control notification handler code here
	CFileDialog dlg(TRUE);
	if (dlg.DoModal()==IDOK)
	{
		FilePathName_qd_fy = dlg.GetPathName();
	}
	m_qd_fy.SetWindowText(FilePathName_qd_fy);
}

void CPara_set::OnSelchangeSimType() 
{
	// TODO: Add your control notification handler code here
	
	if(m_sim_type.GetCurSel()==0)
	{
		b_Dynamic_navigation=false;
	}
	if(m_sim_type.GetCurSel()==1)
	{
		b_Dynamic_navigation=true;
	}
}
