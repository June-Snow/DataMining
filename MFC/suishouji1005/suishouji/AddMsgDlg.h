#pragma once
#include "DBSDK.h"
#include "afxwin.h"
#include "DBSDK.h"
#include "Export.h"
#include "CFont0.h"
#include "MyEditBrowseCtrl.h"
#include "InitializeCtrl.h"
#include "explorer1.h"


#define IDC_SAVEBTNEND  5000000
// AddMsgDlg 对话框

class AddMsgDlg : public CDialogEx
{
	DECLARE_DYNAMIC(AddMsgDlg)

public:
	AddMsgDlg(CWnd* pParent = NULL);   // 标准构造函数
	virtual ~AddMsgDlg();
	virtual BOOL OnInitDialog();
// 对话框数据
	enum { IDD = IDD_DIALOG10 };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 支持

	DECLARE_MESSAGE_MAP()
public:
	CString m_filePath[20],m_fileName[20],m_suffixName[20];
	afx_msg void OnBnClickedBtmaddpic300();
	afx_msg void OnBnClickedBtmaddpic301();
	afx_msg void OnBnClickedBtmaddpic302();
	afx_msg void OnBnClickedBtmaddpic303();
	afx_msg void OnBnClickedBtmaddpic304();
	afx_msg void OnBnClickedBtmaddpic305();
	afx_msg void OnBnClickedBtmaddpic306();
	afx_msg void OnBnClickedBtmaddpic307();
	afx_msg void OnBnClickedBtmaddpic308();
	afx_msg void OnBnClickedBtmaddpic309();
	afx_msg void OnBnClickedBtmaddpic310();
	afx_msg void OnBnClickedBtmaddpic311();
	afx_msg void OnBnClickedBtmaddpic312();
	afx_msg void OnBnClickedBtmaddpic313();
	afx_msg void OnBnClickedBtmaddpic314();
	afx_msg void OnBnClickedBtmaddpic315();
	afx_msg void OnBnClickedBtmaddpic316();
	afx_msg void OnBnClickedBtmaddpic317();
	afx_msg void OnBnClickedBtmaddpic318();
	afx_msg void OnBnClickedBtmaddpic319();
	afx_msg void OnVScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar);
	afx_msg void OnSize(UINT nType, int cx, int cy);
	afx_msg void OnBnClickedBtmdlg10head();
	afx_msg void ONSaveBTNEND();
	int m_ixoldpos;//记录鼠标拖动滑动条的位置
	int m_iyoldpos;
	int maxsroll;
	int selectno;
	CTreeCtrl* m_tree;

	int isedit;
	CString sorttag1;   //通讯录展开规则
    CString sorttag2;    //日记展开规则
	INDEX_NODE index;
	INDEX_NODE folder;
	CFont DefaultFont,TitleFont,NameFont,TextFont,linelink;
	CStatic * m_edit_key[MAX_DATA_NUM];
	CEdit * m_edit_val[MAX_DATA_NUM];
	CStatic * m_static[MAX_DATA_NUM];
	CDateTimeCtrl *m_dateCtrl[MAX_DATA_NUM];
	CMyEditBrowseCtrl * m_editbrowse[MAX_DATA_NUM];
	//CMFCEditBrowseCtrl * m_editbrowse[MAX_DATA_NUM];
	CBrush m_redbrush,m_bluebrush,m_whitebrush;  
	COLORREF m_redcolor,m_bluecolor,m_textcolor,m_blackecolor,m_whitecolor; 
	CString key[MAX_DATA_NUM],val[MAX_DATA_NUM],val1[MAX_DATA_NUM];
	int keyvaluenum;//键值对个数
	afx_msg void OnPaint();
	CExplorer1 *m_nyweb;

	
	afx_msg HBRUSH OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor);

	CButton *m_savebtn;
	afx_msg BOOL OnMouseWheel(UINT nFlags, short zDelta, CPoint pt);
	CStatic *m_static_picture[MAX_DATA_NUM];//显示图片
	CEdit *m_edit_txt[MAX_DATA_NUM];//显示文档跟附件
	CString m_txtandacc_path[30];

	afx_msg void OnBnClickedTxtandaccBtn0();
	afx_msg void OnBnClickedTxtandaccBtn1();
	afx_msg void OnBnClickedTxtandaccBtn2();
	afx_msg void OnBnClickedTxtandaccBtn3();
	afx_msg void OnBnClickedTxtandaccBtn4();
	afx_msg void OnBnClickedTxtandaccBtn5();
	afx_msg void OnBnClickedTxtandaccBtn6();
	afx_msg void OnBnClickedTxtandaccBtn7();
	afx_msg void OnBnClickedTxtandaccBtn8();
	afx_msg void OnBnClickedTxtandaccBtn9();
	afx_msg void OnBnClickedTxtandaccBtn10();
	afx_msg void OnBnClickedTxtandaccBtn11();
	afx_msg void OnBnClickedTxtandaccBtn12();
	afx_msg void OnBnClickedTxtandaccBtn13();
	afx_msg void OnBnClickedTxtandaccBtn14();
	afx_msg void OnBnClickedTxtandaccBtn15();
	afx_msg void OnBnClickedTxtandaccBtn16();
	afx_msg void OnBnClickedTxtandaccBtn17();
	afx_msg void OnBnClickedTxtandaccBtn18();
	afx_msg void OnBnClickedTxtandaccBtn19();
	afx_msg void OnBnClickedTxtandaccBtn20();
	afx_msg void OnBnClickedTxtandaccBtn21();
	afx_msg void OnBnClickedTxtandaccBtn22();
	afx_msg void OnBnClickedTxtandaccBtn23();
	afx_msg void OnBnClickedTxtandaccBtn24();
	afx_msg void OnBnClickedTxtandaccBtn25();
	afx_msg void OnBnClickedTxtandaccBtn26();

	afx_msg void OnBnClickedTxtandaccBtn27();
	afx_msg void OnBnClickedTxtandaccBtn28();
	afx_msg void OnBnClickedTxtandaccBtn29();
	void OnLButtonDown(UINT nFlags, CPoint point);
	CString m_mkdir_path;
	virtual void OnCancel();
	CButton m_addDocument;
	afx_msg void AddDocument();
	//afx_msg void OnBnClickedBtmdlg1head();
	//afx_msg void OnBnClickedBtmdlg1head();
	CStatic m_staticDocumen[10];
	int curPos;
	int addDoc;
};
