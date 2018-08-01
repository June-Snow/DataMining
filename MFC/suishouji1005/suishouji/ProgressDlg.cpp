// ProgressDlg.cpp : 实现文件
//

#include "stdafx.h"
#include "suishouji.h"
#include "ProgressDlg.h"
#include "afxdialogex.h"


// ProgressDlg 对话框

IMPLEMENT_DYNAMIC(ProgressDlg, CDialogEx)

ProgressDlg::ProgressDlg(CWnd* pParent /*=NULL*/)
	: CDialogEx(ProgressDlg::IDD, pParent)
{

}

ProgressDlg::~ProgressDlg()
{
}

void ProgressDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_PROGRESS1, m_ctrlProgress);
	DDX_Control(pDX, IDC_EDIT1, m_editText);
}


BEGIN_MESSAGE_MAP(ProgressDlg, CDialogEx)
	ON_NOTIFY(NM_CUSTOMDRAW, IDC_PROGRESS1, &ProgressDlg::OnNMCustomdrawProgress1)
END_MESSAGE_MAP()


// ProgressDlg 消息处理程序


void ProgressDlg::OnNMCustomdrawProgress1(NMHDR *pNMHDR, LRESULT *pResult)
{
	LPNMCUSTOMDRAW pNMCD = reinterpret_cast<LPNMCUSTOMDRAW>(pNMHDR);
	// TODO: 在此添加控件通知处理程序代码
	*pResult = 0;
}


BOOL ProgressDlg::OnInitDialog()
{
	CDialogEx::OnInitDialog();
	::SetWindowPos(this->m_hWnd,HWND_BOTTOM,0,0,200,400,SWP_NOZORDER);
	// TODO:  在此添加额外的初
	SetDlgItemText(IDC_EDIT1, _T("0%"));
	m_ctrlProgress.SetRange(0,100);
	m_ctrlProgress.SetStep(10);
	m_ctrlProgress.SetStep(0);



	int nPos;
	CString str;

	UpdateData(FALSE);

	int nLower = 0;
	int nUpper = wordFilesNum;
	m_ctrlProgress.GetRange(nLower, nUpper);

	if (m_ctrlProgress.GetPos() == nLower)
	{
		m_ctrlProgress.SetPos(nLower);
	}

	for (int i = 0; i < wordFilesNum; i++)
	{
		Sleep(400);
		m_ctrlProgress.StepIt();

		nPos = (m_ctrlProgress.GetPos()-nLower)*100/(nUpper-nLower);
		m_ctrlProgress.OffsetPos(10);

		str.Format("%d", nPos);
		//m_strText.SetWindowTextW( str + "%");
		m_editText.SetWindowText(str + "%");
		UpdateData(FALSE);
	}
	UpdateData(FALSE);

	return TRUE;  // return TRUE unless you set the focus to a control
	// 异常: OCX 属性页应返回 FALSE
}
