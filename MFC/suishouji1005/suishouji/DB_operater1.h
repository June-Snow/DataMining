#include <atlstr.h>
#include "stdafx.h"





///////////////////////////////////////////////////////////////////
int GetImageName(CString sourcePath , CString* destName);
int ImageNewName(CString* savePath, const int repeatCounts,  CString* sourceImageName );
int ImageSave(const CString sourcePath, CString* savePath);
int BackUp();
int Recover();

int CheckInputValue(CString* labelName );

int GetFileName();
int SavePath(CString* savePath, int FileType);
int GetFileName(CString sourcePath, CString* FileName);
int FileNewName(CString* savePath, CString* FileName,  int repeatCounts);
int FileSave(CString sourcePath, CString* savePath, int FileType);
int GetWorkDir(CString* workDir);
int textblockToHtml(CEdit* m_edit, CString* htmlString);
int HtmlToTextblock(CString* htmlString ,CString *editString);
