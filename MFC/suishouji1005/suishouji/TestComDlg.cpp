// TestComDlg.cpp : ʵ���ļ�
//

#include "stdafx.h"
#include "SuiShouJi.h"
#include "TestComDlg.h"
#include "afxdialogex.h"

#include "stdafx.h"
#include "InitializeCtrl.h"

// CTestComDlg �Ի���

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
	TextFont.CreatePointFont(110,_T("΢���ź�"));
	TitleFont.CreatePointFont(120,_T("΢���ź�"));
	NameFont.CreatePointFont(110,_T("����"));
	//HICON hIcon1=theApp.LoadIcon(IDI_ICON4); 
	
	int i;
	haveeditcreate = false;
	haveccomboboxcreate = false;
	RECT  m_rect;
	int pid;
	m_list.GetClientRect(&m_rect);   
	m_list.SetExtendedStyle(LVS_EX_GRIDLINES | LVS_EX_FULLROWSELECT);
	m_list.InsertColumn(0, _T("��������"), LVCFMT_LEFT, m_rect.right / 2);
	m_list.InsertColumn(1, _T("��������"), LVCFMT_LEFT, m_rect.right / 2);
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


// CTestComDlg ��Ϣ�������


void CTestComDlg::OnBnClickedButton1()  //����
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	int msg;
	if (haveeditcreate == true)//���֮ǰ�����˱༭������ٵ�
	{
		destroyEdit(&m_list, &m_Edit, e_Item, e_SubItem);//���ٵ�Ԫ��༭�����
		haveeditcreate = false;
	}
	if (haveccomboboxcreate == true)//���֮ǰ�����������б������ٵ�
	{
		destroyCcombobox(&m_list, &m_comBox, e_Item, e_SubItem);
		haveccomboboxcreate = false;
	}
	msg = SaveListCtrlAsFolder(&m_list,atoi(sql_text));
	if (msg==2)
	{
		MessageBox(_T("��ǩ���ƻ��ǩ���Ͳ���Ϊ��"),_T("��ʾ"),MB_OK|MB_ICONEXCLAMATION );
	}
	else if (msg==0)
	{
        MessageBox(_T("��ǩ����ʧ�ܣ������������"),_T("��ʾ"),MB_OK|MB_ICONHAND );
	}
	else if (msg==1)
	{
		MessageBox(_T("��ǩ����ɹ�"),_T("��ʾ"),MB_OK|MB_ICONASTERISK );
	}
	else if (msg==3)
	{
		MessageBox(_T("��ǩ�������ù���"),_T("��ʾ"),MB_OK|MB_ICONEXCLAMATION );
	}
	else if (msg==4)
	{
		MessageBox(_T("ͼƬ��ǩ���ù���"),_T("��ʾ"),MB_OK|MB_ICONEXCLAMATION );
	}
	else if (msg==5)
	{
		MessageBox(_T("�ĵ��򸽼���ǩ���ù���"),_T("��ʾ"),MB_OK|MB_ICONEXCLAMATION );
	}
}



