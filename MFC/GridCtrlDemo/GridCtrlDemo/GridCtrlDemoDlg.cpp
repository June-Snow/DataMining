
// GridCtrlDemoDlg.cpp : ʵ���ļ�
//

#include "stdafx.h"
#include "GridCtrlDemo.h"
#include "GridCtrlDemoDlg.h"
#include "afxdialogex.h"
#include "GridCtrl/NewCellTypes/GridCellCheck.h"
#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// ����Ӧ�ó��򡰹��ڡ��˵���� CAboutDlg �Ի���

class CAboutDlg : public CDialogEx
{
public:
	CAboutDlg();

// �Ի�������
	enum { IDD = IDD_ABOUTBOX };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV ֧��

// ʵ��
protected:
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialogEx(CAboutDlg::IDD)
{
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialogEx)
END_MESSAGE_MAP()


// CGridCtrlDemoDlg �Ի���




CGridCtrlDemoDlg::CGridCtrlDemoDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CGridCtrlDemoDlg::IDD, pParent)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CGridCtrlDemoDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CGridCtrlDemoDlg, CDialog)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_WM_CREATE()
	ON_WM_SIZE()
	ON_NOTIFY(NM_CLICK, 1230, OnGridClick)
	ON_NOTIFY(NM_RCLICK, 1230, OnGridRClick)
	ON_COMMAND(2000, OnGridAdd)
	ON_COMMAND(2001, OnGridDelete)
	ON_COMMAND(2002, OnGridMerge)
	ON_COMMAND(2003, OnGridUnMerge)
	ON_NOTIFY(NM_CLICK, 1231, OnTreeClick)
	ON_NOTIFY(NM_RCLICK, 1231, OnTreeRClick)
	ON_COMMAND(3000, OnCreatItem)
	ON_COMMAND(3001, OnTreeDelete)//SetCellCheck
	ON_BN_CLICKED(1230, CGridSetCellCheck)
	ON_NOTIFY(GVN_SELCHANGING, 1230, OnGridStartSelChange)
	ON_NOTIFY(GVN_SELCHANGING, 1230, OnGridEdit)
END_MESSAGE_MAP()


// CGridCtrlDemoDlg ��Ϣ�������

BOOL CGridCtrlDemoDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// ��������...���˵�����ӵ�ϵͳ�˵��С�

	// IDM_ABOUTBOX ������ϵͳ���Χ�ڡ�
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		BOOL bNameValid;
		CString strAboutMenu;
		bNameValid = strAboutMenu.LoadString(IDS_ABOUTBOX);
		ASSERT(bNameValid);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// ���ô˶Ի����ͼ�ꡣ��Ӧ�ó��������ڲ��ǶԻ���ʱ����ܽ��Զ�
	//  ִ�д˲���
	SetIcon(m_hIcon, TRUE);			// ���ô�ͼ��
	SetIcon(m_hIcon, FALSE);		// ����Сͼ��

	AddData();//����б�
	OnAddTree();//�����
	return TRUE;  // ���ǽ��������õ��ؼ������򷵻� TRUE
}

void CGridCtrlDemoDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialog::OnSysCommand(nID, lParam);
	}
}

// �����Ի��������С����ť������Ҫ����Ĵ���
//  �����Ƹ�ͼ�ꡣ����ʹ���ĵ�/��ͼģ�͵� MFC Ӧ�ó���
//  �⽫�ɿ���Զ���ɡ�

void CGridCtrlDemoDlg::OnPaint()
{
	if (IsIconic())
	{
		CPaintDC dc(this); // ���ڻ��Ƶ��豸������

		SendMessage(WM_ICONERASEBKGND, reinterpret_cast<WPARAM>(dc.GetSafeHdc()), 0);

		// ʹͼ���ڹ����������о���
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// ����ͼ��
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CPaintDC dc(this); // ���ڻ��Ƶ��豸������
		CRect rect;
		GetWindowRect(&rect);
		ScreenToClient(&rect);
		dc.FillSolidRect(rect,RGB(255,255,255));
		CDialog::OnPaint();
	}
}

//���û��϶���С������ʱϵͳ���ô˺���ȡ�ù��
//��ʾ��
HCURSOR CGridCtrlDemoDlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}

