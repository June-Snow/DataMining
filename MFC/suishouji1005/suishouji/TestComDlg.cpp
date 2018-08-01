// TestComDlg.cpp : 实现文件
//

#include "stdafx.h"
#include "SuiShouJi.h"
#include "TestComDlg.h"
#include "afxdialogex.h"

#include "stdafx.h"
#include "InitializeCtrl.h"

// CTestComDlg 对话框

IMPLEMENT_DYNAMIC(CTestComDlg, CDialogEx)

CTestComDlg::CTestComDlg(CWnd* pParent /*=NULL*/)
	: CDialogEx(CTestComDlg::IDD, pParent)
{
		
}

CTestComDlg::~CTestComDlg()
{
}

void CTestComDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_LIST1, m_list);
	
	//DDX_Control(pDX, IDC_COMBO4, m_com);
	DDX_Control(pDX, IDC_STATIC1, m_static1);
}

BOOL CTestComDlg::OnInitDialog()
{
	CDialogEx::OnInitDialog();
	TextFont.CreatePointFont(110,_T("微软雅黑"));
	TitleFont.CreatePointFont(120,_T("微软雅黑"));
	NameFont.CreatePointFont(110,_T("黑体"));
	//HICON hIcon1=theApp.LoadIcon(IDI_ICON4); 
	
	int i;
	haveeditcreate = false;
	haveccomboboxcreate = false;
	RECT  m_rect;
	int pid;
	m_list.GetClientRect(&m_rect);   
	m_list.SetExtendedStyle(LVS_EX_GRIDLINES | LVS_EX_FULLROWSELECT);
	m_list.InsertColumn(0, _T("属性名称"), LVCFMT_LEFT, m_rect.right / 2);
	m_list.InsertColumn(1, _T("属性类型"), LVCFMT_LEFT, m_rect.right / 2);
	m_list.GetHeaderCtrl()->EnableWindow(FALSE);	
	m_list.GetHeaderCtrl()->SetFont(&TitleFont);
	m_list.SetFont(&TextFont);
	int sel_no=atoi(sql_text);	
	this->GetDlgItem(IDC_STATIC100)->SetFont(&NameFont);
	IMVL_GetNode(sel_no, &m_foldernode);
	m_static1.SetWindowText(m_foldernode.name);
	m_static1.SetFont(&NameFont);
	pid = m_foldernode.iPID;
	IMVL_GetNode(pid, &p_foldernode);
	if (strcmp(m_foldernode.content,p_foldernode.content)==0)
	{
		isNull=1;
	}
	else{
		isNull=0;
	}		
	keynum = Getkeyval(m_foldernode.content, key, val );
	for (i=0;i<keynum;i++)
	{
		CString str1,str2=_T("");
		str1 = key[i];
		m_list.InsertItem(i, str1);
		str2 = val[i];		
		m_list.SetItemText(i, 1, str2);		
	}
	itemcount=0;
	return TRUE;
}

BEGIN_MESSAGE_MAP(CTestComDlg, CDialogEx)
	ON_BN_CLICKED(IDC_BUTTON1, &CTestComDlg::OnBnClickedButton1)	
	ON_NOTIFY(NM_CLICK, IDC_LIST1, &CTestComDlg::OnNMClickList1)
	ON_NOTIFY(NM_DBLCLK, IDC_LIST1, &CTestComDlg::OnNMDblclkList1)
	ON_NOTIFY(NM_RCLICK, IDC_LIST1, &CTestComDlg::OnNMRClickList1)
	ON_NOTIFY(LVN_ENDLABELEDIT, IDC_LIST1, &CTestComDlg::OnLvnEndlabeleditList1)
	ON_COMMAND(ID_32793, &CTestComDlg::OnAddRow)
	ON_COMMAND(ID_32794, &CTestComDlg::OnDeleteRow)
	ON_NOTIFY(NM_CUSTOMDRAW, IDC_LIST1, &CTestComDlg::OnCustomdrawList1)
END_MESSAGE_MAP()


// CTestComDlg 消息处理程序


