
// ReadExcelFileDlg.cpp : 实现文件
//

#include "stdafx.h"
#include "ReadExcelFile.h"
#include "ReadExcelFileDlg.h"
#include "afxdialogex.h"
#include "ExcelOperate.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// 用于应用程序“关于”菜单项的 CAboutDlg 对话框

class CAboutDlg : public CDialogEx
{
public:
	CAboutDlg();

// 对话框数据
	enum { IDD = IDD_ABOUTBOX };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 支持

// 实现
protected:
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialogEx(CAboutDlg::IDD)
{
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialogEx)
END_MESSAGE_MAP()


// CReadExcelFileDlg 对话框




CReadExcelFileDlg::CReadExcelFileDlg(CWnd* pParent /*=NULL*/)
	: CDialogEx(CReadExcelFileDlg::IDD, pParent)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	m_type = 1;
}

void CReadExcelFileDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CReadExcelFileDlg, CDialogEx)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_BUTTON1, &CReadExcelFileDlg::OnBnClickedButton1)
	ON_BN_CLICKED(IDC_BUTTON2, &CReadExcelFileDlg::OnBnClickedButton2)
	ON_BN_CLICKED(IDC_BUTTON3, &CReadExcelFileDlg::OnBnClickedButton3)
	ON_BN_CLICKED(IDC_BUTTON4, &CReadExcelFileDlg::OnBnClickedButton4)
	ON_BN_CLICKED(IDC_BUTTON5, &CReadExcelFileDlg::OnBnClickedButton5)
	ON_WM_TIMER()
END_MESSAGE_MAP()


// CReadExcelFileDlg 消息处理程序

BOOL CReadExcelFileDlg::OnInitDialog()
{
	CDialogEx::OnInitDialog();

	// 将“关于...”菜单项添加到系统菜单中。

	// IDM_ABOUTBOX 必须在系统命令范围内。
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		BOOL bNameValid;
		CString strAboutMenu;
		bNameValid = strAboutMenu.LoadString(IDS_ABOUTBOX);
		ASSERT(bNameValid);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// 设置此对话框的图标。当应用程序主窗口不是对话框时，框架将自动
	//  执行此操作
	SetIcon(m_hIcon, TRUE);			// 设置大图标
	SetIcon(m_hIcon, FALSE);		// 设置小图标

	// TODO: 在此添加额外的初始化代码

	return TRUE;  // 除非将焦点设置到控件，否则返回 TRUE
}

void CReadExcelFileDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialogEx::OnSysCommand(nID, lParam);
	}
}

// 如果向对话框添加最小化按钮，则需要下面的代码
//  来绘制该图标。对于使用文档/视图模型的 MFC 应用程序，
//  这将由框架自动完成。

void CReadExcelFileDlg::OnPaint()
{
	if (IsIconic())
	{
		CPaintDC dc(this); // 用于绘制的设备上下文

		SendMessage(WM_ICONERASEBKGND, reinterpret_cast<WPARAM>(dc.GetSafeHdc()), 0);

		// 使图标在工作区矩形中居中
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// 绘制图标
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialogEx::OnPaint();
	}
}

//当用户拖动最小化窗口时系统调用此函数取得光标
//显示。
HCURSOR CReadExcelFileDlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}


