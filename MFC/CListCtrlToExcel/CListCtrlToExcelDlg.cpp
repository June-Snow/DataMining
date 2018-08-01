// CListCtrlToExcelDlg.cpp : implementation file
//

#include "stdafx.h"
#include "CListCtrlToExcel.h"
#include "CListCtrlToExcelDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CAboutDlg dialog used for App About

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// Dialog Data
	//{{AFX_DATA(CAboutDlg)
	enum { IDD = IDD_ABOUTBOX };
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAboutDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	//{{AFX_MSG(CAboutDlg)
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
	//{{AFX_DATA_INIT(CAboutDlg)
	//}}AFX_DATA_INIT
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAboutDlg)
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
	//{{AFX_MSG_MAP(CAboutDlg)
		// No message handlers
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CCListCtrlToExcelDlg dialog

CCListCtrlToExcelDlg::CCListCtrlToExcelDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CCListCtrlToExcelDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CCListCtrlToExcelDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CCListCtrlToExcelDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CCListCtrlToExcelDlg)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	DDX_Control(pDX,IDC_AllRecordListCtrl,m_clistctrl);  //self add
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CCListCtrlToExcelDlg, CDialog)
	//{{AFX_MSG_MAP(CCListCtrlToExcelDlg)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(ID_Export, OnExport)  //self add
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CCListCtrlToExcelDlg message handlers

BOOL CCListCtrlToExcelDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// Add "About..." menu item to system menu.

	// IDM_ABOUTBOX must be in the system command range.
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		CString strAboutMenu;
		strAboutMenu.LoadString(IDS_ABOUTBOX);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon
	
	// TODO: Add extra initialization here
	InitListCtrl();
	
	return TRUE;  // return TRUE  unless you set the focus to a control
}

//初始化CListCtrl
void CCListCtrlToExcelDlg::InitListCtrl()
{
	
	m_clistctrl.SetExtendedStyle(LVS_EX_FULLROWSELECT | LVS_EX_GRIDLINES);
	m_clistctrl.SetBkColor(RGB(247,247,255));
	m_clistctrl.SetTextColor(RGB(0,0,255));
	m_clistctrl.SetTextBkColor(RGB(247,247,255));
	
	const int FieldNum=9;
	CString FieldName[FieldNum]={"序号","编号","姓名","成绩","证件类型","证件编号","考试类型","考试员","车牌号"};
	int FieldWidth[FieldNum]={50,80,80,80,80,120,80,80,80};
	
	for(int i=0;i<FieldNum;i++)
	{
		m_clistctrl.InsertColumn(i,FieldName[i]);
		m_clistctrl.SetColumnWidth(i,FieldWidth[i]);
	}
//*	
	CString tempq,tempn,tempIDType="身份证",tempID="420701198811230974",tempCarID="鄂A 05673";
	CString tempName="张三",tempTeacher="欧阳小王",tempScore="93",tempTextType="C2";
	for(int i=0;i<10;i++)
	{
		tempq.Format("%d",i);
		m_clistctrl.InsertItem(i,tempq);
	}
//*	
    int k=0;
	for(long j=201305001;j<201305011;j++)
	{		
		tempn.Format("%d",j);
		m_clistctrl.SetItemText(k,1,tempn);
		m_clistctrl.SetItemText(k,2,tempName);
		m_clistctrl.SetItemText(k,3,tempScore);
		m_clistctrl.SetItemText(k,4,tempIDType);
		m_clistctrl.SetItemText(k,5,tempID);
		m_clistctrl.SetItemText(k,6,tempTextType);
		m_clistctrl.SetItemText(k,7,tempTeacher);
		m_clistctrl.SetItemText(k,8,tempCarID);
		k++;
	}
//*/
	m_clistctrl.Invalidate();

}
void CCListCtrlToExcelDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialog::OnSysCommand(nID, lParam);
	}
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CCListCtrlToExcelDlg::OnPaint() 
{
	if (IsIconic())
	{
		CPaintDC dc(this); // device context for painting

		SendMessage(WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc(), 0);

		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

// The system calls this to obtain the cursor to display while the user drags
//  the minimized window.
HCURSOR CCListCtrlToExcelDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

void CCListCtrlToExcelDlg::OnExport()
{
	CListCtrlToExcel(&m_clistctrl,"数据表");
}
