// CListCtrlToExcel.cpp : Defines the class behaviors for the application.
//

#include "stdafx.h"
#include "CListCtrlToExcel.h"
#include "CListCtrlToExcelDlg.h"
#include <io.h>
#include <odbcinst.h>
#include <afxdb.h>

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CCListCtrlToExcelApp

BEGIN_MESSAGE_MAP(CCListCtrlToExcelApp, CWinApp)
	//{{AFX_MSG_MAP(CCListCtrlToExcelApp)
		// NOTE - the ClassWizard will add and remove mapping macros here.
		//    DO NOT EDIT what you see in these blocks of generated code!
	//}}AFX_MSG
	ON_COMMAND(ID_HELP, CWinApp::OnHelp)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CCListCtrlToExcelApp construction

CCListCtrlToExcelApp::CCListCtrlToExcelApp()
{
	// TODO: add construction code here,
	// Place all significant initialization in InitInstance
}

/////////////////////////////////////////////////////////////////////////////
// The one and only CCListCtrlToExcelApp object

CCListCtrlToExcelApp theApp;

/////////////////////////////////////////////////////////////////////////////
// CCListCtrlToExcelApp initialization

BOOL CCListCtrlToExcelApp::InitInstance()
{
	AfxEnableControlContainer();

	// Standard initialization
	// If you are not using these features and wish to reduce the size
	//  of your final executable, you should remove from the following
	//  the specific initialization routines you do not need.

#ifdef _AFXDLL
	Enable3dControls();			// Call this when using MFC in a shared DLL
#else
	Enable3dControlsStatic();	// Call this when linking to MFC statically
#endif

	CCListCtrlToExcelDlg dlg;
	m_pMainWnd = &dlg;
	int nResponse = dlg.DoModal();
	if (nResponse == IDOK)
	{
		// TODO: Place code here to handle when the dialog is
		//  dismissed with OK
	}
	else if (nResponse == IDCANCEL)
	{
		// TODO: Place code here to handle when the dialog is
		//  dismissed with Cancel
	}

	// Since the dialog has been closed, return FALSE so that we exit the
	//  application, rather than start the application's message pump.
	return FALSE;
}

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


    CFileDialog dlgFile(FALSE,".xls",sExcelFile,OFN_HIDEREADONLY,_T("Excel 工作簿(*.xls)|*.xls|所有文件(*.*)|*.*||"));
	dlgFile.m_ofn.lpstrTitle = "导出";

	if(dlgFile.DoModal()==IDCANCEL)
	{
		return FALSE;
	}
	sExcelFile.ReleaseBuffer();
	if(MakeSurePathExists(sExcelFile))
	{
		if(!DeleteFile(sExcelFile))
		{
			AfxMessageBox("覆盖文件时出错!");
			return FALSE;
		}
	}

	return TRUE;

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
void CListCtrlToExcel(CListCtrl* pList, CString strTitle)
{
	CString warningStr;
	if(pList->GetItemCount()>0)
	{
		CDatabase database;
		CString sDriver;
		CString sExcelFile;
		CString sSql;
		CString tableName = strTitle;

		//检索是否安装有Excel驱动 "Microsoft Excel Driver (*.xls)"
		sDriver = GetExcelDriver();
		if(sDriver.IsEmpty())
		{
			//没有发现Excel驱动
			AfxMessageBox("没有安装Excel!\n请先安装Excel软件才能使用导出功能!");
			return;
		}

		//默认文件名
		if(!GetDefaultXlsFileName(sExcelFile))
			return;

		//创建进行存取的字符串
		sSql.Format("DRIVER={%s};DSN='';FIRSTORWHASNAMES=1;READONLY=FALSE;CREATE_DB=\"%s\";DBQ=%s",sDriver,sExcelFile,sExcelFile);

		//创建数据库(即Excel表格文件)
		if(database.OpenEx(sSql,CDatabase::noOdbcDialog))
		{
			//创建表结构
			int i;
			LVCOLUMN columnData;
			CString columnName;
			int columnNum=0;
			CString strH,strV;
			sSql="";
			strH="";
			columnData.mask = LVCF_TEXT;
			columnData.cchTextMax = 100;
			columnData.pszText = columnName.GetBuffer(100);
			for(i=0;pList->GetColumn(i,&columnData);i++)
			{
				if(i!=0)
				{
					sSql=sSql+", ";
					strH=strH+", ";
				}
				sSql = sSql + " " + columnData.pszText + " TEXT";
				strH = strH + " " + columnData.pszText + " ";
			}
			columnName.ReleaseBuffer();
			columnNum = i;

			sSql = "CREATE TABLE " + tableName + " ( " + sSql + " ) ";
			database.ExecuteSQL(sSql);

			//插入数据项
			int nItemIndex;
			for(nItemIndex=0;nItemIndex<pList->GetItemCount();nItemIndex++)
			{
				strV = "";
				for(i=0;i<columnNum;i++)
				{
					if(i!=0)
					{
						strV = strV + ", ";
					}
					strV = strV + " '" + pList->GetItemText(nItemIndex,i) + "' ";
				}

				sSql = "INSERT INTO " + tableName + " (" + strH + ")" + "VALUES(" + strV + ")";
				database.ExecuteSQL(sSql);
			}
		}
		
		//关闭数据库
		database.Close();

		warningStr.Format("导出文件保存于%s中!",sExcelFile);
		AfxMessageBox(warningStr);
		ShellExecute(NULL,"open",sExcelFile,NULL,NULL,SW_SHOW);    //最后才显示文件名为strFile的数据表
	    
	}
	else
	{
		//没有数据
		MessageBox(NULL,"没有数据，不能导出!","提示",MB_OK|MB_ICONWARNING|MB_TOPMOST);
		
	}
}