int CGridCtrlDemoDlg::OnCreate(LPCREATESTRUCT lpCreateStruct)
{
	if (CDialog::OnCreate(lpCreateStruct) == -1)
		return -1;
	CRect rect;
	GetWindowRect(&rect);
	// TODO:  �ڴ������ר�õĴ�������
	m_grid.Create(rect,this,1230);
	m_grid.SetBkColor(RGB(255,255,255));
	m_grid.SetColumnCount(7);
	m_grid.InsertRow(" ");
	m_grid.SetItemText(0,1, " ");
	m_grid.SetItemText(0,2, "���");
	m_grid.SetItemText(0,3, "����");
	m_grid.SetItemText(0,4, "����");
	m_grid.SetItemText(0,5, "����");
	m_grid.SetItemText(0,6, "�ϼ�");
	m_grid.SetFixedRowCount(1);

	m_tree.Create(WS_VISIBLE|WS_CHILD|TVS_HASLINES|TVS_HASBUTTONS|TVS_LINESATROOT,CRect(0,0,0,0),this,1231);
	return 0;
}

void CGridCtrlDemoDlg::OnSize(UINT nType, int cx, int cy)
{
	// TODO: �ڴ˴������Ϣ����������
	CDialog::OnSize(nType, cx, cy);
	CRect rect;
	GetWindowRect(&rect);
	m_tree.MoveWindow(0, 0, rect.Width()/4,rect.Height(),TRUE);
	m_grid.MoveWindow(rect.Width()/4,0,rect.Width()*3/4,rect.Height(),TRUE);
	m_grid.SetColumnWidth(0,30);
	m_grid.SetColumnWidth(1,30);
	m_grid.SetColumnWidth(2,60);
	int width = (rect.Width()-130)/6;
	m_grid.SetColumnWidth(3,width);
	m_grid.SetColumnWidth(4,width);
	m_grid.SetColumnWidth(5,width);
}

void CGridCtrlDemoDlg::AddData()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	//m_grid.InsertRow(_T("����"));
	//m_grid.SetItemBkColour(1,1,RGB(0,255,0));

	CString strData[31][4] = {
	{"һ","ϵͳ1","0","0"},
	{"(һ)","��ϵͳ1","0","0"},
	{"1","ģ��","0","0"},
	{"(1)","��ģ��1","0","0"},
	{"(2)","��ģ��2","0","0"},
	{"(3)","��ģ��3","0","0"},
	{"2","ģ��","",""},
	{"2.1","��ģ��1","0","0"},
	{"2.2","��ģ��2","0","0"},
	{"2.3","��ģ��3","0","0"},
	{"3","ģ��3","",""},
	{"4","ģ��4","",""},
	{"������","��ϵͳ2","",""},
	{"1","ģ��1","",""},
	{"(1)","��ģ��1","",""},
	{"(2)","��ģ��2","",""},
	{"(3)","��ģ��3","",""},
	{"2","ģ��2","",""},
	{"3","ģ��3","",""},
	{"4","ģ��4","",""},
	{"4.1","�豸1","",""},
	{"4.2","�豸2","",""},
	{"4.3","�豸3","",""},
	{"(��)","��ϵͳ3","",""},
	{"(��)","��ϵͳ4","",""},
	{"(��)","��ϵͳ5","",""},
	{"��","ϵͳ2","",""},
	{"��һ��","��ϵͳ","",""},
	{"������","��ϵͳ","",""},
	{"��","ϵͳ2","",""},
	{"��","��ϵͳ","",""}
	};

	for (int i=0; i!=31; i++)
	{
		m_grid.InsertRow(" ");
		CString str;
		str.Format("%d",i+1);
		m_grid.SetItemText(i+1,1,str);
		m_grid.SetItemText(i+1,2,strData[i][0]);
		m_grid.SetItemText(i+1,3,strData[i][1]);
		m_grid.SetItemText(i+1,4,strData[i][2]);
		m_grid.SetItemText(i+1,5,strData[i][3]);
	}
	GroupPaintGrid(m_grid);
	m_grid.Invalidate(FALSE);
}

