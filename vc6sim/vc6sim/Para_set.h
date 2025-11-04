#if !defined(AFX_PARA_SET_H__74889B2E_388E_49DB_B2CF_7DEEDA038675__INCLUDED_)
#define AFX_PARA_SET_H__74889B2E_388E_49DB_B2CF_7DEEDA038675__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// Para_set.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CPara_set dialog

class CPara_set : public CDialog
{
// Construction
public:
	CString FilePathName_qd_gz;
	CString FilePathName_qd_ph;
	CString FilePathName_qd_fy;
	bool b_Dynamic_navigation;
	CPara_set(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CPara_set)
	enum { IDD = IDD_PARA };
	CComboBox	m_sim_type;
	CEdit	m_qd_fy;
	CEdit	m_qd_ph;
	CEdit	m_qd_gz;
	CComboBox	m_wind_ratio;
	CComboBox	m_wind_type;
	CComboBox	m_rudder_delay_flag;
	CComboBox	m_gz_zaosheng_flag;
	CComboBox	m_gz_delag_flag;
	CComboBox	m_ep_air_flag;
	CComboBox	m_ed_air_flag;
	double	m_mass0;
	double	m_mass1;
	double	m_mass2;
	double	m_P0;
	double	m_P1;
	double	m_P2;
	double	m_Serf;
	double	m_L;
	double	m_jx0;
	double	m_jx1;
	double	m_jx2;
	double	m_jy0;
	double	m_jy1;
	double	m_jy2;
	double	m_jz0;
	double	m_jz1;
	double	m_jz2;
	double	m_G_Cabin0;
	double	m_G_Cabin1;
	double	m_G_Cabin2;
	double	m_mdox;
	double	m_mdoy;
	double	m_mdoz;
	int		m_ed_flag;
	int		m_ep_flag;
	int		m_gz_z_flag;
	int		m_gz_d_flag;
	int		m_rudder_flag;
	double	m_distance;
	double	m_height;
	double	m_height_t;
	double	m_lat;
	double	m_lon;
	double	m_pitch;
	double	m_roll;
	double	m_ved;
	double	m_ved_t;
	double	m_v;
	double	m_v_t;
	double	m_vud;
	double	m_vud_t;
	double	m_wx;
	double	m_wy;
	double	m_wz;
	double	m_yaw;
	double	m_yaw_t;
	int		m_wind_type_flag;
	int		m_wind_ratio_flag;
	double	m_Tpstart1;
	double	m_Tpstart2;
	double	m_Tpstart3;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CPara_set)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CPara_set)
	virtual void OnOK();
	virtual BOOL OnInitDialog();
	afx_msg void OnSelchangeedairflag();
	afx_msg void OnSelchangeepairflag();
	afx_msg void OnSelchangegzzaoshengflag();
	afx_msg void OnSelchangegzDelayflag();
	afx_msg void OnSelchangerudderdelayflag();
	afx_msg void OnSelchangeWindType();
	afx_msg void OnSelchangeWindRatio();
	afx_msg void Onqdgzbt();
	afx_msg void Onqdpgbt();
	afx_msg void Onqdfybt();
	afx_msg void OnSelchangeSimType();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_PARA_SET_H__74889B2E_388E_49DB_B2CF_7DEEDA038675__INCLUDED_)
