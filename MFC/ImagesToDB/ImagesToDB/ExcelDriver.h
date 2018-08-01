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
//名称：GetExcelDriver
//功能：获取ODBC中Excel驱动
//日期：2014-3-5
/////////////////////////////////////////////////////////////////////////
CString GetExcelDriver()
{
	char szBuf[2001];
	WORD cbBufMax = 2000;
	WORD cbBufOut;
	char *pszBuf = szBuf;
	CString sDriver;

	//获取已安装驱动的名称(函数在odbcinst.h里)
	if(!SQLGetInstalledDrivers(szBuf,cbBufMax,&cbBufOut))
		return "";

	//检索已安装的驱动是否有Excel...
	do 
	{
		if(strstr(pszBuf,"Excel") != 0)			
		{
			//发现!
			sDriver = CString(pszBuf);
			break;
		}
		pszBuf=strchr(pszBuf,'\0') + 1;
	} while (pszBuf[1]!='\0');

	return sDriver;
}

///////////////////////////////////////////////////////////////////////////////////
//名称：BOOL MakeSurePathExists(CString &Path , bool FilenameIncluded)
//参数：
//    Path                   路径
//    FilenameIncluded       路径是否包含文件名
//返回值：
//    文件是否存在
//说明：
//    判断Path文件(FilenameIncluded = true)是否存在，存在返回TRUE，不存在返回FALSE
//    自动创建目录
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
//名称：GetDefaultXlsFileName(CString& sExcelFile)
//功能：获得默认文件名
/////////////////////////////////////////////////////
BOOL GetDefaultXlsFileName(CString& sExcelFile)
{
	//默认文件名：yyyymmddmmss.xls
	CString timeStr;
	CTime day;
	day=CTime::GetCurrentTime();
	int filenameday,filenamemonth,filenameyear,filehour,filemin,filesec;
	filenameday   = day.GetDay();    //dd天
	filenamemonth = day.GetMonth();  //mm月份
	filenameyear  = day.GetYear();   //yyyy年份
	filehour      = day.GetHour();   //hh小时
	filemin       = day.GetMinute(); //mm分钟
	filesec       = day.GetSecond(); //ss秒
	timeStr.Format("%04d%02d%02d%02d%02d%02d",filenameyear,filenamemonth,filenameday,filehour,filemin,filesec);

	sExcelFile = timeStr + ".xls";
	// prompt the user (with all document templates)
	CFileDialog dlgFile(FALSE,"*.xls",sExcelFile,OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT,_T("Excel 工作簿(*.xls)|*.xls|所有文件(*.*)|*.*||"));
	dlgFile.m_ofn.lpstrTitle = "导出";

	if(dlgFile.DoModal()==IDOK)
	{
		sExcelFile = dlgFile.GetPathName();
		sExcelFile.ReleaseBuffer();
		if(MakeSurePathExists(sExcelFile))
		{
			if(!DeleteFile(sExcelFile))
			{
				MessageBox(NULL,"覆盖文件时出错,该文件正被占用!","提示",MB_OK);
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
//	函数：void CListCtrlToExcel(CListCtrl* pList, CString strTitle)
//	参数：
//		pList		需要导出的List控件指针
//		strTitle	导出的数据表标题
//	说明:
//		导出CListCtrl控件的全部数据到Excel文件。Excel文件名由用户通过“另存为”
//		对话框输入指定。创建名为strTitle的工作表，将List控件内的所有数据（包括
//		列名和数据项）以文本的形式保存到Excel工作表中。保持行列关系。
//	
//////////////////////////////////////////////////////////////////////////////
void GridCtrlToExcel(CString &strPath, std::vector<std::vector< CString> > dataArray, int startNum, int endNum)
{
	//检索是否安装有Excel驱动 "Microsoft Excel Driver (*.xls)"
	if (!strPath.IsEmpty())
	{
		AddGridCtrlToExcel(strPath, dataArray, startNum, endNum);
		return;
	}
	CString sDriver;
	sDriver = GetExcelDriver();
	if(sDriver.IsEmpty())
	{
		AfxMessageBox("没有安装Excel!\n请先安装Excel软件才能使用导出功能!");
		return;
	}

	CString cStrFile;//=FileDialog.GetPathName();  //选择保存路径名称  
	if(!GetDefaultXlsFileName(cStrFile))
		return;

	if(::PathFileExists(cStrFile))   
		DeleteFile(cStrFile);   
	strPath = cStrFile;

	COleVariant covTrue((short)TRUE),covFalse((short)FALSE),covOptional((long)DISP_E_PARAMNOTFOUND,VT_ERROR);  

	CApplicationExcel app; //Excel程序  
	CString iii = app.get_Version();

	CWorkbooksExcel books; //工作簿集合  
	CWorkbookExcel book;  //工作表  
	CWorksheetsExcel sheets;  //工作簿集合  
	CWorksheetExcel sheet; //工作表集合  
	CRangeExcel range; //使用区域  

	CoUninitialize();  

	book.PrintPreview(_variant_t(false));  
	if(CoInitialize(NULL)==S_FALSE)   //if (!SUCCEEDED(::CoInitialize()))
	{  
		AfxMessageBox(_T("初始化COM支持库失败！"));  
		return;  
	}  
	if(!app.CreateDispatch(_T("Excel.Application")))//创建IDispatch接口对象  
	{  
		//MessageBox(_T("Error!"));  
	}  
	books = app.get_Workbooks();  
	book = books.Add(covOptional);  
	sheets = book.get_Worksheets();  
	sheet = sheets.get_Item(COleVariant((short)1));  //得到第一个工作表  


	std::vector<CString> dataRow;
	dataRow = dataArray[0];

	int   m_cols   = dataRow.size(); //获取列数  
	int   m_rows = endNum-startNum+1;  //获取行数      

	CString   colname;  
	CString strTemp;  

	int   iRow,iCol;  
	for(iCol=0;   iCol <m_cols;   iCol++)//将列表的标题头写入EXCEL   
	{   
		GetCellName(1 ,iCol + 1, colname); //(colname就是对应表格的A1,B1,C1,D1)  
		range   =   sheet.get_Range(COleVariant(colname),COleVariant(colname));    
		CString hdi = dataRow[iCol];
		range.put_Value2(COleVariant(hdi));  //设置每列的内容  
		int   nWidth   = 20;   
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
		dataRow = dataArray[iRow+startNum-1];
		for   (   iCol   =   1;   iCol   <=   m_cols;   iCol++)    
		{   
			index[0]=iRow-1;   
			index[1]=iCol-1;   

			CString   szTemp;   

			szTemp=dataRow[iCol-1]; //取得m_list控件中的内容  

			BSTR   bstr   =   szTemp.AllocSysString(); //The AllocSysString method allocates a new BSTR string that is Automation compatible  

			saRet.PutElement(index,bstr); //把m_list控件中的内容放入saRet  

			SysFreeString(bstr);  
		}   
	}    

	range.put_Value2(COleVariant(saRet)); //将得到的数据的saRet数组值放入表格  
	book.SaveCopyAs(COleVariant(cStrFile)); //保存到cStrFile文件  
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
 //创建Excel 2000服务器(启动Excel)
 if(!app.CreateDispatch("Excel.Application")) 
 {
	AfxMessageBox("无法启动Excel服务器!");
    return;
 }
 
 //*****   
 //打开c:/1.xls
 books.AttachDispatch(app.get_Workbooks());
 lpDisp = books.Open(path,      
   covOptional, covOptional, covOptional, covOptional, covOptional,
   covOptional, covOptional, covOptional, covOptional, covOptional,
   covOptional, covOptional , covOptional, covOptional);      
 //*****
 //得到Workbook
 book.AttachDispatch(lpDisp);
 //*****
 //得到Worksheets 
 sheets.AttachDispatch(book.get_Worksheets()); 
 //*****
 //得到当前活跃sheet
 //如果有单元格正处于编辑状态中，此操作不能返回，会一直等待
 lpDisp=book.get_ActiveSheet();
 sheet.AttachDispatch(lpDisp); 
 //*****
 //读取已经使用区域的信息，包括已经使用的行数、列数、起始行、起始列
 CRangeExcel usedRange;
 usedRange.AttachDispatch(sheet.get_UsedRange());
 range.AttachDispatch(usedRange.get_Rows());
 long iRowNum=range.get_Count();                   //已经使用的行数
 
 range.AttachDispatch(usedRange.get_Columns());
 long iColNum=range.get_Count();                   //已经使用的列数
  
 long iStartRow=usedRange.get_Row();               //已使用区域的起始行，从1开始
 long iStartCol=usedRange.get_Column();            //已使用区域的起始列，从1开始
  
 std::vector<CString> dataRow;
 dataRow = dataArray[0];

 int   m_cols   = dataRow.size(); //获取列数  
 int   m_rows = endNum-startNum+1;  //获取行数      
 CString str;
 range.AttachDispatch(sheet.get_Cells(),TRUE);
 for(int iRow   =  iRowNum+1;   iRow   <=   iRowNum+m_rows;   iRow++)//将列表内容写入EXCEL   
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