
// test_ado_mfcDlg.cpp : 实现文件
//

#include "stdafx.h"
#include "test_ado_mfc.h"
#include "test_ado_mfcDlg.h"
#include "afxdialogex.h"

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


// Ctest_ado_mfcDlg 对话框




Ctest_ado_mfcDlg::Ctest_ado_mfcDlg(CWnd* pParent /*=NULL*/)
	: CDialogEx(Ctest_ado_mfcDlg::IDD, pParent)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void Ctest_ado_mfcDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(Ctest_ado_mfcDlg, CDialogEx)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_BUTTON1, &Ctest_ado_mfcDlg::OnBnClickedButton1)
END_MESSAGE_MAP()


// Ctest_ado_mfcDlg 消息处理程序

BOOL Ctest_ado_mfcDlg::OnInitDialog()
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

void Ctest_ado_mfcDlg::OnSysCommand(UINT nID, LPARAM lParam)
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

void Ctest_ado_mfcDlg::OnPaint()
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
HCURSOR Ctest_ado_mfcDlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}

/*
void createfolder()
{
	FOLDER_NODE folder_node;
	// 不按顺序会怎么样？
	strcpy_s(folder_node.data[0].key, "名称");
	strcpy_s(folder_node.data[0].val, "String");
	strcpy_s(folder_node.data[1].key, "图片");
	strcpy_s(folder_node.data[1].val, "Picture");
	strcpy_s(folder_node.data[2].key, "备注");
	strcpy_s(folder_node.data[2].val, "Memotext");
	strcpy_s(folder_node.data[3].key, "日期");
	strcpy_s(folder_node.data[3].val, "Date");

	folder_node.data_num = 4;//num 和 数组中的数量不相等会怎么样？
	folder_node.PID = 1;
	strcpy_s(folder_node.index.NAME, "甲板商1");
	IMVL_CreateFolder(folder_node);
}


void deleteFolder()
{
	FOLDER_NODE folder_node;
	folder_node.index.ID=58;

	INDEX_TABLE index_table;
	IMVL_LoadIndexTable(index_table);

	IMVL_DeleteFile(58);
}

FOLDER_NODE getNode2()
{
	FOLDER_NODE folder_node;
	strcpy_s(folder_node.data[0].key, "日期");
	strcpy_s(folder_node.data[0].val, "DATE");
	strcpy_s(folder_node.data[1].key, "addr");
	strcpy_s(folder_node.data[1].val, "String");
	strcpy_s(folder_node.data[2].key, "年龄");
	strcpy_s(folder_node.data[2].val, "INTEGER");
	strcpy_s(folder_node.data[3].key, "备忘");
	strcpy_s(folder_node.data[3].val, "MEMOTEXT");

	strcpy_s(folder_node.index.NAME, "军火商3");
	//strcpy_s(folder_node.property_table_name, "军火商3_60_PROPERTY");
	folder_node.data_num = 4;
	folder_node.PID = 1;
	folder_node.index.ID = 57;

	return folder_node;
}


FOLDER_NODE getNode1()
{
	FOLDER_NODE folder_node;
	strcpy_s(folder_node.data[0].key, "日期");
	strcpy_s(folder_node.data[0].val, "DATE");
	strcpy_s(folder_node.data[1].key, "addr");
	strcpy_s(folder_node.data[1].val, "String");
	strcpy_s(folder_node.data[2].key, "AGE");
	strcpy_s(folder_node.data[2].val, "INTEGER");
	strcpy_s(folder_node.data[3].key, "备忘");
	strcpy_s(folder_node.data[3].val, "MEMOTEXT");

	strcpy_s(folder_node.index.NAME, "军火商5");
	//strcpy_s(folder_node.property_table_name, "军火商3_60_PROPERTY");
	folder_node.data_num = 4;
	folder_node.PID = 58;
	folder_node.index.ID = -1;

	return folder_node;
}


FILE_NODE getInsertNode()
{
	FILE_NODE file_node;
	strcpy_s(file_node.data[0].key, "年龄");
	strcpy_s(file_node.data[0].val, "12");
	strcpy_s(file_node.data[1].key, "身高");
	strcpy_s(file_node.data[1].val, "175cm");
	strcpy_s(file_node.data[2].key, "性别");
	strcpy_s(file_node.data[2].val, "男");
	strcpy_s(file_node.data[3].key, "出生日期");
	strcpy_s(file_node.data[3].val, "19910523");
	strcpy_s(file_node.index.NAME, "商人1");
	file_node.data_num = 4;
	file_node.PID = 58;
	file_node.index.ID = -1;

	return file_node;
}


void test1()
{
	IMVL_CreateFolderTable();
}


void test2()
{
	TREENODE node;
	IMVL_LoadDataUnit(&node, "INDEX_TABLE", 1);
}

void test3()
{
	TREENODE newnode = getNode1();
	TREENODE oldnode = getNode2();

	IMVL_CopyNode(&newnode, oldnode);
}


void test4()
{
	int ret = IMVL_Delete(31);
}

void test5()
{
	TREENODE newnode = getNode1();
	IMVL_CreateFolder(newnode);
}

void test6()
{
	int id;
	id = IMVL_GetLastId("INDEX_TABLE");
}

void test7()
{
	int ret;
	ret = IMVL_IsEmptyFolder(32);
}

void test8()
{
	time_t now_time= time(NULL);;
	char tmp[64];   
	strftime( tmp, sizeof(tmp), "%Y_%m_%d_%H_%M_%S", localtime(&now_time) );
}

#define IMVL_TRY_BLOCK_BEGIN		\
	try {                               


#define IMVL_TRY_BLOCK_END(ret)		\
}catch(_com_error& e){				\
	return ret;						\
}								


// #define CV_TS_TRY_BLOCK_BEGIN                   \
// 	try {
// 
// #define CV_TS_TRY_BLOCK_END                     \
// } catch( int _code ) {                      \
// 	ts->set_failed_test_info( _code );      \
// }
// 
// #define CV_TS_TRY_BLOCK_BEGIN                   \
// {                                           \
// 	int _code = setjmp( cv_ts_jmp_mark );   \
// 	if( !_code ) {
// 
// #define CV_TS_TRY_BLOCK_END                     \
// 	}                                       \
// 		else  {                                 \
// 		ts->set_failed_test_info( _code );  \
// }                                       \
// }
// 
// CV_TS_TRY_BLOCK_BEGIN;
// 
// run( start_from );
// 
// CV_TS_TRY_BLOCK_END;


int test9()
{
	char* c = NULL;
	sprintf_s(c, "%s", "asdf");
	return 1;
}

int testTryCatMacro()
{
	IMVL_TRY_BLOCK_BEGIN
		test9();
	IMVL_TRY_BLOCK_END(0);
}*/

void testAdd()
{
	INDEX_NODE node;
	int id = 1;
	node.IsFolder = 1;
	strcpy_s(node.name, "wust");
	strcpy_s(node.content, "<name>Name</name><url>Address</url>");
	IMVL_Create(id, &node);
}


void testUpdate()
{
	int id = 155;
	INDEX_NODE newNode;
	IMVL_GetNode(id, &newNode);
	strcpy_s(newNode.content, "<name>LJX</name><url>https://yaoyaochecknow.com</url>");

	IMVL_Update(&newNode);
}


void testDelete()
{
	int id = 156;
	IMVL_Delete(id);
}

/*
void testSearch()
{
	CString keyWord;
	IMVL_Search(keyWord);
}
*/

void Ctest_ado_mfcDlg::OnBnClickedButton1()
{
	testUpdate();
}

