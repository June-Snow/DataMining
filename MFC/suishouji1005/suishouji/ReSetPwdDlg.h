#pragma once
#include "afxwin.h"


// CReSetPwdDlg 对话框

class CReSetPwdDlg : public CDialogEx
{
	DECLARE_DYNAMIC(CReSetPwdDlg)

public:
	CReSetPwdDlg(CWnd* pParent = NULL);   // 标准构造函数
	virtual ~CReSetPwdDlg();

// 对话框数据
	enum { IDD = IDD_ReSetPwd };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 支持

	DECLARE_MESSAGE_MAP()
public:
	CEdit m_pwd1;
	CEdit m_pwd2;
	CEdit m_pwd3;
	CFont TextFont;
	afx_msg void OnBnClickedButton1();
	afx_msg void OnOK();
	//afx_msg void OnCancel();
};
