#include <atlstr.h>
#include "stdafx.h"
#include<Shlwapi.h>
#pragma comment(lib, "Shlwapi.lib")
#define C1 52845
#define C2 22719

///////////////////////////////////////////////////////////////////
CString Encrypt(CString text);
CString Decrypt(CString text); 



///////////////////////////////////////////////////////////////////
int GetImageName(CString sourcePath , CString* destName);
int ImageNewName(CString* savePath, const int repeatCounts,  CString* sourceImageName );
int ImageSave(const CString sourcePath, CString* savePath);
int BackUp();
int Recover();

int CheckInputValue(CString* labelName );

int GetModuleDir(CString* moduleDir);

int GetWorkDir(CString* workDir);
int SavePath(CString* savePath, int FileType);
int GetFileName(CString sourcePath, CString* FileName);
int FileNewName(CString* savePath, CString* FileName,  int repeatCounts);
int FileSave(CString sourcePath, CString* savePath, int FileType);

int textblockToHtml(CEdit* m_edit, CString* htmlString);
int HtmlToTextblock(CString* htmlString ,CString *editString);

int SetPwd(CString pwd);
int GetPwd(CString* pwd, CString pwdFileName);
int AlterPwd(CString oldPwd, CString newPwd, CString pwdValidate, CString pwdFileName);

int GetTag(CString content,CString *month,CString tag);
int GetMonth(CString date,CString *month);
int DeleteAllChild(CTreeCtrl *m_tree,HTREEITEM hCataItem);
int IsExist(CTreeCtrl *m_tree,HTREEITEM hCataItem,HTREEITEM hitem,CString month);
int SortByDay(CTreeCtrl *m_tree,HTREEITEM hCataItem,int id);
int SortByMonth(CTreeCtrl *m_tree,HTREEITEM hCataItem);
int SortByTag(CTreeCtrl *m_tree,HTREEITEM hCataItem,CString tag);
int UpdateTree(CTreeCtrl *m_tree,int id,CString name);
int UpdateHtml(INDEX_NODE filenode);

int UpdateList(CListCtrl *m_list,int id,CString name, int *pos);
int ListAddRow(CListCtrl *m_list,CString tag);
int GetCurrTime(CString *time);

int UpdateListRow(CListCtrl *m_list,int pos,int tag);

int idIsExist(int* ids, int id);
int MergeIds(int* ids, int enterTimes);
int TimeSearch(INDEX_TABLE* ret_index_table, CStringArray* timeInterval, int idOfFold);
int LargeOrSmall(INDEX_NODE node, CString propertyName, int condition, CString inputStr);
int GetSearchResult(INDEX_TABLE* ret_index_table, int* ids, int flag);
int GetLatestSearchIds(INDEX_TABLE* ret_index_table, int* ids, CStringArray* conditions, int enterTimes);
int AdvancedSearch(INDEX_TABLE* ret_index_table, int idOfFold, CStringArray* searchCriteria);
bool DeleteDirectory1(CString* sDirName);
int HtmlToWord(CString* htmlString ,CString *editString);