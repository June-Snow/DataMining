#include "Export.h"
#include "stdafx.h"
#include <odbcinst.h>
#include <io.h>
#include <afxdb.h>
#include "InitializeCtrl.h"



//函数定义

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
//    判断Path文件(FilenameIncluded = true)是否存在，存在返回true，不存在返回FALSE
//    自动创建目录
//
///////////////////////////////////////////////////////////////////////////////////
BOOL MakeSurePathExists(CString &Path , bool FilenameIncluded)
{
	int Pos=0;
	while((Pos=Path.Find('\\',Pos+1))!=-1)
		CreateDirectory(Path.Left(Pos),NULL);
	if(!true)
		CreateDirectory(Path,NULL);
	//return ((!FilenameIncluded)?=_access(Path,0):
	//!_access(Path.Left(Path.ReverseFind('\\')),0);

	return !_access(Path,0);
}

//增加存储名字
/////////////////////////////////////////////////////
//名称：GetDefaultXlsFileName(CString& sExcelFile)
//功能：获得默认文件名
/////////////////////////////////////////////////////
BOOL GetDefaultFileName(CString& sWordFile, CString strname, CString const type)
{
	//默认文件名：yyyymmddmmss.xls
	if(strcmp(type, _T("doc")) == 0)
	{
		sWordFile = strname + _T(".doc");
		CFileDialog dlgFile(FALSE,_T("*.doc"),sWordFile,OFN_HIDEREADONLY,_T("word 文档(*.doc)|*.doc|所有文件(*.*)|*.*||"));
		dlgFile.m_ofn.lpstrTitle = _T("导出");
		if(dlgFile.DoModal()== IDOK)
		{
			sWordFile = dlgFile.GetPathName();
			sWordFile.ReleaseBuffer();
			if(MakeSurePathExists(sWordFile,true))
			{
				AfxMessageBox(_T("该文件名已经存在，请重新命名!"));
				GetDefaultFileName(sWordFile, strname, type);
				//if(!DeleteFile(sWordFile))
				//{
				//	AfxMessageBox(_T("覆盖文件时出错!"));
				//	return false;
				//}
			}
			return true;
		}
	}
	if(strcmp(type, _T("xls")) == 0)
	{
		sWordFile = strname + _T(".xls");
		CFileDialog dlgFile(FALSE,_T("*.xls"),sWordFile,OFN_HIDEREADONLY,_T("Excel 工作簿(*.xls)|*.xls|所有文件(*.*)|*.*||"));
		dlgFile.m_ofn.lpstrTitle = _T("导出");
		if(dlgFile.DoModal()== IDOK)
		{
			sWordFile = dlgFile.GetPathName();
			sWordFile.ReleaseBuffer();
			if(MakeSurePathExists(sWordFile,true))
			{
				AfxMessageBox(_T("该文件名已经存在，请重新命名!"));
				GetDefaultFileName(sWordFile, strname, type);
				//if(!DeleteFile(sWordFile))
				//{
				//	AfxMessageBox(_T("覆盖文件时出错!"));
				//	return false;
				//}
			}
			return true;
		}
	}
	return false;
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
	//CString warningStr;
	//if(pList->GetItemCount()>0)
	//{
	//	CDatabase database;
	//	CString sDriver;
	//	CString sExcelFile;
	//	CString sSql;
	//	CString tableName = strTitle;

	//	//检索是否安装有Excel驱动 "Microsoft Excel Driver (*.xls)"//
	//	sDriver = GetExcelDriver();
	//	if(sDriver.IsEmpty())
	//	{
	//		//没有发现Excel驱动
	//		AfxMessageBox(_T("没有安装Excel!\n请先安装Excel软件才能使用导出功能!"));
	//		return;
	//	}

	//	//默认文件名
	//	if(!GetDefaultFileName(sExcelFile, strhTtem, _T("xls")))
	//		return;

	//	//创建进行存取的字符串
	//	sSql.Format(_T("DRIVER={%s};DSN='';FIRSTORWHASNAMES=1;READONLY=FALSE;CREATE_DB=\"%s\";DBQ=%s"),sDriver,sExcelFile,sExcelFile);

	//	//创建数据库(即Excel表格文件)
	//	if(database.OpenEx(sSql,CDatabase::noOdbcDialog))
	//	{
	//		//创建表结构
	//		int i;
	//		LVCOLUMN columnData;
	//		CString columnName;
	//		int columnNum=0;
	//		CString strH,strV;
	//		sSql=_T("");
	//		strH=_T("");
	//		columnData.mask = LVCF_TEXT;
	//		columnData.cchTextMax = 100;
	//		columnData.pszText = columnName.GetBuffer(100);
	//		for(i=0;pList->GetColumn(i,&columnData);i++)
	//		{
	//			if(i!=0)
	//			{
	//				sSql=sSql+_T(", ");
	//				strH=strH+_T(", ");
	//			}
	//			sSql = sSql + _T(" ") + columnData.pszText + _T("TEXT");
	//			strH = strH + _T(" ") + columnData.pszText + _T(" ");
	//		}
	//		columnName.ReleaseBuffer();
	//		columnNum = i;

	//		sSql = _T("CREATE TABLE ") + tableName + _T(" ( ") + sSql + _T(" ) ");
	//		database.ExecuteSQL(sSql);

	//		//插入数据项
	//		int nItemIndex;
	//		for(nItemIndex=0;nItemIndex<pList->GetItemCount();nItemIndex++)
	//		{
	//			strV = _T("");
	//			for(i=0;i<columnNum;i++)
	//			{
	//				if(i!=0)
	//				{
	//					strV = strV + _T(", ");
	//				}
	//				strV = strV + _T(" '") + pList->GetItemText(nItemIndex,i) + _T("' ");
	//			}

	//			sSql = _T("INSERT INTO ") + tableName + _T("(") + strH + _T(")") + _T("VALUES(") + strV + _T(")");
	//			database.ExecuteSQL(sSql);
	//		}
	//	}

	//	//关闭数据库
	//	database.Close();

	//	warningStr.Format(_T("导出文件保存于%s中!"),sExcelFile);
	//	AfxMessageBox(warningStr);
	//	ShellExecute(NULL,_T("open"),sExcelFile,NULL,NULL,SW_SHOW);    //最后才显示文件名为strFile的数据表

	//}
	//else
	//{
	//	//没有数据
	//	MessageBox(NULL,_T("没有数据，不能导出!"),_T("提示"),MB_OK|MB_ICONWARNING|MB_TOPMOST);

	//}
}
