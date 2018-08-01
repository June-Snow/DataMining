#ifndef IDC_EDIT_CREATEID
#define IDC_EDIT_CREATEID				(3000)
#endif

#ifndef IDC_COMBOX_CREATEID
#define IDC_COMBOX_CREATEID				(1500)
#endif

#pragma once
#include "afxcmn.h"
#include "afxwin.h"

#include "ado2.h"


class CTestComDlg : public CDialogEx
{
	DECLARE_DYNAMIC(CTestComDlg)

public:
	CTestComDlg(CWnd* pParent = NULL);   // 标准构造函数
	virtual ~CTestComDlg();

// 对话框数据
	enum { IDD = IDD_ADD };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 支持
	virtual BOOL OnInitDialog();
	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnBnClickedButton1();
	afx_msg void OnNMRClickList1(NMHDR *pNMHDR, LRESULT *pResult);
	afx_msg void OnLvnEndlabeleditList1(NMHDR *pNMHDR, LRESULT *pResult);
	afx_msg void OnAddRow();
	afx_msg void OnDeleteRow();
	afx_msg void OnNMClickList1(NMHDR *pNMHDR, LRESULT *pResult);	
    afx_msg void OnNMDblclkList1(NMHDR *pNMHDR, LRESULT *pResult);	
	
	void createEdit(NM_LISTVIEW  *pEditCtrl, CEdit *createdit, int &Item, int &SubItem, bool &havecreat);//创建单元格编辑框函数
	void destroyEdit(CListCtrl *list, CEdit* destroyedit, int &Item, int &SubItem);//销毁单元格编辑框对象
    afx_msg void OnCustomdrawList1(NMHDR *pNMHDR, LRESULT *pResult);	
	void createCcombobox(NM_LISTVIEW  *pEditCtrl, CComboBox *createccomboboxobj, int &Item, int &SubItem, bool &havecreat);//创建单元格下拉列表框函数
	void destroyCcombobox(CListCtrl *list, CComboBox* destroyccomboboxobj, int &Item, int &SubItem);	
	afx_msg void OnOK();	
	CFont DefaultFont,TitleFont,NameFont,TextFont;
	int m_pid;
	int * isFresh;
	int isNull;
	int m_selectnum;
	int keynum;
	CListCtrl m_list;
	CString key[MAX_DATA_NUM],val[MAX_DATA_NUM];
	int e_Item;    //刚编辑的行  
	int e_SubItem; //刚编辑的列  
	CEdit m_Edit;  //生成单元编辑框对象
	CComboBox m_comBox;//生产单元格下拉列表对象
	bool haveccomboboxcreate;//标志下拉列表框已经被创建
	bool haveeditcreate;//标志编辑框已经被创建
	afx_msg BOOL PreTranslateMessage(MSG*   pMsg);
	CString sql_text,strLangName;
	INDEX_NODE m_foldernode;
	INDEX_NODE p_foldernode;	
	CStatic m_static1;
	int itemcount;
	
};
