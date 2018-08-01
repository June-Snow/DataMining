// CListCtrlToExcel.cpp : Defines the class behaviors for the application.
//

#include "stdafx.h"
#include "CListCtrlToExcel.h"
#include "CListCtrlToExcelDlg.h"
#include <io.h>
#include <odbcinst.h>
#include <afxdb.h>

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CCListCtrlToExcelApp

BEGIN_MESSAGE_MAP(CCListCtrlToExcelApp, CWinApp)
	//{{AFX_MSG_MAP(CCListCtrlToExcelApp)
		// NOTE - the ClassWizard will add and remove mapping macros here.
		//    DO NOT EDIT what you see in these blocks of generated code!
	//}}AFX_MSG
	ON_COMMAND(ID_HELP, CWinApp::OnHelp)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CCListCtrlToExcelApp construction

CCListCtrlToExcelApp::CCListCtrlToExcelApp()
{
	// TODO: add construction code here,
	// Place all significant initialization in InitInstance
}

/////////////////////////////////////////////////////////////////////////////
// The one and only CCListCtrlToExcelApp object

CCListCtrlToExcelApp theApp;

/////////////////////////////////////////////////////////////////////////////
// CCListCtrlToExcelApp initialization

BOOL CCListCtrlToExcelApp::InitInstance()
{
	AfxEnableControlContainer();

	// Standard initialization
	// If you are not using these features and wish to reduce the size
	//  of your final executable, you should remove from the following
	//  the specific initialization routines you do not need.

#ifdef _AFXDLL
	Enable3dControls();			// Call this when using MFC in a shared DLL
#else
	Enable3dControlsStatic();	// Call this when linking to MFC statically
#endif

	CCListCtrlToExcelDlg dlg;
	m_pMainWnd = &dlg;
	int nResponse = dlg.DoModal();
	if (nResponse == IDOK)
	{
		// TODO: Place code here to handle when the dialog is
		//  dismissed with OK
	}
	else if (nResponse == IDCANCEL)
	{
		// TODO: Place code here to handle when the dialog is
		//  dismissed with Cancel
	}

	// Since the dialog has been closed, return FALSE so that we exit the
	//  application, rather than start the application's message pump.
	return FALSE;
}

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
//    �ж�Path�ļ�(FilenameIncluded = true)�Ƿ���ڣ����ڷ���TRUE�������ڷ���FALSE
//    �Զ�����Ŀ¼
//
///////////////////////////////////////////////////////////////////////////////////
BOOL MakeSurePathExists(CString &Path , bool FilenameIncluded)
{
	int Pos=0;
	while((Pos=Path.Find('\\',Pos+1))!=-1)
		CreateDirectory(Path.Left(Pos),NULL);
	if(!FilenameIncluded)
		CreateDirectory(Path,NULL);
	//return ((!FilenameIncluded)?=_access(Path,0):
	//!_access(Path.Left(Path.ReverseFind('\\')),0);

	return !_access(Path,0);
}

/////////////////////////////////////////////////////
//���ƣ�GetDefaultXlsFileName(CString& sExcelFile)
//���ܣ����Ĭ���ļ���
/////////////////////////////////////////////////////
BOOL GetDefaultXlsFileName(CString& sExcelFile)
{
	//Ĭ���ļ�����yyyymmddmmss.xls
	CString timeStr;
	CTime day;
	day=CTime::GetCurrentTime();
	int filenameday,filenamemonth,filenameyear,filehour,filemin,filesec;
	filenameday   = day.GetDay();    //dd��
	filenamemonth = day.GetMonth();  //mm�·�
	filenameyear  = day.GetYear();   //yyyy���
	filehour      = day.GetHour();   //hhСʱ
	filemin       = day.GetMinute(); //mm����
	filesec       = day.GetSecond(); //ss��
	timeStr.Format("%04d%02d%02d%02d%02d%02d",filenameyear,filenamemonth,filenameday,filehour,filemin,filesec);

	sExcelFile = timeStr + ".xls";
	// prompt the user (with all document templates)


    CFileDialog dlgFile(FALSE,".xls",sExcelFile,OFN_HIDEREADONLY,_T("Excel ������(*.xls)|*.xls|�����ļ�(*.*)|*.*||"));
	dlgFile.m_ofn.lpstrTitle = "����";

	if(dlgFile.DoModal()==IDCANCEL)
	{
		return FALSE;
	}
	sExcelFile.ReleaseBuffer();
	if(MakeSurePathExists(sExcelFile))
	{
		if(!DeleteFile(sExcelFile))
		{
			AfxMessageBox("�����ļ�ʱ����!");
			return FALSE;
		}
	}

	return TRUE;

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
	CString warningStr;
	if(pList->GetItemCount()>0)
	{
		CDatabase database;
		CString sDriver;
		CString sExcelFile;
		CString sSql;
		CString tableName = strTitle;

		//�����Ƿ�װ��Excel���� "Microsoft Excel Driver (*.xls)"
		sDriver = GetExcelDriver();
		if(sDriver.IsEmpty())
		{
			//û�з���Excel����
			AfxMessageBox("û�а�װExcel!\n���Ȱ�װExcel�������ʹ�õ�������!");
			return;
		}

		//Ĭ���ļ���
		if(!GetDefaultXlsFileName(sExcelFile))
			return;

		//�������д�ȡ���ַ���
		sSql.Format("DRIVER={%s};DSN='';FIRSTORWHASNAMES=1;READONLY=FALSE;CREATE_DB=\"%s\";DBQ=%s",sDriver,sExcelFile,sExcelFile);

		//�������ݿ�(��Excel����ļ�)
		if(database.OpenEx(sSql,CDatabase::noOdbcDialog))
		{
			//������ṹ
			int i;
			LVCOLUMN columnData;
			CString columnName;
			int columnNum=0;
			CString strH,strV;
			sSql="";
			strH="";
			columnData.mask = LVCF_TEXT;
			columnData.cchTextMax = 100;
			columnData.pszText = columnName.GetBuffer(100);
			for(i=0;pList->GetColumn(i,&columnData);i++)
			{
				if(i!=0)
				{
					sSql=sSql+", ";
					strH=strH+", ";
				}
				sSql = sSql + " " + columnData.pszText + " TEXT";
				strH = strH + " " + columnData.pszText + " ";
			}
			columnName.ReleaseBuffer();
			columnNum = i;

			sSql = "CREATE TABLE " + tableName + " ( " + sSql + " ) ";
			database.ExecuteSQL(sSql);

			//����������
			int nItemIndex;
			for(nItemIndex=0;nItemIndex<pList->GetItemCount();nItemIndex++)
			{
				strV = "";
				for(i=0;i<columnNum;i++)
				{
					if(i!=0)
					{
						strV = strV + ", ";
					}
					strV = strV + " '" + pList->GetItemText(nItemIndex,i) + "' ";
				}

				sSql = "INSERT INTO " + tableName + " (" + strH + ")" + "VALUES(" + strV + ")";
				database.ExecuteSQL(sSql);
			}
		}
		
		//�ر����ݿ�
		database.Close();

		warningStr.Format("�����ļ�������%s��!",sExcelFile);
		AfxMessageBox(warningStr);
		ShellExecute(NULL,"open",sExcelFile,NULL,NULL,SW_SHOW);    //������ʾ�ļ���ΪstrFile�����ݱ�
	    
	}
	else
	{
		//û������
		MessageBox(NULL,"û�����ݣ����ܵ���!","��ʾ",MB_OK|MB_ICONWARNING|MB_TOPMOST);
		
	}
}
