#pragma once
#include "afxwin.h"


// CCloseDlg 对话框

class CCloseDlg : public CDialogEx
{
	DECLARE_DYNAMIC(CCloseDlg)

public:
	CCloseDlg(CWnd* pParent = NULL);   // 标准构造函数
	virtual ~CCloseDlg();

// 对话框数据
	enum { IDD = IDD_DIALOG3 };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 支持
	virtual BOOL OnInitDialog();
	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnBnClickedButton1();
	CButton m_check1;
	CButton m_check2;
	afx_msg void OnBnClickedButton2();
	afx_msg void OnOK();
	int *m_check;
};
