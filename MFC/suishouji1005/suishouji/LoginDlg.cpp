// LoginDlg.cpp : 实现文件
//

#include "stdafx.h"
#include "suishouji.h"
#include "LoginDlg.h"
#include "afxdialogex.h"
#include "DB_operater.h"
#include "SetPasswdDlg.h"
#include "ReSetPwdDlg.h"

// CLoginDlg 对话框

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


// CLoginDlg 消息处理程序


void CLoginDlg::OnBnClickedButton1()
{
	// TODO: 在此添加控件通知处理程序代码
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
			MessageBox(_T("登陆口令错误！"),_T("提示"),MB_OKCANCEL|MB_ICONEXCLAMATION );
		}
	} 
	else
	{
		if(MessageBox(_T("登陆口令未设置！是否设置登陆口令？"),_T("提示"),MB_OKCANCEL|MB_ICONASTERISK) == IDOK)
		{
			CSetPasswdDlg dlg;
			dlg.DoModal();			
		}
	}
}


void CLoginDlg::OnBnClickedButton2()
{
	// TODO: 在此添加控件通知处理程序代码
	CReSetPwdDlg dlg;
	dlg.DoModal();
}

void CLoginDlg::OnOK()
{ //里面什么也不写
   CDialogEx::OnOK();
}

//void CLoginDlg::OnCancel()
//{ //里面什么也不写
//
//}