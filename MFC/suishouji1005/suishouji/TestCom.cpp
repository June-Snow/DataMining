// TestCom.cpp : ʵ���ļ�
//

#include "stdafx.h"
#include "SuiShouJi.h"
#include "TestCom.h"
#include "afxdialogex.h"

#include "InitializeCtrl.h"

// CTestCom �Ի���

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
	TextFont.CreatePointFont(90,_T("΢���ź�"));
	TitleFont.CreatePointFont(120,_T("΢���ź�"));
	NameFont.CreatePointFont(110,_T("����"));
	haveeditcreate = false;
	haveccomboboxcreate = false;	
	RECT  m_rect;
	int i;
	m_list.GetClientRect(&m_rect);   
	m_list.SetExtendedStyle(LVS_EX_GRIDLINES | LVS_EX_FULLROWSELECT); 	
	m_list.InsertColumn(0, _T("��ǩ����"), LVCFMT_LEFT, m_rect.right / 2);
	m_list.InsertColumn(1, _T("��ǩ����"), LVCFMT_LEFT, m_rect.right / 2);

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
	return TRUE;  // ���ǽ��������õ��ؼ������򷵻� TRUE
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


// CTestCom ��Ϣ�������


void CTestCom::OnBnSave()
{ 
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	int msg;
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
		MessageBox(_T("��ǩ����ʧ�ܣ������������"),_T("������ʾ"),MB_OK|MB_ICONERROR);
	}
	else if (msg==1)
	{
		MessageBox(_T("��ǩ����ɹ�"),_T("������ʾ"),MB_OK|MB_ICONASTERISK  );
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


void CTestCom::OnNMClickList1(NMHDR *pNMHDR, LRESULT *pResult)
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
	m_list.EditLabel(pEditCtrl->iItem);
	//m_list.SetFocus();
//	printf("�У�%d���У�%d\n", pEditCtrl->iItem, pEditCtrl->iSubItem);
	
	if (isNull==1)
	{
		if (pEditCtrl->iItem==-1)//������ǹ�����
		{
			
			if (haveccomboboxcreate == true)//���֮ǰ�����������б������ٵ�
			{
				destroyCcombobox(&m_list, &m_comBox, e_Item, e_SubItem);
				haveccomboboxcreate = false;
			}
		}
		else if (pEditCtrl->iSubItem != 1)//���������������ѡ��
		{
			
		
		}
		else//������Ա�ѡ��ڵ�Ԫ�����������б���
		{
			if (pEditCtrl->iItem>=1)
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
	else                             //�޸����Խ���
	{
		if (pEditCtrl->iItem<keynum)
		{
			if (pEditCtrl->iSubItem != 1)
			{
				if (haveccomboboxcreate == true)//���֮ǰ�����˱༭������ٵ�
				{
					destroyCcombobox(&m_list, &m_comBox, e_Item, e_SubItem);
					haveccomboboxcreate = false;
				}				
				
			}
			else
				{					
			        if (haveccomboboxcreate == true)//���֮ǰ�����������б������ٵ�
			            {
				            destroyCcombobox(&m_list, &m_comBox, e_Item, e_SubItem);
				            haveccomboboxcreate = false;
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
		else{
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
	
	//NMLISTVIEW *pNMListView = (NMLISTVIEW*)pNMHDR;   

	//if (-1 != pNMListView->iItem)        // ���iItem����-1����˵�����б��ѡ��   
	//{   
	//	// ��ȡ��ѡ���б����һ��������ı�   
	//	strLangName = m_list.GetItemText(pNMListView->iItem, 0);		 
	//}   
	*pResult = 0;
}


void CTestCom::createCcombobox(NM_LISTVIEW  *pEditCtrl, CComboBox *createccomboboxobj, int &Item, int &SubItem, bool &havecreat)//������Ԫ�������б����
	//pEditCtrlΪ�б����ָ�룬createccomboboxΪ�����б��ָ�����
	//ItemΪ������Ԫ�����б��е��У�SubItem��Ϊ�У�havecreatΪ���󴴽���׼
{
	Item = pEditCtrl->iItem;//�����еĵ�Ԫ����и�ֵ�����ձ༭�����С��Ա���ڴ���
	SubItem = pEditCtrl->iSubItem;//�����еĵ�Ԫ����и�ֵ�����ձ༭�����С��Ա���ڴ���
	havecreat = true;
	createccomboboxobj->Create(WS_CHILD | WS_VISIBLE |  CBS_DROPDOWN | CBS_OEMCONVERT, CRect(10,7,200,200), this, IDC_COMBOX_CREATEID);
	createccomboboxobj->SetFont(&TextFont, FALSE);//��������,����������Ļ�������ֻ��ͻأ�ĸо�
	createccomboboxobj->SetParent(&m_list);//��list control����Ϊ������,���ɵ�Ccombobox������ȷ��λ,���Ҳ����Ҫ
	CRect  EditRect;
	m_list.GetSubItemRect(e_Item, e_SubItem, LVIR_LABEL, EditRect);//��ȡ��Ԫ��Ŀռ�λ����Ϣ
	EditRect.SetRect(EditRect.left + 1, EditRect.top , EditRect.left + m_list.GetColumnWidth(e_SubItem), EditRect.bottom-10 );//+1��-1�����ñ༭�����ڵ�ס�б���е�������
	CString strItem = m_list.GetItemText(e_Item, e_SubItem);//�����Ӧ��Ԫ���ַ�
	createccomboboxobj->SetWindowText(strItem);//����Ԫ���ַ���ʾ�ڱ༭����
	createccomboboxobj->MoveWindow(&EditRect);//���༭��λ�÷�����Ӧ��Ԫ����
	createccomboboxobj->ShowWindow(SW_SHOW);//��ʾ�༭���ڵ�Ԫ������
}

void CTestCom::destroyCcombobox(CListCtrl *list, CComboBox* destroyccomboboxobj, int &Item, int &SubItem)
{
	CString meditdata;
	destroyccomboboxobj->GetWindowText(meditdata);
	list->SetItemText(Item, SubItem, meditdata);//������Ӧ��Ԫ���ַ�
	destroyccomboboxobj->DestroyWindow();//���ٶ����д�����Ҫ�����٣���Ȼ�ᱨ��
}


void CTestCom::OnBnClickedButton4()     //���ٰ�ť����Ӧ
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	int i;
	if (strLangName=="")
	{
		CString str2= _T("δѡ���");
		MessageBox(str2,_T("��ʾ"),MB_OKCANCEL);
	} 
	else
	{
		int sel_no=atoi(strLangName);   //Ҫɾ����ID�� 
		POSITION pos = m_list .GetFirstSelectedItemPosition();
	    while(pos)
	    {
		   int nIndex = m_list.GetNextSelectedItem(pos);
		   m_list .DeleteItem(nIndex);
		   pos = m_list .GetFirstSelectedItemPosition(); //�ⲽ����Ҫ����Ȼɾ������ȫ
	    }
		//ɾ��ѡ��ѡ����Ϣ �ٴ����ɾ������
	}			   
	
}


void CTestCom::OnBnClickedButton3()    //���
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	m_list.InsertItem(m_list.GetItemCount(), _T(""));
	m_list.SetItemText(m_list.GetItemCount(), 1, _T(""));
}

void CTestCom::OnOK()
{ //����ʲôҲ��д
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
	// TODO: �ڴ���ӿؼ�֪ͨ����������
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


void CTestCom::OnDeleteRow()
{
	// TODO: �ڴ���������������	
	m_list.DeleteItem(m_selectnum);
}


void CTestCom::OnLvnEndlabeleditList1(NMHDR *pNMHDR, LRESULT *pResult)
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

BOOL   CTestCom::PreTranslateMessage(MSG*   pMsg)    
{  
	if(pMsg->message==WM_KEYDOWN   &&   pMsg->wParam==VK_ESCAPE)     return   TRUE;  
	if(pMsg->message==WM_KEYDOWN   &&   pMsg->wParam==VK_RETURN)   return   TRUE;    
	else    
		return   CDialog::PreTranslateMessage(pMsg);  
}


void CTestCom::OnStnClickedStatic1()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
}
