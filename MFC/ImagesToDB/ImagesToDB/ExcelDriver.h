#include <afxcontrolbars.h>
#include "stdafx.h"
#include <odbcinst.h>
#include <io.h>
#include <afxdb.h>
#include "afxdialogex.h"
#include "excelExport.h"
#include <vector>

CString GetExcelDriver();
BOOL MakeSurePathExists(CString &Path, bool FileNameInclude = true);
BOOL GetDefaultXlsFileName(CString& sExcelFile);
void GridCtrlToExcel(CString &strPath, std::vector<std::vector< CString> > dataArray, int startNum, int endNum);

void AddGridCtrlToExcel(CString path, std::vector<std::vector< CString> > dataArray, int startNum, int endNum);

/////////////////////////////////////////////////////////////////////////
//���ƣ�GetExcelDriver
//���ܣ���ȡODBC��Excel����
//���ڣ�2014-3-5
/////////////////////////////////////////////////////////////////////////
CString GetExcelDriver()
{
	char szBuf[2001];
	WORD cbBufMax = 2000;
	WORD cbBufOut;
	char *pszBuf = szBuf;
	CString sDriver;

	//��ȡ�Ѱ�װ����������(������odbcinst.h��)
	if(!SQLGetInstalledDrivers(szBuf,cbBufMax,&cbBufOut))
		return "";

	//�����Ѱ�װ�������Ƿ���Excel...
	do 
	{
		if(strstr(pszBuf,"Excel") != 0)			
		{
			//����!
			sDriver = CString(pszBuf);
			break;
		}
		pszBuf=strchr(pszBuf,'\0') + 1;
	} while (pszBuf[1]!='\0');

	return sDriver;
}

///////////////////////////////////////////////////////////////////////////////////
//���ƣ�BOOL MakeSurePathExists(CString &Path , bool FilenameIncluded)
//������
//    Path                   ·��
//    FilenameIncluded       ·���Ƿ�����ļ���
//����ֵ��
//    �ļ��Ƿ����
//˵����
//    �ж�Path�ļ�(FilenameIncluded = true)�Ƿ���ڣ����ڷ���TRUE�������ڷ���FALSE
//    �Զ�����Ŀ¼
//
///////////////////////////////////////////////////////////////////////////////////
BOOL MakeSurePathExists(CString &Path , bool FilenameIncluded)
{
	int Pos=0;
	while((Pos=Path.Find('\\',Pos+1))!=-1)
		CreateDirectory(Path.Left(Pos),NULL);
	if(!FilenameIncluded)
		CreateDirectory(Path,NULL);
	//return ((!FilenameIncluded)?=_access(Path,0):
	//!_access(Path.Left(Path.ReverseFind('\\')),0);

	return !_access(Path,0);
}

/////////////////////////////////////////////////////
//���ƣ�GetDefaultXlsFileName(CString& sExcelFile)
//���ܣ����Ĭ���ļ���
/////////////////////////////////////////////////////
BOOL GetDefaultXlsFileName(CString& sExcelFile)
{
	//Ĭ���ļ�����yyyymmddmmss.xls
	CString timeStr;
	CTime day;
	day=CTime::GetCurrentTime();
	int filenameday,filenamemonth,filenameyear,filehour,filemin,filesec;
	filenameday   = day.GetDay();    //dd��
	filenamemonth = day.GetMonth();  //mm�·�
	filenameyear  = day.GetYear();   //yyyy���
	filehour      = day.GetHour();   //hhСʱ
	filemin       = day.GetMinute(); //mm����
	filesec       = day.GetSecond(); //ss��
	timeStr.Format("%04d%02d%02d%02d%02d%02d",filenameyear,filenamemonth,filenameday,filehour,filemin,filesec);

	sExcelFile = timeStr + ".xls";
	// prompt the user (with all document templates)
	CFileDialog dlgFile(FALSE,"*.xls",sExcelFile,OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT,_T("Excel ������(*.xls)|*.xls|�����ļ�(*.*)|*.*||"));
	dlgFile.m_ofn.lpstrTitle = "����";

	if(dlgFile.DoModal()==IDOK)
	{
		sExcelFile = dlgFile.GetPathName();
		sExcelFile.ReleaseBuffer();
		if(MakeSurePathExists(sExcelFile))
		{
			if(!DeleteFile(sExcelFile))
			{
				MessageBox(NULL,"�����ļ�ʱ����,���ļ�����ռ��!","��ʾ",MB_OK);
				return FALSE;
			}
		}
		return TRUE;
	}
	return FALSE;
}

