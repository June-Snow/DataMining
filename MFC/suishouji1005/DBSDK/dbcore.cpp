#include "ado2.h"
#include "dbcore.h"

char g_INDEX_TABLE[MAX_CHAR] = "INDEX_TABLE";
char g_FOLDER_TABLE[MAX_CHAR] = "FOLDER_TABLE";
char g_DBFILE_NAME[MAX_CHAR] = "easydb.mdb";


int	imvl_DeleteElem(CString tableName, int id);
//////////////////////////////////////////////////////////////////////////
int	imvl_InitConnection( CString DBFile, CString tableName, CADODatabase **pDb, CADORecordset **pRs )
{
	CString pwd = _T("123");
	CString strConnection = _T("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=")+DBFile;

	strConnection += _T(";Persist Security Info=False;Jet OLEDB:Database Password=");
	strConnection += pwd;

	(*pDb)->SetConnectionString(strConnection);

	if ((*pDb)->Open())
	{	
		if ((*pRs)->Open(tableName, CADORecordset::openTable))
		{
			return SUCCESS_VALUE;
		}		
	}

	return ERROR_CNNCTON_VALUE;
}


int	imvl_Insert(int PID, INDEX_NODE* node)
{	
	int ret = ERROR_FAILED_VALUE;
	char sqlCmd[MAX_CHAR];
	
	INIT_DB;

	int len = strlen(node->content);
	sprintf_s(sqlCmd, "INSERT INTO %s(NAME, PID, ISFOLDER, CREATETIME, MODIFYTIME, CONTENT) VALUES ('%s', %d, %d, '%s', '%s', '%s')", \
		g_INDEX_TABLE, node->name, PID, node->IsFolder, node->createTime, node->modifyTime, node->content);

	if (pRs->Open(CString(sqlCmd)))
	{
		ret=SUCCESS_VALUE;
	}

	CLOSE_DB;

	node->ID = imvl_GetLastId(g_INDEX_TABLE);
	return ret;
}


void imvl_GetNode(CADORecordset* pRs, INDEX_NODE* t)
{
	CString name, content, createTime, modifyTime;
	int n = pRs->GetFieldCount();
	pRs->GetFieldValue("ID", t->ID); 
	pRs->GetFieldValue("isFolder", t->IsFolder);
	pRs->GetFieldValue("name", name);  strcpy_s(t->name, name);
	pRs->GetFieldValue("createTime", createTime);   strcpy_s(t->createTime, createTime);
	pRs->GetFieldValue("modifyTime", modifyTime);   strcpy_s(t->modifyTime, modifyTime);
	pRs->GetFieldValue("content", content); strcpy_s(t->content, content);
	pRs->GetFieldValue("PID", t->iPID);
	
	pRs->Update();
}


int	imvl_LoadIndexTable(INDEX_TABLE* t)
{
	int ret = ERROR_FAILED_VALUE;
	CString name, content;
	int count;

	INIT_DB;

	if ( !(pRs->IsBOF()) )
	{
		pRs->MoveFirst();
	}

	count = 0;
	while((!pRs->IsEof()) && (count < MAX_INDEX_NUM))
	{	
		imvl_GetNode(pRs, &(t->index[count]));	
		pRs->MoveNext();
		count++;
	}

	t->num = count;

	ret = SUCCESS_VALUE;
	CLOSE_DB;
	return ret;
}


void imvl_InitNode(INDEX_NODE* index)
{
	index->ID = INIT_VALUE;
	index->IsFolder = INIT_VALUE;
	index->content[0] = '\0'; 
	index->name[0] =  '\0';
	index->createTime[0] = '\0';
	index->modifyTime[0] = '\0';
	index->iPID = INIT_VALUE;
}


void imvl_InitIndex(INDEX_TABLE t)
{
	int i;

	for(i = 0; i < MAX_INDEX_NUM; i++)
	{
		imvl_InitNode(&(t.index[i]));
	}
}


int imvl_Update(const INDEX_NODE* node)
{
	int ret = ERROR_FAILED_VALUE;
	char sqlCmd[MAX_CHAR];

	INIT_DB;

	sprintf_s(sqlCmd, "UPDATE %s SET [%s] = '%s',[%s] = '%s',[%s] = '%s' WHERE ID = %d", \
		g_INDEX_TABLE,"name", node->name, "modifyTime", node->modifyTime, "content", node->content,  node->ID);

	if (pRs->Open(sqlCmd))
	{
		CLOSE_DB;
		ret = SUCCESS_VALUE;
	}	
	return ret;

}


int imvl_IsFolder(int id)
{
	char sqlCmd[MAX_CHAR];
	CString folderName;
	int isFolder;

	INIT_DB;

	sprintf_s(sqlCmd, "SELECT * FROM %s WHERE ID = %d", g_INDEX_TABLE, id);
	pRs->Open(sqlCmd);
	if (!(pRs->GetFieldValue("isFolder", isFolder)))
	{
		isFolder = INIT_VALUE;
	}

	CLOSE_DB;
	return isFolder;
}


int imvl_MapId2Pos(int id, const INDEX_TABLE* indexTable)
{
	int i;

	for (i = 0; i < indexTable->num; i++)
	{
		if (id == indexTable->index[i].ID)
		{
			return i;
		}
	}

	return ERROR_INVALID_ID;
}