void CTestComDlg::OnNMClickList1(NMHDR *pNMHDR, LRESULT *pResult)
{
	LPNMITEMACTIVATE pNMItemActivate = reinterpret_cast<LPNMITEMACTIVATE>(pNMHDR);
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	NM_LISTVIEW  *pEditCtrl = (NM_LISTVIEW *)pNMHDR;
	if (pEditCtrl->iItem==-1)//������ǹ�����
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

		int row = m_list.InsertItem(m_list.GetItemCount(), _T("������")+tip);
		m_list.SetItemText(row, 1, _T("�ı�"));
		itemcount++;
		}
		
	}	
	//printf("�У�%d���У�%d\n", pEditCtrl->iItem, pEditCtrl->iSubItem);
	if (isNull==1)
	{
		if (pEditCtrl->iItem<Getkeyval(p_foldernode.content, key, val ))//������ǹ�����
		{
			
			if (haveccomboboxcreate == true)//���֮ǰ�����������б������ٵ�
			{
				destroyCcombobox(&m_list, &m_comBox, e_Item, e_SubItem);
				haveccomboboxcreate = false;
			}
		}
		else 
		{
			m_list.EditLabel(pEditCtrl->iItem);
			if (pEditCtrl->iSubItem != 1)//���������������ѡ��
		    {
			   if (haveccomboboxcreate == true)//���֮ǰ�����˱༭������ٵ�
			   {
				   destroyCcombobox(&m_list, &m_comBox, e_Item, e_SubItem);
				   haveccomboboxcreate = false;
			   }				
		   }
		else//������Ա�ѡ��ڵ�Ԫ�����������б���
		{
			
			if (haveccomboboxcreate == true)
			{
				if (!(e_Item == pEditCtrl->iItem && e_SubItem == pEditCtrl->iSubItem))//������еĵ�Ԫ����֮ǰ�����õ�
				{
					destroyCcombobox(&m_list, &m_comBox, e_Item, e_SubItem);
					haveccomboboxcreate = false;
					createCcombobox(pEditCtrl, &m_comBox, e_Item, e_SubItem, haveccomboboxcreate);//�����༭��
					m_comBox.AddString(_T("�ı�"));
					m_comBox.AddString(_T("�ı���"));
					m_comBox.AddString(_T("ͼƬ"));
					m_comBox.AddString(_T("����"));
					m_comBox.AddString(_T("�ĵ�"));
					m_comBox.AddString(_T("����"));
					m_comBox.SetCurSel(0);
					m_comBox.ShowDropDown();//�Զ�����
				}
				else//���еĵ�Ԫ����֮ǰ�����õ�
				{
					m_comBox.SetFocus();//����Ϊ���� 
				}
			}
			else
			{
				e_Item = pEditCtrl->iItem;//�����еĵ�Ԫ����и�ֵ�����ձ༭�����С��Ա���ڴ���
				e_SubItem = pEditCtrl->iSubItem;//�����еĵ�Ԫ����и�ֵ�����ձ༭�����С��Ա���ڴ���
				createCcombobox(pEditCtrl, &m_comBox, e_Item, e_SubItem, haveccomboboxcreate);//�����༭��
				m_comBox.AddString(_T("�ı�"));
				m_comBox.AddString(_T("�ı���"));
				m_comBox.AddString(_T("ͼƬ"));
				m_comBox.AddString(_T("����"));
				m_comBox.AddString(_T("�ĵ�"));
				m_comBox.AddString(_T("����"));
				m_comBox.SetCurSel(0);
				m_comBox.ShowDropDown();//�Զ�����
			}
		  }
		}
	} 
	else
	{
		if (pEditCtrl->iItem<keynum)
		{
			if (pEditCtrl->iItem<Getkeyval(p_foldernode.content, key, val ))//������ǹ�����
		    {
			   
			    if (haveccomboboxcreate == true)//���֮ǰ�����������б������ٵ�
			   {
				destroyCcombobox(&m_list, &m_comBox, e_Item, e_SubItem);
				haveccomboboxcreate = false;
			   }
		   }
			else{
				if (pEditCtrl->iSubItem != 1)
				{
					if (haveccomboboxcreate == true)//���֮ǰ�����˱༭������ٵ�
					{
						destroyCcombobox(&m_list, &m_comBox, e_Item, e_SubItem);
						haveccomboboxcreate = false;
					}
					
					

				}else
				{
					
					if (haveccomboboxcreate == true)//���֮ǰ�����������б������ٵ�
					{
						destroyCcombobox(&m_list, &m_comBox, e_Item, e_SubItem);
						haveccomboboxcreate = false;
					}

				}
			}
		}		
		else if (pEditCtrl->iSubItem != 1)//���������������ѡ��
		{
			if (haveccomboboxcreate == true)//���֮ǰ�����˱༭������ٵ�
			{
				destroyCcombobox(&m_list, &m_comBox, e_Item, e_SubItem);
				haveccomboboxcreate = false;
			}
			
			
		}
		else//������Ա�ѡ��ڵ�Ԫ�����������б���
		{
			
			if (haveccomboboxcreate == true)
			{
				if (!(e_Item == pEditCtrl->iItem && e_SubItem == pEditCtrl->iSubItem))//������еĵ�Ԫ����֮ǰ�����õ�
				{
					destroyCcombobox(&m_list, &m_comBox, e_Item, e_SubItem);
					haveccomboboxcreate = false;
					createCcombobox(pEditCtrl, &m_comBox, e_Item, e_SubItem, haveccomboboxcreate);//�����༭��
					m_comBox.AddString(_T("�ı�"));
					m_comBox.AddString(_T("�ı���"));
					m_comBox.AddString(_T("ͼƬ"));
					m_comBox.AddString(_T("����"));
					m_comBox.AddString(_T("�ĵ�"));
					m_comBox.AddString(_T("����"));
					m_comBox.SetCurSel(0);
					m_comBox.ShowDropDown();//�Զ�����
				}
				else//���еĵ�Ԫ����֮ǰ�����õ�
				{
					m_comBox.SetFocus();//����Ϊ���� 
				}
			}			
				createCcombobox(pEditCtrl, &m_comBox, e_Item, e_SubItem, haveccomboboxcreate);//�����༭��
				m_comBox.AddString(_T("�ı�"));
				m_comBox.AddString(_T("�ı���"));
				m_comBox.AddString(_T("ͼƬ"));
				m_comBox.AddString(_T("����"));
				m_comBox.AddString(_T("�ĵ�"));
				m_comBox.AddString(_T("����"));
				m_comBox.SetCurSel(0);
				m_comBox.ShowDropDown();//�Զ�����
			}
		}
	
	
	*pResult = 0;
}