static void   GetCellName(int nRow, int nCol, CString &strName)
{
	CString strRow;
	char cCell = (char)('A' + nCol - 1);

	strName.Format(_T("%c"), cCell);
	strRow.Format(_T( "%d "), nRow);
	strName += strRow;
}
//////////////////////////////////////////////////////////////////////////////
//	������void CListCtrlToExcel(CListCtrl* pList, CString strTitle)
//	������
//		pList		��Ҫ������List�ؼ�ָ��
//		strTitle	���������ݱ����
//	˵��:
//		����CListCtrl�ؼ���ȫ�����ݵ�Excel�ļ���Excel�ļ������û�ͨ�������Ϊ��
//		�Ի�������ָ����������ΪstrTitle�Ĺ�������List�ؼ��ڵ��������ݣ�����
//		��������������ı�����ʽ���浽Excel�������С��������й�ϵ��
//	
//////////////////////////////////////////////////////////////////////////////
void GridCtrlToExcel(CString &strPath, std::vector<std::vector< CString> > dataArray, int startNum, int endNum)
{
	//�����Ƿ�װ��Excel���� "Microsoft Excel Driver (*.xls)"
	if (!strPath.IsEmpty())
	{
		AddGridCtrlToExcel(strPath, dataArray, startNum, endNum);
		return;
	}
	CString sDriver;
	sDriver = GetExcelDriver();
	if(sDriver.IsEmpty())
	{
		AfxMessageBox("û�а�װExcel!\n���Ȱ�װExcel�������ʹ�õ�������!");
		return;
	}

	CString cStrFile;//=FileDialog.GetPathName();  //ѡ�񱣴�·������  
	if(!GetDefaultXlsFileName(cStrFile))
		return;

	if(::PathFileExists(cStrFile))   
		DeleteFile(cStrFile);   
	strPath = cStrFile;

	COleVariant covTrue((short)TRUE),covFalse((short)FALSE),covOptional((long)DISP_E_PARAMNOTFOUND,VT_ERROR);  

	CApplicationExcel app; //Excel����  
	CString iii = app.get_Version();

	CWorkbooksExcel books; //����������  
	CWorkbookExcel book;  //������  
	CWorksheetsExcel sheets;  //����������  
	CWorksheetExcel sheet; //��������  
	CRangeExcel range; //ʹ������  

	CoUninitialize();  

	book.PrintPreview(_variant_t(false));  
	if(CoInitialize(NULL)==S_FALSE)   //if (!SUCCEEDED(::CoInitialize()))
	{  
		AfxMessageBox(_T("��ʼ��COM֧�ֿ�ʧ�ܣ�"));  
		return;  
	}  
	if(!app.CreateDispatch(_T("Excel.Application")))//����IDispatch�ӿڶ���  
	{  
		//MessageBox(_T("Error!"));  
	}  
	books = app.get_Workbooks();  
	book = books.Add(covOptional);  
	sheets = book.get_Worksheets();  
	sheet = sheets.get_Item(COleVariant((short)1));  //�õ���һ��������  


	std::vector<CString> dataRow;
	dataRow = dataArray[0];

	int   m_cols   = dataRow.size(); //��ȡ����  
	int   m_rows = endNum-startNum+1;  //��ȡ����      

	CString   colname;  
	CString strTemp;  

	int   iRow,iCol;  
	for(iCol=0;   iCol <m_cols;   iCol++)//���б�ı���ͷд��EXCEL   
	{   
		GetCellName(1 ,iCol + 1, colname); //(colname���Ƕ�Ӧ����A1,B1,C1,D1)  
		range   =   sheet.get_Range(COleVariant(colname),COleVariant(colname));    
		CString hdi = dataRow[iCol];
		range.put_Value2(COleVariant(hdi));  //����ÿ�е�����  
		int   nWidth   = 20;   
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
		dataRow = dataArray[iRow+startNum-1];
		for   (   iCol   =   1;   iCol   <=   m_cols;   iCol++)    
		{   
			index[0]=iRow-1;   
			index[1]=iCol-1;   

			CString   szTemp;   

			szTemp=dataRow[iCol-1]; //ȡ��m_list�ؼ��е�����  

			BSTR   bstr   =   szTemp.AllocSysString(); //The AllocSysString method allocates a new BSTR string that is Automation compatible  

			saRet.PutElement(index,bstr); //��m_list�ؼ��е����ݷ���saRet  

			SysFreeString(bstr);  
		}   
	}    

	range.put_Value2(COleVariant(saRet)); //���õ������ݵ�saRet����ֵ������  
	book.SaveCopyAs(COleVariant(cStrFile)); //���浽cStrFile�ļ�  
	book.put_Saved(true);  
	books.Close(); 
	book.ReleaseDispatch();  
	books.ReleaseDispatch();   
	app.ReleaseDispatch();  
	app.Quit();  
}

