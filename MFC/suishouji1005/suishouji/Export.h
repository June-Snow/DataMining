#include "stdafx.h"
#include <odbcinst.h>
#include <io.h>
#include <afxdb.h>



//º¯ÊýÉùÃ÷
CString		GetExcelDriver();
BOOL    MakeSurePathExists( CString &Path,	bool FilenameIncluded);
BOOL    GetDefaultFileName(CString& sWordFile, CString strname, CString const type);
void    CListCtrlToExcel(CListCtrl* pList, CString strTitle);



