
// test_ado_mfcDlg.h : ͷ�ļ�
//

#pragma once


// Ctest_ado_mfcDlg �Ի���
class Ctest_ado_mfcDlg : public CDialogEx
{
// ����
public:
	Ctest_ado_mfcDlg(CWnd* pParent = NULL);	// ��׼���캯��

// �Ի�������
	enum { IDD = IDD_TEST_ADO_MFC_DIALOG };

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
	afx_msg void OnBnClickedButton1();
	afx_msg void OnBnClickedQuery();
	afx_msg void OnBnClickedDeletetable();
	afx_msg void OnBnClickedButton2();
	afx_msg void OnBnClickedInsertfile();
	afx_msg void OnBnClickedButton3();
	afx_msg void OnBnClickedAlterfile();
	afx_msg void OnBnClickedButton4();
};
