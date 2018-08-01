#pragma once
#include "afxwin.h"


// CSetPasswdDlg 对话框

class CSetPasswdDlg : public CDialogEx
{
	DECLARE_DYNAMIC(CSetPasswdDlg)

public:
	CSetPasswdDlg(CWnd* pParent = NULL);   // 标准构造函数
	virtual ~CSetPasswdDlg();

// 对话框数据
	enum { IDD = IDD_SetPasswd };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 支持

	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnBnClickedButton1();
	CEdit m_pwd1;
	CEdit m_pwd2;
	CFont TextFont;
	afx_msg void OnOK();
	//afx_msg void OnCancel();
};