int CGridCtrlDemoDlg::GroupPaintGrid(CGridCtrl &m_gird)
{
	std::vector<CString>serialStr;
	for (int i=1; i!=m_gird.GetRowCount(); i++){
		CString str;
		str = m_gird.GetItemText(i,2);
		serialStr.push_back(str);
	}
	//��ע������ɫ
	//////////20160306�޸�///////////////////////
	std::vector<std::vector<DeviceItemNode> > layerArray;
	GridNumberLayer(serialStr, layerArray);
	for (int i=0; i!=layerArray.size(); i++)
	{
		std::vector<DeviceItemNode> serialArray;
		serialArray = layerArray[i];
		for (int i=0; i!=serialArray.size(); i++)
		{
			DeviceItemNode node;
			node = serialArray[i];
			int len = node.endPos - node.startPos + 1;
			if (len > 1)
			{
				CString str;
				str.Format("%d", len);
				m_gird.SetItemData(node.startPos+1, 0, len);
				m_gird.SetItemText(node.startPos+1, 0, "-");
				m_gird.SetItemState(node.startPos+1, 0, GVIS_READONLY);
			}
			if (len > 0){
				int layerNum = GroupLevelGrid(serialStr[node.startPos]);
				COLORREF layerColor;
				switch(layerNum)
				{
				case 1 :layerColor = RGB(0,128,255);break;
				case 2 :layerColor = RGB(255,0,128);break;
				case 3 :layerColor = RGB(128,255,0);break;
				case 4 :layerColor = RGB(128,0,255);break;
				default:layerColor = RGB(255,128,0);break;
				}
				for (int j=0; j!=m_gird.GetColumnCount(); j++){
					m_gird.GetCell(node.startPos+1,j)->SetTextClr(layerColor);
				}
			}
		}
	}
	m_gird.Invalidate(FALSE);
	return 0;
}


void CGridCtrlDemoDlg::OnGridClick(NMHDR *pNotifyStruct, LRESULT* pResult)
{
	NM_GRIDVIEW* pItem = (NM_GRIDVIEW*) pNotifyStruct;
	CCellID cell = m_grid.GetFocusCell();
	int num = m_grid.GetItemData(cell.row,0);
	CString str = m_grid.GetItemText(cell.row, 0);
	if (cell.col != 0){
		return;
	}
	if(strcmp(str, "-") == 0){//��������
		for(int i=1; i!=num; i++){
			m_grid.SetRowHeight(cell.row+i,0);
		}
		m_grid.SetItemText(cell.row, 0, _T("+"));
	} 
	if(strcmp(str, "+") == 0){//չ������
		for(int i=1; i!=num; i++){
			CString sign = m_grid.GetItemText(cell.row+i, 0);
			int rowNum = m_grid.GetItemData(cell.row+i, 0);
			if (strcmp(sign, "+") == 0)	{
				m_grid.SetRowHeight(cell.row+i,28);
				i+=rowNum-1;
			}
			else{
				m_grid.SetRowHeight(cell.row+i,28);
			}
		}
		m_grid.SetItemText(cell.row, 0, _T("-"));
	}

	m_grid.Invalidate(FALSE);
}

void CGridCtrlDemoDlg::OnGridRClick(NMHDR *pNMHDR, LRESULT* pResult)
{
	LPNMITEMACTIVATE pNMItemActivate = reinterpret_cast<LPNMITEMACTIVATE>(pNMHDR);
	int selectItem = pNMItemActivate->iItem;
	if (selectItem != 0)
	{
		UINT state = m_grid.GetCell(pNMItemActivate->iItem, pNMItemActivate->iSubItem)->GetState();
		if (!(GVIS_SELECTED&state))
		{
			m_grid.SetSelectedRange(pNMItemActivate->iItem, pNMItemActivate->iSubItem,
				pNMItemActivate->iItem, pNMItemActivate->iSubItem);
		}
		CMenu menuSetPara;
		CMenu popupMenu;
		CPoint point;
		menuSetPara.CreateMenu();
		popupMenu.CreateMenu();
		menuSetPara.AppendMenu(MF_POPUP, (UINT_PTR)popupMenu.m_hMenu, _T("asdad"));
		CMenu *pa = menuSetPara.GetSubMenu(0);
		GetCursorPos(&point);

		CCellRange CCR = m_grid.GetSelectedCellRange();
		curGridPos[0] = CCR.GetMinRow();
		curGridPos[1] = CCR.GetMaxRow();
		curGridPos[2] = CCR.GetMinCol();
		curGridPos[3] = CCR.GetMaxCol();
		pa->AppendMenu(MF_STRING, 2000, _T("����һ��"));
		pa->AppendMenu(MF_STRING, 2001, _T("ɾ��"));
		pa->AppendMenu(MF_STRING, 2002, _T("�ϲ���Ԫ��"));
		pa->AppendMenu(MF_STRING, 2003, _T("ȡ���ϲ���Ԫ��"));
		pa->TrackPopupMenu(TPM_RIGHTBUTTON, point.x, point.y, this);
	}
	
	m_grid.Invalidate(FALSE);



	//m_grid.SetCellType(1,1,RUNTIME_CLASS(CGridCellCheck));
	//CGridCellBase* pCell=m_grid.GetCell(1,1);

	//if (pCell!=NULL&&pCell->IsKindOf(RUNTIME_CLASS(CGridCellCheck)))
	//{
	//	//����checkBox��״̬
	//	//((CGridCellCheck*)pCell)->SetCheck(TRUE);
	//}

}