void AddGridCtrlToExcel(CString path, std::vector<std::vector< CString> > dataArray, int startNum, int endNum)
{

 CApplicationExcel app;    
 CWorkbooksExcel books;
 CWorkbookExcel book;
 CWorksheetsExcel sheets;
 CWorksheetExcel sheet;
 CRangeExcel range;


 LPDISPATCH lpDisp;    
 COleVariant vResult;
 COleVariant
        covTrue((short)TRUE),
        covFalse((short)FALSE),
        covOptional((long)DISP_E_PARAMNOTFOUND, VT_ERROR);    
 
 //*****
 //����Excel 2000������(����Excel)
 if(!app.CreateDispatch("Excel.Application")) 
 {
	AfxMessageBox("�޷�����Excel������!");
    return;
 }
 
 //*****   
 //��c:/1.xls
 books.AttachDispatch(app.get_Workbooks());
 lpDisp = books.Open(path,      
   covOptional, covOptional, covOptional, covOptional, covOptional,
   covOptional, covOptional, covOptional, covOptional, covOptional,
   covOptional, covOptional , covOptional, covOptional);      
 //*****
 //�õ�Workbook
 book.AttachDispatch(lpDisp);
 //*****
 //�õ�Worksheets 
 sheets.AttachDispatch(book.get_Worksheets()); 
 //*****
 //�õ���ǰ��Ծsheet
 //����е�Ԫ�������ڱ༭״̬�У��˲������ܷ��أ���һֱ�ȴ�
 lpDisp=book.get_ActiveSheet();
 sheet.AttachDispatch(lpDisp); 
 //*****
 //��ȡ�Ѿ�ʹ���������Ϣ�������Ѿ�ʹ�õ���������������ʼ�С���ʼ��
 CRangeExcel usedRange;
 usedRange.AttachDispatch(sheet.get_UsedRange());
 range.AttachDispatch(usedRange.get_Rows());
 long iRowNum=range.get_Count();                   //�Ѿ�ʹ�õ�����
 
 range.AttachDispatch(usedRange.get_Columns());
 long iColNum=range.get_Count();                   //�Ѿ�ʹ�õ�����
  
 long iStartRow=usedRange.get_Row();               //��ʹ���������ʼ�У���1��ʼ
 long iStartCol=usedRange.get_Column();            //��ʹ���������ʼ�У���1��ʼ
  
 std::vector<CString> dataRow;
 dataRow = dataArray[0];

 int   m_cols   = dataRow.size(); //��ȡ����  
 int   m_rows = endNum-startNum+1;  //��ȡ����      
 CString str;
 range.AttachDispatch(sheet.get_Cells(),TRUE);
 for(int iRow   =  iRowNum+1;   iRow   <=   iRowNum+m_rows;   iRow++)//���б�����д��EXCEL   
 {   
	 dataRow = dataArray[iRow+startNum-1];
	 for   (int iCol   =   1;   iCol   <=   m_cols;   iCol++)    
	 {   
		 str = dataRow[iCol-1];
		 range.put_Item(COleVariant((long)iRow),COleVariant((long)iCol),COleVariant((CString)str));//_variant_t((long)(iRow)),_variant_t((long)(iCol)),_variant_t((CString)str)
	 }   
 }    
 
 book.Save();
 range.ReleaseDispatch(); 
 sheet.ReleaseDispatch(); 
 sheets.ReleaseDispatch();
 book.ReleaseDispatch(); 
 books.Close();   
 books.ReleaseDispatch();
 book.ReleaseDispatch(); 
 app.Quit();   
 app.ReleaseDispatch(); 
}