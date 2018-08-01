#include "afxcmn.h"
#if !defined(AFX_CLISTCTRLTOEXCELDLG_H__BB265779_6EB1_4353_9284_FAC46D5333F0__INCLUDED_)
#define AFX_CLISTCTRLTOEXCELDLG_H__BB265779_6EB1_4353_9284_FAC46D5333F0__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "afxwin.h"
#include "ado2.h"
#include "Export.h"

// COpenMsgDlg 对话框

class COpenMsgDlg : public CDialogEx
{
	DECLARE_DYNAMIC(COpenMsgDlg)
private:
	void InitListCtrl();    //self add
public:
	COpenMsgDlg(CWnd* pParent = NULL);   // 标准构造函数
	virtual ~COpenMsgDlg();

	// 对话框数据
	enum { IDD = IDD_DIALOG1 };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 支持
	virtual BOOL OnInitDialog();
	DECLARE_MESSAGE_MAP()
public:
	
	afx_msg void OnInsertMsg();
	afx_msg void OnOK();
	afx_msg void OnBnDelete();
	afx_msg void OnNMClickList1(NMHDR *pNMHDR, LRESULT *pResult);
	afx_msg void OnLvnItemchangedList1(NMHDR *pNMHDR, LRESULT *pResult);
	afx_msg void OnBnBack();afx_msg void OnBnClickedButton6();
	afx_msg void OnBnClickedButton1();
	afx_msg void OnBnClickedButton5();
	afx_msg BOOL PreTranslateMessage(MSG*   pMsg);
	CEdit m_edit;	
	int selItem;
	INDEX_NODE  m_folder;	
	int * isFresh;	
	CListCtrl m_programLangList;
	CString sql_text;
	CString strLangName; 
	CButton m_AddButton;
	CButton m_DeleteButton;
	CButton m_LeftButton;
	CButton m_RightButton;
	CFont DefaultFont,TitleFont,NameFont,TextFont;
	CStatic m_static;
	afx_msg void OnStnClickedStatic1();
	CStatic m_title;
	INDEX_NODE index1;
	afx_msg void OnStnClickedStatic100();
	virtual void OnCancel();
};

#endif