void CTestComDlg::OnBnClickedButton1()  //保存
{
	// TODO: 在此添加控件通知处理程序代码
	int msg;
	if (haveeditcreate == true)//如果之前创建了编辑框就销毁掉
	{
		destroyEdit(&m_list, &m_Edit, e_Item, e_SubItem);//销毁单元格编辑框对象
		haveeditcreate = false;
	}
	if (haveccomboboxcreate == true)//如果之前创建了下拉列表框就销毁掉
	{
		destroyCcombobox(&m_list, &m_comBox, e_Item, e_SubItem);
		haveccomboboxcreate = false;
	}
	msg = SaveListCtrlAsFolder(&m_list,atoi(sql_text));
	if (msg==2)
	{
		MessageBox(_T("标签名称或标签类型不可为空"),_T("提示"),MB_OK|MB_ICONEXCLAMATION );
	}
	else if (msg==0)
	{
        MessageBox(_T("标签保存失败，请检查相关设置"),_T("提示"),MB_OK|MB_ICONHAND );
	}
	else if (msg==1)
	{
		MessageBox(_T("标签保存成功"),_T("提示"),MB_OK|MB_ICONASTERISK );
	}
	else if (msg==3)
	{
		MessageBox(_T("标签个数设置过多"),_T("提示"),MB_OK|MB_ICONEXCLAMATION );
	}
	else if (msg==4)
	{
		MessageBox(_T("图片标签设置过多"),_T("提示"),MB_OK|MB_ICONEXCLAMATION );
	}
	else if (msg==5)
	{
		MessageBox(_T("文档或附件标签设置过多"),_T("提示"),MB_OK|MB_ICONEXCLAMATION );
	}
}



void CTestComDlg::OnNMClickList1(NMHDR *pNMHDR, LRESULT *pResult)
{
	LPNMITEMACTIVATE pNMItemActivate = reinterpret_cast<LPNMITEMACTIVATE>(pNMHDR);
	// TODO: 在此添加控件通知处理程序代码
	NM_LISTVIEW  *pEditCtrl = (NM_LISTVIEW *)pNMHDR;
	if (pEditCtrl->iItem==-1)//点击到非工作区
	{
		CString tip;
		if (itemcount==0)
		{
			tip=_T("");
		} 
		else
		{
			tip.Format("%d",itemcount);
		}
		if(pEditCtrl->iSubItem==0)
		{

		int row = m_list.InsertItem(m_list.GetItemCount(), _T("新增项")+tip);
		m_list.SetItemText(row, 1, _T("文本"));
		itemcount++;
		}
		
	}	
	//printf("行：%d，列：%d\n", pEditCtrl->iItem, pEditCtrl->iSubItem);
	if (isNull==1)
	{
		if (pEditCtrl->iItem<Getkeyval(p_foldernode.content, key, val ))//点击到非工作区
		{
			
			if (haveccomboboxcreate == true)//如果之前创建了下拉列表框就销毁掉
			{
				destroyCcombobox(&m_list, &m_comBox, e_Item, e_SubItem);
				haveccomboboxcreate = false;
			}
		}
		else 
		{
			m_list.EditLabel(pEditCtrl->iItem);
			if (pEditCtrl->iSubItem != 1)//如果不是属性类型选项
		    {
			   if (haveccomboboxcreate == true)//如果之前创建了编辑框就销毁掉
			   {
				   destroyCcombobox(&m_list, &m_comBox, e_Item, e_SubItem);
				   haveccomboboxcreate = false;
			   }				
		   }
		else//如果是性别选项，在单元格处生成下拉列表项
		{
			
			if (haveccomboboxcreate == true)
			{
				if (!(e_Item == pEditCtrl->iItem && e_SubItem == pEditCtrl->iSubItem))//如果点中的单元格不是之前创建好的
				{
					destroyCcombobox(&m_list, &m_comBox, e_Item, e_SubItem);
					haveccomboboxcreate = false;
					createCcombobox(pEditCtrl, &m_comBox, e_Item, e_SubItem, haveccomboboxcreate);//创建编辑框
					m_comBox.AddString(_T("文本"));
					m_comBox.AddString(_T("文本块"));
					m_comBox.AddString(_T("图片"));
					m_comBox.AddString(_T("日期"));
					m_comBox.AddString(_T("文档"));
					m_comBox.AddString(_T("附件"));
					m_comBox.SetCurSel(0);
					m_comBox.ShowDropDown();//自动下拉
				}
				else//点中的单元格是之前创建好的
				{
					m_comBox.SetFocus();//设置为焦点 
				}
			}
			else
			{
				e_Item = pEditCtrl->iItem;//将点中的单元格的行赋值给“刚编辑过的行”以便后期处理
				e_SubItem = pEditCtrl->iSubItem;//将点中的单元格的行赋值给“刚编辑过的行”以便后期处理
				createCcombobox(pEditCtrl, &m_comBox, e_Item, e_SubItem, haveccomboboxcreate);//创建编辑框
				m_comBox.AddString(_T("文本"));
				m_comBox.AddString(_T("文本块"));
				m_comBox.AddString(_T("图片"));
				m_comBox.AddString(_T("日期"));
				m_comBox.AddString(_T("文档"));
				m_comBox.AddString(_T("附件"));
				m_comBox.SetCurSel(0);
				m_comBox.ShowDropDown();//自动下拉
			}
		  }
		}
	} 
	else
	{
		if (pEditCtrl->iItem<keynum)
		{
			if (pEditCtrl->iItem<Getkeyval(p_foldernode.content, key, val ))//点击到非工作区
		    {
			   
			    if (haveccomboboxcreate == true)//如果之前创建了下拉列表框就销毁掉
			   {
				destroyCcombobox(&m_list, &m_comBox, e_Item, e_SubItem);
				haveccomboboxcreate = false;
			   }
		   }
			else{
				if (pEditCtrl->iSubItem != 1)
				{
					if (haveccomboboxcreate == true)//如果之前创建了编辑框就销毁掉
					{
						destroyCcombobox(&m_list, &m_comBox, e_Item, e_SubItem);
						haveccomboboxcreate = false;
					}
					
					

				}else
				{
					
					if (haveccomboboxcreate == true)//如果之前创建了下拉列表框就销毁掉
					{
						destroyCcombobox(&m_list, &m_comBox, e_Item, e_SubItem);
						haveccomboboxcreate = false;
					}

				}
			}
		}		
		else if (pEditCtrl->iSubItem != 1)//如果不是属性类型选项
		{
			if (haveccomboboxcreate == true)//如果之前创建了编辑框就销毁掉
			{
				destroyCcombobox(&m_list, &m_comBox, e_Item, e_SubItem);
				haveccomboboxcreate = false;
			}
			
			
		}
		else//如果是性别选项，在单元格处生成下拉列表项
		{
			
			if (haveccomboboxcreate == true)
			{
				if (!(e_Item == pEditCtrl->iItem && e_SubItem == pEditCtrl->iSubItem))//如果点中的单元格不是之前创建好的
				{
					destroyCcombobox(&m_list, &m_comBox, e_Item, e_SubItem);
					haveccomboboxcreate = false;
					createCcombobox(pEditCtrl, &m_comBox, e_Item, e_SubItem, haveccomboboxcreate);//创建编辑框
					m_comBox.AddString(_T("文本"));
					m_comBox.AddString(_T("文本块"));
					m_comBox.AddString(_T("图片"));
					m_comBox.AddString(_T("日期"));
					m_comBox.AddString(_T("文档"));
					m_comBox.AddString(_T("附件"));
					m_comBox.SetCurSel(0);
					m_comBox.ShowDropDown();//自动下拉
				}
				else//点中的单元格是之前创建好的
				{
					m_comBox.SetFocus();//设置为焦点 
				}
			}			
				createCcombobox(pEditCtrl, &m_comBox, e_Item, e_SubItem, haveccomboboxcreate);//创建编辑框
				m_comBox.AddString(_T("文本"));
				m_comBox.AddString(_T("文本块"));
				m_comBox.AddString(_T("图片"));
				m_comBox.AddString(_T("日期"));
				m_comBox.AddString(_T("文档"));
				m_comBox.AddString(_T("附件"));
				m_comBox.SetCurSel(0);
				m_comBox.ShowDropDown();//自动下拉
			}
		}
	
	
	*pResult = 0;
}