void CGridCtrlDemoDlg::OnGridAdd()
{
	int num = curGridPos[0];
	if (num < m_grid.GetRowCount()-1)
	{
		m_grid.InsertRow(_T("����һ��"), num+1);
	} 
	else
	{
		m_grid.InsertRow(_T("����һ��"), -1);
	}


}

void CGridCtrlDemoDlg::OnGridDelete()
{
	int minRow = curGridPos[0];
	int maxRow = curGridPos[1];
	if (minRow == maxRow)
	{
		m_grid.DeleteRow(minRow);
	} 
	else
	{
		for (int i=maxRow; i!=minRow-1; i--)
		{
			m_grid.DeleteRow(i);
		}
	}
}

void CGridCtrlDemoDlg::OnGridMerge()
{
	//MessageBox(_T("û�кϲ�����"));

	CCellRange range=m_grid.GetSelectedCellRange();
	if(range.GetColSpan()<=1 && range.GetRowSpan()<=1)
		return;
	m_grid.MergeCells(range.GetMinRow(), range.GetMinCol(), range.GetMaxRow(), range.GetMaxCol());
	m_grid.GetCell(3,2)->SetTextClr(RGB(255,0,0));
	m_grid.SetItemBkColour(4,4,RGB(255,0,0));
}

void CGridCtrlDemoDlg::OnAddTree()
{
	HICON hIcon[3];      // ͼ��������   
	HTREEITEM hRoot;     // ���ĸ��ڵ�ľ��   
	HTREEITEM hCataItem; // �ɱ�ʾ��һ����ڵ�ľ��   
	HTREEITEM hArtItem;  // �ɱ�ʾ��һ���½ڵ�ľ��   

	// ��������ͼ�꣬�������ǵľ�����浽����   
	hIcon[0] = theApp.LoadIcon(IDI_ICON2);   
	hIcon[1] = theApp.LoadIcon(IDI_ICON1);   
	hIcon[2] = theApp.LoadIcon(IDI_ICON3);   

	// ����ͼ������CImageList����   
	m_imageList.Create(16, 16, ILC_COLOR32, 3, 3);   
	for (int i=0; i<3; i++)   
	{   
		m_imageList.Add(hIcon[i]);   
	}  

	// Ϊ���οؼ�����ͼ������   
	m_tree.SetImageList(&m_imageList, TVSIL_NORMAL);  

	// ������ڵ�   
	hRoot = m_tree.InsertItem(_T("������"), 0, 0);   
	m_tree.SetItemData(hRoot, 1);
	// �ڸ��ڵ��²����ӽڵ�   
	hCataItem = m_tree.InsertItem(_T("IT������"), 1, 1, hRoot, TVI_LAST);   
	m_tree.SetItemData(hCataItem, 1);
	// Ϊ��IT���������ڵ���Ӹ��ӵı�����ݣ�����껮���ýڵ�ʱ��ʾ   
	m_tree.SetItemData(hCataItem, 1);   
	// �ڡ�IT���������ڵ��²����ӽڵ�   
	hArtItem = m_tree.InsertItem(_T("�ٶ�����1"), 2, 2, hCataItem, TVI_LAST);   
	// Ϊ���ٶ�����1���ڵ���Ӹ��ӵı�����ݣ�����껮���ýڵ�ʱ��ʾ   
	m_tree.SetItemData(hArtItem, 2);   
	// �ڡ�IT���������ڵ��²�����һ�ӽڵ�   
	hArtItem = m_tree.InsertItem(_T("�ȸ�����2"), 2, 2, hCataItem, TVI_LAST);   
	// Ϊ���ȸ�����2���ڵ���Ӹ��ӵı�����ݣ�����껮���ýڵ�ʱ��ʾ   
	m_tree.SetItemData(hArtItem, 3);   
	// �ڸ��ڵ��²���ڶ����ӽڵ�   
	hCataItem = m_tree.InsertItem(_T("��������"), 1, 1, hRoot, TVI_LAST);   
	// Ϊ����������ڵ���Ӹ��ӵı�����ݣ�����껮���ýڵ�ʱ��ʾ   
	m_tree.SetItemData(hCataItem, 4);   
	// �ڡ���������ڵ��²����ӽڵ�   
	hArtItem = m_tree.InsertItem(_T("�����ֻ�����1"), 2, 2, hCataItem, TVI_LAST);   
	// Ϊ�������ֻ�����1���ڵ���Ӹ��ӵı�����ݣ�����껮���ýڵ�ʱ��ʾ   
	m_tree.SetItemData(hArtItem, 5);   
	// �ڡ���������ڵ��²�����һ�ӽڵ�   
	hArtItem = m_tree.InsertItem(_T("ƽ���������2"), 2, 2, hCataItem, TVI_LAST);   
	// Ϊ��ƽ���������2���ڵ���Ӹ��ӵı�����ݣ�����껮���ýڵ�ʱ��ʾ   
	m_tree.SetItemData(hArtItem, 6);   
	// �ڸ��ڵ��²���������ӽڵ�   
	hCataItem = m_tree.InsertItem(_T("�������"), 1, 1, hRoot, TVI_LAST);   
	// Ϊ������������ڵ���Ӹ��ӵı�����ݣ�����껮���ýڵ�ʱ��ʾ   
	m_tree.SetItemData(hCataItem, 7);   
	// �ڡ�����������ڵ��²����ӽڵ�   
	hArtItem = m_tree.InsertItem(_T("C++�������ϵ��1"), 2, 2, hCataItem, TVI_LAST);   
	// Ϊ��C++�������ϵ��1���ڵ���Ӹ��ӵı�����ݣ�����껮���ýڵ�ʱ��ʾ   
	m_tree.SetItemData(hArtItem, 8);   
	// �ڡ�����������ڵ��²�����һ�ӽڵ�   
	hArtItem = m_tree.InsertItem(_T("VS2010/MFC�������2"), 2, 2, hCataItem, TVI_LAST);   
	// Ϊ��VS2010/MFC�������2���ڵ���Ӹ��ӵı�����ݣ�����껮���ýڵ�ʱ��ʾ   
	m_tree.SetItemData(hArtItem, 9);   
	// �ڸ��ڵ��²�����ĸ��ӽڵ�   
	hCataItem = m_tree.InsertItem(_T("��������"), 1, 1, hRoot, TVI_LAST);   
	// Ϊ���������С��ڵ���Ӹ��ӵı�����ݣ�����껮���ýڵ�ʱ��ʾ   
	m_tree.SetItemData(hCataItem, 10);   
	// �ڡ��������С��ڵ��²����ӽڵ�   
	hArtItem = m_tree.InsertItem(_T("������������1"), 2, 2, hCataItem, TVI_LAST);   
	// Ϊ��������������1���ڵ���Ӹ��ӵı�����ݣ�����껮���ýڵ�ʱ��ʾ   
	m_tree.SetItemData(hArtItem, 11);   
	// �ڡ��������С��ڵ��²�����һ�ӽڵ�   
	hArtItem = m_tree.InsertItem(_T("ITЦ��2"), 2, 2, hCataItem, TVI_LAST);  
}

