#include "DBSDK.h"
#include "dbcore.h"

extern char g_INDEX_TABLE[MAX_CHAR];
extern char g_FOLDER_TABLE[MAX_CHAR];
extern char g_DBFILE_NAME[MAX_CHAR];


//////////////////////////////////////////////////////////////////////////
DBDLL_API int IMVL_Initialize(CString dbPath)
{
	int ret = ERROR_FAILED_VALUE;

	if (!dbPath.IsEmpty())
	{
		strcpy_s(g_DBFILE_NAME, dbPath);
		ret = SUCCESS_VALUE;
	}
	else
	{
		ret = ERROR_INVALID_PTH;
	}

	return ret;
}


DBDLL_API int IMVL_UnInitialize()
{
	return SUCCESS_VALUE;
}


DBDLL_API int IMVL_LoadIndexTable(INDEX_TABLE* indexTable)
{
	CHECK_PTR(indexTable);

	imvl_LoadIndexTable(indexTable);
}


DBDLL_API int IMVL_Create(int PID, INDEX_NODE* fileNode)
{
	CHECK_ID(PID)
		CHECK_PTR(fileNode);

	int ret = ERROR_FAILED_VALUE;

	imvl_Insert(PID, fileNode);

	ret = SUCCESS_VALUE;
	return ret;
}


DBDLL_API int IMVL_InitNode(INDEX_NODE* node)
{
	int ret = ERROR_FAILED_VALUE;

	CHECK_PTR(node);
	imvl_InitNode(node);
	ret = SUCCESS_VALUE;

	return ret;
}


DBDLL_API int IMVL_GetNode(int id, INDEX_NODE* node)
{
	int ret = ERROR_FAILED_VALUE;
	char sqlCmd[MAX_CHAR];
	INIT_DB;

	IMVL_InitNode(node);
	sprintf_s(sqlCmd, "SELECT * FROM %s WHERE ID = %d", g_INDEX_TABLE, id);
	pRs->Open(sqlCmd);
	
	imvl_GetNode(pRs, node);

	CLOSE_DB;
	return ret;
}


DBDLL_API int IMVL_Update(const INDEX_NODE* node)//Ò²ÊÇ alter
{
	CHECK_PTR(node);

	return imvl_Update(node);
}


DBDLL_API int IMVL_Delete(int id)
{	
	int ret = ERROR_FAILED_VALUE;

	CHECK_ID(id);

	INDEX_TABLE index;
	imvl_LoadIndexTable(&index);

	if (imvl_IsFolder(id))
	{
		imvl_DeleteFolder(id, &index);
	}
	else
	{
		imvl_DeleteFile(id, &index);
	}

	ret = SUCCESS_VALUE;

	return ret;
}

DBDLL_API int IMVL_Search(const CString target, INDEX_TABLE* index_table)
{


	int ret = ERROR_FAILED_VALUE;
	CHECK_PTR(index_table);

	ret = imvl_Search(target, index_table);

	return ret;

}

