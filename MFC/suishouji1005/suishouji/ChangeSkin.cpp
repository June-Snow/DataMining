// ChangeSkin.cpp : 实现文件
//

#include "stdafx.h"
#include "suishouji.h"
#include "ChangeSkin.h"
#include "afxdialogex.h"
#include <fstream>
#include <string>
#include <iostream>
using namespace std;
// CChangeSkin 对话框

IMPLEMENT_DYNAMIC(CChangeSkin, CDialogEx)

CChangeSkin::CChangeSkin(CWnd* pParent /*=NULL*/)
	: CDialogEx(CChangeSkin::IDD, pParent)
{

}

CChangeSkin::~CChangeSkin()
{
	for (int i = 0; i!=3; i++)
	{
		delete img_btn[i];
		img_btn[i] = NULL;
	}
}

void CChangeSkin::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
}


BEGIN_MESSAGE_MAP(CChangeSkin, CDialogEx)
	ON_COMMAND_RANGE(IMGBTNID, 60005, OnButtonClick)
	ON_WM_TIMER()
END_MESSAGE_MAP()


// CChangeSkin 消息处理程序


BOOL CChangeSkin::OnInitDialog()
{
	CDialogEx::OnInitDialog();

	// TODO:  在此添加额外的初始化
	//GetDlgItem(IDD_SKIN)->MoveWindow(0, 0, 722, 450);
	int img_high = 10;
	for (int i = 0 ; i != 3; i++)
	{
		img_btn[2*i] = new CBitmapButton();
		img_btn[2*i]->Create(_T(""),WS_CHILD|WS_VISIBLE|BS_PUSHBUTTON|BS_BITMAP| BS_OWNERDRAW | WS_TABSTOP, CRect(10,img_high,356,img_high+155), this, IMGBTNID + 2*i);
		img_btn[2*i]->LoadBitmaps(277+2*i);


		img_btn[2*i+1] = new CBitmapButton();
		img_btn[2*i+1]->Create(_T(""), WS_CHILD|WS_VISIBLE|BS_PUSHBUTTON|BS_BITMAP| BS_OWNERDRAW | WS_TABSTOP, CRect(366,img_high,712,img_high+155), this, IMGBTNID + 2*i+1);
		img_btn[2*i+1]->LoadBitmaps(277+2*i+1);

		img_high = img_high + 165;
	}

	return TRUE;  // return TRUE unless you set the focus to a control
}

void CChangeSkin::OnButtonClick(UINT id)
{
	int num = id % 6000;

	CString str_num;
	str_num.Format("%d", num);
	CString file_name = str_num + ".she";

	CString path_skin = exe_path + "\\skin\\"+file_name;

	CString skin_Save = exe_path+_T("\\skin\\skinsave.txt");//保存皮肤

	ofstream outfile(skin_Save);
	outfile<<file_name<<endl ;

	SetTimer(10,5,NULL);
	SkinH_AttachEx(path_skin, NULL);
    
}


void CChangeSkin::OnTimer(UINT_PTR nIDEvent)
{
	// TODO: 在此添加消息处理程序代码和/或调用默认值



	if(nIDEvent   ==   10)   
	{   

		KillTimer(nIDEvent);   
		//DestroyWindow();   //可以用这个
		keybd_event(VK_RETURN,0,0,0);   
		//keybd_event(VK_RETURN,0,KEYEVENTF_KEYUP,0);//模拟"回车"命令  

	}
	CDialogEx::OnTimer(nIDEvent);
}
