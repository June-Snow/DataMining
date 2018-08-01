// OpenMsgDlg.cpp : 实现文件
//

#include "stdafx.h"
#include "SuiShouJi.h"
#include "OpenMsgDlg.h"
#include "afxdialogex.h"
#include "SuiShouJiDlg.h"

#include "DBSDK.h"
#include <io.h>
#include <odbcinst.h>
#include <afxdb.h>
#include <odbcinst.h>
#include "InitializeCtrl.h"
#include "Export.h"
#include "CApplication.h"
#include "CRange.h"
#include "CWorkbook.h"
#include "CWorkbooks.h"
#include "CWorksheet.h"
#include "CWorksheets.h"
#include "CApplication0.h"

#include "AddMsgDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

// COpenMsgDlg 对话框

IMPLEMENT_DYNAMIC(COpenMsgDlg, CDialogEx)

COpenMsgDlg::COpenMsgDlg(CWnd* pParent /*=NULL*/)
	: CDialogEx(COpenMsgDlg::IDD, pParent)
{
	
}



COpenMsgDlg::~COpenMsgDlg()
{
}

void COpenMsgDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_LIST1, m_programLangList);
	DDX_Control(pDX, IDC_BUTTON3, m_AddButton);
	DDX_Control(pDX, IDC_BUTTON4, m_DeleteButton);
	DDX_Control(pDX, IDC_BUTTON5, m_LeftButton);
	DDX_Control(pDX, IDC_BUTTON6, m_RightButton);
	DDX_Control(pDX, IDC_EDIT2, m_edit);
	DDX_Control(pDX, IDC_STATIC1, m_static);
	DDX_Control(pDX, IDC_STATIC100, m_title);
}

BOOL COpenMsgDlg::OnInitDialog()
{
	CDialogEx::OnInitDialog();
	TextFont.CreatePointFont(110,_T("微软雅黑"));
	TitleFont.CreatePointFont(120,_T("微软雅黑"));
	NameFont.CreatePointFont(110,_T("黑体"));
	int i,j,maxnum;	
	CString strnum;
	//HICON hIcon1=theApp.LoadIcon(IDI_ICON4); 
	//m_AddButton.SetIcon(hIcon1);
	//HICON hIcon2=theApp.LoadIcon(IDI_ICON3); 
	//m_DeleteButton.SetIcon(hIcon2);
	//HICON hIcon3=theApp.LoadIcon(IDI_ICON5); 
	//m_LeftButton.SetIcon(hIcon3);
	//HICON hIcon4=theApp.LoadIcon(IDI_ICON6); 
	//m_RightButton.SetIcon(hIcon4);
	int sel_no=atoi(sql_text);
	m_programLangList.SetFont(&TextFont);
	m_programLangList.GetHeaderCtrl()->SetFont(&TitleFont);
	IMVL_GetNode(sel_no,&index1);
	int msg = InitializeExcelList(&m_programLangList,sel_no);	
	SetDlgItemText(IDC_EDIT3,_T("1"));
	this->GetDlgItem(IDC_STATIC)->SetFont(&NameFont);
	m_title.SetWindowTextA(index1.name);
	m_title.SetFont(&NameFont);
	maxnum = m_programLangList.GetItemCount();
	/*if (m_programLangList.GetItemCount()==20)
	{
	m_RightButton.EnableWindow(TRUE);
	}	*/
	strnum.Format("%d",maxnum);	
	CString static_text=_T("共有");		
	static_text+=strnum+_T("条数据");	
	m_static.SetWindowTextA(static_text);	
	m_static.SetFont(&TextFont);
	return TRUE;

}


