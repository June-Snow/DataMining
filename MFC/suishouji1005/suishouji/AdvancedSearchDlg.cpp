// CAdvancedSearchDlg.cpp : 实现文件
//

#include "stdafx.h"
#include "suishouji.h"
#include "AdvancedSearchDlg.h"
#include "afxdialogex.h"
#include "DBSDK.h"
#include "InitializeCtrl.h"
#include "DB_operater.h"



// CAdvancedSearchDlg 对话框

IMPLEMENT_DYNAMIC(CAdvancedSearchDlg, CDialogEx)

	CAdvancedSearchDlg::CAdvancedSearchDlg(CWnd* pParent /*=NULL*/)
	: CDialogEx(CAdvancedSearchDlg::IDD, pParent)
{
	icmbch = 0;
	edgeWidth = 5;
	ctrlHeight = 5;
}

CAdvancedSearchDlg::~CAdvancedSearchDlg()
{

}

void CAdvancedSearchDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
}


BEGIN_MESSAGE_MAP(CAdvancedSearchDlg, CDialogEx)
	ON_BN_CLICKED(IDC_BTN_ADD, &CAdvancedSearchDlg::OnBnClickedButton1)
	ON_BN_CLICKED(IDC_BTN_CUT, &CAdvancedSearchDlg::OnBnClickedButton2)

	ON_BN_CLICKED(IDC_BTN_SEARCH, &CAdvancedSearchDlg::OnBnClickedButton3)


	ON_CBN_SELCHANGE(IDC_COMBO_BTN1, &CAdvancedSearchDlg::OnCbnBtn1)
	ON_CBN_SELCHANGE(IDC_COMBO_BTN2, &CAdvancedSearchDlg::OnCbnBtn2)
//	ON_CBN_SELCHANGE(IDC_COMBO_BTN3, &CAdvancedSearchDlg::OnCbnBtn3)
//ON_WM_VSCROLL()
ON_WM_SIZE()
//ON_WM_MOUSEHWHEEL()
//ON_WM_MOUSEWHEEL()
END_MESSAGE_MAP()


// CAdvancedSearchDlg 消息处理程序