void CTestComDlg::createEdit(NM_LISTVIEW  *pEditCtrl, CEdit *createdit, int &Item, int &SubItem, bool &havecreat)//������Ԫ��༭����
	//pEditCtrlΪ�б����ָ�룬createditΪ�༭��ָ�����
	//ItemΪ������Ԫ�����б��е��У�SubItem��Ϊ�У�havecreatΪ���󴴽���׼
{
	Item = pEditCtrl->iItem;//�����еĵ�Ԫ����и�ֵ�����ձ༭�����С��Ա���ڴ���
	SubItem = pEditCtrl->iSubItem;//�����еĵ�Ԫ����и�ֵ�����ձ༭�����С��Ա���ڴ���
	createdit->Create(ES_AUTOHSCROLL | WS_CHILD | ES_LEFT | ES_WANTRETURN,
		CRect(0, 0, 0, 0), this, IDC_EDIT_CREATEID);//�����༭�����,IDC_EDIT_CREATEIDΪ�ؼ�ID��3000�������¿�ͷ����
	havecreat = true;
	createdit->SetFont(&TextFont, FALSE);//��������,����������Ļ�������ֻ��ͻأ�ĸо�
	createdit->SetParent(&m_list);//��list control����Ϊ������,���ɵ�Edit������ȷ��λ,���Ҳ����Ҫ
	CRect  EditRect;
	m_list.GetSubItemRect(e_Item, e_SubItem, LVIR_LABEL, EditRect);//��ȡ��Ԫ��Ŀռ�λ����Ϣ
	EditRect.SetRect(EditRect.left+1, EditRect.top+1, EditRect.left + m_list.GetColumnWidth(e_SubItem), EditRect.bottom-1);//+1��-1�����ñ༭�����ڵ�ס�б���е�������
	CString strItem = m_list.GetItemText(e_Item, e_SubItem);//�����Ӧ��Ԫ���ַ�
	createdit->SetWindowText(strItem);//����Ԫ���ַ���ʾ�ڱ༭����
	createdit->MoveWindow(&EditRect);//���༭��λ�÷�����Ӧ��Ԫ����
	createdit->ShowWindow(SW_SHOW);//��ʾ�༭���ڵ�Ԫ������
	createdit->SetFocus();//����Ϊ���� 
	createdit->SetSel(-1);//���ù�����ı������ֵ����
}

