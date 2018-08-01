// SetPasswdDlg.cpp : 实现文件
//

#include "stdafx.h"
#include "suishouji.h"
#include "SetPasswdDlg.h"
#include "afxdialogex.h"
#include "DB_operater.h"

// CSetPasswdDlg 对话框

IMPLEMENT_DYNAMIC(CSetPasswdDlg, CDialogEx)

CSetPasswdDlg::CSetPasswdDlg(CWnd* pParent /*=NULL*/)
	: CDialogEx(CSetPasswdDlg::IDD, pParent)
{

}

CSetPasswdDlg::~CSetPasswdDlg()
{
}

void CSetPasswdDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_EDIT1, m_pwd1);
	DDX_Control(pDX, IDC_EDIT2, m_pwd2);
}


BEGIN_MESSAGE_MAP(CSetPasswdDlg, CDialogEx)
	ON_BN_CLICKED(IDC_BUTTON1, &CSetPasswdDlg::OnBnClickedButton1)
END_MESSAGE_MAP()


// CSetPasswdDlg 消息处理程序


void CSetPasswdDlg::OnBnClickedButton1()
{
	// TODO: 在此添加控件通知处理程序代码
	CString password1;
	CString password2;
	m_pwd1.GetWindowText(password1);
	m_pwd2.GetWindowText(password2);
	if(strcmp(password1,_T(""))==0)
	{
		MessageBox(_T("登陆口令不可为空！"),_T("提示"),MB_OKCANCEL|MB_ICONEXCLAMATION );
	}
	else if(strcmp(password1,password2)!=0)
	{
		MessageBox(_T("确认密码与密码不相同！"),_T("提示"),MB_OKCANCEL|MB_ICONEXCLAMATION );
	}
	else
	{
		int error = SetPwd(password1);
		if (MessageBox(_T("密码保存成功！"),_T("提示"),MB_OK|MB_ICONEXCLAMATION )==IDOK)
		{
			CDialog::OnCancel();
		}	
	}
}

void CSetPasswdDlg::OnOK()
{ //里面什么也不写
}

//void CSetPasswdDlg::OnCancel()
//{ //里面什么也不写
//}