
// jizhuomiexampleDlg.h : ͷ�ļ�
//

#pragma once
#include "TipDlg.h"

// CjizhuomiexampleDlg �Ի���
class CjizhuomiexampleDlg : public CDialogEx
{
	private:
	CTipDlg  *m_pTipDlg;
// ����
public:
	CjizhuomiexampleDlg(CWnd* pParent = NULL);	// ��׼���캯��
	~CjizhuomiexampleDlg();
// �Ի�������
	enum { IDD = IDD_JIZHUOMIEXAMPLE_DIALOG };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV ֧��


// ʵ��
protected:
	HICON m_hIcon;

	// ���ɵ���Ϣӳ�亯��
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnEnChangeSummandEdit();
	double m_editSummand;
	double m_editAddend;
	double m_editSum;
	afx_msg void OnClickedAddButton();
};
