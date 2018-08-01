// ImagesToDBDlg.cpp : implementation file
//

#include "stdafx.h"
#include "ImagesToDB.h"
#include "ImagesToDBDlg.h"
#include "ExcelDriver.h"

#include "ado2.h"
#include <vector>

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CAboutDlg dialog used for App About

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

	// Dialog Data
	enum { IDD = IDD_ABOUTBOX };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support

	// Implementation
protected:
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
END_MESSAGE_MAP()


// CImagesToDBDlg dialog




CImagesToDBDlg::CImagesToDBDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CImagesToDBDlg::IDD, pParent)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	numCol = 0;
}

void CImagesToDBDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CImagesToDBDlg, CDialog)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	//}}AFX_MSG_MAP
	ON_WM_CREATE()
	ON_WM_SIZE()
	ON_COMMAND(1240, OnDataTestBtn)
	ON_CBN_SELCHANGE(1243, OnComboxBtn)
	ON_COMMAND(1247, OnBatchExportBtn)
	ON_COMMAND(1248, OnPicExportBtn)

	ON_COMMAND(1250, OnHomePageBtn)
	ON_COMMAND(1251, OnUpPageBtn)
	ON_COMMAND(1252, OnDownPageBtn)
	ON_COMMAND(1253, OnEndPageBtn)
	ON_CBN_SELCHANGE(1238, OnComBoxDataBtn)
END_MESSAGE_MAP()


// CImagesToDBDlg message handlers

BOOL CImagesToDBDlg::OnInitDialog()
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
	SetIcon(m_hIcon, TRUE);         // Set big icon
	SetIcon(m_hIcon, FALSE);        // Set small icon
	numCol = 10;
	CString strData[63][4] = {
		{"等级","名称","数量","总数"},
		{"一","系统1","0","0"},
		{"(一)","子系统1","0","0"},
		{"1","模块","0","0"},
		{"(1)","子模块1","0","0"},
		{"(2)","子模块2","0","0"},
		{"(3)","子模块3","0","0"},
		{"2","模块","",""},
		{"2.1","子模块1","0","0"},
		{"2.2","子模块2","0","0"},
		{"2.3","子模块3","0","0"},
		{"3","模块3","",""},
		{"4","模块4","",""},
		{"（二）","子系统2","",""},
		{"1","模块1","",""},
		{"(1)","子模块1","",""},
		{"(2)","子模块2","",""},
		{"(3)","子模块3","",""},
		{"2","模块2","",""},
		{"3","模块3","",""},
		{"4","模块4","",""},
		{"4.1","设备1","",""},
		{"4.2","设备2","",""},
		{"4.3","设备3","",""},
		{"(三)","子系统3","",""},
		{"(四)","子系统4","",""},
		{"(五)","子系统5","",""},
		{"二","系统2","",""},
		{"（一）","子系统","",""},
		{"（二）","子系统","",""},
		{"三","系统2","",""},
		{"四","子系统","",""},
		{"一","系统1","0","0"},
		{"(一)","子系统1","0","0"},
		{"1","模块","0","0"},
		{"(1)","子模块1","0","0"},
		{"(2)","子模块2","0","0"},
		{"(3)","子模块3","0","0"},
		{"2","模块","",""},
		{"2.1","子模块1","0","0"},
		{"2.2","子模块2","0","0"},
		{"2.3","子模块3","0","0"},
		{"3","模块3","",""},
		{"4","模块4","",""},
		{"（二）","子系统2","",""},
		{"1","模块1","",""},
		{"(1)","子模块1","",""},
		{"(2)","子模块2","",""},
		{"(3)","子模块3","",""},
		{"2","模块2","",""},
		{"3","模块3","",""},
		{"4","模块4","",""},
		{"4.1","设备1","",""},
		{"4.2","设备2","",""},
		{"4.3","设备3","",""},
		{"(三)","子系统3","",""},
		{"(四)","子系统4","",""},
		{"(五)","子系统5","",""},
		{"二","系统2","",""},
		{"（一）","子系统","",""},
		{"（二）","子系统","",""},
		{"三","系统2","",""},
		{"四","子系统","",""}
	};

	int cx = GetSystemMetrics(SM_CXFULLSCREEN);
	int cy = GetSystemMetrics(SM_CYFULLSCREEN);
	MoveWindow(0,0,cx,cy);

	for (int i=0; i!=63; i++)
	{
		std::vector<CString>  dataCol;
		dataCol.clear();
		for (int j=0; j!=4; j++)
		{
			dataCol.push_back(strData[i][j]);
		}
		dataArray.push_back(dataCol);

	}
	sumRow = dataArray.size();

	std::vector<CString> colData;
	colData = dataArray[0];
	CString str = _T("序号");
	m_grid.InsertRow(" ");
	m_grid.SetRowHeight(0, 30);
	m_grid.SetItemText(0, 0, str);
	for (int j=0; j!=colData.size(); j++)
	{
		str = colData[j];
		m_grid.SetItemText(0, j+1, str);
	}
	OnGridCtrlWrite(1);


	// TODO: Add extra initialization here
	/*CADODatabase* pAdoDb = new CADODatabase();
	CString strConnection = _T("");

	strConnection = _T("Provider=SQLOLEDB;Data Source=127.0.0.1,1433;"
	"PersistSecurityInfo=False;Trusted_Connection=Yes;"
	"Initial Catalog=IMSDB;"
	"User Id=colten;Password=123;");


	pAdoDb->SetConnectionString(strConnection);

	if(pAdoDb->Open())
	{
	AfxMessageBox("this is a test example!");
	}
	else
	{
	AfxMessageBox("failed");
	return FALSE;
	}

	CADORecordset *pRs = new CADORecordset(pAdoDb);
	CString sqlCmd = "select TOP 3 CameraID as ci from VDiagRealResult";
	std::vector<CString> names;
	CString temp = "";

	if (pRs->Open(sqlCmd))
	{
	while (!pRs->IsEOF())
	{
	pRs->GetFieldValue("ci", temp);
	names.push_back(temp);
	pRs->MoveNext();
	}
	}
	*/

	return TRUE;  // return TRUE  unless you set the focus to a control
}

