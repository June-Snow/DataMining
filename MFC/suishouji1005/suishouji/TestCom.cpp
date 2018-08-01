// TestCom.cpp : 实现文件
//

#include "stdafx.h"
#include "SuiShouJi.h"
#include "TestCom.h"
#include "afxdialogex.h"

#include "InitializeCtrl.h"

// CTestCom 对话框

IMPLEMENT_DYNAMIC(CTestCom, CDialogEx)

CTestCom::CTestCom(CWnd* pParent /*=NULL*/)
	: CDialogEx(CTestCom::IDD, pParent)
{
	
}

CTestCom::~CTestCom()
{
}

void CTestCom::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_LIST1, m_list);
	DDX_Control(pDX, IDC_STATIC1, m_static1);
}

BOOL CTestCom::OnInitDialog()
{	
	CDialogEx::OnInitDialog();	
	TextFont.CreatePointFont(90,_T("微软雅黑"));
	TitleFont.CreatePointFont(120,_T("微软雅黑"));
	NameFont.CreatePointFont(110,_T("黑体"));
	haveeditcreate = false;
	haveccomboboxcreate = false;	
	RECT  m_rect;
	int i;
	m_list.GetClientRect(&m_rect);   
	m_list.SetExtendedStyle(LVS_EX_GRIDLINES | LVS_EX_FULLROWSELECT); 	
	m_list.InsertColumn(0, _T("标签名称"), LVCFMT_LEFT, m_rect.right / 2);
	m_list.InsertColumn(1, _T("标签类型"), LVCFMT_LEFT, m_rect.right / 2);

	m_list.GetHeaderCtrl()->EnableWindow(FALSE);
	m_list.GetHeaderCtrl()->SetFont(&TitleFont);
	m_list.SetFont(&NameFont);

	int sel_no=atoi(sql_text);
	CString strnum;
	IMVL_GetNode(sel_no, &foldernode);
	m_static1.SetWindowText(foldernode.name);
	m_static1.SetFont(&NameFont);

	this->GetDlgItem(IDC_STATIC2000)->SetFont(&NameFont);

	if (strcmp(foldernode.content,_T(""))!=0)
	{
		isNull=0;
	}
	else{
		isNull=1;
	}	
	
	keynum = Getkeyval(foldernode.content, key, val );
	for (i=0;i<keynum;i++)
	{
		CString str1,str2=_T("");
		str1 = key[i];
		m_list.InsertItem(i, str1);
		str2 = val[i];		
		m_list.SetItemText(i, 1, str2);		
	}	
	itemcount = 0;
	return TRUE;  // 除非将焦点设置到控件，否则返回 TRUE
}

BEGIN_MESSAGE_MAP(CTestCom, CDialogEx)
	ON_BN_CLICKED(IDC_BUTTON1, &CTestCom::OnBnSave)
	ON_NOTIFY(NM_CLICK, IDC_LIST1, &CTestCom::OnNMClickList1)
	ON_BN_CLICKED(IDC_BUTTON4, &CTestCom::OnBnClickedButton4)
	ON_BN_CLICKED(IDC_BUTTON3, &CTestCom::OnBnClickedButton3)
	ON_NOTIFY(NM_DBLCLK, IDC_LIST1, &CTestCom::OnNMDblclkList1)
	ON_NOTIFY(NM_CUSTOMDRAW, IDC_LIST1, OnCustomdrawList)//cjz
	ON_NOTIFY(NM_RCLICK, IDC_LIST1, &CTestCom::OnNMRClickList1)
	ON_COMMAND(ID_32791, &CTestCom::OnAddRow)
	ON_COMMAND(ID_32792, &CTestCom::OnDeleteRow)
	ON_NOTIFY(LVN_ENDLABELEDIT, IDC_LIST1, &CTestCom::OnLvnEndlabeleditList1)
	ON_STN_CLICKED(IDC_STATIC1, &CTestCom::OnStnClickedStatic1)
END_MESSAGE_MAP()


// CTestCom 消息处理程序


