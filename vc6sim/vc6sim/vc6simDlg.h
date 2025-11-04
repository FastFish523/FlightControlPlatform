// vc6simDlg.h : header file
//


#if !defined(AFX_VC6SIMDLG_H__CC7814C2_E5C7_4E09_8039_5872794CCC0B__INCLUDED_)
#define AFX_VC6SIMDLG_H__CC7814C2_E5C7_4E09_8039_5872794CCC0B__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "Missile.h"
#include "Para_set.h"
#include "Const.h"

/////////////////////////////////////////////////////////////////////////////
// CVc6simDlg dialog
class CVc6simDlg : public CDialog
{
// Construction
public:
	void Init_nav();
	char Directory[100];
	void Init_sim();
	CMissile missile;
	CPara_set PARA_SET;
	CVc6simDlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	//{{AFX_DATA(CVc6simDlg)
	enum { IDD = IDD_VC6SIM_DIALOG };
	CButton	m_start;
	CEdit	m_stop_V;
	CEdit	m_stop_T;
	CEdit	m_stop_P;
	CEdit	m_err_Z;
	CEdit	m_err_N;
	CEdit	m_err_E;
	double	m_err_e;
	double	m_err_n;
	double	m_err_zh;
	double	m_stop_pitch;
	double	m_stop_t;
	double	m_stop_v;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CVc6simDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CVc6simDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnSelchangingTab1(NMHDR* pNMHDR, LRESULT* pResult);
	afx_msg void OnparaSet();
	afx_msg void Onstartsim();
	afx_msg void Ondataanalize();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_VC6SIMDLG_H__CC7814C2_E5C7_4E09_8039_5872794CCC0B__INCLUDED_)
