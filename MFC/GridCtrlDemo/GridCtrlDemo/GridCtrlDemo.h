
// GridCtrlDemo.h : PROJECT_NAME Ӧ�ó������ͷ�ļ�
//

#pragma once

#ifndef __AFXWIN_H__
	#error "�ڰ������ļ�֮ǰ������stdafx.h�������� PCH �ļ�"
#endif

#include "resource.h"		// ������


// CGridCtrlDemoApp:
// �йش����ʵ�֣������ GridCtrlDemo.cpp
//

class CGridCtrlDemoApp : public CWinApp
{
public:
	CGridCtrlDemoApp();

// ��д
public:
	virtual BOOL InitInstance();

// ʵ��

	DECLARE_MESSAGE_MAP()
};

extern CGridCtrlDemoApp theApp;