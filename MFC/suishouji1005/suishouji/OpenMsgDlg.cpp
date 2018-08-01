// OpenMsgDlg.cpp : ʵ���ļ�
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

// COpenMsgDlg �Ի���

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
	TextFont.CreatePointFont(110,_T("΢���ź�"));
	TitleFont.CreatePointFont(120,_T("΢���ź�"));
	NameFont.CreatePointFont(110,_T("����"));
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
	CString static_text=_T("����");		
	static_text+=strnum+_T("������");	
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


// COpenMsgDlg ��Ϣ�������


void COpenMsgDlg::OnInsertMsg()   //���Ӱ�ť��Ӧ�¼�
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	/*AddMsgDlg dlg;	
	dlg.selectno = atoi(sql_text);	
	dlg.isfresh = isFresh;	
	dlg.isedit=0;
	dlg.DoModal();	  
	this->ShowWindow(1);*/
}


void COpenMsgDlg::OnBnDelete()  //ɾ����ť��Ӧ�¼�
{   
	 
}
	   



void COpenMsgDlg::OnNMClickList1(NMHDR *pNMHDR, LRESULT *pResult)
{
	LPNMITEMACTIVATE pNMItemActivate = reinterpret_cast<LPNMITEMACTIVATE>(pNMHDR);
	// TODO: �ڴ���ӿؼ�֪ͨ����������	  
	NMLISTVIEW *pNMListView = (NMLISTVIEW*)pNMHDR;   

	if (-1 != pNMListView->iItem)        // ���iItem����-1����˵�����б��ѡ��   
	{   
		// ��ȡ��ѡ���б����һ��������ı�   
		strLangName = m_programLangList.GetItemText(pNMListView->iItem, 0);	
		selItem=pNMListView->iItem;
	}   
	*pResult = 0;
}


void COpenMsgDlg::OnLvnItemchangedList1(NMHDR *pNMHDR, LRESULT *pResult)
{
	LPNMLISTVIEW pNMLV = reinterpret_cast<LPNMLISTVIEW>(pNMHDR);
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	*pResult = 0;
}



void COpenMsgDlg::OnBnClickedButton5()      //��ǰ��һҳ
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
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
	CString static_text=_T("����");		
	static_text+=strnum+_T("������");	
	SetDlgItemText(IDC_EDIT2, static_text);
}

void COpenMsgDlg::OnOK()
{ //����ʲôҲ��д
}


void COpenMsgDlg::OnBnBack()    //���ذ�ť����Ӧ
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
}


void COpenMsgDlg::OnBnClickedButton6()  //���һҳ
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
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
	CString static_text=_T("����");		
	static_text+=strnum+_T("������");	
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