void CGridCtrlDemoDlg::OnTreeClick(NMHDR *pNotifyStruct, LRESULT* pResult)
{
	CPoint point;
	GetCursorPos(&point);
	m_tree.ScreenToClient(&point);
	UINT uFlags;
	HTREEITEM hItemDbClk = m_tree.HitTest(point, &uFlags);
	if (hItemDbClk != NULL)
	{
		CString text = m_tree.GetItemText(hItemDbClk);
		CString itemno;
		int no = m_tree.GetItemData(hItemDbClk);
		itemno.Format("%d", no);
		HTREEITEM pItem = m_tree.GetParentItem(hItemDbClk);
		HTREEITEM hRoot = m_tree.GetRootItem();
		CString consistno;
		consistno.Format("%d", no);
		if (pItem == hRoot)
		{
			
		}
		else if(m_tree.GetParentItem(pItem) == hRoot)
		{
			
		}
	}
}

void CGridCtrlDemoDlg::OnTreeRClick(NMHDR *pNotifyStruct, LRESULT* pResult)
{
	CPoint point;
	GetCursorPos(&point);
	CPoint pontTree = point;
	m_tree.ScreenToClient(&pontTree);
	UINT flag = TVHT_ONITEM;
	HTREEITEM rhItem = m_tree.HitTest(pontTree, &flag);
	HTREEITEM hRoot = m_tree.GetRootItem();
	if (rhItem != NULL)
	{
		m_tree.SelectItem(rhItem);
		CMenu menuSetPara;
		CMenu popuMenu;
		menuSetPara.CreateMenu();
		popuMenu.CreateMenu();
		menuSetPara.AppendMenu(MF_POPUP, (UINT_PTR)popuMenu.m_hMenu, _T("�˵�"));
		CMenu *pa = menuSetPara.GetSubMenu(0);
		int no = m_tree.GetItemData(rhItem);
		if (no == 1)
		{
			pa->AppendMenu(MF_STRING, 3000,_T("�½���Ŀ"));
			pa->AppendMenu(MF_STRING, 3001,_T("ɾ����Ŀ"));

		}
		else
		{
			pa->AppendMenu(MF_STRING, 3001,_T("ɾ����Ŀ"));
		}
		pa->TrackPopupMenu(TPM_RIGHTBUTTON, point.x, point.y, this);
	}
}