BEGIN_MESSAGE_MAP(COpenMsgDlg, CDialogEx)
	ON_BN_CLICKED(IDC_BUTTON3, &COpenMsgDlg::OnInsertMsg)
	ON_BN_CLICKED(IDC_BUTTON4, &COpenMsgDlg::OnBnDelete)
	ON_NOTIFY(NM_CLICK, IDC_LIST1, &COpenMsgDlg::OnNMClickList1)
	ON_NOTIFY(LVN_ITEMCHANGED, IDC_LIST1, &COpenMsgDlg::OnLvnItemchangedList1)
	ON_BN_CLICKED(IDC_BUTTON5, &COpenMsgDlg::OnBnClickedButton5)
	ON_BN_CLICKED(IDC_BUTTON2, &COpenMsgDlg::OnBnBack)
	ON_BN_CLICKED(IDC_BUTTON6, &COpenMsgDlg::OnBnClickedButton6)
	ON_BN_CLICKED(IDC_BUTTON1, &COpenMsgDlg::OnBnClickedButton1)
	ON_STN_CLICKED(IDC_STATIC1, &COpenMsgDlg::OnStnClickedStatic1)
	ON_STN_CLICKED(IDC_STATIC100, &COpenMsgDlg::OnStnClickedStatic100)
END_MESSAGE_MAP()


// COpenMsgDlg 消息处理程序


void COpenMsgDlg::OnInsertMsg()   //增加按钮响应事件
{
	// TODO: 在此添加控件通知处理程序代码
	/*AddMsgDlg dlg;	
	dlg.selectno = atoi(sql_text);	
	dlg.isfresh = isFresh;	
	dlg.isedit=0;
	dlg.DoModal();	  
	this->ShowWindow(1);*/
}


void COpenMsgDlg::OnBnDelete()  //删除按钮响应事件
{   
	 
}
	   



void COpenMsgDlg::OnNMClickList1(NMHDR *pNMHDR, LRESULT *pResult)
{
	LPNMITEMACTIVATE pNMItemActivate = reinterpret_cast<LPNMITEMACTIVATE>(pNMHDR);
	// TODO: 在此添加控件通知处理程序代码	  
	NMLISTVIEW *pNMListView = (NMLISTVIEW*)pNMHDR;   

	if (-1 != pNMListView->iItem)        // 如果iItem不是-1，就说明有列表项被选择   
	{   
		// 获取被选择列表项第一个子项的文本   
		strLangName = m_programLangList.GetItemText(pNMListView->iItem, 0);	
		selItem=pNMListView->iItem;
	}   
	*pResult = 0;
}


void COpenMsgDlg::OnLvnItemchangedList1(NMHDR *pNMHDR, LRESULT *pResult)
{
	LPNMLISTVIEW pNMLV = reinterpret_cast<LPNMLISTVIEW>(pNMHDR);
	// TODO: 在此添加控件通知处理程序代码
	*pResult = 0;
}



void COpenMsgDlg::OnBnClickedButton5()      //向前翻一页
{
	// TODO: 在此添加控件通知处理程序代码
	int i,j,maxnum;
	int page,msg;
	CString  num,strnum;
	GetDlgItemText(IDC_EDIT3,num);	
	page = atoi(num)-1;
	msg=InitializeListCtrl(&m_programLangList,atoi(sql_text),page);
	maxnum = m_programLangList.GetItemCount();
	if (page==1)
	{
		m_LeftButton.EnableWindow(FALSE);
	} 
	else
	{
		m_LeftButton.EnableWindow(TRUE);
	}
	m_RightButton.EnableWindow(TRUE);
	num.Format("%d",page);
	SetDlgItemText(IDC_EDIT3,num);
	strnum.Format("%d",maxnum);	
	CString static_text=_T("共有");		
	static_text+=strnum+_T("条数据");	
	SetDlgItemText(IDC_EDIT2, static_text);
}

void COpenMsgDlg::OnOK()
{ //里面什么也不写
}


void COpenMsgDlg::OnBnBack()    //返回按钮的响应
{
	// TODO: 在此添加控件通知处理程序代码
}


