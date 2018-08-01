#pragma once
#include "DBSDK.h"
#include "afxwin.h"
#include "DBSDK.h"
#include "Export.h"
#include "AddMsgDlg.h"
#include "InitializeCtrl.h"
// EditMsgDlg 对话框





class EditMsgDlg : public CDialogEx
{
	DECLARE_DYNAMIC(EditMsgDlg)

public:
	EditMsgDlg(CWnd* pParent = NULL);   // 标准构造函数
	virtual ~EditMsgDlg();

// 对话框数据
	enum { IDD = IDD_STATICEDIT_DIALOG };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 支持
	virtual BOOL OnInitDialog();
	DECLARE_MESSAGE_MAP();
public:
	int selectno;
	INDEX_NODE index;
	INDEX_NODE folder;
	CString m_filePath[10],m_fileName[10],m_suffixName[10];
	CFont DefaultFont,TitleFont,NameFont,TextFont,linelink;
	CStatic * m_edit_key[MAX_DATA_NUM];
	CEdit * m_edit_val[MAX_DATA_NUM];
	CStatic * m_static[MAX_DATA_NUM];
	CString str_picture;
	int * isfresh;
	CButton *p_mybut;                   //add botton
	CButton *p_btn_save;
	CButton *p_btn_add_img;
	CButton *p_btn_export_word;
	afx_msg void OnBnClickedBtmimg0();
	afx_msg void OnBnClickedBtmimg1();
	afx_msg void OnBnClickedBtmimg2();
	afx_msg void OnBnClickedBtmimg3();
	afx_msg void OnBnClickedBtmimg4();
	afx_msg void OnBnClickedBtmimg5();
	afx_msg void OnBnClickedBtmimg6();
	afx_msg void OnBnClickedBtmimg7();
	afx_msg void OnBnClickedBtmimg8();
	afx_msg void OnBnClickedBtmimg9();
	afx_msg void OnBnClickedButton2();
	CString key[MAX_DATA_NUM],val[MAX_DATA_NUM],val1[MAX_DATA_NUM];
	int keyvaluenum;//键值对个数
	
	afx_msg void OnVScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar);
	afx_msg void OnSize(UINT nType, int cx, int cy);
	int m_ixoldpos;//记录鼠标拖动滑动条的位置
	int m_iyoldpos;
	CBrush m_redbrush,m_bluebrush,m_whitebrush;  
	COLORREF m_redcolor,m_bluecolor,m_textcolor,m_blackecolor,m_whitecolor; 

	afx_msg HBRUSH OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor);
};
