#pragma once
#include "afxwin.h"
#include "explorer1.h"

// CDiaryDlg �Ի���

class CDiaryDlg : public CDialogEx
{
	DECLARE_DYNAMIC(CDiaryDlg)

public:
	CDiaryDlg(CWnd* pParent = NULL);   // ��׼���캯��
	virtual ~CDiaryDlg();

// �Ի�������
	enum { IDD = IDD_Diary };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV ֧��
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
	CString sorttag1;   //ͨѶ¼չ������
	CString sorttag2;    //�ռ�չ������
	CExplorer1 *diaryedit;
};
