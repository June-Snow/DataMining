#ifndef _SSJ_CORE_H_ 
#define _SSJ_CORE_H_


#include "ado2.h"
#include "DBSDK.h"


#define EXIST					(1)
#define NOTEXIST				(0)
#define EMPTY					(1)
#define NOTEMPTY				(0)


#define CHECK_ID(ID)	{if(ID<=0)	return ERROR_INVALID_ID; }
#define CHECK_PTR(PTR)	{if(PTR == NULL) return ERROR_INVALID_PTR; }	

#define  INIT_DB											\
CADODatabase* pDb = new CADODatabase();						\
CADORecordset* pRs = new CADORecordset(pDb);				\
imvl_InitConnection(g_DBFILE_NAME, g_INDEX_TABLE, &pDb, &pRs);

#define  CLOSE_DB	{pRs->Update();	pRs->Close();pDb->Close();}


#define __TABLE_OFFSET__  (3) // ID, NAME, PID 在表里面是固定的3个基本表属性，不展示给上一层逻辑

#define INVALID_ID		(-10000)
#define __ID_INDEX__	(1)
#define __VAL_LEN__     (20)
#define  INVALID_DATA   (-1)


//////////////////////////////////////////////////////////////////////////
int	imvl_InitConnection( CString DBFile, CString tableName, CADODatabase **pDb, CADORecordset **pRs );
int	imvl_Insert(int PID, INDEX_NODE* node);
void imvl_GetNode(CADORecordset* pRs, INDEX_NODE* t);
int	imvl_LoadIndexTable(INDEX_TABLE* t);
void imvl_InitIndex(INDEX_NODE* index);
void imvl_InitNode(INDEX_NODE* node);
int imvl_Update(const INDEX_NODE* node);
int imvl_IsFolder(int id);
int	imvl_DeleteFile(int id);
int imvl_GetLastId(CString tablename);
int imvl_MapId2Pos(int id, const INDEX_TABLE* indexTable);
int	imvl_DeleteFolder(int id, const INDEX_TABLE* indexTable);
int	imvl_DeleteFile(int id, const INDEX_TABLE* index);
int imvl_Search(const CString target, INDEX_TABLE* index_table);

int imvl_BackUp();
int imvl_Recover();
int imvl_ImageSave(const CString sourcePath, CString* savePath);
int imvl_GetImageName(const CString sourcePath);
int imvl_ImageNewName(CString* savePath, const int repeatCounts );
#endif //#ifndef _SSJ_CORE_H_ 