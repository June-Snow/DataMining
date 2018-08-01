#pragma once
#include "afxext.h"


// CChangeSkin 对话框

class CChangeSkin : public CDialogEx
{
	DECLARE_DYNAMIC(CChangeSkin)

public:
	CChangeSkin(CWnd* pParent = NULL);   // 标准构造函数
	virtual ~CChangeSkin();

// 对话框数据
	enum { IDD = IDD_SKIN };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 支持

	DECLARE_MESSAGE_MAP()
public:
	virtual BOOL OnInitDialog();

	CBitmapButton *img_btn[6];

	int m_ixoldpos;//记录鼠标拖动滑动条的位置
	int m_iyoldpos;
	afx_msg void OnButtonClick(UINT uID);
	afx_msg void OnTimer(UINT_PTR nIDEvent);
};
