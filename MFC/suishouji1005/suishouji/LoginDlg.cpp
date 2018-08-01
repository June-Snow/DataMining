// LoginDlg.cpp : ʵ���ļ�
//

#include "stdafx.h"
#include "suishouji.h"
#include "LoginDlg.h"
#include "afxdialogex.h"
#include "DB_operater.h"
#include "SetPasswdDlg.h"
#include "ReSetPwdDlg.h"

// CLoginDlg �Ի���

IMPLEMENT_DYNAMIC(CLoginDlg, CDialogEx)

CLoginDlg::CLoginDlg(CWnd* pParent /*=NULL*/)
	: CDialogEx(CLoginDlg::IDD, pParent)
{

}

CLoginDlg::~CLoginDlg()
{
}

void CLoginDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_EDIT1, m_password);
}


BEGIN_MESSAGE_MAP(CLoginDlg, CDialogEx)
	ON_BN_CLICKED(IDC_BUTTON1, &CLoginDlg::OnBnClickedButton1)
	ON_BN_CLICKED(IDC_BUTTON2, &CLoginDlg::OnBnClickedButton2)
END_MESSAGE_MAP()


// CLoginDlg ��Ϣ�������


void CLoginDlg::OnBnClickedButton1()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	CString password;
	CString passwordA;
	m_password.GetWindowText(password);
	CString pwdFileName = _T("./data.txt");
	if (GetPwd(&passwordA,pwdFileName)==ERROR_FAILED_VALUE)
	{
		if (strcmp(password,passwordA)==0)
		{
			 CDialog::OnOK();
		}
		else
		{
			MessageBox(_T("��½�������"),_T("��ʾ"),MB_OKCANCEL|MB_ICONEXCLAMATION );
		}
	} 
	else
	{
		if(MessageBox(_T("��½����δ���ã��Ƿ����õ�½���"),_T("��ʾ"),MB_OKCANCEL|MB_ICONASTERISK) == IDOK)
		{
			CSetPasswdDlg dlg;
			dlg.DoModal();			
		}
	}
}


void CLoginDlg::OnBnClickedButton2()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	CReSetPwdDlg dlg;
	dlg.DoModal();
}

void CLoginDlg::OnOK()
{ //����ʲôҲ��д
   CDialogEx::OnOK();
}

//void CLoginDlg::OnCancel()
//{ //����ʲôҲ��д
//
//}