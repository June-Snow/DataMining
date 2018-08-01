// CListCtrlToExcelDlg.h : header file
//

#if !defined(AFX_CLISTCTRLTOEXCELDLG_H__BB265779_6EB1_4353_9284_FAC46D5333F0__INCLUDED_)
#define AFX_CLISTCTRLTOEXCELDLG_H__BB265779_6EB1_4353_9284_FAC46D5333F0__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

/////////////////////////////////////////////////////////////////////////////
// CCListCtrlToExcelDlg dialog

class CCListCtrlToExcelDlg : public CDialog
{
private:
	void InitListCtrl();    //self add
	
// Construction
public:
	CCListCtrlToExcelDlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	//{{AFX_DATA(CCListCtrlToExcelDlg)
	enum { IDD = IDD_CLISTCTRLTOEXCEL_DIALOG };
	CListCtrl m_clistctrl;    //self add
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CCListCtrlToExcelDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CCListCtrlToExcelDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnExport();   //self add
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_CLISTCTRLTOEXCELDLG_H__BB265779_6EB1_4353_9284_FAC46D5333F0__INCLUDED_)