void CTestComDlg::destroyEdit(CListCtrl *list,CEdit* destroyedit, int &Item, int &SubItem)
{
	CString meditdata;
	destroyedit->GetWindowText(meditdata);
	list->SetItemText(Item, SubItem, meditdata);//�����Ӧ��Ԫ���ַ�
	destroyedit->DestroyWindow();//���ٶ����д�����Ҫ�����٣���Ȼ�ᱨ��
}

void CTestComDlg::createCcombobox(NM_LISTVIEW  *pEditCtrl, CComboBox *createccomboboxobj, int &Item, int &SubItem, bool &havecreat)//������Ԫ�������б����
	//pEditCtrlΪ�б����ָ�룬createccomboboxΪ�����б��ָ�����
	//ItemΪ������Ԫ�����б��е��У�SubItem��Ϊ�У�havecreatΪ���󴴽���׼
{
	Item = pEditCtrl->iItem;//�����еĵ�Ԫ����и�ֵ�����ձ༭�����С��Ա���ڴ���
	SubItem = pEditCtrl->iSubItem;//�����еĵ�Ԫ����и�ֵ�����ձ༭�����С��Ա���ڴ���
	havecreat = true;
	createccomboboxobj->Create(WS_CHILD|WS_VISIBLE|WS_VSCROLL|CBS_DROPDOWNLIST, CRect(10,10,200,200),this, IDC_COMBOX_CREATEID);
	createccomboboxobj->SetFont(&TextFont, FALSE);//��������,����������Ļ�������ֻ��ͻأ�ĸо�
	createccomboboxobj->SetParent(&m_list);//��list control����Ϊ������,���ɵ�Ccombobox������ȷ��λ,���Ҳ����Ҫ
	CRect  EditRect;
	m_list.GetSubItemRect(e_Item, e_SubItem, LVIR_LABEL, EditRect);//��ȡ��Ԫ��Ŀռ�λ����Ϣ
	EditRect.SetRect(EditRect.left + 1, EditRect.top -2 , EditRect.left + m_list.GetColumnWidth(e_SubItem) - 1, EditRect.bottom - 15);//+1��-1�����ñ༭�����ڵ�ס�б���е�������
	CString strItem = m_list.GetItemText(e_Item, e_SubItem);//�����Ӧ��Ԫ���ַ�

	createccomboboxobj->SetWindowText(strItem);//����Ԫ���ַ���ʾ�ڱ༭����
	createccomboboxobj->MoveWindow(&EditRect);//���༭��λ�÷�����Ӧ��Ԫ����
	createccomboboxobj->ShowWindow(SW_SHOW);//��ʾ�༭���ڵ�Ԫ������
}

void CTestComDlg::destroyCcombobox(CListCtrl *list, CComboBox* destroyccomboboxobj, int &Item, int &SubItem)
{
	CString meditdata;
	destroyccomboboxobj->GetWindowText(meditdata);
	list->SetItemText(Item, SubItem, meditdata);//������Ӧ��Ԫ���ַ�
	destroyccomboboxobj->DestroyWindow();//���ٶ����д�����Ҫ�����٣���Ȼ�ᱨ��
}

void CTestComDlg::OnOK()
{ //����ʲôҲ��д
}



void CTestComDlg::OnNMDblclkList1(NMHDR *pNMHDR, LRESULT *pResult)
{
	
}


void CTestComDlg::OnNMRClickList1(NMHDR *pNMHDR, LRESULT *pResult)
{
	LPNMITEMACTIVATE pNMItemActivate = reinterpret_cast<LPNMITEMACTIVATE>(pNMHDR);
	// TODO: �ڴ���ӿؼ�֪ͨ����������
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
	// TODO: �ڴ���ӿؼ�֪ͨ����������
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
	// TODO: �ڴ���������������
	CString tip;
	if (itemcount==0)
	{
		tip=_T("");
	} 
	else
	{
		tip.Format("%d",itemcount);
	}

	int row = m_list.InsertItem(m_list.GetItemCount(), _T("������")+tip);
	m_list.SetItemText(row, 1, _T("�ı�"));
	itemcount++;
}


void CTestComDlg::OnDeleteRow()
{
	// TODO: �ڴ���������������
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
			clrNewBkColor = RGB(255,255,255);     //��ɫ  
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