void CGridCtrlDemoDlg::OnCreatItem()
{
	HTREEITEM hRoot = m_tree.GetSelectedItem();
	int no = m_tree.GetItemData(hRoot);
	int childno;
	CString name;
	if (no == 1)
	{
		name = _T("�½���Ŀ");
		childno = 2;
	} 
	else
	{
		name = _T("�½��豸��");
		childno = 1;
	}
	HTREEITEM subItem = m_tree.InsertItem(name, 0, 0, hRoot,TVI_FIRST);
	m_tree.SetItemData(subItem, childno);
	m_tree.EditLabel(subItem);
}

void CGridCtrlDemoDlg::OnTreeDelete()
{
	HTREEITEM item = m_tree.GetSelectedItem();
	m_tree.DeleteItem(item);
}

void CGridCtrlDemoDlg::OnGridUnMerge()
{
	CCellRange range=m_grid.GetSelectedCellRange();

	m_grid.UnMergeCells(range.GetMinRow(), range.GetMinCol(), range.GetMaxRow(), range.GetMaxCol());
	m_grid.GetCell(2,2)->SetBackClr(RGB(51,153,255));
	m_grid.GetCell(2,2)->SetTextClr(RGB(255, 0, 0));
	m_grid.SetSingleRowSelection(TRUE);
}

void CGridCtrlDemoDlg::CGridSetCellCheck()
{
	//���õ�Ԫ������
	//m_grid.SetCellType(1,1, RUNTIME_CLASS(CGridCell));
	//m_grid.SetItemText(1,1, _T("1"));
	//m_grid.SetItemState(1,1, m_grid.GetItemState(1,1) & ~GVIS_READONLY);
	//m_grid.Invalidate();

	//m_grid.SetCellType(1,1,RUNTIME_CLASS(CGridCellCheck));
	//CGridCellBase* pCell=m_grid.GetCell(1,1);

	//if (pCell!=NULL&&pCell->IsKindOf(RUNTIME_CLASS(CGridCellCheck)))
	//{
	//	//����checkBox��״̬
	//	((CGridCellCheck*)pCell)->SetCheck(TRUE);
	//}
	//m_grid.SetCellCheck();
}

