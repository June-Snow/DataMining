#include "DB_operater.h"
#include "stdafx.h"



//////////////////////////////////////////////////////

int GetWorkDir(CString* workDir)
{
	int ret;
	char pFileName[MAX_PATH]; 
	int nPos = GetCurrentDirectory( MAX_PATH, pFileName); 

	if( nPos < 0 ) 
	{
		*workDir = _T("");
	}
	else 
	{
		*workDir = (CString)pFileName;
		ret = SUCCESS_VALUE;
	}
	return ret;
}


int GetFileName(CString sourcePath, CString* FileName)
{
	int ret = ERROR_FAILED_VALUE;
	int n;

	n = sourcePath.ReverseFind('\\');
	*FileName = sourcePath.Right(sourcePath.GetLength()-n-1);

	ret = SUCCESS_VALUE;
	return ret;
}

int FileSaveName(CString* savePath,  CString* FileName,  int repeatCounts )
{
	int ret = ERROR_FAILED_VALUE;
	CString intToCstring;
	CString path, nameLeft, nameRight, newPath;
	int n1, n2;

	
	n1 = (*savePath).ReverseFind('\\');
	n2 = (*FileName).ReverseFind('.');


	path = (*savePath).Left( n1 + 1 );
	nameLeft = (*FileName).Left( n2 );
	nameRight = (*FileName).Right( (*FileName).GetLength() - n2 );

	newPath += path;
	newPath += nameLeft;
	newPath += _T("_");
	intToCstring.Format("%d", repeatCounts);
	newPath += intToCstring;
	newPath += nameRight;

	*savePath = newPath;

	ret = SUCCESS_VALUE;

	return ret;
}

int SavePath(CString* savePath, int FileType)
{
	int ret = ERROR_FAILED_VALUE;
	CString workDir;

	ret = GetWorkDir(&workDir);
	*savePath += workDir;
	switch(FileType)
	{
	case 0:
		*savePath += _T("\\image\\");
		ret = SUCCESS_VALUE;
		break;
	case 1:
		*savePath += _T("\\file\\");
		ret = SUCCESS_VALUE;
		break;
	case 2:
		*savePath += _T("\\attachment\\");
		ret = SUCCESS_VALUE;
		break;
	default:
		break;		
	}

	return ret;
}

//保存文档、附件
//           | = 0 -------  image
// FileType  | = 1 -------  document
//			 | = 2 -------  attachment
int FileSave(CString sourcePath, CString* savePath, int FileType)
{
	

	int ret = ERROR_FAILED_VALUE;
	int repeatCount = 0;
	CString FileName;

	ret = GetFileName(sourcePath, &FileName);
	ret = SavePath(savePath, FileType);
	*savePath += FileName;

	while (!(CopyFile((LPCSTR)sourcePath, (LPCSTR)(*savePath), TRUE)))
	{
		repeatCount++;
		ret = FileSaveName(savePath, &FileName, repeatCount);
	}

	return ret;


}

//备份
int BackUp()
{
	int ret = ERROR_FAILED_VALUE;
	CString SourcePath = ".\\easydb.mdb";
	CString DesPath = ".\\backup\\easydb.mdb";
	if (CopyFile((LPCSTR)SourcePath, (LPCSTR)DesPath, FALSE))
	{
		ret = SUCCESS_VALUE;
	}	
	return ret;	


}
int Recover()
{
	int ret = ERROR_FAILED_VALUE;
	CString SourcePath = ".\\backup\\easydb.mdb";
	CString DesPath = ".\\easydb.mdb";
	if (CopyFile((LPCSTR)SourcePath, (LPCSTR)DesPath, FALSE))
	{
		ret = SUCCESS_VALUE;
	}	
	return ret;	
}

//输入数据检测
int CheckInputValue(CString* labelName )
{
	int ret = ERROR_FAILED_VALUE;
//	strstr()

	return ret;
}

int textblockToHtml(CEdit* m_edit, CString* htmlString)
{
	int ret = SUCCESS_VALUE;
	int length,n;
	CString str, strline;
	CString space = _T("&nbsp");
	CString sp = _T(" ");
	length = m_edit->LineLength(m_edit->LineIndex(0));
	if (length == 0)
	{
		n=0;
	} 
	else
	{
		n = m_edit->GetLineCount();
	}
	
   
	for (int i = 0; i < n; i++)
	{
		length = m_edit->LineLength(m_edit->LineIndex(i));
		m_edit->GetLine(i, str.GetBuffer(length), length);
		str.ReleaseBuffer(length);
		if (i == 0)
		{
			strline.Format(_T("%s%s\n"), str, _T("<br>"));
		} 
		else
			if (i == n-1)
			{
				strline.Format(_T("%s\n"), str);
			} 
			else
			{
				strline.Format(_T("%s%s\n"), str, _T("<br>"));
			}

			strline.Replace(sp, space);
			*htmlString += strline;
	}
	//ret = SUCCESS_VALUE;
	return ret;
}

int HtmlToTextblock(CString* htmlString ,CString *editString)
{
	int ret = ERROR_FAILED_VALUE;
	CString sp = _T("&nbsp");
	CString sl = _T("<br>");
	CString space = _T(" ");
	CString swtichLine = _T("");
	*editString = *htmlString;
	editString->Replace(sp, space);
	editString->Replace(sl, swtichLine);
	ret = SUCCESS_VALUE;

	return ret;
}