void CTestComDlg::createEdit(NM_LISTVIEW  *pEditCtrl, CEdit *createdit, int &Item, int &SubItem, bool &havecreat)//创建单元格编辑框函数
	//pEditCtrl为列表对象指针，createdit为编辑框指针对象，
	//Item为创建单元格在列表中的行，SubItem则为列，havecreat为对象创建标准
{
	Item = pEditCtrl->iItem;//将点中的单元格的行赋值给“刚编辑过的行”以便后期处理
	SubItem = pEditCtrl->iSubItem;//将点中的单元格的行赋值给“刚编辑过的行”以便后期处理
	createdit->Create(ES_AUTOHSCROLL | WS_CHILD | ES_LEFT | ES_WANTRETURN,
		CRect(0, 0, 0, 0), this, IDC_EDIT_CREATEID);//创建编辑框对象,IDC_EDIT_CREATEID为控件ID号3000，在文章开头定义
	havecreat = true;
	createdit->SetFont(&TextFont, FALSE);//设置字体,不设置这里的话上面的字会很突兀的感觉
	createdit->SetParent(&m_list);//将list control设置为父窗口,生成的Edit才能正确定位,这个也很重要
	CRect  EditRect;
	m_list.GetSubItemRect(e_Item, e_SubItem, LVIR_LABEL, EditRect);//获取单元格的空间位置信息
	EditRect.SetRect(EditRect.left+1, EditRect.top+1, EditRect.left + m_list.GetColumnWidth(e_SubItem), EditRect.bottom-1);//+1和-1可以让编辑框不至于挡住列表框中的网格线
	CString strItem = m_list.GetItemText(e_Item, e_SubItem);//获得相应单元格字符
	createdit->SetWindowText(strItem);//将单元格字符显示在编辑框上
	createdit->MoveWindow(&EditRect);//将编辑框位置放在相应单元格上
	createdit->ShowWindow(SW_SHOW);//显示编辑框在单元格上面
	createdit->SetFocus();//设置为焦点 
	createdit->SetSel(-1);//设置光标在文本框文字的最后
}

