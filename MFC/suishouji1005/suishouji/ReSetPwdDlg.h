#pragma once
#include "afxwin.h"


// CReSetPwdDlg �Ի���

class CReSetPwdDlg : public CDialogEx
{
	DECLARE_DYNAMIC(CReSetPwdDlg)

public:
	CReSetPwdDlg(CWnd* pParent = NULL);   // ��׼���캯��
	virtual ~CReSetPwdDlg();

// �Ի�������
	enum { IDD = IDD_ReSetPwd };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV ֧��

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
