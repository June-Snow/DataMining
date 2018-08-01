﻿
// jizhuomiexampleDlg.cpp : 实现文件
//

#include "stdafx.h"
#include "jizhuomiexample.h"
#include "jizhuomiexampleDlg.h"
#include "afxdialogex.h"
//#include "TipDlg.h"

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


// CjizhuomiexampleDlg 对话框




CjizhuomiexampleDlg::CjizhuomiexampleDlg(CWnd* pParent /*=NULL*/)
	: CDialogEx(CjizhuomiexampleDlg::IDD, pParent),m_pTipDlg(NULL)
	, m_editSummand(0)
	, m_editAddend(0)
	, m_editSum(0)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

CjizhuomiexampleDlg::~CjizhuomiexampleDlg()   
{   
    // 如果非模态对话框已经创建则删除它   
    if (NULL != m_pTipDlg)   
    {   
        // 删除非模态对话框对象   
        delete m_pTipDlg;   
    }   
}  

void CjizhuomiexampleDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
	DDX_Text(pDX, IDC_SUMMAND_EDIT, m_editSummand);
	DDX_Text(pDX, IDC_ADDEND_EDIT, m_editAddend);
	DDX_Text(pDX, IDC_SUM_EDIT, m_editSum);
}

BEGIN_MESSAGE_MAP(CjizhuomiexampleDlg, CDialogEx)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_EN_CHANGE(IDC_SUMMAND_EDIT, &CjizhuomiexampleDlg::OnEnChangeSummandEdit)
	ON_BN_CLICKED(IDC_ADD_BUTTON, &CjizhuomiexampleDlg::OnClickedAddButton)
END_MESSAGE_MAP()


// CjizhuomiexampleDlg 消息处理程序

BOOL CjizhuomiexampleDlg::OnInitDialog()
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

void CjizhuomiexampleDlg::OnSysCommand(UINT nID, LPARAM lParam)
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

void CjizhuomiexampleDlg::OnPaint()
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
HCURSOR CjizhuomiexampleDlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}



void CjizhuomiexampleDlg::OnEnChangeSummandEdit()
{
	// TODO:  Èç¹û¸Ã¿Ø¼þÊÇ RICHEDIT ¿Ø¼þ£¬Ëü½«²»
	// ·¢ËÍ´ËÍ¨Öª£¬³ý·ÇÖØÐ´ CDialogEx::OnInitDialog()
	// º¯Êý²¢µ÷ÓÃ CRichEditCtrl().SetEventMask()£¬
	// Í¬Ê±½« ENM_CHANGE ±êÖ¾¡°»ò¡±ÔËËãµ½ÑÚÂëÖÐ¡£

	// TODO:  ÔÚ´ËÌí¼Ó¿Ø¼þÍ¨Öª´¦Àí³ÌÐò´úÂë
}


void CjizhuomiexampleDlg::OnClickedAddButton()
{
	// TODO: ÔÚ´ËÌí¼Ó¿Ø¼þÍ¨Öª´¦Àí³ÌÐò´úÂë
	/*模态对话框实例 
	INT_PTR nRes;             // 用于保存DoModal函数的返回值   
  
    CTipDlg tipDlg;           // 构造对话框类CTipDlg的实例   
    nRes = tipDlg.DoModal();  // 弹出对话框   
    if (IDCANCEL == nRes)     // 判断对话框退出后返回值是否为IDCANCEL，如果是则return，否则继续向下执行   
        return;  
		*/
	if (NULL == m_pTipDlg)   
    {   
        // 创建非模态对话框实例   
        m_pTipDlg = new CTipDlg();   
        m_pTipDlg->Create(IDD_DIALOG1, this);   
    }   
    // 显示非模态对话框   
    m_pTipDlg->ShowWindow(SW_SHOW);  


	UpdateData(TRUE);
	m_editSum = m_editSummand + m_editAddend;
	UpdateData(FALSE);

}
