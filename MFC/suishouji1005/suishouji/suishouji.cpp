																																																															
// SuiShouJi.cpp : ����Ӧ�ó��������Ϊ��
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


// CSuiShouJiApp ����

CSuiShouJiApp::CSuiShouJiApp()
{
	// ֧����������������
	m_dwRestartManagerSupportFlags = AFX_RESTART_MANAGER_SUPPORT_RESTART;

	// TODO: �ڴ˴���ӹ�����룬
	// ��������Ҫ�ĳ�ʼ�������� InitInstance ��
}


// Ψһ��һ�� CSuiShouJiApp ����

CSuiShouJiApp theApp;


// CSuiShouJiApp ��ʼ��
		
BOOL CSuiShouJiApp::InitInstance()
{
	GetWorkDir(&exe_path);
	CString htmlSave = exe_path+_T("\\skin\\skinsave.txt");//Ƥ��
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
		skin_file = exe_path + "\\skin\\��.she";
	}

	SkinH_AttachEx(skin_file, NULL); 

	INITCOMMONCONTROLSEX InitCtrls;
	InitCtrls.dwSize = sizeof(InitCtrls);
	// ��������Ϊ��������Ҫ��Ӧ�ó�����ʹ�õ�
	// �����ؼ��ࡣ
	InitCtrls.dwICC = ICC_WIN95_CLASSES;
	InitCommonControlsEx(&InitCtrls);
	CWinApp::InitInstance();

	AfxEnableControlContainer();

	CShellManager *pShellManager = new CShellManager;


	SetRegistryKey(_T("���ּ�"));

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
	

	/* ���ڶԻ����ѹرգ����Խ����� FALSE �Ա��˳�Ӧ�ó���
	  ����������Ӧ�ó������Ϣ�á�*/
	return FALSE;
}


