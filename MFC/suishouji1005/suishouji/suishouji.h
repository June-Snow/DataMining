
// SuiShouJi.h : PROJECT_NAME Ӧ�ó������ͷ�ļ�
//

#pragma once

#ifndef __AFXWIN_H__
	#error "�ڰ������ļ�֮ǰ������stdafx.h�������� PCH �ļ�"
#endif

#include "resource.h"// ������
#include "DBSDK.h"


// CSuiShouJiApp:
// �йش����ʵ�֣������ SuiShouJi.cpp
//

class CSuiShouJiApp : public CWinApp
{
public:
	CSuiShouJiApp();

// ��д
public:
	virtual BOOL InitInstance();
	//CMFCPropertyGridCtrl m_propertyGrid1;
// ʵ��

	DECLARE_MESSAGE_MAP()
};

extern CSuiShouJiApp theApp;