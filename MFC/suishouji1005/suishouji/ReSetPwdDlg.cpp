// ReSetPwdDlg.cpp : ʵ���ļ�
//

#include "stdafx.h"
#include "suishouji.h"
#include "ReSetPwdDlg.h"
#include "afxdialogex.h"
#include "DB_operater.h"

// CReSetPwdDlg �Ի���

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


// CReSetPwdDlg ��Ϣ�������


void CReSetPwdDlg::OnBnClickedButton1()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	CString password1;
	CString password2;
	CString password3;
	m_pwd1.GetWindowText(password1);
	m_pwd2.GetWindowText(password2);
	m_pwd3.GetWindowText(password3);
	if(strcmp(password2,_T(""))==0||strcmp(password3,_T(""))==0)
	{
		MessageBox(_T("��½�����Ϊ�գ�"),_T("��ʾ"),MB_OKCANCEL|MB_ICONEXCLAMATION );
	}
	else
	{
		int error=AlterPwd(password1,password2,password3,_T("./data.txt"));
		if(error==ERROR_OLDPWD_VALUE)
	   {	
           MessageBox(_T("�������������"),_T("��ʾ"),MB_OKCANCEL|MB_ICONEXCLAMATION );
	   }
		else if(error==ERROR_PWDNOTSAME_VALUE)
		{
			MessageBox(_T("ȷ�����������벻��ͬ��"),_T("��ʾ"),MB_OKCANCEL|MB_ICONEXCLAMATION );
		}
		else
		{
			if (MessageBox(_T("���뱣��ɹ���"),_T("��ʾ"),MB_OK|MB_ICONEXCLAMATION )==IDOK)
			{
				CDialog::OnCancel();
			}			
		}
	}
}

void CReSetPwdDlg::OnOK()
{ //����ʲôҲ��д
}

//void CReSetPwdDlg::OnCancel()
//{ //����ʲôҲ��д
//}