int	imvl_DeleteElem(CString tableName, int id)
{
	int ret = SUCCESS_VALUE;
	char sqlCmd[MAX_CHAR];

	INIT_DB;

	sprintf_s(sqlCmd, "DELETE * FROM %s WHERE ID =%d", tableName, id);
	if (!pDb->Execute(sqlCmd))
	{
		return ERROR_FAILED_VALUE;
	}

	ret = SUCCESS_VALUE;
	CLOSE_DB;
	return ret;
}


int	imvl_DeleteFile(int id, const INDEX_TABLE* index)
{
	CString tableName;

	// Delete file info in INDEX_TABLE
	imvl_DeleteElem(g_INDEX_TABLE, id);

	return SUCCESS_VALUE;
}


int	imvl_DeleteFolder(int id, const INDEX_TABLE* indexTable)
{
	int ret = SUCCESS_VALUE;
	int pos, i;

	CHECK_PTR(indexTable);
	CHECK_ID(id);

	pos = imvl_MapId2Pos(id, indexTable);

	for(i=0; i < indexTable->num; i++)
	{
		if (id == indexTable->index[i].iPID)
		{
			if (indexTable->index[i].IsFolder)
			{
				imvl_DeleteFolder(indexTable->index[i].ID, indexTable);
			}
			else
			{
				imvl_DeleteFile(indexTable->index[i].ID, indexTable);
			}
		}
	}

	// delete folder info in INDEX_TABLE
	imvl_DeleteElem(g_INDEX_TABLE, id);

	return SUCCESS_VALUE;
	return ret;
}

int imvl_GetLastId(CString tablename)
{
	int ret = ERROR_FAILED_VALUE;
	int id;

	INIT_DB;

	if (!pRs->IsEof())
	{
		pRs->MoveLast();
		pRs->GetFieldValue("ID", id);
	}

	ret = id;
	CLOSE_DB;
	return ret;
}

int imvl_Search(const CString target, INDEX_TABLE* index_table)
{
	int ret = ERROR_FAILED_VALUE;
	INIT_DB
		char sqlCmd[MAX_CHAR];
	int countNode = 0 ;
	CString name, content, createTime, modifyTime;

	sprintf_s(sqlCmd, "SELECT * FROM %s WHERE NAME LIKE '%%%s%%' OR CONTENT LIKE '%%%s%%'", \
		g_INDEX_TABLE, target, target);
	if (pRs->Open((CString)sqlCmd))
	{
		index_table->num = pRs->GetRecordCount();
		while(!pRs->IsEOF())
		{
			pRs->GetFieldValue("id", index_table->index[countNode].ID);
			pRs->GetFieldValue("pid", index_table->index[countNode].iPID);
			pRs->GetFieldValue("isFolder", index_table->index[countNode].IsFolder);
			pRs->GetFieldValue("name", name);					strcpy_s(index_table->index[countNode].name, name);
			pRs->GetFieldValue("createTime", createTime);		strcpy_s(index_table->index[countNode].createTime, createTime);
			pRs->GetFieldValue("modifyTime", modifyTime);		strcpy_s(index_table->index[countNode].modifyTime, modifyTime);
			pRs->GetFieldValue("content", content);				strcpy_s(index_table->index[countNode].content, content);
			pRs->MoveNext();
			countNode++;						
		}
		ret = SUCCESS_VALUE;
	}	

	CLOSE_DB

		return ret;
}

int imvl_BackUp()
{
	int ret = ERROR_FAILED_VALUE;
	CString SourcePath = ".\\easydb.mdb";
	CString DesPath = ".\\files\\easydb.mdb";
	if (CopyFile((LPCSTR)SourcePath, (LPCSTR)DesPath, FALSE))
	{
		ret = SUCCESS_VALUE;
	}	
	return ret;	
}

int imvl_Recover()
{
	int ret = ERROR_FAILED_VALUE;
	CString SourcePath = ".\\files\\easydb.mdb";
	CString DesPath = ".\\easydb.mdb";
	if (CopyFile((LPCSTR)SourcePath, (LPCSTR)DesPath, FALSE))
	{
		ret = SUCCESS_VALUE;
	}	
	return ret;	
}

int imvl_GetImageName(CString sourcePath , CString* destName)
{
	int ret = ERROR_FAILED_VALUE;
	CString path = sourcePath;
	CString imageName;
	int pos = 0, pre_pos = 0;
	while(-1 != pos)
	{
		pre_pos = pos;
		pos = path.Find("\\", (pos+1));
		*destName = path.Mid(pre_pos+1, path.GetLength()); 
	}


	ret = SUCCESS_VALUE;
	return ret;

}

int imvl_ImageNewName(CString* savePath, const int repeatCounts )
{
	int ret = ERROR_FAILED_VALUE;
	CString intToCstring;
	CString leftName, rightName ,newName ;

	int n = (*savePath).ReverseFind('.');

	leftName = (*savePath).Left( n );
	rightName = (*savePath).Right((*savePath).GetLength()- n );

	newName += leftName;
	newName += _T("_");
	intToCstring.Format("%d", repeatCounts);
	newName += intToCstring;
	newName += rightName;

	*savePath = newName;

	ret = SUCCESS_VALUE;

	return ret;
}

int imvl_ImageSave(const CString sourcePath, CString* savePath)
{
	int ret = ERROR_FAILED_VALUE;
	int i = 1;
	CString dstImagePath;
	ret = imvl_GetImageName(sourcePath, &dstImagePath);

	*savePath += _T(".\\images\\");

	*savePath += dstImagePath;

	while (!(CopyFile((LPCSTR)sourcePath, (LPCSTR)(*savePath), TRUE)))
	{
		ret = imvl_ImageNewName(savePath, i);
		i++;	
	}

	return ret;

}

