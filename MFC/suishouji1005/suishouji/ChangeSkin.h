#pragma once
#include "afxext.h"


// CChangeSkin �Ի���

class CChangeSkin : public CDialogEx
{
	DECLARE_DYNAMIC(CChangeSkin)

public:
	CChangeSkin(CWnd* pParent = NULL);   // ��׼���캯��
	virtual ~CChangeSkin();

// �Ի�������
	enum { IDD = IDD_SKIN };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV ֧��

	DECLARE_MESSAGE_MAP()
public:
	virtual BOOL OnInitDialog();

	CBitmapButton *img_btn[6];

	int m_ixoldpos;//��¼����϶���������λ��
	int m_iyoldpos;
	afx_msg void OnButtonClick(UINT uID);
	afx_msg void OnTimer(UINT_PTR nIDEvent);
};
