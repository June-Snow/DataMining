// HtmlMsgDlg.cpp : 实现文件
//

#include "stdafx.h"
#include "suishouji.h"
#include "HtmlMsgDlg.h"
#include "afxdialogex.h"
#include "DBSDK.h"
#include "InitializeCtrl.h"
// CHtmlMsgDlg 对话框

IMPLEMENT_DYNAMIC(CHtmlMsgDlg, CDialogEx)

CHtmlMsgDlg::CHtmlMsgDlg(CWnd* pParent /*=NULL*/)
	: CDialogEx(CHtmlMsgDlg::IDD, pParent)
{

}

CHtmlMsgDlg::~CHtmlMsgDlg()
{
}

void CHtmlMsgDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_EXPLORER1, m_msgweb);
}


BEGIN_MESSAGE_MAP(CHtmlMsgDlg, CDialogEx)
END_MESSAGE_MAP()

BOOL CHtmlMsgDlg::OnInitDialog()
{	
	CDialogEx::OnInitDialog();
	IMVL_GetNode(selectno,&file);
	IMVL_GetNode(file.iPID,&folder);
	CString key[MAX_DATA_NUM],val[MAX_DATA_NUM],filderval[MAX_DATA_NUM];
	Getkeyval(file.content,key,val);
	int num = Getkeyval(folder.content,key,filderval);
	CString  liststr;
	//CString htmlpath;
	liststr.Format("%s",file.name);
	//htmlpath =_T("\\");
	//htmlpath=liststr+_T(".htm");

	SetHtml(filderval,val,key,liststr,exe_path, num);

	//SetHtml(val1,val,key,indexnode.name,exe_path, num);

				CHAR		szPath[MAX_PATH];
				memset(szPath, 0, sizeof(CHAR)*MAX_PATH);
				GetCurrentDirectory(MAX_PATH, szPath);
				StrCat(szPath, (exe_path+_T("/html/MFCHtml.htm")));


	m_msgweb.Navigate((exe_path+_T("\\html\\MFCHtml.htm")),NULL,NULL,NULL,NULL);	


	
	//CHAR  szPath[MAX_PATH];	
	//memset(szPath, 0, sizeof(CHAR)*MAX_PATH);
	//GetCurrentDirectory(MAX_PATH, szPath);

	//StrCat(szPath, _T("./html/")+htmlpath);
	//m_msgweb.Navigate(szPath,NULL,NULL,NULL,NULL);		

	return TRUE;
}
// CHtmlMsgDlg 消息处理程序