//excel文件
void CReadExcelFileDlg::OnBnClickedButton1()
{
	// TODO: 在此添加控件通知处理程序代码
	//CString path = _T("C:\\Users\\Serissa\\Desktop\\算法组工作周报\\工作周报-20160526-李涛.xls");


	static char szFilter[] = "Excel Files (*.xls)|*.xls|Excel Files (*.xlsx)|*.xlsx||";
	CFileDialog dlg(TRUE, "xls", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;
	CString m_pathName = dlg.GetPathName();
	GetDlgItem(IDC_EDIT1)->SetWindowText(m_pathName);
}

//原始视频
void CReadExcelFileDlg::OnBnClickedButton2()
{
	char szPath[MAX_PATH];     //存放选择的目录路径 
	CString str;
	ZeroMemory(szPath, sizeof(szPath));   
	BROWSEINFO bi;   
	bi.hwndOwner = m_hWnd;   
	bi.pidlRoot = NULL;   
	bi.pszDisplayName = szPath;   
	bi.lpszTitle = "请选择需要打开的文件夹：";   
	bi.ulFlags = 0;   
	bi.lpfn = NULL;   
	bi.lParam = 0;   
	bi.iImage = 0;   
	//弹出选择目录对话框
	LPITEMIDLIST lp = SHBrowseForFolder(&bi);   

	if(lp && SHGetPathFromIDList(lp, szPath))   
	{
		str.Format("%s",  szPath);
		GetDlgItem(IDC_EDIT2)->SetWindowText(str);
	}
	else   
		AfxMessageBox("无效的文件夹，请重新选择");   
}

//保存视频
void CReadExcelFileDlg::OnBnClickedButton3()
{
	char szPath[MAX_PATH];     //存放选择的目录路径 
	CString str;
	ZeroMemory(szPath, sizeof(szPath));   
	BROWSEINFO bi;   
	bi.hwndOwner = m_hWnd;   
	bi.pidlRoot = NULL;   
	bi.pszDisplayName = szPath;   
	bi.lpszTitle = "请选择保存的文件夹：";   
	bi.ulFlags = 0;   
	bi.lpfn = NULL;   
	bi.lParam = 0;   
	bi.iImage = 0;   
	//弹出选择目录对话框
	LPITEMIDLIST lp = SHBrowseForFolder(&bi);   

	if(lp && SHGetPathFromIDList(lp, szPath))   
	{
		str.Format("%s",  szPath);
		GetDlgItem(IDC_EDIT3)->SetWindowText(str);
	}
	else   
		AfxMessageBox("无效的文件夹，请重新选择");   
}

//复制视频
void CReadExcelFileDlg::OnBnClickedButton4()
{
	CString strExcelPath;
	GetDlgItem(IDC_EDIT1)->GetWindowText(strExcelPath);
	CString strAviPath;
	GetDlgItem(IDC_EDIT2)->GetWindowText(strAviPath);
	CString strSavePath;
	GetDlgItem(IDC_EDIT3)->GetWindowText(strSavePath);
	if (strExcelPath.IsEmpty() || strAviPath.IsEmpty() || strSavePath.IsEmpty())
	{
		return;
	}
	std::vector<CString> name;
	OnReadExcel(strExcelPath,name);
	startThread(name, strAviPath, strSavePath, 1);
	m_type = 1;//搜索标志位：1，开始，2，结束
	SetTimer(5, 500, NULL);

}

//剪切视频
void CReadExcelFileDlg::OnBnClickedButton5()
{
	CString strExcelPath;
	GetDlgItem(IDC_EDIT1)->GetWindowText(strExcelPath);
	CString strAviPath;
	GetDlgItem(IDC_EDIT2)->GetWindowText(strAviPath);
	CString strSavePath;
	GetDlgItem(IDC_EDIT3)->GetWindowText(strSavePath);
	if (strExcelPath.IsEmpty() || strAviPath.IsEmpty() || strSavePath.IsEmpty())
	{
		return;
	}
	std::vector<CString> name;
	OnReadExcel(strExcelPath,name);

	startThread(name, strAviPath, strSavePath, 2);
	m_type = 1;//搜索标志位：1，开始，2，结束
	SetTimer(5, 500, NULL);
}

void CReadExcelFileDlg::startThread(std::vector<CString> name, CString source, CString save, int type)
{
	aviName = name;
	sourcePath = source;
	savePath = save;
	moveType = type;
	_beginthread(moveFileThread, 0, this);//开线程

}

void CReadExcelFileDlg::moveFileThread(void *args)
{
	CReadExcelFileDlg *obj = (CReadExcelFileDlg*)args;
	std::vector<CString> name;
	name = obj->aviName;
	CString source = obj->sourcePath;
	source = source +_T("\\");
	CString save = obj->savePath;
	save = save +_T("\\");
	int type = obj->moveType;
	if (type == 1)
	{
		for (int i=0; i!=name.size(); i++)
		{
			if (PathFileExists(source+name[i]))
			{
				CopyFile(source+name[i],save +name[i], FALSE);
			}
		}

	}
	if (type == 2)
	{
		for (int i=0; i!=name.size(); i++)
		{
			if (PathFileExists(source+name[i]))
			{
				MoveFile( source+name[i],save +name[i]);
			}
		}
	}
	obj->m_type = 2;
}

void CReadExcelFileDlg::OnTimer(UINT_PTR nIDEvent)
{
	// TODO: 在此添加消息处理程序代码和/或调用默认值
	if(nIDEvent  == 5)
	{
		if(m_type  == 2)
		{
			KillTimer(nIDEvent );
		}
	}
	CDialogEx::OnTimer(nIDEvent);
}
