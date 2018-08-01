// SetPasswdDlg.cpp : ʵ���ļ�
//

#include "stdafx.h"
#include "suishouji.h"
#include "SetPasswdDlg.h"
#include "afxdialogex.h"
#include "DB_operater.h"

// CSetPasswdDlg �Ի���

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


// CSetPasswdDlg ��Ϣ�������


void CSetPasswdDlg::OnBnClickedButton1()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	CString password1;
	CString password2;
	m_pwd1.GetWindowText(password1);
	m_pwd2.GetWindowText(password2);
	if(strcmp(password1,_T(""))==0)
	{
		MessageBox(_T("��½�����Ϊ�գ�"),_T("��ʾ"),MB_OKCANCEL|MB_ICONEXCLAMATION );
	}
	else if(strcmp(password1,password2)!=0)
	{
		MessageBox(_T("ȷ�����������벻��ͬ��"),_T("��ʾ"),MB_OKCANCEL|MB_ICONEXCLAMATION );
	}
	else
	{
		int error = SetPwd(password1);
		if (MessageBox(_T("���뱣��ɹ���"),_T("��ʾ"),MB_OK|MB_ICONEXCLAMATION )==IDOK)
		{
			CDialog::OnCancel();
		}	
	}
}

void CSetPasswdDlg::OnOK()
{ //����ʲôҲ��д
}

//void CSetPasswdDlg::OnCancel()
//{ //����ʲôҲ��д
//}