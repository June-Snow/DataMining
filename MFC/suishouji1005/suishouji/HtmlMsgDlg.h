#pragma once
#include "explorer1.h"


// CHtmlMsgDlg 对话框

class CHtmlMsgDlg : public CDialogEx
{
	DECLARE_DYNAMIC(CHtmlMsgDlg)

public:
	CHtmlMsgDlg(CWnd* pParent = NULL);   // 标准构造函数
	virtual ~CHtmlMsgDlg();

// 对话框数据
	enum { IDD = IDD_SHOWHTML };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 支持
	virtual BOOL OnInitDialog();
	DECLARE_MESSAGE_MAP()
public:
	CExplorer1 m_msgweb;
	INDEX_NODE file;
	INDEX_NODE folder;
	int selectno;
};
