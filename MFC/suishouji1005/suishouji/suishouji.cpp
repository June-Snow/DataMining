																																																															
// SuiShouJi.cpp : 定义应用程序的类行为。
//

#include "stdafx.h"
#include "SuiShouJi.h"
#include "SuiShouJiDlg.h"
#include "DBSDK.h"
#include "LoginDlg.h"
#include "DB_operater.h"
#include <fstream>
#include <string>
#include <iostream>
using namespace std;

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

using namespace std;

// CSuiShouJiApp

BEGIN_MESSAGE_MAP(CSuiShouJiApp, CWinApp)
	ON_COMMAND(ID_HELP, &CWinApp::OnHelp)
END_MESSAGE_MAP()


// CSuiShouJiApp 构造

CSuiShouJiApp::CSuiShouJiApp()
{
	// 支持重新启动管理器
	m_dwRestartManagerSupportFlags = AFX_RESTART_MANAGER_SUPPORT_RESTART;

	// TODO: 在此处添加构造代码，
	// 将所有重要的初始化放置在 InitInstance 中
}


// 唯一的一个 CSuiShouJiApp 对象

CSuiShouJiApp theApp;


// CSuiShouJiApp 初始化
		
BOOL CSuiShouJiApp::InitInstance()
{
	GetWorkDir(&exe_path);
	CString htmlSave = exe_path+_T("\\skin\\skinsave.txt");//皮肤
	ifstream infilebe(htmlSave);
	string temp=_T("");
	CString skin_file;
	getline(infilebe,temp);
	
	if (temp.length() != 0)
	{
		CString skin_txt;
		skin_txt = temp.c_str();
		skin_file = exe_path + "\\skin\\" + skin_txt;		
	}
	else
	{
		skin_file = exe_path + "\\skin\\蓝.she";
	}

	SkinH_AttachEx(skin_file, NULL); 

	INITCOMMONCONTROLSEX InitCtrls;
	InitCtrls.dwSize = sizeof(InitCtrls);
	// 将它设置为包括所有要在应用程序中使用的
	// 公共控件类。
	InitCtrls.dwICC = ICC_WIN95_CLASSES;
	InitCommonControlsEx(&InitCtrls);
	CWinApp::InitInstance();

	AfxEnableControlContainer();

	CShellManager *pShellManager = new CShellManager;


	SetRegistryKey(_T("随手记"));

	//CLoginDlg logindlg;
	//int nResponse =logindlg.DoModal();
	//if (nResponse == IDOK)  
	//{
		CSuiShouJiDlg dlg;
		m_pMainWnd = &dlg;
		INT_PTR nResponse = dlg.DoModal();

		if (pShellManager != NULL)
		{
			delete pShellManager;
		}
	//}
	

	/* 由于对话框已关闭，所以将返回 FALSE 以便退出应用程序，
	  而不是启动应用程序的消息泵。*/
	return FALSE;
}


