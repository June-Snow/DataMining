
// ReadExcelFileDlg.h : 头文件
//

#pragma once
#include <vector>

// CReadExcelFileDlg 对话框
class CReadExcelFileDlg : public CDialogEx
{
// 构造
public:
	CReadExcelFileDlg(CWnd* pParent = NULL);	// 标准构造函数

// 对话框数据
	enum { IDD = IDD_READEXCELFILE_DIALOG };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV 支持


// 实现
protected:
	HICON m_hIcon;

	// 生成的消息映射函数
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnBnClickedButton1();
	afx_msg void OnBnClickedButton2();
	afx_msg void OnBnClickedButton3();
	afx_msg void OnBnClickedButton4();
	afx_msg void OnBnClickedButton5();
	void startThread(std::vector<CString> name, CString sourcePath, CString savePath, int type);
	static void moveFileThread(void *args);
	std::vector<CString> aviName;
	CString sourcePath;
	CString savePath;
	int moveType;
	int m_type;
	afx_msg void OnTimer(UINT_PTR nIDEvent);
};
