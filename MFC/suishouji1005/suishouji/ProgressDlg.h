#pragma once
#include "resource.h"
#include "afxcmn.h"
#include "afxwin.h"


// ProgressDlg �Ի���

class ProgressDlg : public CDialogEx
{
	DECLARE_DYNAMIC(ProgressDlg)

public:
	ProgressDlg(CWnd* pParent = NULL);   // ��׼���캯��
	virtual ~ProgressDlg();

// �Ի�������
	enum { IDD = IDD_PROGRESSDLG };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV ֧��

	DECLARE_MESSAGE_MAP()
public:
	CProgressCtrl m_ctrlProgress;
	CEdit m_editText;
	int wordSearchNum;
	int wordFilesNum;
	afx_msg void OnNMCustomdrawProgress1(NMHDR *pNMHDR, LRESULT *pResult);
	virtual BOOL OnInitDialog();
};