BOOL CAdvancedSearchDlg::OnInitDialog()
{	
	CDialogEx::OnInitDialog();	

	textFont.CreatePointFont(110,_T("宋体"));
	CRect rect;
	GetWindowRect(&rect);
	int x = (rect.left+rect.right)/2;
	int y = (rect.top+rect.bottom)/2;
	int WIDTH = 441;
	int HEIGHT = 450;
//	x = x-width/2;
	y = y - HEIGHT/2;

	::SetWindowPos(this->m_hWnd,HWND_BOTTOM,x,y,WIDTH,HEIGHT,SWP_NOZORDER);

	int COMBOXWIDTH = 100;//WIDTH/6;//100
	int DATECTRL = 120;//WIDTH/5;//120

	m_static[0].Create(_T("输入检索控制条件："),WS_CHILD|WS_VISIBLE,CRect(edgeWidth,ctrlHeight+3,WIDTH/3,ctrlHeight+28),this,123);			
	m_static[0].SetFont(&textFont);

	m_btn[2].Create(_T("搜索"), WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON , CRect(WIDTH-75,ctrlHeight,WIDTH-10,ctrlHeight+25 ), this, IDC_BTN_SEARCH);
	m_btn[2].SetFont(&textFont);
	ctrlHeight = ctrlHeight +30;

	m_combobox[0].Create(WS_CHILD | WS_VISIBLE| CBS_DROPDOWN | CBS_HASSTRINGS | WS_VSCROLL,
		CRect(edgeWidth, ctrlHeight, COMBOXWIDTH, 200), this, 123);
	m_combobox[0].SetFont(&textFont);
	m_combobox[0].InsertString(0, _T("修改日期"));
	m_combobox[0].InsertString(0, _T("创建日期"));
	m_combobox[0].SetCurSel(0);

	m_static[1].Create(_T("时间：从"),WS_CHILD|WS_VISIBLE,CRect(COMBOXWIDTH+5,ctrlHeight+3,COMBOXWIDTH+5+60,ctrlHeight+28),this,123);
	m_static[1].SetFont(&textFont);

	m_date[0].Create( DTS_APPCANPARSE  |WS_VISIBLE,CRect(COMBOXWIDTH+10+60,ctrlHeight,COMBOXWIDTH+10+WIDTH/8+DATECTRL,ctrlHeight+22 ), this, 123 );
	m_date[0].SetFont(&textFont);
	DateTime_SetFormat(m_date[0].GetSafeHwnd(),"''yyyy'-'MM'-'dd' '");

	m_static[2].Create(_T("到"),WS_CHILD|WS_VISIBLE,CRect(COMBOXWIDTH+15+WIDTH/8+DATECTRL,ctrlHeight+3,COMBOXWIDTH+35+WIDTH/8+DATECTRL,ctrlHeight+28),this,123);
	m_static[2].SetFont(&textFont);

	m_date[1].Create( DTS_APPCANPARSE  |WS_VISIBLE,CRect(COMBOXWIDTH+40+WIDTH/8+DATECTRL,ctrlHeight,COMBOXWIDTH+35+WIDTH/8+2*DATECTRL,ctrlHeight+22 ), this, 123 );
	m_date[1].SetFont(&textFont);
	DateTime_SetFormat(m_date[1].GetSafeHwnd(),"''yyyy'-'MM'-'dd' '");
	ctrlHeight = ctrlHeight+30;

	m_btn[0].Create(_T("+"), WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON , CRect(edgeWidth,ctrlHeight,edgeWidth+65,ctrlHeight+25 ), this, IDC_BTN_ADD );
	m_btn[0].SetFont(&textFont);

	m_btn[1].Create(_T("-"), WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON , CRect(edgeWidth+70,ctrlHeight,edgeWidth+135,ctrlHeight+25 ), this, IDC_BTN_CUT );
	m_btn[1].SetFont(&textFont);

	m_combobox[1].Create(WS_CHILD | WS_VISIBLE| CBS_DROPDOWN | CBS_HASSTRINGS | WS_VSCROLL,
		CRect(edgeWidth+140,ctrlHeight, edgeWidth+140+WIDTH/6, 200), this, IDC_COMBO_BTN1);
	m_combobox[1].SetFont(&textFont);
	INDEX_TABLE index;
	int count =0;
	IMVL_LoadIndexTable(&index);
	for (int i=0;i<index.num;i++)
	{
		if (index.index[i].IsFolder==1&&index.index[i].iPID==1)
		{
			m_combobox[1].InsertString(count, index.index[i].name);
			m_combobox[1].SetItemData(count,index.index[i].ID);
			count++;
		}
	}	
	m_combobox[1].SetCurSel(0);

	selectid = 27;
	m_combobox[2].Create(WS_CHILD | WS_VISIBLE| CBS_DROPDOWN | CBS_HASSTRINGS | WS_VSCROLL,
		CRect(edgeWidth+145+WIDTH/6,ctrlHeight, edgeWidth+145+WIDTH/6+DATECTRL, 200), this, IDC_COMBO_BTN2);
	m_combobox[2].SetFont(&textFont);
	m_combobox[2].InsertString(0, _T("----"));
	m_combobox[2].SetCurSel(0);
	ctrlHeight = ctrlHeight+30;

	for(int i = 0; i != 10; i++)
	{
		m_combo_cho[i].Create(WS_CHILD | WS_VISIBLE| CBS_DROPDOWN | CBS_HASSTRINGS | WS_VSCROLL,CRect(0,0,0,0), this, 123);
		m_combo_cho[i].SetFont(&textFont);
		m_combo_pro[i].Create(WS_CHILD | WS_VISIBLE| CBS_DROPDOWN | CBS_HASSTRINGS | WS_VSCROLL,CRect(0,0,0,0), this, 123);
		m_combo_pro[i].SetFont(&textFont);
		m_combo_cmp[i].Create(WS_CHILD | WS_VISIBLE| CBS_DROPDOWN | CBS_HASSTRINGS | WS_VSCROLL,CRect(0,0,0,0), this, 123);
		m_combo_cmp[i].SetFont(&textFont);
		m_edit[i].Create(WS_CHILD | WS_VISIBLE  | ES_LEFT  | ES_WANTRETURN| WS_BORDER,CRect(0,0,0,0),this,123);
		m_edit[i].SetFont(&textFont);
	}

	return true;
}

//添加
void CAdvancedSearchDlg::OnBnClickedButton1()
{
	// TODO: 在此添加控件通知处理程序代码

	if (icmbch<10)
	{
		m_combo_cho[icmbch].MoveWindow(edgeWidth, ctrlHeight, 60,100,TRUE);
		m_combo_cho[icmbch].InsertString(0, _T("或者"));
		m_combo_cho[icmbch].InsertString(0, _T("并且"));
		m_combo_cho[icmbch].SetCurSel(0);

		m_combo_pro[icmbch].MoveWindow(70,ctrlHeight,120,200,TRUE);
		INDEX_NODE folder;
		IMVL_GetNode(selectid,&folder);
		CString key[MAX_DATA_NUM],val[MAX_DATA_NUM];
		int pronum = Getkeyval(folder.content,key,val);
		for (int j=0;j<pronum;j++)
		{
			m_combo_pro[icmbch].InsertString(j,key[j]);
		}
		m_combo_pro[icmbch].SetCurSel(0);	

		m_combo_cmp[icmbch].MoveWindow(195, ctrlHeight,60,100,TRUE);
		m_combo_cmp[icmbch].InsertString(0, _T("大于"));
		m_combo_cmp[icmbch].InsertString(0, _T("小于"));
		m_combo_cmp[icmbch].InsertString(0, _T("等于"));
		m_combo_cmp[icmbch].SetCurSel(0);

		m_edit[icmbch].MoveWindow(260, ctrlHeight, 170, 23);
		icmbch++;
		ctrlHeight = ctrlHeight + 30;

	}

}

