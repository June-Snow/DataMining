#pragma once
#include "afxwin.h"
#include "explorer1.h"

// CDiaryDlg 对话框

class CDiaryDlg : public CDialogEx
{
	DECLARE_DYNAMIC(CDiaryDlg)

public:
	CDiaryDlg(CWnd* pParent = NULL);   // 标准构造函数
	virtual ~CDiaryDlg();

// 对话框数据
	enum { IDD = IDD_Diary };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 支持
	virtual BOOL OnInitDialog();
	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnBnClickedButton1();
	CFont TextFont;
	CTreeCtrl *m_tree;
	int isedit;
	int id;
	CEdit m_topic;
	CEdit m_article;
	CString sorttag1;   //通讯录展开规则
	CString sorttag2;    //日记展开规则
	CExplorer1 *diaryedit;
};
