
#ifndef IDC_EDIT_CREATEID
#define IDC_EDIT_CREATEID				(3000)
#endif

#ifndef IDC_COMBOX_CREATEID
#define IDC_COMBOX_CREATEID				(3001)
#endif
#pragma once
#include "afxcmn.h"
#include "ado2.h"
#include "afxwin.h"

// CTestCom 对话框

class CTestCom : public CDialogEx
{
	DECLARE_DYNAMIC(CTestCom)

public:
	CTestCom(CWnd* pParent = NULL);   // 标准构造函数
	virtual ~CTestCom();

// 对话框数据
	enum { IDD = IDD_MODIFY };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 支持
	virtual BOOL OnInitDialog();
	DECLARE_MESSAGE_MAP()

public:
	afx_msg void OnBnSave();
	afx_msg void OnNMClickList1(NMHDR *pNMHDR, LRESULT *pResult);
	CListCtrl m_list;
	CString  sql_text;
	CString  strLangName;
	int e_Item;    //刚编辑的行  
	int e_SubItem; //刚编辑的列  	
	CEdit m_Edit;  //生成单元编辑框对象
	bool haveeditcreate;//标志编辑框已经被创建
	//void createEdit(NM_LISTVIEW  *pEditCtrl, CEdit *createdit, int &Item, int &SubItem, bool &havecreat);//创建单元格编辑框函数
	//void destroyEdit(CListCtrl *list, CEdit* destroyedit, int &Item, int &SubItem);//销毁单元格编辑框对象

	CComboBox m_comBox;//生产单元格下拉列表对象
	bool haveccomboboxcreate;//标志下拉列表框已经被创建
	void createCcombobox(NM_LISTVIEW  *pEditCtrl, CComboBox *createccomboboxobj, int &Item, int &SubItem, bool &havecreat);//创建单元格下拉列表框函数
	void destroyCcombobox(CListCtrl *list, CComboBox* destroyccomboboxobj, int &Item, int &SubItem);
	INDEX_NODE foldernode;
	afx_msg void OnBnClickedButton4();
	afx_msg void OnBnClickedButton3();
	afx_msg void OnOK();
	int m_isChild;
	int * isFresh;
	CFont DefaultFont,TitleFont,NameFont,TextFont;
	int isNull;
	int m_selectnum;
	int keynum;
	CString key[MAX_DATA_NUM],val[MAX_DATA_NUM];
	afx_msg void OnNMDblclkList1(NMHDR *pNMHDR, LRESULT *pResult);
	afx_msg void OnCustomdrawList(NMHDR*, LRESULT*);
	afx_msg void OnNMRClickList1(NMHDR *pNMHDR, LRESULT *pResult);
	afx_msg void OnAddRow();
	afx_msg void OnDeleteRow();
	afx_msg void OnLvnEndlabeleditList1(NMHDR *pNMHDR, LRESULT *pResult);
	afx_msg BOOL PreTranslateMessage(MSG*   pMsg);
	CStatic m_static1;
	int itemcount;
	afx_msg void OnStnClickedStatic1();
};
