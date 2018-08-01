
// jizhuomiexampleDlg.h : 头文件
//

#pragma once
#include "TipDlg.h"

// CjizhuomiexampleDlg 对话框
class CjizhuomiexampleDlg : public CDialogEx
{
	private:
	CTipDlg  *m_pTipDlg;
// 构造
public:
	CjizhuomiexampleDlg(CWnd* pParent = NULL);	// 标准构造函数
	~CjizhuomiexampleDlg();
// 对话框数据
	enum { IDD = IDD_JIZHUOMIEXAMPLE_DIALOG };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV 支持


// 实现
protected:
	HICON m_hIcon;

	// 生成的消息映射函数
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnEnChangeSummandEdit();
	double m_editSummand;
	double m_editAddend;
	double m_editSum;
	afx_msg void OnClickedAddButton();
};
