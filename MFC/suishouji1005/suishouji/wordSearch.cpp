#include "stdafx.h"
#include "wordcore.h"
#include "wordSearch.h"

#include "ProgressDlg.h"


int GetWordsNumber(int *wordNumber, INDEX_TABLE *indextable)
{
	int ret = ERROR_FAILED_VALUE;
	CString docPath[100];
	CString cPath;

	for (int i = 0; i <indextable->num; i++)
	{
		for (int k = 0; k < 100; k++)
		{
			docPath[k] = _T("");
		}

		GetDocFile(indextable->index[i].content, docPath);

		for (int j = 0; j < docPath->GetLength(); j++)
		{
			if (cPath == "")
			{
				break;
			}
			else
			{
				*wordNumber += 1;


			}
		}
	}

	ret = SUCCESS_VALUE;
	return ret;
	
}

//int progressShow(int number,int wordFilesNum)
//{
//	int ret = ERROR_FAILED_VALUE;
//	int nPos;
//	CString str;
//
//	UpdateData(FALSE);
//
//	int nLower = 0;
//	int nUpper = wordFilesNum;
//	m_ctrlProgress.GetRange(nLower, nUpper);
//
//	if (m_ctrlProgress.GetPos() == nLower)
//	{
//		m_ctrlProgress.SetPos(nLower);
//	}
//
//
//	Sleep(500);
//	m_ctrlProgress.StepIt();
//
//	nPos = (m_ctrlProgress.GetPos()-nLower)*100/(nUpper-nLower);
//	m_ctrlProgress.OffsetPos(number);
//
//	str.Format("%d", nPos);
//	m_editText.SetWindowText(str + "%");
//	UpdateData(FALSE);
//
//
//	ret = SUCCESS_VALUE;
//	return ret;
//
//}


//int IMVL_WordSearch(CString keyword, CString exePath)
int IMVL_WordSearch(CString keyWord, INDEX_TABLE *index_table, INDEX_TABLE *result_index_table)
{
	int ret  = ERROR_FAILED_VALUE;

	int isFound;
	IMVLFile fileManager;
	vector<string> names;
	string root;  
	string ext = "*.doc";
	string path;
	CString cPath;
	CString tabooWord = "$";
	CString result[MAX_CHAR];
	CString docPath[100];
	CString newName;
	int pos, num = 0;
	time_t time_start, time_end;
	double time_diff;
	CString startTime, endTime;
	CString str;
	CString fileName;
	int flag = 0;
	int result_count = 0;
	int wordSearchNum = 0;
	int wordFilesNum;

	ProgressDlg dlg;


	GetWordsNumber(&wordFilesNum, index_table);

	for (int i = 0; i <index_table->num; i++)
	{
		flag = 0;
		for (int k = 0; k < 100; k++)
		{
			docPath[k] = _T("");
		}

		GetDocFile(index_table->index[i].content, docPath);

		if (docPath->GetLength() < 1)
		{
			index_table->index[i].ID = -1;
		}

		for (int j = 0; j < docPath->GetLength(); j++)
		{

			GetCurrTime(&startTime);
			isFound = 0;
			newName = _T("");
			cPath = exe_path + "\\attachment\\"+docPath[j];
			if (docPath[j] == "")
			{
				break;
			}
			wordSearchNum++;  

			//计算完成的搜索任务
			
			dlg.wordSearchNum = wordSearchNum;

			dlg.wordFilesNum = wordFilesNum;
			dlg.DoModal();

			pos = cPath.Find(tabooWord);
			if (pos != -1) // found taboo
			{
				IMVL_WordSDKClose();				
				continue;
			}
			if (ERROR_FAILED_VALUE == IMVL_WordSDKOpen(cPath))
			{			
				continue;
			}

			isFound = IMVL_Find(keyWord);
			IMVL_WordSDKClose();

			if (isFound == 1)
			{				
				result_index_table->index[result_count].ID = index_table->index[i].ID;
				strcpy_s(result_index_table->index[result_count].name , index_table->index[i].name);
				result_index_table->index[result_count].IsFolder = index_table->index[i].IsFolder;
				strcpy_s(result_index_table->index[result_count].createTime, index_table->index[i].createTime);
				strcpy_s(result_index_table->index[result_count].modifyTime, index_table->index[i].modifyTime);
				result_index_table->index[result_count].iPID = index_table->index[i].iPID;
				result_count++;
				result_index_table->num = result_count;				
			}
			IMVL_WordSDKUnInit();
		}
	}
	return ret;	
}









//	fileManager.GetNames(root+ext, names);
//
//	IMVL_WordSDKInit(cPath); 
//	for (vector<string>::iterator itor = names.begin(); 
//		itor != names.end();
//		itor++)
//	{
//		path = root + (*itor);
//		cout<< path <<endl;
//		cPath = CString(path.c_str());
//		pos = cPath.Find(tabooWord);
//		if (pos != -1) // found taboo
//		{
//			IMVL_WordSDKClose();
//			continue;
//		}
//
//		if (ERROR_FAILED_VALUE == IMVL_WordSDKOpen(cPath))
//		{
////			cout<<"ERROR : 文件"+(*itor)+"存在未知问题，即将忽略。"<<endl;
//			continue;
//		}
//
//		isFound = IMVL_Find(keyWord);
//		IMVL_WordSDKClose();
//
//		if (isFound != ERROR_FAILED_VALUE)
//		{		
//			if (isFound == 1)
//			{
//				result[num] = cPath;
//				num++;
//			}
//			else
//			{
////				cout<< "没能在" + cPath + "中找到" + keyWord<<endl;
//			}
//		}
//	}
//
//	IMVL_WordSDKUnInit();