#include "stdafx.h"
#include "InitializeCtrl.h"
#include "DB_operater.h"
#include "stdio.h"
//////////////////////////////////////////////////////
// get the dir that contains the .cpp
int GetWorkDir(CString* workDir)
{
	int ret = ERROR_FAILED_VALUE;
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

// get the dir that contains the .exe 
int GetModuleDir(CString* moduleDir) 
{ 
	int ret = ERROR_FAILED_VALUE;
	HMODULE module = GetModuleHandle(0); 
	char pFileName[MAX_PATH]; 
	GetModuleFileName(module, pFileName, MAX_PATH); 

	*moduleDir = (CString)pFileName;

	int nPos = (*moduleDir).ReverseFind( _T('\\') ); 
	if( nPos < 0 ) 
	{
		*moduleDir = _T("");
	}
	else 
	{
		CString csFullPath = *moduleDir;
		*moduleDir = csFullPath.Left( nPos ); 
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

	//ret = GetModuleDir(&workDir);
	*savePath += exe_path;

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
	int retval;
	CString FileName;
	if (sourcePath == _T(""))
	{
		return SUCCESS_VALUE;
	}
	retval = PathFileExists(sourcePath);

	if (retval)
	{
		ret = GetFileName(sourcePath, &FileName);

		ret = SavePath(savePath, FileType);
		/*if(!PathFileExists(*savePath))
		{
		::CreateDiretory(savePath, NULL);
		}*/

		*savePath += FileName;

		while (!(CopyFile((LPCSTR)sourcePath, (LPCSTR)(*savePath), TRUE)))
		{
			repeatCount++;
			ret = FileSaveName(savePath, &FileName, repeatCount);
		}
		ret = SUCCESS_VALUE;
	} 
	else
	{
		ret = ERROR_FAILED_VALUE;
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
	int ret = ERROR_FAILED_VALUE;
	int length, rowNum;
	int pos;
	CString str, strline, empty_row;
	CString space = _T("&nbsp");
	CString sp = _T(" ");
	CString activeText;

	rowNum = m_edit->GetLineCount();
	CString ab;
	m_edit->GetWindowText(ab);
	int asdads = ab.Find("\r\n");
	int sab = strlen(ab);
	for (int i = 0; i < rowNum; i++)
	{
		pos = ab.Find("\r\n");

		if(pos == -1)
		{
			activeText = ab;
			*htmlString += activeText;
			htmlString->Replace(sp, space);
		}
		else
		{
			activeText = ab.Left(pos);
			ab = ab.Mid(pos+2, ab.GetLength());


			*htmlString += activeText;

			*htmlString += _T("<br>");
			htmlString->Replace(sp, space);
		}
	}
	  
		/*CString str_br = htmlString->Mid(strlen(*htmlString)-5, strlen(*htmlString));
		if(str_br.Find("<br>") != -1)
		{
			*htmlString = htmlString->Mid(0,strlen(* htmlString)-6);
		}	
		ret = SUCCESS_VALUE;
		int s1 = strlen(*htmlString);
		int s2 = strlen(ab);*/
		return ret;
	}
	

	int HtmlToTextblock(CString* htmlString ,CString *editString)
	{
		int ret = ERROR_FAILED_VALUE;
		CString sp = _T("&nbsp");
		CString sl = _T("<br>");
		CString space = _T(" ");
		CString swtichLine = _T("\r\n");
		*editString = *htmlString;
		CString edString = *htmlString;

		while(edString.Find(_T("<br>")) != -1)
		{
			int pos = edString.Find(_T("<br>"));
			CString strbr = edString.Mid(0, pos);
			CString canbr = edString.Mid(pos+4, 8);

			CString latestr;
			while(canbr.Find("<br>") != -1)
			{
				latestr = edString.Mid(pos+8, strlen(edString)-pos-7);
				canbr = edString.Mid(pos+8, 4);
				pos =pos+4;
			}
			edString = strbr+latestr;
		}
		editString->Replace(sp, space);
		editString->Replace(sl, swtichLine);
		int s3 = strlen(swtichLine);
		int s1 = strlen(*editString);
		int a = htmlString->Find("\r\n");
		int s12 = strlen(*htmlString);
		ret = SUCCESS_VALUE;

		return ret;
	}

	CString Encrypt(CString text) // 加密函数
	{	
		CString Result,str;
		WORD Key = 1314;
		int i,j;

		Result = text; // 初始化结果字符串
		for(i=0; i<text.GetLength(); i++) // 依次对字符串中各字符进行操作
		{
			Result.SetAt(i, text.GetAt(i)^(Key>>8)); // 将密钥移位后与字符异或
			Key = ((BYTE)Result.GetAt(i)+Key)*C1+C2; // 产生下一个密钥
		}
		text = Result; // 保存结果
		Result.Empty(); // 清除结果
		for(i=0; i<text.GetLength(); i++) // 对加密结果进行转换
		{
			j=(BYTE)text.GetAt(i); // 提取字符
			// 将字符转换为两个字母保存
			str="12"; // 设置str长度为2
			str.SetAt(0, 65+j/26);//这里将65改大点的数例如256，密文就会变乱码，效果更好，相应的，解密处要改为相同的数
			str.SetAt(1, 65+j%26);
			Result += str;
		}
		return Result;
	}

	// 解密函数
	CString Decrypt(CString text) 
	{
		CString Result,str;
		WORD Key = 1314;
		int i,j;

		Result.Empty(); // 清除结果
		for(i=0; i <text .GetLength()/2; i++) // 将字符串两个字母一组进行处理
		{
			j = ((BYTE)text.GetAt(2*i)-65)*26;//相应的，解密处要改为相同的数

			j += (BYTE)text.GetAt(2*i+1)-65;
			str="1"; // 设置str长度为1
			str.SetAt(0, j);
			Result+=str; // 追加字符，还原字符串
		}
		text = Result; // 保存中间结果
		for(i=0; i<text.GetLength(); i++) // 依次对字符串中各字符进行操作
		{
			Result.SetAt(i, (BYTE)text.GetAt(i)^(Key>>8)); // 将密钥移位后与字符异或
			Key = ((BYTE)text.GetAt(i)+Key)*C1+C2; // 产生下一个密钥
		}
		return Result;
	}

	int SetPwd(CString pwd)
	{
		int ret = ERROR_FAILED_VALUE;
		CString pszFileName="./data.txt";
		CString pwdSave;
		CStdioFile pwdFile;
		CFileException fileException;

		if(pwdFile.Open(pszFileName,CFile::typeText|CFile::modeCreate|CFile::modeReadWrite),&fileException)
		{
			pwdFile.WriteString("[password]\n");
			pwdSave = Encrypt(pwd);
			pwdFile.WriteString(pwdSave);

			ret = SUCCESS_VALUE;
			pwdFile.Close();
		}
		else
		{
			TRACE("Can't open file %s,error=%u\n",pszFileName,fileException.m_cause);
		}
		SetFileAttributes(pszFileName, FILE_ATTRIBUTE_HIDDEN);

		return ret;
	}


	//#define ERROR_PWDNOTEXIST_VALUE (0x10000110)
	// NOTE !!
	// pwdFileName is the name of the password file
	// Use like this:
	// CString password;
	// CString pwdFileName = _T("./data");
	// GetPwd(password, pwdFileName);
	int GetPwd(CString* pwd, CString pwdFileName)
	{
		int ret = ERROR_FAILED_VALUE;
		CStdioFile pwdFile;
		CFileException fileExpection;
		CString name, text;
		WORD key = 1314;

		if (PathFileExists(pwdFileName))
		{
			if (pwdFile.Open(pwdFileName, CFile::typeText|CFile::modeRead), &fileExpection)
			{
				pwdFile.SeekToBegin();
				pwdFile.ReadString(name);
				pwdFile.ReadString(text);

				*pwd = Decrypt(text);

				pwdFile.Close();		
			} 
		} 
		else
		{
			ret = ERROR_PWDNOTEXIST_VALUE;
		}
		return ret;
	}


	//#define ERROR_OLDPWD_VALUE		 (0x10000001)
	//#define ERROR_PWDNOTSAME_VALUE	 (0x10000011)
	// NOTE !!!
	// input (oldPwd, newPwd, pwdValidate) is the value of the editbox
	int AlterPwd(CString oldPwd, CString newPwd, CString pwdValidate, CString pwdFileName)
	{
		int ret = ERROR_FAILED_VALUE;
		CString password;
		CStdioFile pwdFile;
		CFileException fileException;
		CString pwdSave;
		int row;

		GetPwd(&password, pwdFileName);

		if (password == oldPwd)
		{
			if (newPwd == pwdValidate)
			{
				if(pwdFile.Open(pwdFileName,CFile::typeText|CFile::modeReadWrite),&fileException)//|CFile::modeCreate
				{
					pwdFile.WriteString("[password]\n");
					pwdSave = Encrypt(newPwd);
					pwdFile.WriteString(pwdSave);

					ret = SUCCESS_VALUE;
					pwdFile.Close();
				}
				else
				{
					TRACE("Can't open file %s,error=%u\n",pwdFileName, fileException.m_cause);
				}
			} 
			else
			{
				ret = ERROR_PWDNOTSAME_VALUE;
			}		
		} 
		else
		{
			ret = ERROR_OLDPWD_VALUE;
		}


		return ret;
	}

	int GetMonth(CString date,CString *month)
	{
		//CString stm = _T("2014/12/01");
		int num = date.Find(_T("月"));
		*month = _T("2015年");
		*month = *month + date.Mid(num -2, 2)+_T("月");
		return 1;
	}

	int GetTag(CString content,CString *month,CString tag)
	{
		//CString stm = _T("2014/12/01");
		CString key[MAX_DATA_NUM],val[MAX_DATA_NUM];
		int num = Getkeyval(content,key,val);
		for (int i=0;i<num;i++)
		{
			if (strcmp(key[i],tag)==0)
			{
				HtmlToTextblock(&val[i],month);
				//*month = val[i];
				break;
			}
		}
		return 1;
	}

	int DeleteAllChild(CTreeCtrl *m_tree,HTREEITEM hCataItem)
	{
		HTREEITEM hitem = m_tree->GetChildItem(hCataItem) ;
		while (hitem !=NULL)
		{
			m_tree->DeleteItem(hitem);
			hitem = m_tree->GetChildItem(hCataItem);
		}
		return 1;
	}

int IsExist(CTreeCtrl *m_tree,HTREEITEM hCataItem,HTREEITEM *hitem,CString month)
	{
		*hitem = NULL;
		int flag = 0;
		if (m_tree->ItemHasChildren(hCataItem))
		{
			HTREEITEM p1Item = m_tree->GetChildItem(hCataItem);

			while (p1Item != NULL)
			{
				CString msg = m_tree->GetItemText(p1Item);
				if(strcmp(msg,month)!=0)
				{					
					p1Item = m_tree->GetNextSiblingItem(p1Item);
				}
				else
				{
					*hitem = p1Item;
					flag = 1;
					break;
				}				
			}
		}
		else
		{
			flag = 0;
		}
		CString ddd = m_tree->GetItemText(*hitem);
		return flag;
	}

	int SortByDay(CTreeCtrl *m_tree,HTREEITEM hCataItem,int id)
	{
		DeleteAllChild(m_tree,hCataItem);
		INDEX_TABLE indextable;
		HTREEITEM hArtItem;
		int i;
		IMVL_LoadIndexTable(&indextable);
		for (i=0;i<indextable.num;i++)
		{
			if (indextable.index[i].iPID==id)
			{
				hArtItem = m_tree->InsertItem(indextable.index[i].name, 1, 1, hCataItem, TVI_LAST);
				m_tree->SetItemData(hArtItem, indextable.index[i].ID);
			}
		}
		m_tree->Expand(hCataItem,TVE_EXPAND);
		return 1;
	}

	int SortByMonth(CTreeCtrl *m_tree,HTREEITEM hCataItem)
	{
		DeleteAllChild(m_tree,hCataItem);
		INDEX_TABLE indextable;
		HTREEITEM hArtItem;
		HTREEITEM hitem = NULL;
		CString month;
		int i;
		IMVL_LoadIndexTable(&indextable);
		for (i=0;i<indextable.num;i++)
		{		
			if (indextable.index[i].iPID==28)
			{
				GetMonth(indextable.index[i].name,&month);
				if (IsExist(m_tree,hCataItem,&hitem,month)==0)
				{
					hitem = m_tree->InsertItem(month, 0, 0, hCataItem, TVI_FIRST);
					m_tree->SetItemData(hitem, -1);
					hArtItem = m_tree->InsertItem(indextable.index[i].name, 1, 1, hitem, TVI_LAST);
					m_tree->SetItemData(hArtItem, indextable.index[i].ID);
				}
				else
				{
					hArtItem = m_tree->InsertItem(indextable.index[i].name, 1, 1, hitem, TVI_LAST);
					m_tree->SetItemData(hArtItem, indextable.index[i].ID);
				}			
			}
		}
		//m_tree->Expand(hCataItem,TVE_EXPAND);
		return 1;
	}

	int SortByTag(CTreeCtrl *m_tree,HTREEITEM hCataItem,CString tag)
	{
		DeleteAllChild(m_tree,hCataItem);
		INDEX_TABLE indextable;
		HTREEITEM hArtItem;
		HTREEITEM hitem = NULL;
		CString month;
		int i;
		IMVL_LoadIndexTable(&indextable);
		for (i=0;i<indextable.num;i++)
		{		
			if (indextable.index[i].iPID==27)
			{
				GetTag(indextable.index[i].content,&month,tag);
				////GetMonth(indextable.index[i].name,&month);
				if (IsExist(m_tree,hCataItem,&hitem,month)==0)
				{
					
					if (strcmp(month ,_T(""))!=0)
					{
						hitem = m_tree->InsertItem(month, 0, 0, hCataItem, TVI_FIRST);
					    m_tree->SetItemData(hitem, -1);
						CString ddd = m_tree->GetItemText(hitem);
						hArtItem = m_tree->InsertItem(indextable.index[i].name, 1, 1, hitem, TVI_LAST);
						m_tree->SetItemData(hArtItem, indextable.index[i].ID);
					}
					else
					{
						CString ddd = m_tree->GetItemText(hCataItem);
						hArtItem = m_tree->InsertItem(indextable.index[i].name, 1, 1, hCataItem, TVI_LAST);
						m_tree->SetItemData(hArtItem, indextable.index[i].ID);
					}
				}
				else
				{
					CString ddd = m_tree->GetItemText(hitem);
					hArtItem = m_tree->InsertItem(indextable.index[i].name, 1, 1, hitem, TVI_LAST);
					m_tree->SetItemData(hArtItem, indextable.index[i].ID);
				}			
			}
		}
		m_tree->Expand(hCataItem,TVE_EXPAND);
		return 1;
	}

	int UpdateTree(CTreeCtrl *m_tree,int id,CString name)
	{	
		HTREEITEM hArtItem;
		HTREEITEM hitem = NULL;
		hitem = m_tree->GetSelectedItem();
		hArtItem = m_tree->InsertItem(name, 1, 1, hitem, TVI_LAST);
		m_tree->SetItemData(hArtItem, id);
		return 1;
	}

	int UpdateHtml(INDEX_NODE filenode)
	{
		INDEX_NODE foldernode;
		IMVL_GetNode(filenode.iPID,&foldernode);
		CString key[MAX_DATA_NUM],val[MAX_DATA_NUM],val1[MAX_DATA_NUM];
		//AfxMessageBox(indexnode.content);
		int num = Getkeyval(filenode.content, key, val );
		Getkeyval(foldernode.content, key, val1 );
		SetHtml(val1,val,key,filenode.name,"./html/MFCHtml.htm", num);
		return 1;
	}

	int UpdateList(CListCtrl *m_list,int id,CString name,int *pos)
	{
		INDEX_TABLE indextable;	
		int i,count = 0;
		CString namestr;
		IMVL_LoadIndexTable(&indextable);
		for (i=0;i<indextable.num;i++)
		{		
			if (indextable.index[i].iPID==id)
			{

				namestr= indextable.index[i].name;
				int idc=m_list->InsertItem(count,namestr);
				m_list->SetItemText(count, 1, name);

				if (pos[2]!=-1)
				{
					m_list->SetItemText(count, 2, indextable.index[i].modifyTime);
					m_list->SetItemText(count, 3, indextable.index[i].createTime);
				}
				else
				{
					m_list->SetItemText(count, 2, indextable.index[i].createTime);
				}

				m_list->SetItemData(count,indextable.index[i].ID);	
			}
		}
		return 1;
	}

	int ListAddRow(CListCtrl *m_list,CString tag,bool ischeck)
	{
		CRect rect; 	  
		m_list->GetClientRect(&rect);  
		int column = m_list->GetHeaderCtrl()->GetItemCount();
		if (ischeck == false)
		{
			m_list->InsertColumn(column, tag, LVCFMT_CENTER,rect.Width()/column, column);
			/*int row = m_list->GetItemCount();
			for (int i=0;i<row;i++)
			{
			m_list->GetItemData(i);

			m_list->SetItemText(i, 2, _T("1"));
			}*/
		}
		else
		{
			m_list->DeleteColumn(3);
		}
		ischeck = !ischeck;
		return 1;
	}

	int GetCurrTime(CString *time)
	{
		CString str; 
		CTime tm;
		tm=CTime::GetCurrentTime(); 
		str=tm.Format("%Y-%m-%d %H:%M:%S");

		*time = str;
		return 1;

	}

	int UpdateListRow(CListCtrl *m_list,int pos,int tag)
	{
		INDEX_NODE file;	
		int num = m_list->GetItemCount();
		for (int i =0;i<num;i++)
		{
			int id = m_list->GetItemData(i);
			IMVL_GetNode(id,&file);
			if (tag ==1)
			{
				m_list->SetItemText(i,pos,file.modifyTime);
			}
			else
			{
				m_list->SetItemText(i,pos,file.createTime);
			}		
		}
		return 1;
	}

	int TimeSearch(INDEX_TABLE* ret_index_table, CStringArray* timeInterval, int idOfFold)
	{
		int ret = ERROR_FAILED_VALUE;
		int num, count = 0;
		CString timeStart, timeEnd;
		INDEX_TABLE index_table;

		timeStart = timeInterval->GetAt(0) + _T(" 00:00");
		timeEnd  = timeInterval->GetAt(1) + _T(" 00:00");

		IMVL_Search("k(e}y",&index_table);
		num = index_table.num;

		for (int i = 0; i < num; i++)
		{
			if ((timeStart.Compare(index_table.index[i].createTime) < 0)&&(timeEnd.Compare(index_table.index[i].createTime) > 0)&&(index_table.index[i].iPID == idOfFold))
			{
				ret_index_table->index[count++] = index_table.index[i];
			}
		}
		ret_index_table->num = count;

		return ret;
	}


	int idIsExist(int* ids, int id)
	{
		int ret = ERROR_FAILED_VALUE;

		if (*ids == -1)  //未修改数据的初始化数组
		{
			//		ret = SUCCESS_VALUE;
			return ret;
		} 
		else
		{
			for (int i = 0; i < MAX_DATA_NUM; i++)
			{
				if (*(ids+i) == id)
				{
					ret = SUCCESS_VALUE;
					break;
				}
			}
		}


		return ret;
	}

	int MergeIds(int* ids, int enterTimes)
	{
		int ret = ERROR_FAILED_VALUE;
		int newIds[MAX_DATA_NUM];
		int countIds = 0;
		int ret_idsCount = 0;
		int temp;

		memset(newIds, 0 , sizeof(newIds));  //全部初始化为零

		if (enterTimes == 0)  //没有数据
		{


			return ret;
		} 
		else
		{
			while(*(ids + ret_idsCount) != -1)
			{
				newIds[ret_idsCount] = *(ids + ret_idsCount);
				ret_idsCount++;
			}

			for (int i = 0; i < ret_idsCount; i++)
			{
				for (int j = i+1; j < ret_idsCount; j++)
				{
					if (newIds[j] == newIds[i])
					{
						*(ids + countIds) = newIds[i];
						countIds++;
					}
				}			
			}
			while (countIds < MAX_DATA_NUM)
			{
				*(ids + countIds) = -1;
				countIds++;
			}

			ret = SUCCESS_VALUE;
		}

		return ret;
	}


	// node			将要比较的节点
	// propertyName 将要比较的标签名
	// condition	比较的条件（大于或小于） 1 --- 大于，  -1 ---- 小于
	// inputStr     将要比较的值（编辑框中的输入）
	int LargeOrSmall(INDEX_NODE node, CString propertyName, int condition, CString inputStr)
	{
		int ret = ERROR_FAILED_VALUE;
		CString key[MAX_DATA_NUM];
		CString val[MAX_DATA_NUM];
		int i = 0;
		int propertyValue, inputValue;

		inputValue = _ttoi(inputStr);
		Getkeyval(node.content, key, val);

		while(1)
		{
			if (key[i] == propertyName)
			{
				propertyValue = _ttoi(val[i]);
				break;
			}
			i++;
		}
		if ((condition == -1 && propertyValue < inputValue)||(condition == 1 && propertyValue > inputValue))
		{		
			ret = SUCCESS_VALUE;
		} 
		return ret;
	}


	int GetSearchResult(INDEX_TABLE* ret_index_table, int* ids, int flag)
	{
		int ret = ERROR_FAILED_VALUE;

		if (flag == 0)
		{
			ret = SUCCESS_VALUE;
		} 
		else
		{
			for (int i = 0; i < ret_index_table->num; i++)
			{
				if (idIsExist(ids, ret_index_table->index[i].ID) == ERROR_FAILED_VALUE)
				{
					ret_index_table->index[i].ID = -1;
				}
			}
			ret = SUCCESS_VALUE;
		}

		return ret;
	}

	int GetLatestSearchIds(INDEX_TABLE* ret_index_table, int* ids, CStringArray* conditions, int enterTimes)
	{
		int ret = ERROR_FAILED_VALUE;
		int condition;
		CString strCondition, strInput;
		CString key[MAX_DATA_NUM], val_property[MAX_DATA_NUM];
		int idsCount, propertyNum;
		int i = 0;

		/*while(*(ids++) != -1)
		{
		i++;
		}*/
		while(ids[i] != -1)
		{
			i++;
		}


		idsCount = i; //序号-1
		strCondition = conditions->GetAt(2);   // 获得比较条件 	

		if (conditions->GetAt(0) == _T("或者"))  
		{
			if ((strCondition == "大于")||(strCondition == "小于"))  //数值比较
			{
				if (strCondition == "大于") {	condition = 1;	}
				else{	condition = -1;		}

				for (int j = 0; j < ret_index_table->num; j++)
				{
					ret = LargeOrSmall(ret_index_table->index[j], conditions->GetAt(1), condition, conditions->GetAt(3));
					if (ret == SUCCESS_VALUE)
					{
						if (idIsExist(ids, ret_index_table->index[j].ID) == ERROR_FAILED_VALUE)
						{
							ids[idsCount]=ret_index_table->index[j].ID;

							idsCount++;
							break;
						}

					}
				}
			}
			else  //非数值比较
			{
				strInput = conditions->GetAt(3);

				for (int j = 0; j < ret_index_table->num; j++)
				{
					propertyNum = Getkeyval(ret_index_table->index[j].content, key, val_property);

					for (int k = 0; k < propertyNum; k++)
					{
						if (key[k] == conditions->GetAt(1))
						{
							if (StrStrI(val_property[k], strInput))   
							{
								ids[idsCount]=ret_index_table->index[j].ID;
								idsCount++;
								break;
							}
						} 
					}
				}
			}

		} 
		else  //并且
		{
			if ((strCondition == "大于")||(strCondition == "小于"))  //数值比较
			{
				if (strCondition == "大于") {	condition = 1;	}
				else{	condition = -1;		}

				for (int j = 0; j < ret_index_table->num; j++)
				{
					ret = LargeOrSmall(ret_index_table->index[j], conditions->GetAt(1), condition, conditions->GetAt(3));
					if (ret == SUCCESS_VALUE)
					{
						if (idIsExist(ids, ret_index_table->index[j].ID) == ERROR_FAILED_VALUE)
						{
							ids[idsCount]=ret_index_table->index[j].ID;
							idsCount++;
						}
					}
				}

				MergeIds(ids, enterTimes);

			}
			else  //非数值比较
			{
				strInput = conditions->GetAt(3);

				for (int j = 0; j < ret_index_table->num; j++)
				{
					propertyNum = Getkeyval(ret_index_table->index[j].content, key, val_property);

					for (int k = 0; k < propertyNum; k++)
					{
						if (key[k] == conditions->GetAt(1))
						{
							if (StrStrI(val_property[k], strInput))   
							{
								//*(ids + idsCount) = ret_index_table->index[j].ID;
								ids[idsCount]=ret_index_table->index[j].ID;

								idsCount++;
							}
						} 
					}

				}
				//将所有存在的都加入ids之后，再取得重复的交集
				MergeIds(ids, enterTimes);			
			}
		}

		return ret;
	}


	// idOfFold is the id of address book  or  dairy  or  project 
	int AdvancedSearch(INDEX_TABLE* ret_index_table, int idOfFold, CStringArray* searchCriteria)
	{
		int ret = ERROR_FAILED_VALUE;
		int num = searchCriteria->GetCount() / 4;
		int condition;
		INDEX_NODE folder;
		CString key[MAX_DATA_NUM];
		CString val_folder[MAX_DATA_NUM], val_property[MAX_DATA_NUM];
		CString strCondition, strInput;
		CStringArray conditions;
		//	int ids[MAX_DATA_NUM][MAX_DATA_NUM]= {-1};   //定义最多搜索MAX_DATA_NUM(200)项
		int ids[MAX_DATA_NUM];   //定义最多搜索MAX_DATA_NUM(200)项
		int idsCount, propertyNum;
		int flag = 0;

		memset(ids, -1, sizeof(ids));
		IMVL_GetNode(idOfFold, &folder);
		Getkeyval(folder.content, key, val_folder);  // 获得文件夹的属性


		for (int i = 0; i < num; i++)
		{
			conditions.RemoveAll();
			conditions.Add(searchCriteria->GetAt(i*4));
			conditions.Add(searchCriteria->GetAt(i*4+1));
			conditions.Add(searchCriteria->GetAt(i*4+2));
			conditions.Add(searchCriteria->GetAt(i*4+3));

			GetLatestSearchIds(ret_index_table, ids, &conditions , i);
			flag = 1;
		}

		GetSearchResult(ret_index_table, ids, flag);
		return ret;
	}


	//bool CreateDirectory(CString lpPathName,  LPSECURITY_ATTRIBUTES   lpSecurityAttributes    )
	//{
	//
	//}


	bool DeleteDirectory1( CString DirName)
	{
		CString PUBPATH;
		PUBPATH=DirName;
		CFileFind tempFind;
		DirName+="\\*.*";
		BOOL IsFinded=(BOOL)tempFind.FindFile(DirName);
		while(IsFinded)
		{
			IsFinded=(BOOL)tempFind.FindNextFile();
			if(!tempFind.IsDots())
			{
				CString strDirName;
				strDirName+=PUBPATH;
				strDirName+="\\";
				strDirName+=tempFind.GetFileName();
				if(tempFind.IsDirectory())
				{
					DeleteDirectory1(strDirName);
				}
				else
				{
					SetFileAttributes(strDirName,FILE_ATTRIBUTE_NORMAL); //去掉文件的系统和隐藏属性
					DeleteFile(strDirName);
				}
			}
		}
		tempFind.Close();
		if(!RemoveDirectory(PUBPATH))
		{
			return false ;
		}
		return true;
	}

	int HtmlToWord(CString* htmlString ,CString *editString)
	{
		int ret = ERROR_FAILED_VALUE;
		CString sp = _T("&nbsp");
		CString sl = _T("<br>");
		CString space = _T(" ");
		CString swtichLine = _T("\n");
		*editString = *htmlString;
		CString edString = *htmlString;

		while(edString.Find(_T("<br>")) != -1)
		{
			int pos = edString.Find(_T("<br>"));
			CString strbr = edString.Mid(0, pos);
			CString canbr = edString.Mid(pos+4, 8);

			CString latestr;
			while(canbr.Find("<br>") != -1)
			{
				latestr = edString.Mid(pos+8, strlen(edString)-pos-7);
				canbr = edString.Mid(pos+8, 4);
				pos =pos+4;
			}
			edString = strbr+latestr;
		}
		editString->Replace(sp, space);
		editString->Replace(sl, swtichLine);
		int s3 = strlen(swtichLine);
		int s1 = strlen(*editString);
		int a = htmlString->Find("\n");
		int s12 = strlen(*htmlString);
		ret = SUCCESS_VALUE;

		return ret;
	}