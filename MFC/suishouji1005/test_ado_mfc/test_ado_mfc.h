
// test_ado_mfc.h : PROJECT_NAME Ӧ�ó������ͷ�ļ�
//

#pragma once

#ifndef __AFXWIN_H__
	#error "�ڰ������ļ�֮ǰ������stdafx.h�������� PCH �ļ�"
#endif

#include "resource.h"		// ������
#include <ctime>

// Ctest_ado_mfcApp:
// �йش����ʵ�֣������ test_ado_mfc.cpp
//

class Ctest_ado_mfcApp : public CWinApp
{
public:
	Ctest_ado_mfcApp();

// ��д
public:
	virtual BOOL InitInstance();

// ʵ��

	DECLARE_MESSAGE_MAP()
};

extern Ctest_ado_mfcApp theApp;