void COpenMsgDlg::OnBnClickedButton6()  //向后翻一页
{
	// TODO: 在此添加控件通知处理程序代码
	int page,msg,maxnum;
	CString  num,strnum;
	GetDlgItemText(IDC_EDIT3,num);
	page = atoi(num)+1;
	msg=InitializeListCtrl(&m_programLangList,atoi(sql_text),page);
	maxnum = m_programLangList.GetItemCount();
	if (maxnum==20)
	{
		m_RightButton.EnableWindow(TRUE);
	}
	else{
		m_RightButton.EnableWindow(FALSE);
	}
	m_LeftButton.EnableWindow(TRUE);
	num.Format("%d",page);
	SetDlgItemText(IDC_EDIT3,num);
	strnum.Format("%d",maxnum);	
	CString static_text=_T("共有");		
	static_text+=strnum+_T("条数据");	
	SetDlgItemText(IDC_EDIT2, static_text);
}

static void   GetCellName(int nRow, int nCol, CString &strName)
{
	CString strRow;
	char cCell = (char)('A' + nCol - 1);

	strName.Format(_T("%c"), cCell);
	strRow.Format(_T( "%d "), nRow);
	strName += strRow;
}

void COpenMsgDlg::OnBnClickedButton1()  //单张表的导出
{
	// TODO: 在此添加控件通知处理程序代码
	//CListCtrlToExcel(&m_programLangList,_T("数据表"));
	CFileDialog FileDialog(FALSE,_T("xls"),NULL,OFN_HIDEREADONLY|OFN_OVERWRITEPROMPT, _T("Microsoft Excel 2000(*.xls)|*.xls|所有文件(*.*)"),this);

	//if(FileDialog.DoModal()!=IDOK)   
	//{  
	//	return;   
	//}  
	CString cStrFile;//=FileDialog.GetPathName();  //选择保存路径名称  
	CString sDriver;
	//检索是否安装有Excel驱动 "Microsoft Excel Driver (*.xls)"//
	sDriver = GetExcelDriver();
	if(sDriver.IsEmpty())
	{
		//没有发现Excel驱动
		AfxMessageBox(_T("没有安装Excel!\n请先安装Excel软件才能使用导出功能!"));
		return;
	}

	//默认文件名
	INDEX_NODE indexnode;
	IMVL_GetNode(atoi(sql_text),&indexnode);
	CString strhTtem = indexnode.name;
	if(!GetDefaultFileName(cStrFile, strhTtem, _T("xls")))
		return;

	if(::PathFileExists(cStrFile))   
		DeleteFile(cStrFile);   

	//CString cStrFile = _T("E:\\myexcel.xls");  
	COleVariant covTrue((short)TRUE),covFalse((short)FALSE),covOptional((long)DISP_E_PARAMNOTFOUND,VT_ERROR);  

	CApplication0 app; //Excel程序  
	CWorkbooks books; //工作簿集合  
	CWorkbook book;  //工作表  
	CWorksheets sheets;  //工作簿集合  
	CWorksheet sheet; //工作表集合  
	CRange range; //使用区域  

	//CoUninitialize();  

	book.PrintPreview(_variant_t(false));  
	//if(CoInitialize(NULL)==S_FALSE)   
	//{  
	//	//MessageBox(_T("初始化COM支持库失败！"));  
	//	return;  
	//}  

	if(!app.CreateDispatch(_T("Excel.Application"))); //创建IDispatch接口对象  
	{  
		//MessageBox(_T("Error!"));  

	}  


	books = app.get_Workbooks();  
	
	book = books.Add(covOptional);  


	sheets = book.get_Worksheets();  
	sheet = sheets.get_Item(COleVariant((short)1));  //得到第一个工作表  

	CHeaderCtrl   *pmyHeaderCtrl= m_programLangList.GetHeaderCtrl(); //获取表头  

	int   m_cols   = pmyHeaderCtrl-> GetItemCount(); //获取列数  
	int   m_rows = m_programLangList.GetItemCount();  //获取行数  


	TCHAR     lpBuffer[256];      

	HDITEM   hdi; //This structure contains information about an item in a header control. This structure has been updated to support header item images and order values.  
	hdi.mask   =   HDI_TEXT;  
	hdi.pszText   =   lpBuffer;  
	hdi.cchTextMax   =   256;   

	CString   colname;  
	CString strTemp;  

	int   iRow,iCol;  
	for(iCol=0;   iCol <m_cols;   iCol++)//将列表的标题头写入EXCEL   
	{   
		GetCellName(1 ,iCol + 1, colname); //(colname就是对应表格的A1,B1,C1,D1)  

		range   =   sheet.get_Range(COleVariant(colname),COleVariant(colname));    

		pmyHeaderCtrl-> GetItem(iCol,   &hdi); //获取表头每列的信息  

		range.put_Value2(COleVariant(hdi.pszText));  //设置每列的内容  

		int   nWidth   =   m_programLangList.GetColumnWidth(iCol)/6;   

		//得到第iCol+1列     
		range.AttachDispatch(range.get_Item(_variant_t((long)(iCol+1)),vtMissing).pdispVal,true);     

		//设置列宽    
		range.put_ColumnWidth(_variant_t((long)nWidth));  

	}   

	range   =   sheet.get_Range(COleVariant( _T("A1 ")),   COleVariant(colname));   

	range.put_RowHeight(_variant_t((long)20));//设置行的高度   


	range.put_VerticalAlignment(COleVariant((short)-4108));//xlVAlignCenter   =   -4108   

	COleSafeArray   saRet; //COleSafeArray类是用于处理任意类型和维数的数组的类  
	DWORD   numElements[]={m_rows,m_cols};       //行列写入数组  
	saRet.Create(VT_BSTR,   2,   numElements); //创建所需的数组  

	range = sheet.get_Range(COleVariant( _T("A2 ")),covOptional); //从A2开始  
	range = range.get_Resize(COleVariant((short)m_rows),COleVariant((short)m_cols)); //表的区域  

	long   index[2];    

	for(   iRow   =   1;   iRow   <=   m_rows;   iRow++)//将列表内容写入EXCEL   
	{   
		for   (   iCol   =   1;   iCol   <=   m_cols;   iCol++)    
		{   
			index[0]=iRow-1;   
			index[1]=iCol-1;   

			CString   szTemp;   

			szTemp=m_programLangList.GetItemText(iRow-1,iCol-1); //取得m_list控件中的内容  

			BSTR   bstr   =   szTemp.AllocSysString(); //The AllocSysString method allocates a new BSTR string that is Automation compatible  

			saRet.PutElement(index,bstr); //把m_list控件中的内容放入saRet  

			SysFreeString(bstr);  
		}   
	}    
	range.put_Value2(COleVariant(saRet)); //将得到的数据的saRet数组值放入表格  
	book.SaveCopyAs(COleVariant(cStrFile)); //保存到cStrFile文件  
	book.put_Saved(true);  

	books.Close();  

	//  
	book.ReleaseDispatch();  
	books.ReleaseDispatch();   

	app.ReleaseDispatch();  
	app.Quit();  

	
}




void COpenMsgDlg::OnStnClickedStatic1()
{
	// TODO: 在此添加控件通知处理程序代码
}


BOOL COpenMsgDlg::PreTranslateMessage(MSG* pMsg)    
{  
	if(pMsg->message==WM_KEYDOWN   &&   pMsg->wParam==VK_ESCAPE)     return   TRUE;  
	if(pMsg->message==WM_KEYDOWN   &&   pMsg->wParam==VK_RETURN)   return   TRUE;    
	else    
		return   CDialog::PreTranslateMessage(pMsg);  
}

void COpenMsgDlg::OnStnClickedStatic100()
{
	// TODO: 在此添加控件通知处理程序代码
}


void COpenMsgDlg::OnCancel()
{
	// TODO: 在此添加专用代码和/或调用基类

	CDialogEx::OnCancel();
}
