#pragma once
#include "afxwin.h"
#include "suishoujiDlg.h"
#include "resource.h"
// CAdvancedSearchDlg 对话框

class CAdvancedSearchDlg : public CDialogEx
{
	DECLARE_DYNAMIC(CAdvancedSearchDlg)

public:
	CAdvancedSearchDlg(CWnd* pParent = NULL);   // 标准构造函数
	virtual ~CAdvancedSearchDlg();
	virtual BOOL OnInitDialog();
	// 对话框数据
	enum { IDD = IDD_DIALOG2 };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 支持

	afx_msg void OnCbnBtn1();
	afx_msg void OnCbnBtn2();
//	afx_msg void OnCbnBtn3();
	DECLARE_MESSAGE_MAP()
public:

	afx_msg void OnBnClickedButton2();
	afx_msg void OnBnClickedButton1();
	afx_msg void OnOK();
	afx_msg void OnCancel();

	CFont textFont;

	afx_msg void OnBnClickedButton3();

	CListCtrl *m_list;
	CComboBox m_combobox[3];

	CComboBox m_combo_cho[10];
	CComboBox m_combo_pro[10];
	CComboBox m_combo_cmp[10];
	CEdit  m_edit[10];

	CStatic m_static[3];
	CDateTimeCtrl m_date[2];
	CButton m_btn[3];

	int selectid;
	bool * isdialog;
	int *pos;
	afx_msg void OnSize(UINT nType, int cx, int cy);
	int icmbch;
	int edgeWidth;
	int ctrlHeight;
};
