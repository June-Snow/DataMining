#pragma once
#include "afxwin.h"


// CCloseDlg �Ի���

class CCloseDlg : public CDialogEx
{
	DECLARE_DYNAMIC(CCloseDlg)

public:
	CCloseDlg(CWnd* pParent = NULL);   // ��׼���캯��
	virtual ~CCloseDlg();

// �Ի�������
	enum { IDD = IDD_DIALOG3 };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV ֧��
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