void CTestComDlg::destroyEdit(CListCtrl *list,CEdit* destroyedit, int &Item, int &SubItem)
{
	CString meditdata;
	destroyedit->GetWindowText(meditdata);
	list->SetItemText(Item, SubItem, meditdata);//获得相应单元格字符
	destroyedit->DestroyWindow();//销毁对象，有创建就要有销毁，不然会报错
}

void CTestComDlg::createCcombobox(NM_LISTVIEW  *pEditCtrl, CComboBox *createccomboboxobj, int &Item, int &SubItem, bool &havecreat)//创建单元格下拉列表框函数
	//pEditCtrl为列表对象指针，createccombobox为下拉列表框指针对象，
	//Item为创建单元格在列表中的行，SubItem则为列，havecreat为对象创建标准
{
	Item = pEditCtrl->iItem;//将点中的单元格的行赋值给“刚编辑过的行”以便后期处理
	SubItem = pEditCtrl->iSubItem;//将点中的单元格的行赋值给“刚编辑过的行”以便后期处理
	havecreat = true;
	createccomboboxobj->Create(WS_CHILD|WS_VISIBLE|WS_VSCROLL|CBS_DROPDOWNLIST, CRect(10,10,200,200),this, IDC_COMBOX_CREATEID);
	createccomboboxobj->SetFont(&TextFont, FALSE);//设置字体,不设置这里的话上面的字会很突兀的感觉
	createccomboboxobj->SetParent(&m_list);//将list control设置为父窗口,生成的Ccombobox才能正确定位,这个也很重要
	CRect  EditRect;
	m_list.GetSubItemRect(e_Item, e_SubItem, LVIR_LABEL, EditRect);//获取单元格的空间位置信息
	EditRect.SetRect(EditRect.left + 1, EditRect.top -2 , EditRect.left + m_list.GetColumnWidth(e_SubItem) - 1, EditRect.bottom - 15);//+1和-1可以让编辑框不至于挡住列表框中的网格线
	CString strItem = m_list.GetItemText(e_Item, e_SubItem);//获得相应单元格字符

	createccomboboxobj->SetWindowText(strItem);//将单元格字符显示在编辑框上
	createccomboboxobj->MoveWindow(&EditRect);//将编辑框位置放在相应单元格上
	createccomboboxobj->ShowWindow(SW_SHOW);//显示编辑框在单元格上面
}

void CTestComDlg::destroyCcombobox(CListCtrl *list, CComboBox* destroyccomboboxobj, int &Item, int &SubItem)
{
	CString meditdata;
	destroyccomboboxobj->GetWindowText(meditdata);
	list->SetItemText(Item, SubItem, meditdata);//更新相应单元格字符
	destroyccomboboxobj->DestroyWindow();//销毁对象，有创建就要有销毁，不然会报错
}

void CTestComDlg::OnOK()
{ //里面什么也不写
}



void CTestComDlg::OnNMDblclkList1(NMHDR *pNMHDR, LRESULT *pResult)
{
	
}


void CTestComDlg::OnNMRClickList1(NMHDR *pNMHDR, LRESULT *pResult)
{
	LPNMITEMACTIVATE pNMItemActivate = reinterpret_cast<LPNMITEMACTIVATE>(pNMHDR);
	// TODO: 在此添加控件通知处理程序代码
	CMenu menuSetPara;
	m_selectnum = pNMItemActivate->iItem;
	if (m_selectnum>=keynum)
	{
		menuSetPara.LoadMenu(IDR_MENU7);
		CMenu *pa=menuSetPara.GetSubMenu(0);
		CPoint pt; GetCursorPos(&pt);
		pa->TrackPopupMenu(TPM_RIGHTBUTTON, pt.x, pt.y, this);	  
		menuSetPara.DestroyMenu();

	}
	*pResult = 0;
}