//删减
void CAdvancedSearchDlg::OnBnClickedButton2()
{
	// TODO: 在此添加控件通知处理程序代码	
	if (icmbch>0)
	{
		icmbch = icmbch - 1;
		m_combo_cho[icmbch].MoveWindow(0,0,0,0);

		m_combo_pro[icmbch].MoveWindow(0,0,0,0);

		m_combo_cmp[icmbch].MoveWindow(0,0,0,0);

		m_edit[icmbch].MoveWindow(0,0,0,0);

		ctrlHeight = ctrlHeight - 30;
	}
}

void CAdvancedSearchDlg::OnBnClickedButton3()
{
	// TODO: 在此添加控件通知处理程序代码
	CStringArray arryhead,arrybody;
	CString str1,str2;
	INDEX_TABLE search_index;	
	m_date[0].GetWindowText(str1);
	arryhead.Add(str1);
	m_date[1].GetWindowText(str2);
	arryhead.Add(str2);
	for (int i = 0; i<icmbch;i++)
	{
		CString strchoice;
		m_combo_cho[i].GetWindowText(strchoice);
		arrybody.Add(strchoice);

		m_combo_pro[i].GetWindowText(strchoice);
		arrybody.Add(strchoice);

		m_combo_cmp[i].GetWindowText(strchoice);
		arrybody.Add(strchoice);

		m_edit[i].GetWindowText(strchoice);
		arrybody.Add(strchoice);
	}
	TimeSearch(&search_index,&arryhead,selectid);
	AdvancedSearch(&search_index,selectid,&arrybody);
	InitializeTreeCtrlHead(m_list);
	INDEX_NODE index;
	for (int j=0;j<search_index.num;j++)
	{
		if (search_index.index[j].ID!=-1)
		{
			IMVL_GetNode(search_index.index[j].iPID,&index);
			m_list->InsertItem(j,search_index.index[j].name);
			m_list->SetItemData(j,search_index.index[j].ID);
			m_list->SetItemText(j,1,index.name);
			m_list->SetItemText(j,2,search_index.index[j].modifyTime);
			m_list->SetItemText(j,3,search_index.index[j].createTime);
		}		
	}
	if (!m_list->IsWindowVisible())
	{
		m_list->ShowWindow(TRUE);			  
	}
	pos[2]=2;
	pos[3]=3;
}

void CAdvancedSearchDlg::OnCbnBtn1()
{
	//CString str1,str2;

	int nIndex = m_combobox[1].GetCurSel();

	int id = m_combobox[1].GetItemData(nIndex);
	m_combobox[2].ResetContent();


	INDEX_TABLE index;
	int count =0;
	IMVL_LoadIndexTable(&index);
	for (int i=0;i<index.num;i++)
	{
		if (index.index[i].IsFolder==1&&index.index[i].iPID==id)
		{
			m_combobox[2].InsertString(count, index.index[i].name);
			m_combobox[2].SetItemData(count,index.index[i].ID);
			count++;
		}
	}	

	INDEX_NODE folder;
	IMVL_GetNode(id,&folder);
	CString key[MAX_DATA_NUM],val[MAX_DATA_NUM];
	int pronum = Getkeyval(folder.content,key,val);
	for (int i = 0; i<icmbch;i++)
	{
		m_combo_pro[i].ResetContent();
		for (int j=0;j<pronum;j++)
		{
			m_combo_pro[i].InsertString(j,key[j]);
		}
		m_combo_pro[i].SetCurSel(0);
	}	
	selectid = id;   

}
void CAdvancedSearchDlg::OnCbnBtn2()
{
	

	int nIndex = m_combobox[2].GetCurSel();	
	int id = m_combobox[2].GetItemData(nIndex);


	INDEX_NODE folder;
	IMVL_GetNode(id,&folder);
	CString key[MAX_DATA_NUM],val[MAX_DATA_NUM];
	int pronum = Getkeyval(folder.content,key,val);
	for (int i = 0; i<icmbch;i++)
	{
		m_combo_pro[i].ResetContent();
		for (int j=0;j<pronum;j++)
		{
			m_combo_pro[i].InsertString(j,key[j]);
		}
		m_combo_pro[i].SetCurSel(0);
	}	
	selectid = id;
}

void CAdvancedSearchDlg::OnCancel()
{
	icmbch = 0;
	*isdialog = FALSE;
	CDialog::OnCancel();
}

void CAdvancedSearchDlg::OnOK()
{

}

void CAdvancedSearchDlg::OnSize(UINT nType, int cx, int cy)
{

}


