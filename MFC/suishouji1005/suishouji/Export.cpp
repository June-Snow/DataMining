#include "Export.h"
#include "stdafx.h"
#include <odbcinst.h>
#include <io.h>
#include <afxdb.h>
#include "InitializeCtrl.h"



//��������

/////////////////////////////////////////////////////////////////////////
//���ƣ�GetExcelDriver
//���ܣ���ȡODBC��Excel����
//���ڣ�2014-3-5
/////////////////////////////////////////////////////////////////////////
CString GetExcelDriver()
{
	char szBuf[2001];
	WORD cbBufMax = 2000;
	WORD cbBufOut;
	char *pszBuf = szBuf;
	CString sDriver;

	//��ȡ�Ѱ�װ����������(������odbcinst.h��)
	if(!SQLGetInstalledDrivers(szBuf,cbBufMax,&cbBufOut))
		return "";

	//�����Ѱ�װ�������Ƿ���Excel...
	do 
	{
		if(strstr(pszBuf,"Excel") != 0)			
		{
			//����!
			sDriver = CString(pszBuf);
			break;
		}
		pszBuf=strchr(pszBuf,'\0') + 1;
	} while (pszBuf[1]!='\0');

	return sDriver;
}

///////////////////////////////////////////////////////////////////////////////////
//���ƣ�BOOL MakeSurePathExists(CString &Path , bool FilenameIncluded)
//������
//    Path                   ·��
//    FilenameIncluded       ·���Ƿ�����ļ���
//����ֵ��
//    �ļ��Ƿ����
//˵����
//    �ж�Path�ļ�(FilenameIncluded = true)�Ƿ���ڣ����ڷ���true�������ڷ���FALSE
//    �Զ�����Ŀ¼
//
///////////////////////////////////////////////////////////////////////////////////
BOOL MakeSurePathExists(CString &Path , bool FilenameIncluded)
{
	int Pos=0;
	while((Pos=Path.Find('\\',Pos+1))!=-1)
		CreateDirectory(Path.Left(Pos),NULL);
	if(!true)
		CreateDirectory(Path,NULL);
	//return ((!FilenameIncluded)?=_access(Path,0):
	//!_access(Path.Left(Path.ReverseFind('\\')),0);

	return !_access(Path,0);
}

//���Ӵ洢����
/////////////////////////////////////////////////////
//���ƣ�GetDefaultXlsFileName(CString& sExcelFile)
//���ܣ����Ĭ���ļ���
/////////////////////////////////////////////////////
BOOL GetDefaultFileName(CString& sWordFile, CString strname, CString const type)
{
	//Ĭ���ļ�����yyyymmddmmss.xls
	if(strcmp(type, _T("doc")) == 0)
	{
		sWordFile = strname + _T(".doc");
		CFileDialog dlgFile(FALSE,_T("*.doc"),sWordFile,OFN_HIDEREADONLY,_T("word �ĵ�(*.doc)|*.doc|�����ļ�(*.*)|*.*||"));
		dlgFile.m_ofn.lpstrTitle = _T("����");
		if(dlgFile.DoModal()== IDOK)
		{
			sWordFile = dlgFile.GetPathName();
			sWordFile.ReleaseBuffer();
			if(MakeSurePathExists(sWordFile,true))
			{
				AfxMessageBox(_T("���ļ����Ѿ����ڣ�����������!"));
				GetDefaultFileName(sWordFile, strname, type);
				//if(!DeleteFile(sWordFile))
				//{
				//	AfxMessageBox(_T("�����ļ�ʱ����!"));
				//	return false;
				//}
			}
			return true;
		}
	}
	if(strcmp(type, _T("xls")) == 0)
	{
		sWordFile = strname + _T(".xls");
		CFileDialog dlgFile(FALSE,_T("*.xls"),sWordFile,OFN_HIDEREADONLY,_T("Excel ������(*.xls)|*.xls|�����ļ�(*.*)|*.*||"));
		dlgFile.m_ofn.lpstrTitle = _T("����");
		if(dlgFile.DoModal()== IDOK)
		{
			sWordFile = dlgFile.GetPathName();
			sWordFile.ReleaseBuffer();
			if(MakeSurePathExists(sWordFile,true))
			{
				AfxMessageBox(_T("���ļ����Ѿ����ڣ�����������!"));
				GetDefaultFileName(sWordFile, strname, type);
				//if(!DeleteFile(sWordFile))
				//{
				//	AfxMessageBox(_T("�����ļ�ʱ����!"));
				//	return false;
				//}
			}
			return true;
		}
	}
	return false;
}