void CGridCtrlDemoDlg::OnGridStartSelChange(NMHDR *pNotifyStruct, LRESULT* /*pResult*/)
{
	NM_GRIDVIEW* pItem = (NM_GRIDVIEW*) pNotifyStruct;
		//pItem->iRow, pItem->iColumn, m_Grid.GetSelectedCount());
	int row = pItem->iRow;
	CString str  = m_grid.GetItemText(row, 2);
	std::vector<CString>serialStr;
	for (int i=1; i!=m_grid.GetRowCount(); i++){
		CString str;
		str = m_grid.GetItemText(i,2);
		serialStr.push_back(str);
	}
	std::vector<int> pos;
	GridCascadeSequenceNumber(serialStr, row, pos);
	GridCascadingChanges(pos);

}

//////////20160306�޸�///////////////////////
//��������ַ��Ĳ��
int CGridCtrlDemoDlg::GroupLevelGrid(CString str)
{
	if (str.IsEmpty())
	{
		return -1;
	}
	CString str1 = _T("��һ�����������߰˾�ʮ��ǧ��");
	CString str2 = _T("1234567890");
	char *p = NULL;
	int word;
	p = (LPSTR)(LPCTSTR)str;
	word = *p;
	if ((word!=-93) && (word < 0) && (str1.Find(str.Mid(0, 2)) != -1)){//һ
		return 1;
	}else if (((str1.Find(str.Mid(2, 2)) != -1)&& word==-93) ||((str1.Find(str.Mid(1, 2)) != -1) && word==40)){//(һ)��һ��
		return 2;
	}else if ((str.Find(".")==-1) && (str2.Find(str.Mid(0,1))!=-1) && word > 0){//1�� 2	
		return 3;
	}else if ((str.Find(".")!=-1) && (str2.Find(str.Mid(0,1))!=-1) && word > 0){//1.1������1.1.1.1
		int count = 0;
		while (1){
			int pos = str.Find(".");
			if (pos != -1){
				str = str.Mid(pos+1);
				count++;
			}else{
				break;
			}
		}
		return (3+count);
	} 
	else if(((str2.Find(str.Mid(2, 1)) != -1) && word==-93) ||((str2.Find(str.Mid(1, 1)) != -1) && word==40)){//(1)
		return 0;
	}else{
		return -1;
	} 
}
//////////20160306�޸�///////////////////////
//������в��
int CGridCtrlDemoDlg::GridNumberLayer(std::vector<CString>serialStr, std::vector<std::vector<DeviceItemNode> > &layerArray)
{
	//��һ�������
	std::vector<DeviceItemNode> serialArray;
	DeviceItemNode node;
	node.startPos = 0;
	CString str = serialStr[0];
	int level = GroupLevelGrid(str);
	for (int i=1; i!=serialStr.size(); i++){
		CString str1 = serialStr[i];
		int level1 = GroupLevelGrid(str1);
		if (level == level1){
			node.endPos = i-1;
			serialArray.push_back(node);
			node.startPos = i;
		} 
	}
	node.endPos = serialStr.size()-1;
	serialArray.push_back(node);
	//��������
	while(serialArray.size()){
		std::vector<DeviceItemNode> serialArray1;
		layerArray.push_back(serialArray);
		serialArray1 = serialArray;
		serialArray.clear();
		GridSameLayer(serialStr, serialArray1, serialArray);
	}
	return 1;
}
//////////20160306�޸�///////////////////////
//���ͬһ��ķ���
void CGridCtrlDemoDlg::GridSameLayer(std::vector<CString>serialStr, 
	std::vector<DeviceItemNode> serialArray,
	std::vector<DeviceItemNode> &serialArray1)
{
	for (int i=0; i!=serialArray.size(); i++){
		DeviceItemNode startEndPos;
		startEndPos = serialArray[i];
		DeviceItemNode node;
		node.startPos = 0;
		node.endPos = 0;
		if (startEndPos.startPos+1 == startEndPos.endPos){
			node.startPos = startEndPos.endPos;
			node.endPos = startEndPos.endPos;
			serialArray1.push_back(node);
		}else if(startEndPos.startPos+1 < startEndPos.endPos)
		{
			CString str = serialStr[startEndPos.startPos+1];
			int level = GroupLevelGrid(str);
			node.startPos = startEndPos.startPos+1;
			for (int j=startEndPos.startPos+2; j<=startEndPos.endPos; j++){
				CString str1 = serialStr[j];
				int level1 = GroupLevelGrid(str1);
				if (level == level1){
					node.endPos = j-1;
					serialArray1.push_back(node);
					node.startPos = j;
				} 
			}
			if (node.startPos != 0){
				node.endPos = startEndPos.endPos;
				serialArray1.push_back(node);
			}
		}
	}
}
//////////20160306�޸�///////////////////////
//�������,���㵱ǰ�㼶����������ֱ���㼶
void CGridCtrlDemoDlg::GridCascadeSequenceNumber(std::vector<CString>serialStr, int row, std::vector<int> &pos)
{
	if (row<0 || row>serialStr.size()-1){
		return;
	}
	pos.push_back(row);
	CString str = serialStr[row-1];
	int level = GroupLevelGrid(str);
	int cur_level = level;

	for (int i=row-2; i>=0; i--){
		CString str1 = serialStr[i];
		int level1 = GroupLevelGrid(str1);
		if (cur_level == 0){
			if (level1 != 0){
				pos.push_back(i+1);
				cur_level = level1;
			}
		}else{
			if (level1+1 == cur_level){
				pos.push_back(i+1);
				cur_level = level1;
			}
		}
		if (cur_level == 1){
			break;
		}
	}
}
//////////20160306�޸�///////////////////////
//�����޸�
void CGridCtrlDemoDlg::GridCascadingChanges(std::vector<int> pos)
{
	CString strNum = m_grid.GetItemText(pos[0], 4);
	CString strPrice = m_grid.GetItemText(pos[0], 5);
	CString strOriSum = m_grid.GetItemText(pos[0], 6);
	if (strNum.IsEmpty()){ strNum = "0"; }
	if (strPrice.IsEmpty()){ strPrice = "0"; }
	if (strOriSum.IsEmpty()){ strOriSum = "0"; }
	double oriSum = _ttof(strOriSum);
	double curSum = _ttoi(strNum) * _ttof(strPrice);
	double balance = curSum - oriSum;
	int num = _ttoi(strNum);
	CString strCurSum;
	strCurSum.Format("%lf", curSum);
	m_grid.SetItemText(pos[0], 6, strCurSum);
	CString str = m_grid.GetItemText(pos[0], 2);
	int level = GroupLevelGrid(str);
	for (int i=1; i!=pos.size(); i++)
	{
		int row = pos[i];
		GridCascadingChangesRow(row, balance, num, level);
	}
	Invalidate(FALSE);
}
//////////20160306�޸�///////////////////////
//�����޸�һ��
void CGridCtrlDemoDlg::GridCascadingChangesRow(int row, double balance, int num, int level)
{
	CString strNum = m_grid.GetItemText(row, 4);
	CString strPrice = m_grid.GetItemText(row, 5);
	CString strOriSum = m_grid.GetItemText(row, 6);
	if (strNum.IsEmpty()){ strNum = "0"; }
	if (strPrice.IsEmpty()){ strPrice = "0"; }
	if (strOriSum.IsEmpty()){ strOriSum = "0"; }
	double oriSum = _ttof(strOriSum);
	double curSum = oriSum + balance;
	CString strCurSum;
	strCurSum.Format("%f", curSum);
	m_grid.SetItemText(row, 6, strCurSum);
	if (level != 0)
	{
		int num1 = _ttoi(strNum) + num;
		strNum.Format("%d", num1);
		m_grid.SetItemText(row, 4, strNum);
	}
}

void CGridCtrlDemoDlg::OnGridEdit(NMHDR *pNMHDR, LRESULT* pResult)
{
	NM_GRIDVIEW* PNmgv = (NM_GRIDVIEW*)pNMHDR;
	CString str = m_grid.GetItemText(PNmgv->iRow, PNmgv->iColumn);//��ȡ�޸ĵ�Ԫ������
}