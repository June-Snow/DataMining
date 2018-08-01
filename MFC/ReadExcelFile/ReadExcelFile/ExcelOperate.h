#include "stdafx.h"
#include <afxcontrolbars.h>
#include "stdafx.h"
#include <odbcinst.h>
#include <io.h>
#include <afxdb.h>
#include "afxdialogex.h"
#include <vector>


#include "CApplication.h"
#include "CRange.h"
#include "CWorkbook.h"
#include "CWorkbooks.h"
#include "CWorksheet.h"
#include "CWorksheets.h"


void OnReadExcel(CString strPath, std::vector<CString> &name)
{
	CApplication app;
	CWorkbooks books;
	CWorkbook book;
	CWorksheets sheets;
	CWorksheet sheet;
	CRange range;
	CRange iCell;
	LPDISPATCH lpDisp;
	COleVariant vResult;
	COleVariant covOptional((long)DISP_E_PARAMNOTFOUND, VT_ERROR);
	if(!app.CreateDispatch("Excel.Application"))
	{
	//AfxMessageBox(L"无法启动Excel服务器!");
	return;
	}
	books.AttachDispatch(app.get_Workbooks());
	lpDisp = books.Open(strPath,covOptional, covOptional, covOptional, covOptional, covOptional,covOptional, covOptional, covOptional, covOptional, covOptional,covOptional, covOptional, covOptional,covOptional);
	
	//得到Workbook
	book.AttachDispatch(lpDisp);
	//得到Worksheets
	sheets.AttachDispatch(book.get_Worksheets());
	sheet = sheets.get_Item(COleVariant((short)1));

	range.AttachDispatch(sheet.get_UsedRange());
	range.AttachDispatch(range.get_Rows());
	long iRowNum = range.get_Count();
	range.AttachDispatch(range.get_Columns());
	long iColNum = range.get_Column();
	long iStartRow = range.get_Row();
	long iStartCol = range.get_Column();
	iColNum = 1;
	for(int i=iStartRow;i<=iRowNum;i++)
	{
		for(int j=iStartCol;j<=iColNum;j++)
		{
			//读取单元格的值
			range.AttachDispatch(sheet.get_Cells());
			range.AttachDispatch(range.get_Item(COleVariant((long)i),COleVariant((long)j)).pdispVal);
			vResult = range.get_Value2();
			CString str,stry,strm,strd;
			SYSTEMTIME st;
			if(vResult.vt == VT_BSTR)     //若是字符串
			{
				str = vResult.bstrVal;
			}
			else if (vResult.vt == VT_R8) //8字节的数字
			{
				str.Format("%d",vResult.dblVal);
			}
			else if(vResult.vt == VT_DATE) //时间格式
			{
				VariantTimeToSystemTime(vResult.date, &st);
				stry.Format("%d",st.wYear);
				strm.Format("%d",st.wMonth);
				strd.Format("%d",st.wDay);
				str = stry+L"-"+strm+"-"+strd;
			}
			else if(vResult.vt == VT_EMPTY) //单元为空
			{
				str=L"";
			}
			else if (vResult.vt ==VT_I4)
			{
				str.Format(_T("%d"), (int)vResult.lVal);
			}
			name.push_back(str);
		}
	}

    books.Close(); 
    app.Quit();  			// 退出
	//释放对象  
	range.ReleaseDispatch();
	sheet.ReleaseDispatch();
	sheets.ReleaseDispatch();
	book.ReleaseDispatch();
	books.ReleaseDispatch();
	app.ReleaseDispatch();
}