void CTestCom::OnBnSave()
{ 
	// TODO: 在此添加控件通知处理程序代码
	int msg;
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
		MessageBox(_T("标签保存失败，请检查相关设置"),_T("操作提示"),MB_OK|MB_ICONERROR);
	}
	else if (msg==1)
	{
		MessageBox(_T("标签保存成功"),_T("操作提示"),MB_OK|MB_ICONASTERISK  );
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


void CTestCom::OnNMClickList1(NMHDR *pNMHDR, LRESULT *pResult)
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
	m_list.EditLabel(pEditCtrl->iItem);
	//m_list.SetFocus();
//	printf("行：%d，列：%d\n", pEditCtrl->iItem, pEditCtrl->iSubItem);
	
	if (isNull==1)
	{
		if (pEditCtrl->iItem==-1)//点击到非工作区
		{
			
			if (haveccomboboxcreate == true)//如果之前创建了下拉列表框就销毁掉
			{
				destroyCcombobox(&m_list, &m_comBox, e_Item, e_SubItem);
				haveccomboboxcreate = false;
			}
		}
		else if (pEditCtrl->iSubItem != 1)//如果不是属性类型选项
		{
			
		
		}
		else//如果是性别选项，在单元格处生成下拉列表项
		{
			if (pEditCtrl->iItem>=1)
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
	else                             //修改属性界面
	{
		if (pEditCtrl->iItem<keynum)
		{
			if (pEditCtrl->iSubItem != 1)
			{
				if (haveccomboboxcreate == true)//如果之前创建了编辑框就销毁掉
				{
					destroyCcombobox(&m_list, &m_comBox, e_Item, e_SubItem);
					haveccomboboxcreate = false;
				}				
				
			}
			else
				{					
			        if (haveccomboboxcreate == true)//如果之前创建了下拉列表框就销毁掉
			            {
				            destroyCcombobox(&m_list, &m_comBox, e_Item, e_SubItem);
				            haveccomboboxcreate = false;
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
		else{
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
	
	//NMLISTVIEW *pNMListView = (NMLISTVIEW*)pNMHDR;   

	//if (-1 != pNMListView->iItem)        // 如果iItem不是-1，就说明有列表项被选择   
	//{   
	//	// 获取被选择列表项第一个子项的文本   
	//	strLangName = m_list.GetItemText(pNMListView->iItem, 0);		 
	//}   
	*pResult = 0;
}


void CTestCom::createCcombobox(NM_LISTVIEW  *pEditCtrl, CComboBox *createccomboboxobj, int &Item, int &SubItem, bool &havecreat)//创建单元格下拉列表框函数
	//pEditCtrl为列表对象指针，createccombobox为下拉列表框指针对象，
	//Item为创建单元格在列表中的行，SubItem则为列，havecreat为对象创建标准
{
	Item = pEditCtrl->iItem;//将点中的单元格的行赋值给“刚编辑过的行”以便后期处理
	SubItem = pEditCtrl->iSubItem;//将点中的单元格的行赋值给“刚编辑过的行”以便后期处理
	havecreat = true;
	createccomboboxobj->Create(WS_CHILD | WS_VISIBLE |  CBS_DROPDOWN | CBS_OEMCONVERT, CRect(10,7,200,200), this, IDC_COMBOX_CREATEID);
	createccomboboxobj->SetFont(&TextFont, FALSE);//设置字体,不设置这里的话上面的字会很突兀的感觉
	createccomboboxobj->SetParent(&m_list);//将list control设置为父窗口,生成的Ccombobox才能正确定位,这个也很重要
	CRect  EditRect;
	m_list.GetSubItemRect(e_Item, e_SubItem, LVIR_LABEL, EditRect);//获取单元格的空间位置信息
	EditRect.SetRect(EditRect.left + 1, EditRect.top , EditRect.left + m_list.GetColumnWidth(e_SubItem), EditRect.bottom-10 );//+1和-1可以让编辑框不至于挡住列表框中的网格线
	CString strItem = m_list.GetItemText(e_Item, e_SubItem);//获得相应单元格字符
	createccomboboxobj->SetWindowText(strItem);//将单元格字符显示在编辑框上
	createccomboboxobj->MoveWindow(&EditRect);//将编辑框位置放在相应单元格上
	createccomboboxobj->ShowWindow(SW_SHOW);//显示编辑框在单元格上面
}

void CTestCom::destroyCcombobox(CListCtrl *list, CComboBox* destroyccomboboxobj, int &Item, int &SubItem)
{
	CString meditdata;
	destroyccomboboxobj->GetWindowText(meditdata);
	list->SetItemText(Item, SubItem, meditdata);//更新相应单元格字符
	destroyccomboboxobj->DestroyWindow();//销毁对象，有创建就要有销毁，不然会报错
}


void CTestCom::OnBnClickedButton4()     //减少按钮的响应
{
	// TODO: 在此添加控件通知处理程序代码
	int i;
	if (strLangName=="")
	{
		CString str2= _T("未选定项！");
		MessageBox(str2,_T("提示"),MB_OKCANCEL);
	} 
	else
	{
		int sel_no=atoi(strLangName);   //要删除的ID号 
		POSITION pos = m_list .GetFirstSelectedItemPosition();
	    while(pos)
	    {
		   int nIndex = m_list.GetNextSelectedItem(pos);
		   m_list .DeleteItem(nIndex);
		   pos = m_list .GetFirstSelectedItemPosition(); //这步很重要，不然删除不完全
	    }
		//删除选定选的信息 再次添加删除函数
	}			   
	
}


void CTestCom::OnBnClickedButton3()    //添加
{
	// TODO: 在此添加控件通知处理程序代码
	m_list.InsertItem(m_list.GetItemCount(), _T(""));
	m_list.SetItemText(m_list.GetItemCount(), 1, _T(""));
}

void CTestCom::OnOK()
{ //里面什么也不写
}

void CTestCom::OnNMDblclkList1(NMHDR *pNMHDR, LRESULT *pResult)
{
	
}

void CTestCom::OnCustomdrawList(NMHDR *pNMHDR, LRESULT *pResult)
{
    //////////////////////////////////////////////////////
    NMLVCUSTOMDRAW* pLVCD = reinterpret_cast<NMLVCUSTOMDRAW*>( pNMHDR );
}

void CTestCom::OnNMRClickList1(NMHDR *pNMHDR, LRESULT *pResult)
{
	LPNMITEMACTIVATE pNMItemActivate = reinterpret_cast<LPNMITEMACTIVATE>(pNMHDR);
	// TODO: 在此添加控件通知处理程序代码
	CMenu menuSetPara;
	m_selectnum = pNMItemActivate->iItem;
	if (m_selectnum>=keynum)
	{
		menuSetPara.LoadMenu(IDR_MENU6);
		CMenu *pa=menuSetPara.GetSubMenu(0);
		CPoint pt; GetCursorPos(&pt);
		pa->TrackPopupMenu(TPM_RIGHTBUTTON, pt.x, pt.y, this);	  
		menuSetPara.DestroyMenu();
		
	}
	*pResult = 0;
}


void CTestCom::OnAddRow()
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


void CTestCom::OnDeleteRow()
{
	// TODO: 在此添加命令处理程序代码	
	m_list.DeleteItem(m_selectnum);
}


void CTestCom::OnLvnEndlabeleditList1(NMHDR *pNMHDR, LRESULT *pResult)
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

BOOL   CTestCom::PreTranslateMessage(MSG*   pMsg)    
{  
	if(pMsg->message==WM_KEYDOWN   &&   pMsg->wParam==VK_ESCAPE)     return   TRUE;  
	if(pMsg->message==WM_KEYDOWN   &&   pMsg->wParam==VK_RETURN)   return   TRUE;    
	else    
		return   CDialog::PreTranslateMessage(pMsg);  
}


void CTestCom::OnStnClickedStatic1()
{
	// TODO: 在此添加控件通知处理程序代码
}
