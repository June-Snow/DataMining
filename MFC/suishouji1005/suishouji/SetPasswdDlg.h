#pragma once
#include "afxwin.h"


// CSetPasswdDlg �Ի���

class CSetPasswdDlg : public CDialogEx
{
	DECLARE_DYNAMIC(CSetPasswdDlg)

public:
	CSetPasswdDlg(CWnd* pParent = NULL);   // ��׼���캯��
	virtual ~CSetPasswdDlg();

// �Ի�������
	enum { IDD = IDD_SetPasswd };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV ֧��

	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnBnClickedButton1();
	CEdit m_pwd1;
	CEdit m_pwd2;
	CFont TextFont;
	afx_msg void OnOK();
	//afx_msg void OnCancel();
};