void CTestComDlg::OnLvnEndlabeleditList1(NMHDR *pNMHDR, LRESULT *pResult)
{
	NMLVDISPINFO *pDispInfo = reinterpret_cast<NMLVDISPINFO*>(pNMHDR);
	// TODO: 在此添加控件通知处理程序代码
	CString str1=pDispInfo->item.pszText;
	int tIndex = pDispInfo->item.iItem;
	m_list.SetFocus();
	if( ( ! str1.IsEmpty() ) && tIndex >= 0 )
	{
		m_list.SetItemText(tIndex,0,str1);
	}

	*pResult = 0;
}


void CTestComDlg::OnAddRow()
{
	// TODO: 在此添加命令处理程序代码
	CString tip;
	if (itemcount==0)
	{
		tip=_T("");
	} 
	else
	{
		tip.Format("%d",itemcount);
	}

	int row = m_list.InsertItem(m_list.GetItemCount(), _T("新增项")+tip);
	m_list.SetItemText(row, 1, _T("文本"));
	itemcount++;
}


void CTestComDlg::OnDeleteRow()
{
	// TODO: 在此添加命令处理程序代码
	m_list.DeleteItem(m_selectnum);
}


void CTestComDlg::OnCustomdrawList1(NMHDR *pNMHDR, LRESULT *pResult)
{
	//NMLVCUSTOMDRAW* pLVCD = reinterpret_cast<NMLVCUSTOMDRAW*>( pNMHDR ); 
	//
 //   if ( CDDS_PREPAINT == pLVCD->nmcd.dwDrawStage )
 //   {
 //       *pResult = CDRF_NOTIFYITEMDRAW;
 //   }
 //   else if ( CDDS_ITEMPREPAINT == pLVCD->nmcd.dwDrawStage )
 //   {
 //       COLORREF crText = RGB(0,0,0),crBk = RGB(255,255,255);		
	//	
	//	if ( pLVCD->nmcd.dwItemSpec <p_foldernode.data_unit_num)	
	//	{
 //           crText = RGB(255,0,0);//RGB(32,32,255);
 //           crBk =RGB(96,96,96);
 //      
	//	}      
 //       
 //       // Store the color back in the NMLVCUSTOMDRAW struct.

 //       pLVCD->clrText = crText;
 //       pLVCD->clrTextBk = crBk;              
 //   }
	//*pResult = CDRF_NEWFONT; 
	NMLVCUSTOMDRAW* pLVCD = reinterpret_cast<NMLVCUSTOMDRAW*>( pNMHDR );  


	// Take the default processing unless we set this to something else below.  
	*pResult = CDRF_DODEFAULT;  


	// First thing - check the draw stage. If it's the control's prepaint  
	// stage, then tell Windows we want messages for every item.  
	if ( CDDS_PREPAINT == pLVCD->nmcd.dwDrawStage )  
	{  
		*pResult = CDRF_NOTIFYITEMDRAW;  
	}  
	else if ( CDDS_ITEMPREPAINT == pLVCD->nmcd.dwDrawStage )  
	{  
		// This is the notification message for an item.  We'll request  
		// notifications before each subitem's prepaint stage.  


		*pResult = CDRF_NOTIFYSUBITEMDRAW;  
	}  
	else if ( (CDDS_ITEMPREPAINT | CDDS_SUBITEM) == pLVCD->nmcd.dwDrawStage )  
	{  


		COLORREF clrNewTextColor = RGB(0,0,0), clrNewBkColor = RGB(255,255,255);  


		int    nItem = static_cast<int>( pLVCD->nmcd.dwItemSpec ); 

		 
		if(nItem<Getkeyval(p_foldernode.content, key, val )){  
			clrNewTextColor = RGB(144,144,144);       //Set the text   
			clrNewBkColor = RGB(255,255,255);     //青色  
		} 
		pLVCD->clrText = clrNewTextColor;  
		pLVCD->clrTextBk = clrNewBkColor; 		  
		*pResult = CDRF_DODEFAULT;  
	}  
}

BOOL   CTestComDlg::PreTranslateMessage(MSG*   pMsg)    
{  
	if(pMsg->message==WM_KEYDOWN   &&   pMsg->wParam==VK_ESCAPE)     return   TRUE;  
	if(pMsg->message==WM_KEYDOWN   &&   pMsg->wParam==VK_RETURN)   return   TRUE;    
	else    
		return   CDialog::PreTranslateMessage(pMsg);  
}
