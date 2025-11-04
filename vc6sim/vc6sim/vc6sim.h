// vc6sim.h : main header file for the VC6SIM application
//

#if !defined(AFX_VC6SIM_H__99C55AAA_EA7B_4C06_BC78_2C20120190D5__INCLUDED_)
#define AFX_VC6SIM_H__99C55AAA_EA7B_4C06_BC78_2C20120190D5__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CVc6simApp:
// See vc6sim.cpp for the implementation of this class
//

class CVc6simApp : public CWinApp
{
public:
	CVc6simApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CVc6simApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CVc6simApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_VC6SIM_H__99C55AAA_EA7B_4C06_BC78_2C20120190D5__INCLUDED_)
