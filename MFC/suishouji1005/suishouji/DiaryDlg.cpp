// DiaryDlg.cpp : 实现文件
//

#include "stdafx.h"
#include "suishouji.h"
#include "DiaryDlg.h"
#include "afxdialogex.h"
#include "DB_operater.h"
#include "InitializeCtrl.h"
// CDiaryDlg 对话框

IMPLEMENT_DYNAMIC(CDiaryDlg, CDialogEx)

CDiaryDlg::CDiaryDlg(CWnd* pParent /*=NULL*/)
	: CDialogEx(CDiaryDlg::IDD, pParent)
{

}

CDiaryDlg::~CDiaryDlg()
{
}

void CDiaryDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_EDIT3, m_topic);
	DDX_Control(pDX, IDC_EDIT2, m_article);
}


BEGIN_MESSAGE_MAP(CDiaryDlg, CDialogEx)
	ON_BN_CLICKED(IDC_BUTTON1, &CDiaryDlg::OnBnClickedButton1)
END_MESSAGE_MAP()

BOOL CDiaryDlg::OnInitDialog()
{
	CDialogEx::OnInitDialog();
	TextFont.CreatePointFont(120,_T("宋体"));
	GetDlgItem(IDC_STATIC1234)->SetFont(&TextFont);
	GetDlgItem(IDC_STATIC1235)->SetFont(&TextFont);
	GetDlgItem(IDC_STATIC1236)->SetFont(&TextFont);

	if(isedit==0)
	{
	   CString str; //获取系统时间 
	   CTime tm;
	   tm=CTime::GetCurrentTime(); 
	   str=tm.Format("%Y年%m月%d日%H时%M分");
	   SetDlgItemText(IDC_savedate,str);
	}
	else
	{
		INDEX_NODE filenode;
		INDEX_NODE foldernode;
		IMVL_GetNode(id,&filenode);
		CString key[MAX_DATA_NUM],val[MAX_DATA_NUM],val1[MAX_DATA_NUM];		
		Getkeyval(filenode.content, key, val );
		SetDlgItemText(IDC_savedate,val[0]);		
		m_topic.SetWindowTextA(val[1]);		


		//m_article.SetWindowTextA(val[2]);

		CString editString;
		HtmlToTextblock(&val[2] ,&editString);
		//MessageBox(editString);
		//CString msgstr;
		//while(editString.Find(_T("\\r\\n")) != -1)
		//{
		//	int pos = editString.Find(_T("\\r\\n"));
		//	CString str = editString.Mid(0, pos);
		//	editString = editString.Mid(pos+4, strlen(editString));
		//	msgstr = msgstr +str+ _T("\r\n");
		//}

		//if(strlen(msgstr) == 0)
		//{
		//	msgstr = editString;
		//}
		m_article.SetWindowText(editString);



	}
	GetDlgItem(IDC_savedate)->SetFont(&TextFont);
	m_topic.SetFont(&TextFont);
	m_article.SetFont(&TextFont);
	return TRUE;
}
// CDiaryDlg 消息处理程序