void CImagesToDBDlg::OnSysCommand(UINT nID, LPARAM lParam)
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

void CImagesToDBDlg::OnPaint()
{
	if (IsIconic())
	{
		CPaintDC dc(this); // device context for painting

		SendMessage(WM_ICONERASEBKGND, reinterpret_cast<WPARAM>(dc.GetSafeHdc()), 0);

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

// The system calls this function to obtain the cursor to display while the user drags
//  the minimized window.
HCURSOR CImagesToDBDlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}



int CImagesToDBDlg::OnCreate(LPCREATESTRUCT lpCreateStruct)
{
	if (CDialog::OnCreate(lpCreateStruct) == -1)
		return -1;
	m_text.CreatePointFont(100, _T("宋体"));
	m_btn.CreatePointFont(100, _T("宋体"));
	CRect rect;
	GetWindowRect(&rect);
	// TODO:  在此添加您专用的创建代码
	m_grid.Create(rect,this,1230);
	m_grid.SetBkColor(RGB(255,255,255));
	m_grid.SetColumnCount(10);
	//m_grid.SetRowHeight(25);
	m_grid.SetTrackFocusCell(FALSE);
	m_grid.SetEditable(FALSE);
	m_grid.SetFixedRowCount(1);
	m_grid.SetFont(&m_text);

	m_dataGroup.Create(_T("数据库信息"), WS_VISIBLE|WS_CHILD|WS_GROUP|WS_BORDER, CRect(0,0,0,0), this, 1231);
	m_dataGroup.SetFont(&m_text);
	m_dataIp.Create(_T("数据库地址"), WS_VISIBLE|WS_CHILD, CRect(0,0,0,0), this, 1232);
	m_dataIp.SetFont(&m_text);
	m_userName.Create(_T("登录用户"), WS_VISIBLE|WS_CHILD, CRect(0,0,0,0), this, 1233);
	m_userName.SetFont(&m_text);
	m_logSecret.Create(_T("登录密码"), WS_VISIBLE|WS_CHILD, CRect(0,0,0,0), this, 1235);
	m_logSecret.SetFont(&m_text);
	m_ip.Create(WS_CHILD | WS_VISIBLE|WS_TABSTOP|WS_BORDER ,CRect(0,0,0,0),this,1236);
	m_ip.EnableWindow(TRUE);
	m_ip.SetFont(&m_text);
	m_user.Create(WS_CHILD | WS_VISIBLE|WS_TABSTOP|WS_BORDER,CRect(0,0,0,0),this,1237);
	m_user.SetFont(&m_text);

	m_log.Create(WS_CHILD | WS_VISIBLE|WS_TABSTOP|WS_BORDER,CRect(0,0,0,0),this,1239);
	m_log.SetFont(&m_text);
	m_dataTest.Create(_T("数据库测试"), WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON , rect, this, 1240);
	m_dataTest.SetFont(&m_btn);

	m_picGroup.Create(_T("图片信息"), WS_VISIBLE|WS_CHILD|WS_GROUP|WS_BORDER, CRect(0,0,0,0), this, 1241);
	m_picGroup.SetFont(&m_text);
	m_dataName.Create(_T("数据库名"), WS_VISIBLE|WS_CHILD, CRect(0,0,0,0), this, 1234);
	m_dataName.SetFont(&m_text);
	m_data.Create(WS_CHILD | WS_VISIBLE | CBS_DROPDOWNLIST|WS_VSCROLL|CBN_SELCHANGE,CRect(0,0,0,0),this,1238);
	m_data.SetFont(&m_text);
	m_tableName.Create(_T("表名"), WS_VISIBLE|WS_CHILD, CRect(0,0,0,0), this, 1242);
	m_tableName.SetFont(&m_text);
	m_combox.Create(WS_CHILD | WS_VISIBLE | CBS_DROPDOWNLIST|WS_VSCROLL , CRect(0,0,0,0), this, 1243);
	m_combox.SetFont(&m_text);
	rangeExport.Create(_T("范围"), WS_VISIBLE|WS_CHILD, CRect(0,0,0,0), this, 1244);
	rangeExport.SetFont(&m_text);
	m_separator.Create(_T("->"), WS_VISIBLE|WS_CHILD, CRect(0,0,0,0), this, 1244);
	m_separator.SetFont(&m_text);
	rangeMin.Create(WS_CHILD | WS_VISIBLE|WS_TABSTOP|WS_BORDER,CRect(0,0,0,0),this,1245);
	rangeMin.SetFont(&m_text);
	rangeMax.Create(WS_CHILD | WS_VISIBLE|WS_TABSTOP|WS_BORDER,CRect(0,0,0,0),this,1246);
	rangeMax.SetFont(&m_text);
	batchExport.Create(_T("批量导出"), WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON , CRect(0,0,0,0), this, 1247);
	batchExport.SetFont(&m_btn);
	picEport.Create(_T("图片导出"), WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON , CRect(0,0,0,0), this, 1248);
	picEport.SetFont(&m_btn);

	m_pageGroup.Create(_T(""), WS_VISIBLE|WS_CHILD|WS_GROUP|WS_BORDER, CRect(0,0,0,0), this, 1249);
	m_pageGroup.SetFont(&m_text);
	m_page.Create(_T(""), WS_VISIBLE|WS_CHILD, CRect(0,0,0,0), this, 1231);
	m_page.SetFont(&m_text);
	m_bomePage.Create(_T("首页"), WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON , CRect(0,0,0,0), this, 1250);
	m_bomePage.SetFont(&m_btn);
	m_upPage.Create(_T("上一页"), WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON , CRect(0,0,0,0), this, 1251);
	m_upPage.SetFont(&m_btn);
	m_downPage.Create(_T("下一页"), WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON , CRect(0,0,0,0), this, 1252);
	m_downPage.SetFont(&m_btn);
	m_endPage.Create(_T("末页"), WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON , CRect(0,0,0,0), this, 1253);
	m_endPage.SetFont(&m_btn);

	return 0;
}


void CImagesToDBDlg::OnSize(UINT nType, int cx, int cy)
{
	CDialog::OnSize(nType, cx, cy);
	CRect rect;
	GetWindowRect(&rect);
	int row = m_grid.GetRowCount();
	int ctrlHeight = 20;
	int ctrlLeft = 20;
	int count = 30;
	m_dataGroup.MoveWindow(5,5,250,135,TRUE);
	m_dataIp.MoveWindow(ctrlLeft,count,70,ctrlHeight,TRUE);
	m_ip.MoveWindow(ctrlLeft+70,count-2,150,ctrlHeight,TRUE);
	count = count + ctrlHeight + 5;
	m_userName.MoveWindow(ctrlLeft,count,70,ctrlHeight,TRUE);
	m_user.MoveWindow(ctrlLeft+70,count-2,150,ctrlHeight,TRUE);
	count = count + ctrlHeight + 5;
	m_logSecret.MoveWindow(ctrlLeft,count,70,ctrlHeight,TRUE);
	m_log.MoveWindow(ctrlLeft+70,count-2,150,ctrlHeight,TRUE);
	count = count + ctrlHeight + 10;
	m_dataTest.MoveWindow(150,count,80,ctrlHeight,TRUE);
	count = count + ctrlHeight + 15;

	int winHeight = rect.Height();

	m_picGroup.MoveWindow(5,count,250,winHeight-185,TRUE);
	count = count + ctrlHeight+5;
	m_dataName.MoveWindow(ctrlLeft,count,70,ctrlHeight,TRUE);
	m_data.MoveWindow(ctrlLeft+70,count-2,150,100,TRUE);
	count = count + ctrlHeight + 5;
	m_tableName.MoveWindow(ctrlLeft,count,70,ctrlHeight,TRUE);
	m_combox.MoveWindow(ctrlLeft+70,count,150,100,TRUE);

	batchExport.MoveWindow(4*ctrlLeft+10,winHeight-50-ctrlHeight,60,ctrlHeight,TRUE);
	picEport.MoveWindow(4*ctrlLeft+80+10,winHeight-50-ctrlHeight,60,ctrlHeight,TRUE);
	rangeExport.MoveWindow(ctrlLeft,winHeight-50-ctrlHeight-5-ctrlHeight-1,30,ctrlHeight,TRUE);
	rangeMin.MoveWindow(ctrlLeft+30,winHeight-50-ctrlHeight-10-ctrlHeight,80,ctrlHeight,TRUE);
	m_separator.MoveWindow(ctrlLeft+111,winHeight-50-ctrlHeight-10-ctrlHeight+3,14,ctrlHeight,TRUE);
	rangeMax.MoveWindow(ctrlLeft+125,winHeight-50-ctrlHeight-10-ctrlHeight,80,ctrlHeight,TRUE);

	m_pageGroup.MoveWindow(255,rect.Height()-70,rect.Width()-255,40,TRUE);
	m_page.MoveWindow(270,rect.Height()-45-ctrlHeight,200,ctrlHeight,TRUE);
	m_bomePage.MoveWindow(rect.Width()-60-70-60-70-70,rect.Height()-45-ctrlHeight,60,ctrlHeight,TRUE);
	m_upPage.MoveWindow(rect.Width()-60-70-60-70,rect.Height()-45-ctrlHeight,60,ctrlHeight,TRUE);
	m_downPage.MoveWindow(rect.Width()-60-70-60,rect.Height()-45-ctrlHeight,60,ctrlHeight,TRUE);
	m_endPage.MoveWindow(rect.Width()-60-60,rect.Height()-45-ctrlHeight,60,ctrlHeight,TRUE);

	if (numCol > 0)
	{
		m_grid.MoveWindow(260,0,rect.Width()-260,rect.Height()-80,TRUE);
		pageRow = (rect.Height()-80)/25-1;
		int wi = rect.Width();
		int he = rect.Height();
		int width = rect.Width()-280;
		if (width <= 0)
		{
			width = 15;
		}
		for (int i=0; i!=numCol; i++)
		{
			m_grid.SetColumnWidth(i,width/numCol);
		}
	}
}

void CImagesToDBDlg::OnGridCtrlWrite(int pageNum)
{
	CString str, str1;
	str1.Format("%d", pageNum);
	double num = ceil(sumRow/pageRow);
	str.Format("%.lf", num);
	str = _T("第")+str1+_T("页 共")+str+_T("页");
	m_page.SetWindowText(str);
	int endNum = min(pageNum*pageRow+1, dataArray.size());
	m_grid.SetRowCount(1);

	for (int i=(pageNum-1)*pageRow+1; i!=endNum; i++)
	{
		std::vector<CString> colData;
		colData = dataArray[i];
		CString str;
		m_grid.InsertRow(" ");
		m_grid.SetRowHeight(i-(pageNum-1)*pageRow, 25);
		str.Format("%d", i);
		m_grid.SetItemText(i-(pageNum-1)*pageRow, 0, str);
		for (int j=0; j!=colData.size(); j++)
		{
			str = colData[j];
			m_grid.SetItemText(i-(pageNum-1)*pageRow, j+1, str);
		}
	}

}

//数据库测试
void CImagesToDBDlg::OnDataTestBtn()
{
	CString strIP;
	CString strUserName;
	CString strPassword;
	m_ip.GetWindowText(strIP);
	m_user.GetWindowText(strUserName);
	m_log.GetWindowText(strPassword);

//TODO:读取数据库
	std::vector<CString> dataName;
	std::vector<CString> tableName;
	CString str;
	dataName.push_back(_T("数据库1"));
	dataName.push_back(_T("数据库2"));
	dataName.push_back(_T("数据库1"));
	dataName.push_back(_T("数据库2"));
	dataName.push_back(_T("数据库1"));
	dataName.push_back(_T("数据库2"));
	dataName.push_back(_T("数据库1"));
	dataName.push_back(_T("数据库2"));
	tableName.push_back(_T("表1"));
	tableName.push_back(_T("表2"));
	for (int i=0;i!=dataName.size();i++)
	{
		str = dataName[i];
		m_data.AddString(str);
	}
	m_data.SetCurSel(0);
	for (int i=0;i!=tableName.size();i++)
	{
		str = tableName[i];
		m_combox.AddString(str);
	}
	m_combox.SetCurSel(0);
}

//数据库名
void CImagesToDBDlg::OnComBoxDataBtn()
{
	CString dataName;
	m_data.GetLBText(m_data.GetCurSel(), dataName);
	//TODO:通过数据库名查询表名
	std::vector<CString> tableName;
	tableName.push_back(_T("表1"));
	tableName.push_back(_T("表2"));
	CString str;
	for (int i=0;i!=tableName.size();i++)
	{
		str = tableName[i];
		m_combox.AddString(str);
	}
	//TODO:数据库查询
	//dataArray.clear();
	OnGridCtrlWrite(1);
}
//表名
void  CImagesToDBDlg::OnComboxBtn()
{
	CString dataName;
	m_data.GetLBText(m_data.GetCurSel(), dataName);
	CString tableName;
	m_combox.GetLBText(m_combox.GetCurSel(), tableName);
	//TODO:通过表名名查询数据库
	OnGridCtrlWrite(1);
}
//批量导出
void  CImagesToDBDlg::OnBatchExportBtn()
{
	CString strMin;
	CString strMax;
	rangeMin.GetWindowText(strMin);
	rangeMax.GetWindowText(strMax);
	int numMin = _ttoi(strMin);
	int numMax = _ttoi(strMax);
	if (numMin > numMax)
	{
		//MessageBox()
	}
	CString path = "";
	for(int i = 0;i<2;i++)
	{
	GridCtrlToExcel(path, dataArray, numMin, numMax);
	}

}
//图片导出
void  CImagesToDBDlg::OnPicExportBtn()
{

}
//首页
void  CImagesToDBDlg::OnHomePageBtn()
{
	int num;
	GetExtractDigitalCharacters(num);
	if (num == 1)
	{
		return;
	}
	OnGridCtrlWrite(1);
}

//上一页
void  CImagesToDBDlg::OnUpPageBtn()
{
	int num;
	GetExtractDigitalCharacters(num);
	if (num==1)
	{
		return;
	}
	OnGridCtrlWrite(num-1);
}
//下一页
void  CImagesToDBDlg::OnDownPageBtn()
{
	int num;
	GetExtractDigitalCharacters(num);
	double sumNum = ceil(sumRow/pageRow);
	if (num == sumNum)
	{
		return;
	}
	OnGridCtrlWrite(num+1);
}
//末页
void  CImagesToDBDlg::OnEndPageBtn()
{
	int num;
	GetExtractDigitalCharacters(num);
	double sumNum = ceil(sumRow/pageRow);
	if (num == sumNum)
	{
		return;
	}
	OnGridCtrlWrite(sumNum);

}

void  CImagesToDBDlg::GetExtractDigitalCharacters(int &num)
{
	CString str;
	m_page.GetWindowText(str);
	int pos = str.Find(_T("页"));
	str = str.Mid(2,pos-2);
	num = _ttoi(str);
}
