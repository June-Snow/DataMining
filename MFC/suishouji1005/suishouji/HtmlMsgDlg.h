#pragma once
#include "explorer1.h"


// CHtmlMsgDlg �Ի���

class CHtmlMsgDlg : public CDialogEx
{
	DECLARE_DYNAMIC(CHtmlMsgDlg)

public:
	CHtmlMsgDlg(CWnd* pParent = NULL);   // ��׼���캯��
	virtual ~CHtmlMsgDlg();

// �Ի�������
	enum { IDD = IDD_SHOWHTML };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV ֧��
	virtual BOOL OnInitDialog();
	DECLARE_MESSAGE_MAP()
public:
	CExplorer1 m_msgweb;
	INDEX_NODE file;
	INDEX_NODE folder;
	int selectno;
};
