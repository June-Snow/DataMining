// ImagesToDBDlg.h : header file
//

#pragma once
#include "GridCtrl/GridCtrl.h"
#include "afxwin.h"


// CImagesToDBDlg dialog
class CImagesToDBDlg : public CDialog
{
	// Construction
public:
	CImagesToDBDlg(CWnd* pParent = NULL);   // standard constructor

	// Dialog Data
	enum { IDD = IDD_IMAGESTODB_DIALOG };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support

public:
	CGridCtrl m_grid;
	int numCol;

	CStatic m_dataGroup;
	CStatic m_dataIp;
	CStatic m_userName;
	CStatic m_dataName;
	CStatic m_logSecret;
	CButton m_dataTest;
	CEdit m_ip;
	CEdit m_user;
	CComboBox m_data;
	CEdit m_log;

	CStatic m_picGroup;
	CStatic m_tableName;
	CComboBox m_combox;
	CStatic rangeExport;
	CStatic m_separator;
	CEdit rangeMin;
	CEdit rangeMax;
	CButton batchExport;
	CButton picEport;

	CStatic m_pageGroup;
	CStatic m_page;
	CButton m_bomePage;
	CButton m_upPage;
	CButton m_downPage;
	CButton m_endPage;

	CFont m_text;
	CFont m_btn;


	std::vector<std::vector<CString> > dataArray;
	double sumRow;
	double pageRow;
	// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	DECLARE_MESSAGE_MAP()
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	afx_msg void OnSize(UINT nType, int cx, int cy);
	
public:
	afx_msg void OnDataTestBtn();
	afx_msg void OnComboxBtn();
	afx_msg void OnBatchExportBtn();
	afx_msg void OnPicExportBtn();

	afx_msg void OnHomePageBtn();
	afx_msg void OnUpPageBtn();
	afx_msg void OnDownPageBtn();
	afx_msg void OnEndPageBtn();
	afx_msg void OnComBoxDataBtn();
	void GetExtractDigitalCharacters(int &num);
	void OnGridCtrlWrite(int pageNum);
};
