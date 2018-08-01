#ifndef __DBSDK_H__
#define __DBSDK_H__

#include <afxdisp.h>

//////////////////////////////////////////////////////////////////////////
#define DBDLL_API __declspec(dllexport)   

#define MAX_CHAR				(2000)
#define MAX_DATE				(30)
#define MAX_DATA_NUM			(200)
#define MAX_INDEX_NUM			(500)
#define MAX_CHAR_CONTENT		(1500)

#define ERROR_INVALID_PTH       (0x00010002)
#define SUCCESS_VALUE			(0x00000000)
#define ERROR_FAILED_VALUE      (0x10000000)
#define ERROR_CNNCTON_VALUE     (0x01000000)
#define ERROR_REPEATED_VALUE    (0x00100000)
#define ERROR_INVALID_ID        (0x00010000)
#define ERROR_INVALID_PTR       (0x00010001)
#define ERROR_NOT_EXIST         (0x10010000)
#define ERROR_ALREADY_EXIST     (0x10110000)
#define ERROR_UNKNOW_TYPE       (0x00001000)
#define INIT_VALUE              (-1000000)

#define ERROR_OLDPWD_VALUE		 (0x10000001)
#define ERROR_PWDNOTSAME_VALUE	 (0x10000011)
#define ERROR_PWDNOTEXIST_VALUE  (0x10000111)

//////////////////////////////////////////////////////////////////////////
typedef struct INDEX_NODE
{
	int  ID;
	int  IsFolder;
	char name[MAX_CHAR];
	char createTime[MAX_DATE];
	char modifyTime[MAX_DATE];
	char content[MAX_CHAR_CONTENT];
	int  iPID;	
}INDEX_NODE;


typedef struct INDEX_TABLE
{
	int num;
	INDEX_NODE index[MAX_INDEX_NUM];
}INDEX_TABLE;


DBDLL_API int IMVL_Initialize(CString dbPath);
DBDLL_API int IMVL_Create(int PID, INDEX_NODE* node);
DBDLL_API int IMVL_GetNode(int id, INDEX_NODE* node);
DBDLL_API int IMVL_Update(const INDEX_NODE* Node);
DBDLL_API int IMVL_LoadIndexTable(INDEX_TABLE* indexTable);
DBDLL_API int IMVL_Delete(int id);
DBDLL_API int IMVL_Search(const CString target, INDEX_TABLE* index_table);

//DBDLL_API int IMVL_BackUp();
//DBDLL_API int IMVL_Recover();
//DBDLL_API int IMVL_ImageSave(const CString sourcePath, CString* savePath);
#endif