//////////////////////////////////////////////////////////////////////////////
//	������void CListCtrlToExcel(CListCtrl* pList, CString strTitle)
//	������
//		pList		��Ҫ������List�ؼ�ָ��
//		strTitle	���������ݱ����
//	˵��:
//		����CListCtrl�ؼ���ȫ�����ݵ�Excel�ļ���Excel�ļ������û�ͨ�������Ϊ��
//		�Ի�������ָ����������ΪstrTitle�Ĺ�������List�ؼ��ڵ��������ݣ�����
//		��������������ı�����ʽ���浽Excel�������С��������й�ϵ��
//	
//////////////////////////////////////////////////////////////////////////////
void CListCtrlToExcel(CListCtrl* pList, CString strTitle)
{
	//CString warningStr;
	//if(pList->GetItemCount()>0)
	//{
	//	CDatabase database;
	//	CString sDriver;
	//	CString sExcelFile;
	//	CString sSql;
	//	CString tableName = strTitle;

	//	//�����Ƿ�װ��Excel���� "Microsoft Excel Driver (*.xls)"//
	//	sDriver = GetExcelDriver();
	//	if(sDriver.IsEmpty())
	//	{
	//		//û�з���Excel����
	//		AfxMessageBox(_T("û�а�װExcel!\n���Ȱ�װExcel�������ʹ�õ�������!"));
	//		return;
	//	}

	//	//Ĭ���ļ���
	//	if(!GetDefaultFileName(sExcelFile, strhTtem, _T("xls")))
	//		return;

	//	//�������д�ȡ���ַ���
	//	sSql.Format(_T("DRIVER={%s};DSN='';FIRSTORWHASNAMES=1;READONLY=FALSE;CREATE_DB=\"%s\";DBQ=%s"),sDriver,sExcelFile,sExcelFile);

	//	//�������ݿ�(��Excel����ļ�)
	//	if(database.OpenEx(sSql,CDatabase::noOdbcDialog))
	//	{
	//		//������ṹ
	//		int i;
	//		LVCOLUMN columnData;
	//		CString columnName;
	//		int columnNum=0;
	//		CString strH,strV;
	//		sSql=_T("");
	//		strH=_T("");
	//		columnData.mask = LVCF_TEXT;
	//		columnData.cchTextMax = 100;
	//		columnData.pszText = columnName.GetBuffer(100);
	//		for(i=0;pList->GetColumn(i,&columnData);i++)
	//		{
	//			if(i!=0)
	//			{
	//				sSql=sSql+_T(", ");
	//				strH=strH+_T(", ");
	//			}
	//			sSql = sSql + _T(" ") + columnData.pszText + _T("TEXT");
	//			strH = strH + _T(" ") + columnData.pszText + _T(" ");
	//		}
	//		columnName.ReleaseBuffer();
	//		columnNum = i;

	//		sSql = _T("CREATE TABLE ") + tableName + _T(" ( ") + sSql + _T(" ) ");
	//		database.ExecuteSQL(sSql);

	//		//����������
	//		int nItemIndex;
	//		for(nItemIndex=0;nItemIndex<pList->GetItemCount();nItemIndex++)
	//		{
	//			strV = _T("");
	//			for(i=0;i<columnNum;i++)
	//			{
	//				if(i!=0)
	//				{
	//					strV = strV + _T(", ");
	//				}
	//				strV = strV + _T(" '") + pList->GetItemText(nItemIndex,i) + _T("' ");
	//			}

	//			sSql = _T("INSERT INTO ") + tableName + _T("(") + strH + _T(")") + _T("VALUES(") + strV + _T(")");
	//			database.ExecuteSQL(sSql);
	//		}
	//	}

	//	//�ر����ݿ�
	//	database.Close();

	//	warningStr.Format(_T("�����ļ�������%s��!"),sExcelFile);
	//	AfxMessageBox(warningStr);
	//	ShellExecute(NULL,_T("open"),sExcelFile,NULL,NULL,SW_SHOW);    //������ʾ�ļ���ΪstrFile�����ݱ�

	//}
	//else
	//{
	//	//û������
	//	MessageBox(NULL,_T("û�����ݣ����ܵ���!"),_T("��ʾ"),MB_OK|MB_ICONWARNING|MB_TOPMOST);

	//}
}