void CDiaryDlg::OnBnClickedButton1()
{
	// TODO: 在此添加控件通知处理程序代码
	CString keyvaluestr;
	CString date;
	CString topic;
	CString article;
	int msg;
	GetDlgItemText(IDC_savedate,date);
	m_topic.GetWindowTextA(topic);	
	textblockToHtml(&m_article, &article);

	//m_article.GetWindowTextA(article);

	keyvaluestr = keyvaluestr + "k(e}y" + _T("日期") + "v(a}l" + date;
	keyvaluestr = keyvaluestr + "k(e}y" + _T("主题") + "v(a}l" + topic;

	keyvaluestr = keyvaluestr + "k(e}y" + _T("正文") + "v(a}l" + article;
	keyvaluestr = keyvaluestr + "k(e}y";
	INDEX_NODE filenode;

	filenode.IsFolder=0;
	filenode.iPID=28;
	strcpy_s(filenode.name, date);
	if (strcmp(article,"")==0)
	{
		MessageBox(_T("日记正文不可为空！"),_T("操作提示"),MB_OK|MB_ICONERROR  );
	}
	else if (strlen(keyvaluestr)>1300)
	{
		MessageBox(_T("日记内容过大，编辑失败"),_T("操作提示"),MB_OK|MB_ICONERROR);
	}
	else
	{
		CString time;
		GetCurrTime(&time);
		if(isedit == 0)
		{	
			strcpy_s(filenode.createTime, time);
			strcpy_s(filenode.modifyTime, time);
			strcpy_s(filenode.content, keyvaluestr);
			int s1 = strlen(keyvaluestr);
			int s2 = strlen(filenode.content);
			msg = IMVL_Create(28,&filenode);


			//INDEX_NODE foldernode1;
			//IMVL_GetNode(filenode.iPID,&foldernode1);
			//CString key[MAX_DATA_NUM],val[MAX_DATA_NUM],val1[MAX_DATA_NUM];
			////AfxMessageBox(indexnode.content);
			//int num = Getkeyval(filenode.content, key, val );
			//Getkeyval(foldernode1.content, key, val1 );
			////SetHtml(val1,val,key,filenode.name,"MFCHtml.htm", num);
			//SetDiaryHtml(val, "DiaryHtml.htm");
			//CHAR		szPath[MAX_PATH];
			//memset(szPath, 0, sizeof(CHAR)*MAX_PATH);
			//GetCurrentDirectory(MAX_PATH, szPath);
			//StrCat(szPath, _T("./html/DiaryHtml.htm"));
			//diaryedit->Navigate(szPath,NULL,NULL,NULL,NULL);


			if(strcmp(sorttag2,_T("天"))==0)
			{
				HTREEITEM hArtItem;
				hArtItem = m_tree->InsertItem(filenode.name, 1, 1, m_tree->GetSelectedItem(), TVI_LAST);
				m_tree->SetItemData(hArtItem, filenode.ID);
			}
			else
			{
				SortByMonth(m_tree,m_tree->GetSelectedItem());
			}
		}
		else
		{
			INDEX_NODE foldernode;
			IMVL_GetNode(id,&foldernode);
			strcpy_s(filenode.createTime, foldernode.createTime);
			strcpy_s(filenode.modifyTime, time);
			strcpy_s(filenode.content, keyvaluestr);
			filenode.ID = id;
			int s1 = strlen(keyvaluestr);
			int s2 = strlen(filenode.content);
			msg = IMVL_Update(&filenode);


			INDEX_NODE foldernode1;
			IMVL_GetNode(filenode.iPID,&foldernode1);
			CString key[MAX_DATA_NUM],val[MAX_DATA_NUM],val1[MAX_DATA_NUM];
			//AfxMessageBox(indexnode.content);
			int num = Getkeyval(filenode.content, key, val );
			Getkeyval(foldernode1.content, key, val1 );
			//SetHtml(val1,val,key,filenode.name,"MFCHtml.htm", num);

			     SetDiaryHtml(val, exe_path);

				//CHAR		szPath[MAX_PATH];
				//memset(szPath, 0, sizeof(CHAR)*MAX_PATH);
				//GetCurrentDirectory(MAX_PATH, szPath);
				//StrCat(szPath, (exe_path+_T("/html/DiaryHtml.htm")));

				diaryedit->Navigate((exe_path+_T("\\html\\DiaryHtml.htm")),NULL,NULL,NULL,NULL);

			//SetDiaryHtml(val, "DiaryHtml.htm");
		/*	CHAR		szPath[MAX_PATH];
			memset(szPath, 0, sizeof(CHAR)*MAX_PATH);
			GetCurrentDirectory(MAX_PATH, szPath);
			StrCat(szPath, _T("./html/DiaryHtml.htm"));*/
			//diaryedit->Navigate(szPath,NULL,NULL,NULL,NULL);
		}
	if (msg == SUCCESS_VALUE)
	{
		MessageBox(_T("日记保存成功"),_T("操作提示"),MB_OK|MB_ICONASTERISK  );
		
		//UpdateTree(m_tree,filenode.ID,filenode.name);
		OnCancel();
	}
	else
	{
		MessageBox(_T("日记保存失败"),_T("操作提示"),MB_OK|MB_ICONERROR  );
	}
  }	
}
