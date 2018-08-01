// CloseDlg.cpp : ʵ���ļ�
//

#include "stdafx.h"
#include "suishouji.h"
#include "CloseDlg.h"
#include "afxdialogex.h"


// CCloseDlg �Ի���

IMPLEMENT_DYNAMIC(CCloseDlg, CDialogEx)

CCloseDlg::CCloseDlg(CWnd* pParent /*=NULL*/)
	: CDialogEx(CCloseDlg::IDD, pParent)
{

}

CCloseDlg::~CCloseDlg()
{
}

void CCloseDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_RADIO1, m_check1);
	DDX_Control(pDX, IDC_RADIO2, m_check2);
}


BEGIN_MESSAGE_MAP(CCloseDlg, CDialogEx)
	ON_BN_CLICKED(IDC_BUTTON1, &CCloseDlg::OnBnClickedButton1)
	ON_BN_CLICKED(IDC_BUTTON2, &CCloseDlg::OnBnClickedButton2)
END_MESSAGE_MAP()

BOOL CCloseDlg::OnInitDialog()
{
	CDialogEx::OnInitDialog();
	m_check1.SetCheck(TRUE);
	return TRUE;
}
// CCloseDlg ��Ϣ�������


void CCloseDlg::OnBnClickedButton1()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	int check;
	if (m_check1.GetCheck()==1)
	{
		check = 1;		
	}
	else
	{
		check = 2;		
	}
	*m_check = check;
	CDialog::OnOK();
}


void CCloseDlg::OnBnClickedButton2()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	CDialog::OnCancel();
}

void CCloseDlg::OnOK()
{

}