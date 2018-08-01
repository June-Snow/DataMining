//#if !defined(AFX_WORD_H__97228B03_8F88_4237_92DB_CDFF84DA9A5F__INCLUDED_)
//#define AFX_WORD_H__97228B03_8F88_4237_92DB_CDFF84DA9A5F__INCLUDED_
//
//#if _MSC_VER > 1000
//#pragma once
//#endif // _MSC_VER > 1000
#include "stdafx.h"
#include <atlstr.h>
#include "stdafx.h"
#include "InitializeCtrl.h"
#include "DB_operater.h"
#include "IMVLFile.h"
#include "WordSDK.h"

//#endif

//int IMVL_WordSearch(CString keyword, CString exePath);

int GetWordsNumber(int *wordNumber, INDEX_TABLE *indextable);
//int progressShow(int number, int wordFilesNum);

int IMVL_WordSearch(CString keyWord, INDEX_TABLE *index_table, INDEX_TABLE *result_index_table);