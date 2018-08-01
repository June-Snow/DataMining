// CListCtrlToExcel.h : main header file for the CLISTCTRLTOEXCEL application
//

#if !defined(AFX_CLISTCTRLTOEXCEL_H__83895F96_F7C1_4C31_958B_F026F8E7F610__INCLUDED_)
#define AFX_CLISTCTRLTOEXCEL_H__83895F96_F7C1_4C31_958B_F026F8E7F610__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CCListCtrlToExcelApp:
// See CListCtrlToExcel.cpp for the implementation of this class
//

class CCListCtrlToExcelApp : public CWinApp
{
public:
	CCListCtrlToExcelApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CCListCtrlToExcelApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CCListCtrlToExcelApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

CString		GetExcelDriver();
BOOL		MakeSurePathExists( CString &Path,	bool FilenameIncluded=true);
void		CListCtrlToExcel(CListCtrl* pList, CString strTitle);

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_CLISTCTRLTOEXCEL_H__83895F96_F7C1_4C31_958B_F026F8E7F610__INCLUDED_)