void COpenMsgDlg::OnBnClickedButton1()  //���ű�ĵ���
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	//CListCtrlToExcel(&m_programLangList,_T("���ݱ�"));
	CFileDialog FileDialog(FALSE,_T("xls"),NULL,OFN_HIDEREADONLY|OFN_OVERWRITEPROMPT, _T("Microsoft Excel 2000(*.xls)|*.xls|�����ļ�(*.*)"),this);

	//if(FileDialog.DoModal()!=IDOK)   
	//{  
	//	return;   
	//}  
	CString cStrFile;//=FileDialog.GetPathName();  //ѡ�񱣴�·������  
	CString sDriver;
	//�����Ƿ�װ��Excel���� "Microsoft Excel Driver (*.xls)"//
	sDriver = GetExcelDriver();
	if(sDriver.IsEmpty())
	{
		//û�з���Excel����
		AfxMessageBox(_T("û�а�װExcel!\n���Ȱ�װExcel�������ʹ�õ�������!"));
		return;
	}

	//Ĭ���ļ���
	INDEX_NODE indexnode;
	IMVL_GetNode(atoi(sql_text),&indexnode);
	CString strhTtem = indexnode.name;
	if(!GetDefaultFileName(cStrFile, strhTtem, _T("xls")))
		return;

	if(::PathFileExists(cStrFile))   
		DeleteFile(cStrFile);   

	//CString cStrFile = _T("E:\\myexcel.xls");  
	COleVariant covTrue((short)TRUE),covFalse((short)FALSE),covOptional((long)DISP_E_PARAMNOTFOUND,VT_ERROR);  

	CApplication0 app; //Excel����  
	CWorkbooks books; //����������  
	CWorkbook book;  //������  
	CWorksheets sheets;  //����������  
	CWorksheet sheet; //��������  
	CRange range; //ʹ������  

	//CoUninitialize();  

	book.PrintPreview(_variant_t(false));  
	//if(CoInitialize(NULL)==S_FALSE)   
	//{  
	//	//MessageBox(_T("��ʼ��COM֧�ֿ�ʧ�ܣ�"));  
	//	return;  
	//}  

	if(!app.CreateDispatch(_T("Excel.Application"))); //����IDispatch�ӿڶ���  
	{  
		//MessageBox(_T("Error!"));  

	}  


	books = app.get_Workbooks();  
	
	book = books.Add(covOptional);  


	sheets = book.get_Worksheets();  
	sheet = sheets.get_Item(COleVariant((short)1));  //�õ���һ��������  

	CHeaderCtrl   *pmyHeaderCtrl= m_programLangList.GetHeaderCtrl(); //��ȡ��ͷ  

	int   m_cols   = pmyHeaderCtrl-> GetItemCount(); //��ȡ����  
	int   m_rows = m_programLangList.GetItemCount();  //��ȡ����  


	TCHAR     lpBuffer[256];      

	HDITEM   hdi; //This structure contains information about an item in a header control. This structure has been updated to support header item images and order values.  
	hdi.mask   =   HDI_TEXT;  
	hdi.pszText   =   lpBuffer;  
	hdi.cchTextMax   =   256;   

	CString   colname;  
	CString strTemp;  

	int   iRow,iCol;  
	for(iCol=0;   iCol <m_cols;   iCol++)//���б�ı���ͷд��EXCEL   
	{   
		GetCellName(1 ,iCol + 1, colname); //(colname���Ƕ�Ӧ����A1,B1,C1,D1)  

		range   =   sheet.get_Range(COleVariant(colname),COleVariant(colname));    

		pmyHeaderCtrl-> GetItem(iCol,   &hdi); //��ȡ��ͷÿ�е���Ϣ  

		range.put_Value2(COleVariant(hdi.pszText));  //����ÿ�е�����  

		int   nWidth   =   m_programLangList.GetColumnWidth(iCol)/6;   

		//�õ���iCol+1��     
		range.AttachDispatch(range.get_Item(_variant_t((long)(iCol+1)),vtMissing).pdispVal,true);     

		//�����п�    
		range.put_ColumnWidth(_variant_t((long)nWidth));  

	}   

	range   =   sheet.get_Range(COleVariant( _T("A1 ")),   COleVariant(colname));   

	range.put_RowHeight(_variant_t((long)20));//�����еĸ߶�   


	range.put_VerticalAlignment(COleVariant((short)-4108));//xlVAlignCenter   =   -4108   

	COleSafeArray   saRet; //COleSafeArray�������ڴ����������ͺ�ά�����������  
	DWORD   numElements[]={m_rows,m_cols};       //����д������  
	saRet.Create(VT_BSTR,   2,   numElements); //�������������  

	range = sheet.get_Range(COleVariant( _T("A2 ")),covOptional); //��A2��ʼ  
	range = range.get_Resize(COleVariant((short)m_rows),COleVariant((short)m_cols)); //�������  

	long   index[2];    

	for(   iRow   =   1;   iRow   <=   m_rows;   iRow++)//���б�����д��EXCEL   
	{   
		for   (   iCol   =   1;   iCol   <=   m_cols;   iCol++)    
		{   
			index[0]=iRow-1;   
			index[1]=iCol-1;   

			CString   szTemp;   

			szTemp=m_programLangList.GetItemText(iRow-1,iCol-1); //ȡ��m_list�ؼ��е�����  

			BSTR   bstr   =   szTemp.AllocSysString(); //The AllocSysString method allocates a new BSTR string that is Automation compatible  

			saRet.PutElement(index,bstr); //��m_list�ؼ��е����ݷ���saRet  

			SysFreeString(bstr);  
		}   
	}    
	range.put_Value2(COleVariant(saRet)); //���õ������ݵ�saRet����ֵ������  
	book.SaveCopyAs(COleVariant(cStrFile)); //���浽cStrFile�ļ�  
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
	// TODO: �ڴ���ӿؼ�֪ͨ����������
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
	// TODO: �ڴ���ӿؼ�֪ͨ����������
}


void COpenMsgDlg::OnCancel()
{
	// TODO: �ڴ����ר�ô����/����û���

	CDialogEx::OnCancel();
}
