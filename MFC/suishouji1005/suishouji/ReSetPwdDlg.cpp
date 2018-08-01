// ReSetPwdDlg.cpp : 实现文件
//

#include "stdafx.h"
#include "suishouji.h"
#include "ReSetPwdDlg.h"
#include "afxdialogex.h"
#include "DB_operater.h"

// CReSetPwdDlg 对话框

IMPLEMENT_DYNAMIC(CReSetPwdDlg, CDialogEx)

CReSetPwdDlg::CReSetPwdDlg(CWnd* pParent /*=NULL*/)
	: CDialogEx(CReSetPwdDlg::IDD, pParent)
{

}

CReSetPwdDlg::~CReSetPwdDlg()
{
}

void CReSetPwdDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_EDIT1, m_pwd1);
	DDX_Control(pDX, IDC_EDIT2, m_pwd2);
	DDX_Control(pDX, IDC_EDIT5, m_pwd3);
}


BEGIN_MESSAGE_MAP(CReSetPwdDlg, CDialogEx)
	ON_BN_CLICKED(IDC_BUTTON1, &CReSetPwdDlg::OnBnClickedButton1)
END_MESSAGE_MAP()


// CReSetPwdDlg 消息处理程序


void CReSetPwdDlg::OnBnClickedButton1()
{
	// TODO: 在此添加控件通知处理程序代码
	CString password1;
	CString password2;
	CString password3;
	m_pwd1.GetWindowText(password1);
	m_pwd2.GetWindowText(password2);
	m_pwd3.GetWindowText(password3);
	if(strcmp(password2,_T(""))==0||strcmp(password3,_T(""))==0)
	{
		MessageBox(_T("登陆口令不可为空！"),_T("提示"),MB_OKCANCEL|MB_ICONEXCLAMATION );
	}
	else
	{
		int error=AlterPwd(password1,password2,password3,_T("./data.txt"));
		if(error==ERROR_OLDPWD_VALUE)
	   {	
           MessageBox(_T("旧密码输入错误！"),_T("提示"),MB_OKCANCEL|MB_ICONEXCLAMATION );
	   }
		else if(error==ERROR_PWDNOTSAME_VALUE)
		{
			MessageBox(_T("确认密码与密码不相同！"),_T("提示"),MB_OKCANCEL|MB_ICONEXCLAMATION );
		}
		else
		{
			if (MessageBox(_T("密码保存成功！"),_T("提示"),MB_OK|MB_ICONEXCLAMATION )==IDOK)
			{
				CDialog::OnCancel();
			}			
		}
	}
}

void CReSetPwdDlg::OnOK()
{ //里面什么也不写
}

//void CReSetPwdDlg::OnCancel()
//{ //里面什么也不写
//}
