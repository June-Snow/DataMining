// AddMsgDlg.cpp : 实现文件
//

#include "stdafx.h"
#include "suishouji.h"
#include "AddMsgDlg.h"
#include "afxdialogex.h"
#include "MyEditBrowseCtrl.h"
#include "DB_operater.h"
// AddMsgDlg 对话框

IMPLEMENT_DYNAMIC(AddMsgDlg, CDialogEx)

AddMsgDlg::AddMsgDlg(CWnd* pParent /*=NULL*/)
	: CDialogEx(AddMsgDlg::IDD, pParent)
{
	m_tree=NULL;
}

AddMsgDlg::~AddMsgDlg()
{
	//delete m_savebtn;
	//m_savebtn = NULL;
	int iimg = 0,iaffix = 0,idate = 0;
	CString keyvaluestr;
	for (int i = 0; i < keyvaluenum; i++)
	{
		if (strcmp(val1[i],_T("图片"))==0)
		{
			delete m_edit_key[i];
			m_edit_key[i] = NULL;
			delete m_static_picture[iimg];
			m_static_picture[iimg] = NULL;
			iimg++;
		} 
		else if(strcmp(val1[i],_T("文本"))==0||strcmp(val1[i],_T("文本块"))==0)
		{
			delete m_edit_key[i];
			m_edit_key[i] = NULL;
			delete m_edit_val[i];
			m_edit_val[i] = NULL;
		}
		else if(strcmp(val1[i],_T("日期"))==0)
		{
			delete m_edit_key[i];
			m_edit_key[i] = NULL;
			delete m_dateCtrl[idate];
			m_dateCtrl[idate] = NULL;
			idate++;
		}
		else if(strcmp(val1[i],_T("附件"))==0||strcmp(val1[i],_T("文档"))==0)
		{
			delete m_edit_key[i];
			m_edit_key[i] = NULL;
			delete m_edit_txt[iaffix];
			m_edit_txt[iaffix] = NULL;
			iaffix++;
		}
	}
}

void AddMsgDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);

}


BEGIN_MESSAGE_MAP(AddMsgDlg, CDialogEx)
	ON_BN_CLICKED(IDC_BTMADDPIC300, &AddMsgDlg::OnBnClickedBtmaddpic300)
	ON_BN_CLICKED(IDC_BTMADDPIC301, &AddMsgDlg::OnBnClickedBtmaddpic301)
	ON_BN_CLICKED(IDC_BTMADDPIC302, &AddMsgDlg::OnBnClickedBtmaddpic302)
	ON_BN_CLICKED(IDC_BTMADDPIC303, &AddMsgDlg::OnBnClickedBtmaddpic303)
	ON_BN_CLICKED(IDC_BTMADDPIC304, &AddMsgDlg::OnBnClickedBtmaddpic304)
	ON_BN_CLICKED(IDC_BTMADDPIC305, &AddMsgDlg::OnBnClickedBtmaddpic305)
	ON_BN_CLICKED(IDC_BTMADDPIC306, &AddMsgDlg::OnBnClickedBtmaddpic306)
	ON_BN_CLICKED(IDC_BTMADDPIC307, &AddMsgDlg::OnBnClickedBtmaddpic307)
	ON_BN_CLICKED(IDC_BTMADDPIC308, &AddMsgDlg::OnBnClickedBtmaddpic308)
	ON_BN_CLICKED(IDC_BTMADDPIC309, &AddMsgDlg::OnBnClickedBtmaddpic309)
	ON_BN_CLICKED(IDC_BTMADDPIC310, &AddMsgDlg::OnBnClickedBtmaddpic310)
	ON_BN_CLICKED(IDC_BTMADDPIC311, &AddMsgDlg::OnBnClickedBtmaddpic311)
	ON_BN_CLICKED(IDC_BTMADDPIC312, &AddMsgDlg::OnBnClickedBtmaddpic312)
	ON_BN_CLICKED(IDC_BTMADDPIC313, &AddMsgDlg::OnBnClickedBtmaddpic313)
	ON_BN_CLICKED(IDC_BTMADDPIC314, &AddMsgDlg::OnBnClickedBtmaddpic314)
	ON_BN_CLICKED(IDC_BTMADDPIC315, &AddMsgDlg::OnBnClickedBtmaddpic315)
	ON_BN_CLICKED(IDC_BTMADDPIC316, &AddMsgDlg::OnBnClickedBtmaddpic316)
	ON_BN_CLICKED(IDC_BTMADDPIC317, &AddMsgDlg::OnBnClickedBtmaddpic317)
	ON_BN_CLICKED(IDC_BTMADDPIC318, &AddMsgDlg::OnBnClickedBtmaddpic318)
	ON_BN_CLICKED(IDC_BTMADDPIC319, &AddMsgDlg::OnBnClickedBtmaddpic319)
	ON_WM_VSCROLL()
	ON_WM_SIZE()
	ON_BN_CLICKED(IDC_BTMDLG10HEAD, &AddMsgDlg::OnBnClickedBtmdlg10head)
	ON_WM_PAINT()
	ON_BN_CLICKED(IDC_SAVEBTNEND, ONSaveBTNEND)

	ON_WM_CTLCOLOR()

	ON_WM_MOUSEWHEEL()

	ON_BN_CLICKED(IDC_TXTANDACC_BTN0, &AddMsgDlg::OnBnClickedTxtandaccBtn0)
	ON_BN_CLICKED(IDC_TXTANDACC_BTN1, &AddMsgDlg::OnBnClickedTxtandaccBtn1)
	ON_BN_CLICKED(IDC_TXTANDACC_BTN2, &AddMsgDlg::OnBnClickedTxtandaccBtn2)
	ON_BN_CLICKED(IDC_TXTANDACC_BTN3, &AddMsgDlg::OnBnClickedTxtandaccBtn3)
	ON_BN_CLICKED(IDC_TXTANDACC_BTN4, &AddMsgDlg::OnBnClickedTxtandaccBtn4)
	ON_BN_CLICKED(IDC_TXTANDACC_BTN5, &AddMsgDlg::OnBnClickedTxtandaccBtn5)
	ON_BN_CLICKED(IDC_TXTANDACC_BTN6, &AddMsgDlg::OnBnClickedTxtandaccBtn6)
	ON_BN_CLICKED(IDC_TXTANDACC_BTN7, &AddMsgDlg::OnBnClickedTxtandaccBtn7)
	ON_BN_CLICKED(IDC_TXTANDACC_BTN8, &AddMsgDlg::OnBnClickedTxtandaccBtn8)
	ON_BN_CLICKED(IDC_TXTANDACC_BTN9, &AddMsgDlg::OnBnClickedTxtandaccBtn9)
	ON_BN_CLICKED(IDC_TXTANDACC_BTN10, &AddMsgDlg::OnBnClickedTxtandaccBtn10)
	ON_BN_CLICKED(IDC_TXTANDACC_BTN11, &AddMsgDlg::OnBnClickedTxtandaccBtn11)
	ON_BN_CLICKED(IDC_TXTANDACC_BTN12, &AddMsgDlg::OnBnClickedTxtandaccBtn12)
	ON_BN_CLICKED(IDC_TXTANDACC_BTN13, &AddMsgDlg::OnBnClickedTxtandaccBtn13)
	ON_BN_CLICKED(IDC_TXTANDACC_BTN14, &AddMsgDlg::OnBnClickedTxtandaccBtn14)
	ON_BN_CLICKED(IDC_TXTANDACC_BTN15, &AddMsgDlg::OnBnClickedTxtandaccBtn15)
	ON_BN_CLICKED(IDC_TXTANDACC_BTN16, &AddMsgDlg::OnBnClickedTxtandaccBtn16)
	ON_BN_CLICKED(IDC_TXTANDACC_BTN17, &AddMsgDlg::OnBnClickedTxtandaccBtn17)
	ON_BN_CLICKED(IDC_TXTANDACC_BTN18, &AddMsgDlg::OnBnClickedTxtandaccBtn18)
	ON_BN_CLICKED(IDC_TXTANDACC_BTN19, &AddMsgDlg::OnBnClickedTxtandaccBtn19)
	ON_BN_CLICKED(IDC_TXTANDACC_BTN20, &AddMsgDlg::OnBnClickedTxtandaccBtn20)
	ON_BN_CLICKED(IDC_TXTANDACC_BTN21, &AddMsgDlg::OnBnClickedTxtandaccBtn21)
	ON_BN_CLICKED(IDC_TXTANDACC_BTN22, &AddMsgDlg::OnBnClickedTxtandaccBtn22)
	ON_BN_CLICKED(IDC_TXTANDACC_BTN23, &AddMsgDlg::OnBnClickedTxtandaccBtn23)
	ON_BN_CLICKED(IDC_TXTANDACC_BTN24, &AddMsgDlg::OnBnClickedTxtandaccBtn24)
	ON_BN_CLICKED(IDC_TXTANDACC_BTN25, &AddMsgDlg::OnBnClickedTxtandaccBtn25)
	ON_BN_CLICKED(IDC_TXTANDACC_BTN26, &AddMsgDlg::OnBnClickedTxtandaccBtn26)

	ON_BN_CLICKED(IDC_TXTANDACC_BTN27, &AddMsgDlg::OnBnClickedTxtandaccBtn27)
	ON_BN_CLICKED(IDC_TXTANDACC_BTN28, &AddMsgDlg::OnBnClickedTxtandaccBtn28)
	ON_BN_CLICKED(IDC_TXTANDACC_BTN29, &AddMsgDlg::OnBnClickedTxtandaccBtn29)
	ON_WM_LBUTTONDOWN()
	//ON_NOTIFY(NM_THEMECHANGED, IDC_SCROLLBAR1, &AddMsgDlg::OnNMThemeChangedScrollbar1)
	//ON_BN_CLICKED(IDC_BTMDLG1HEAD, &AddMsgDlg::OnBnClickedBtmdlg1head)
	//ON_BN_CLICKED(IDC_BTMDLG1HEAD, &AddMsgDlg::OnBnClickedBtmdlg1head)
END_MESSAGE_MAP()


// AddMsgDlg 消息处理程序
BOOL AddMsgDlg::OnInitDialog()
{	
	CDialogEx::OnInitDialog();	
	HICON hIcon;
	NameFont.CreatePointFont(140,_T("宋体"));
	TextFont.CreatePointFont(120,_T("宋体"));
	TitleFont.CreatePointFont(160,_T("黑体"));
	linelink.CreatePointFont(100,_T("宋体"));
	DefaultFont.CreatePointFont(120,_T("黑体"));
	::SetWindowPos(this->m_hWnd,HWND_BOTTOM,0,0,200,400,SWP_NOZORDER);
	m_blackecolor = RGB(0,0,0);                   //黑色
	m_redcolor=RGB(255,0,0);                      // 红色  
	m_bluecolor=RGB(0,0,255);                     // 蓝色  
	m_whitecolor=RGB(255,255,255);                 // 文本颜色设置为白色  
	m_whitebrush.CreateSolidBrush(m_whitecolor);   //白色背景色
	m_redbrush.CreateSolidBrush(m_redcolor);      // 红色背景色  
	m_bluebrush.CreateSolidBrush(m_bluecolor);    // 蓝色背景色  

	for(int i=0;i<MAX_DATA_NUM;i++)
	{
		val[i]=_T("");
	}
	//wenjian
	if (isedit == 1)
	{
		IMVL_GetNode(selectno,&folder); 
		IMVL_GetNode(folder.iPID,&index); 
		keyvaluenum=Getkeyval(index.content, key, val1 );
		keyvaluenum = Getkeyval(folder.content, key, val );
	}
	else
	{
		IMVL_GetNode(selectno,&index);
		keyvaluenum=Getkeyval(index.content, key, val1 );
	}

	//	

	GetDlgItem(IDC_BTMDLGHEAD)->SetFont(&DefaultFont);
	if (isedit == 0)
	{
		GetDlgItem(IDC_STATIC1234)->SetWindowTextA(_T("当前目录:"));
		GetDlgItem(IDC_BTMDLGHEAD)->SetWindowText(index.name);
	} 
	else if (isedit == 1)
	{
		GetDlgItem(IDC_STATIC1234)->SetWindowTextA(_T("当前文件:"));
		GetDlgItem(IDC_BTMDLGHEAD)->SetWindowText(folder.name);
	}
	GetDlgItem(IDC_STATIC1234)->SetFont(&DefaultFont);

	int count=80;//控制输出高度
	int i, picbtmcount=0, idate = 0,ieditbrowse = 0, iweb = 0, ipicture = 0, itxt = 0;
	const int IDC_NUM = 53100;
	const int IDC_TXTANDACC = 53300;
	const int IDC_TXTANDACCB_BTN = 53200;

	for (i=0;i<keyvaluenum;i++)
	{
		if (strcmp(val1[i],_T("图片"))==0)
		{			
			m_edit_key[i] = new CStatic;
			m_edit_key[i]->Create(key[i],WS_CHILD|WS_VISIBLE,CRect(40,count,400,count+30),this,123);
			m_edit_key[i]->SetFont(&NameFont);			
			count = count + 30;

			CRect rect;
			m_static_picture[ipicture] = new CStatic() ;
			m_static_picture[ipicture]->Create(NULL,WS_CHILD |WS_VISIBLE |WS_TABSTOP |WS_BORDER,CRect(80,count,350,count+180),this,IDC_NUM + ipicture);
			m_static_picture[ipicture]->GetWindowRect(rect);
			CString str_pic = "";
			if (!val[i].IsEmpty())
			{
                str_pic = exe_path+"\\image\\"+val[i];	
			}
					
			CStatic *pWnd = (CStatic*)GetDlgItem(IDC_NUM + ipicture);
			pWnd->ModifyStyle(0xF,SS_BITMAP|SS_CENTERIMAGE);
			pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
				str_pic,
				IMAGE_BITMAP,
				rect.Width(),rect.Height(),
				LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));

			count = count + 195;
			CRect   rect1; 
			int btmnum = IDC_BTMADDPIC300;
			btmnum = btmnum + picbtmcount;
			GetDlgItem(btmnum)->GetWindowRect(&rect1);  
			ScreenToClient(&rect1);  
			GetDlgItem(btmnum)->MoveWindow(350,count-45,80,30, TRUE);  
			GetDlgItem(btmnum)->ShowWindow(SW_SHOW);
			picbtmcount++;
			ipicture++;


		} 
		else if(strcmp(val1[i],_T("文本"))==0)//||strcmp(val1[i],_T("文本块"))==0)
		{			
			m_edit_key[i] = new CStatic;
			m_edit_key[i]->Create(key[i],WS_CHILD|WS_VISIBLE,CRect(40,count,400,count+30),this,123);
			m_edit_key[i]->SetFont(&NameFont);			
			count = count + 30;	

			m_edit_val[i]= new CEdit;
			m_edit_val[i]->Create(WS_CHILD | WS_VISIBLE |WS_TABSTOP | ES_LEFT  |ES_WANTRETURN|WS_BORDER
				,CRect(80,count,600,count+25),this,123);
			CString editstr;
			HtmlToTextblock(&val[i],&editstr);
			m_edit_val[i]->SetWindowText(editstr);
			m_edit_val[i]->SetFont(&TextFont);
			count = count + 40;	

		}
		else if(strcmp(val1[i],_T("文本块"))==0)
		{			
			m_edit_key[i] = new CStatic;
			m_edit_key[i]->Create(key[i],WS_CHILD|WS_VISIBLE,CRect(40,count,400,count+30),this,123);
			m_edit_key[i]->SetFont(&NameFont);			
			count = count + 30;	

			m_edit_val[i]= new CEdit;
			m_edit_val[i]->Create(WS_CHILD | WS_VISIBLE |WS_TABSTOP | ES_MULTILINE | ES_LEFT | ES_AUTOVSCROLL |ES_WANTRETURN|WS_BORDER
				,CRect(80,count,600,count+140),this,123);

			CString editString;
			HtmlToTextblock(&val[i],&editString);

			CString msgstr;
			while(editString.Find(_T("\\r\\n")) != -1)
			{
				int pos = editString.Find(_T("\\r\\n"));
				CString str = editString.Mid(0, pos);
				editString = editString.Mid(pos+4, strlen(editString));
				msgstr = msgstr +str+ _T("\r\n");
			}

			m_edit_val[i]->SetWindowText(msgstr);

			m_edit_val[i]->SetFont(&TextFont);
			count = count + 155;	

		}
		else if(strcmp(val1[i],_T("日期"))==0)
		{
			m_edit_key[i] = new CStatic;
			m_edit_key[i]->Create(key[i],WS_CHILD|WS_VISIBLE,CRect(40,count,400,count+30),this,123);
			m_edit_key[i]->SetFont(&NameFont);	

			count = count + 30;	

			m_dateCtrl[idate] = new CDateTimeCtrl;
			m_dateCtrl[idate]->Create(WS_VISIBLE | WS_TABSTOP | WS_CHILD //| DTS_SHOWNONE | DTS_SHORTDATEFORMAT //| MCS_WEEKNUMBERS
				,CRect(80,count,240,count+30), this, 0x224);
			m_dateCtrl[idate]->SetFont(&TextFont);
			if (val[i].IsEmpty()!=1)
			{
				m_dateCtrl[idate]->SetFormat( "yyy/MM/dd"); 
				COleDateTime oleDate;
				oleDate.ParseDateTime(val[i], VAR_DATEVALUEONLY);//SetWindowTextA(val[i]);
				/*COleDateTime           PlayStart;       
				PlayStart=COleDateTime::GetCurrentTime(       );               
				m_DatePicker.SetFormat( "yyy-MM-dd,HH:mm:ss ");       
				m_DatePicker.SetTime(PlayStart); */
				m_dateCtrl[idate]->SetTime(oleDate);
			}

			count = count + 45;
			idate++;
		}
		else if (strcmp(val1[i],_T("附件"))==0||strcmp(val1[i],_T("文档"))==0)
		{
			m_edit_key[i] = new CStatic;
			m_edit_key[i]->Create(key[i],WS_CHILD|WS_VISIBLE,CRect(40,count,400,count+30),this,123);
			m_edit_key[i]->SetFont(&NameFont);			
			count = count + 30;	

			CString str;
			if (strcmp(val1[i], _T("附件")) == 0)
			{
				str = _T("附件");
			} 
			else if(strcmp(val1[i], _T("文档")) == 0)
			{
				str = _T("文档");
			}
			m_edit_txt[itxt] = new CEdit() ;
			m_edit_txt[itxt]->Create(WS_CHILD | WS_VISIBLE |WS_TABSTOP | ES_LEFT |WS_BORDER|ES_WANTRETURN | ES_MULTILINE //| ES_AUTOVSCROLL //取消换行功能
				,CRect(80,count,576,count+25),this,IDC_TXTANDACC + itxt);

			CString file_str = "";
			if (!val[i].IsEmpty())
			{
				file_str = exe_path+"\\attachment\\"+val[i];	
			}

			m_edit_txt[itxt]->SetWindowText(file_str);
			m_edit_txt[itxt]->SetFont(&TextFont);

			CRect   rect1; 
			GetDlgItem(IDC_TXTANDACCB_BTN + itxt)->GetWindowRect(&rect1);  
			ScreenToClient(&rect1);  
			GetDlgItem(IDC_TXTANDACCB_BTN + itxt)->MoveWindow(576,count,rect1.Width(),rect1.Height(), TRUE);  
			GetDlgItem(IDC_TXTANDACCB_BTN + itxt)->ShowWindow(SW_SHOW);
			SetDlgItemText(IDC_TXTANDACCB_BTN + itxt, str);
			GetDlgItem(IDC_TXTANDACCB_BTN + itxt)->SetFont(&TextFont);
			itxt++;
			count = count + 40;

		}
	}

	if (count>600)
	{
		m_savebtn = new CButton;
		m_savebtn->Create(_T("保存"), WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON , CRect(610,count+10,675,count+40), this, IDC_SAVEBTNEND );
		m_savebtn->SetFont(&linelink);
	}	

	if (maxsroll < 500)
	{
		GetDlgItem(IDC_SCROLLBAR1)->ShowWindow(FALSE);
	}


	this->GetDlgItem(IDC_BTMDLG1HEAD)->SetFont(&linelink);

	//SavePath(&m_mkdir_path, 0);

	m_mkdir_path = exe_path + _T("\\image\\image_temp\\");
	if (!PathFileExists(m_mkdir_path))
	{
		if (!CreateDirectory(m_mkdir_path, NULL))
		{
			return FALSE;
		}
	}




	return true;
}


void AddMsgDlg::OnVScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar)
{
	// TODO: 在此添加消息处理程序代码和/或调用默认值
	SCROLLINFO sif = { sizeof(SCROLLINFO),SIF_ALL };  
	GetScrollInfo(SB_VERT,&sif);  

	int oldPos = sif.nPos;  
	switch(nSBCode)  
	{  
	case SB_TOP:    sif.nPos = sif.nMin;    break;  
	case SB_BOTTOM: sif.nPos = sif.nMax;    break;  
	case SB_LINEUP:     sif.nPos -= 120;   break;  
	case SB_LINEDOWN:   sif.nPos += 120;   break;  
	case SB_PAGEUP:     sif.nPos -= sif.nPage;  break;  
	case SB_PAGEDOWN:   sif.nPos += sif.nPage;  break;  
	case SB_THUMBTRACK: sif.nPos = sif.nTrackPos;   break;  
	default:    break;  
	}  
	if(sif.nPos > sif.nMax)  
		sif.nPos = sif.nMax;  
	else if(sif.nPos < sif.nMin)  
		sif.nPos = sif.nMin;  
	sif.fMask = SIF_POS;  
	SetScrollInfo(SB_VERT,&sif);  

	GetScrollInfo(SB_VERT,&sif);  
	if(sif.nPos != oldPos)  
		ScrollWindow(0,oldPos - sif.nPos);  //这里是重点  

}


void AddMsgDlg::OnSize(UINT nType, int cx, int cy)
{
	CDialogEx::OnSize(nType, cx, cy);
	SCROLLINFO si;
	si.cbSize = sizeof(si);
	si.fMask = SIF_RANGE | SIF_PAGE;
	si.nMin = 0;
	si.nMax = 500;
	si.nPage = cx;
	SetScrollInfo(SB_HORZ,&si,TRUE);
	si.nMax = maxsroll;
	si.nPage = cy;
	SetScrollInfo(SB_VERT,&si,TRUE);

	int icurxpos = GetScrollPos(SB_HORZ);
	int icurypos = GetScrollPos(SB_VERT);

	//if (icurxpos < m_ixoldpos || icurypos < m_iyoldpos)
	//{
	//	ScrollWindow(m_ixoldpos-icurxpos, 0);
	//	ScrollWindow(0, m_iyoldpos-icurypos);

	//}	
	//m_ixoldpos = icurxpos;
	//m_iyoldpos = icurypos;



	Invalidate(TRUE);
	// TODO: 在此处添加消息处理程序代码
}



void AddMsgDlg::OnBnClickedBtmaddpic300()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = "JPG Files (*.jpg)|*.jpg|BMP Files (*.bmp)|*.bmp|GIF Files (*.gif)|*.gif|All Files (*.*)|*.*||";
	CFileDialog dlg(TRUE, "BMP", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString str_save_path;
	CString m_fileName = dlg.GetFileName();	
	CString m_pathName = dlg.GetPathName();
	CString m_Name = dlg.GetFileTitle();
	//CString m_suffixName =m_fileName.Right(m_fileName.GetLength()-m_fileName.ReverseFind('.')-1);
	CImage image;
	image.Load(m_pathName);
	str_save_path = m_mkdir_path + m_Name + _T(".bmp");
	image.Save(str_save_path); 
	//str_save_path = exe_path +"\\image"+m_Name + _T(".bmp");
	CRect rect;
	GetDlgItem(53100)->GetWindowRect(rect);	
	CStatic *pWnd = (CStatic*)GetDlgItem(53100);
	pWnd->ModifyStyle(0xF,SS_BITMAP|SS_CENTERIMAGE);
	pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
		str_save_path,
		IMAGE_BITMAP,
		rect.Width(),rect.Height(),
		LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
	m_filePath[0] = str_save_path;

}


void AddMsgDlg::OnBnClickedBtmaddpic301()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = "JPG Files (*.jpg)|*.jpg|BMP Files (*.bmp)|*.bmp|GIF Files (*.gif)|*.gif|All Files (*.*)|*.*||";
	CFileDialog dlg(TRUE, "BMP", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString str_save_path;
	CString m_pathName = dlg.GetPathName();
	CString m_Name = dlg.GetFileTitle();
	CImage image;
	image.Load(m_pathName);
	str_save_path = m_mkdir_path + m_Name + _T(".bmp");
	image.Save(str_save_path); 

	CRect rect;
	GetDlgItem(53101)->GetWindowRect(rect);		
	CStatic *pWnd = (CStatic*)GetDlgItem(53101);
	pWnd->ModifyStyle(0xF,SS_BITMAP|SS_CENTERIMAGE);
	pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
		str_save_path,
		IMAGE_BITMAP,
		rect.Width(),rect.Height(),
		LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
	m_filePath[1] = str_save_path;
}


void AddMsgDlg::OnBnClickedBtmaddpic302()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = "JPG Files (*.jpg)|*.jpg|BMP Files (*.bmp)|*.bmp|GIF Files (*.gif)|*.gif|All Files (*.*)|*.*||";
	CFileDialog dlg(TRUE, "BMP", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString str_save_path;
	CString m_pathName = dlg.GetPathName();
	CString m_Name = dlg.GetFileTitle();
	CImage image;
	image.Load(m_pathName);
	str_save_path = m_mkdir_path + m_Name + _T(".bmp");
	image.Save(str_save_path); 
	CRect rect;
	GetDlgItem(53102)->GetWindowRect(rect);		
	CStatic *pWnd = (CStatic*)GetDlgItem(53102);
	pWnd->ModifyStyle(0xF,SS_BITMAP|SS_CENTERIMAGE);
	pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
		str_save_path,
		IMAGE_BITMAP,
		rect.Width(),rect.Height(),
		LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
	m_filePath[2] = str_save_path;
}


void AddMsgDlg::OnBnClickedBtmaddpic303()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = "JPG Files (*.jpg)|*.jpg|BMP Files (*.bmp)|*.bmp|GIF Files (*.gif)|*.gif|All Files (*.*)|*.*||";
	CFileDialog dlg(TRUE, "BMP", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString str_save_path;
	CString m_pathName = dlg.GetPathName();
	CString m_Name = dlg.GetFileTitle();
	CImage image;
	image.Load(m_pathName);
	str_save_path = m_mkdir_path + m_Name + _T(".bmp");
	image.Save(str_save_path); 
	CRect rect;
	GetDlgItem(53103)->GetWindowRect(rect);		
	CStatic *pWnd = (CStatic*)GetDlgItem(53103);
	pWnd->ModifyStyle(0xF,SS_BITMAP|SS_CENTERIMAGE);
	pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
		str_save_path,
		IMAGE_BITMAP,
		rect.Width(),rect.Height(),
		LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
	m_filePath[3] = str_save_path;
}


void AddMsgDlg::OnBnClickedBtmaddpic304()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = "JPG Files (*.jpg)|*.jpg|BMP Files (*.bmp)|*.bmp|GIF Files (*.gif)|*.gif|All Files (*.*)|*.*||";
	CFileDialog dlg(TRUE, "BMP", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString str_save_path;
	CString m_pathName = dlg.GetPathName();
	CString m_Name = dlg.GetFileTitle();
	CImage image;
	image.Load(m_pathName);
	str_save_path = m_mkdir_path + m_Name + _T(".bmp");
	image.Save(str_save_path); 
	CRect rect;
	GetDlgItem(53104)->GetWindowRect(rect);		
	CStatic *pWnd = (CStatic*)GetDlgItem(53104);
	pWnd->ModifyStyle(0xF,SS_BITMAP|SS_CENTERIMAGE);
	pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
		str_save_path,
		IMAGE_BITMAP,
		rect.Width(),rect.Height(),
		LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
	m_filePath[4] = str_save_path;
}


void AddMsgDlg::OnBnClickedBtmaddpic305()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = "JPG Files (*.jpg)|*.jpg|BMP Files (*.bmp)|*.bmp|GIF Files (*.gif)|*.gif|All Files (*.*)|*.*||";
	CFileDialog dlg(TRUE, "BMP", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString str_save_path;
	CString m_pathName = dlg.GetPathName();
	CString m_Name = dlg.GetFileTitle();
	CImage image;
	image.Load(m_pathName);
	str_save_path = m_mkdir_path + m_Name + _T(".bmp");
	image.Save(str_save_path); 
	CRect rect;
	GetDlgItem(53105)->GetWindowRect(rect);		
	CStatic *pWnd = (CStatic*)GetDlgItem(53105);
	pWnd->ModifyStyle(0xF,SS_BITMAP|SS_CENTERIMAGE);
	pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
		str_save_path,
		IMAGE_BITMAP,
		rect.Width(),rect.Height(),
		LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
	m_filePath[5] = str_save_path;
}


void AddMsgDlg::OnBnClickedBtmaddpic306()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = "JPG Files (*.jpg)|*.jpg|BMP Files (*.bmp)|*.bmp|GIF Files (*.gif)|*.gif|All Files (*.*)|*.*||";
	CFileDialog dlg(TRUE, "BMP", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString str_save_path;
	CString m_pathName = dlg.GetPathName();
	CString m_Name = dlg.GetFileTitle();
	CImage image;
	image.Load(m_pathName);
	str_save_path = m_mkdir_path + m_Name + _T(".bmp");
	image.Save(str_save_path); 
	CRect rect;
	GetDlgItem(53106)->GetWindowRect(rect);		
	CStatic *pWnd = (CStatic*)GetDlgItem(53106);
	pWnd->ModifyStyle(0xF,SS_BITMAP|SS_CENTERIMAGE);
	pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
		str_save_path,
		IMAGE_BITMAP,
		rect.Width(),rect.Height(),
		LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
	m_filePath[6] = str_save_path;
}


void AddMsgDlg::OnBnClickedBtmaddpic307()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = "JPG Files (*.jpg)|*.jpg|BMP Files (*.bmp)|*.bmp|GIF Files (*.gif)|*.gif|All Files (*.*)|*.*||";
	CFileDialog dlg(TRUE, "BMP", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString str_save_path;
	CString m_pathName = dlg.GetPathName();
	CString m_Name = dlg.GetFileTitle();
	CImage image;
	image.Load(m_pathName);
	str_save_path = m_mkdir_path + m_Name + _T(".bmp");
	image.Save(str_save_path); 
	CRect rect;
	GetDlgItem(53107)->GetWindowRect(rect);		
	CStatic *pWnd = (CStatic*)GetDlgItem(53107);
	pWnd->ModifyStyle(0xF,SS_BITMAP|SS_CENTERIMAGE);
	pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
		str_save_path,
		IMAGE_BITMAP,
		rect.Width(),rect.Height(),
		LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
	m_filePath[7] = str_save_path;
}


void AddMsgDlg::OnBnClickedBtmaddpic308()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = "JPG Files (*.jpg)|*.jpg|BMP Files (*.bmp)|*.bmp|GIF Files (*.gif)|*.gif|All Files (*.*)|*.*||";
	CFileDialog dlg(TRUE, "BMP", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString str_save_path;
	CString m_pathName = dlg.GetPathName();
	CString m_Name = dlg.GetFileTitle();
	CImage image;
	image.Load(m_pathName);
	str_save_path = m_mkdir_path + m_Name + _T(".bmp");
	image.Save(str_save_path); 
	CRect rect;
	GetDlgItem(53108)->GetWindowRect(rect);		
	CStatic *pWnd = (CStatic*)GetDlgItem(53108);
	pWnd->ModifyStyle(0xF,SS_BITMAP|SS_CENTERIMAGE);
	pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
		str_save_path,
		IMAGE_BITMAP,
		rect.Width(),rect.Height(),
		LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
	m_filePath[8] = str_save_path;
}


void AddMsgDlg::OnBnClickedBtmaddpic309()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = "JPG Files (*.jpg)|*.jpg|BMP Files (*.bmp)|*.bmp|GIF Files (*.gif)|*.gif|All Files (*.*)|*.*||";
	CFileDialog dlg(TRUE, "BMP", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString str_save_path;
	CString m_pathName = dlg.GetPathName();
	CString m_Name = dlg.GetFileTitle();
	CImage image;
	image.Load(m_pathName);
	str_save_path = m_mkdir_path + m_Name + _T(".bmp");
	image.Save(str_save_path); 

	CRect rect;
	GetDlgItem(53109)->GetWindowRect(rect);		
	CStatic *pWnd = (CStatic*)GetDlgItem(53109);
	pWnd->ModifyStyle(0xF,SS_BITMAP|SS_CENTERIMAGE);
	pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
		str_save_path,
		IMAGE_BITMAP,
		rect.Width(),rect.Height(),
		LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
	m_filePath[9] = str_save_path;
}


void AddMsgDlg::OnBnClickedBtmaddpic310()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = "JPG Files (*.jpg)|*.jpg|BMP Files (*.bmp)|*.bmp|GIF Files (*.gif)|*.gif|All Files (*.*)|*.*||";
	CFileDialog dlg(TRUE, "BMP", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString str_save_path;
	CString m_pathName = dlg.GetPathName();
	CString m_Name = dlg.GetFileTitle();
	CImage image;
	image.Load(m_pathName);
	str_save_path = m_mkdir_path + m_Name + _T(".bmp");
	image.Save(str_save_path); 

	CRect rect;
	GetDlgItem(53110)->GetWindowRect(rect);		
	CStatic *pWnd = (CStatic*)GetDlgItem(53110);
	pWnd->ModifyStyle(0xF,SS_BITMAP|SS_CENTERIMAGE);
	pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
		str_save_path,
		IMAGE_BITMAP,
		rect.Width(),rect.Height(),
		LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
	m_filePath[10] = str_save_path;
}


void AddMsgDlg::OnBnClickedBtmaddpic311()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = "JPG Files (*.jpg)|*.jpg|BMP Files (*.bmp)|*.bmp|GIF Files (*.gif)|*.gif|All Files (*.*)|*.*||";
	CFileDialog dlg(TRUE, "BMP", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString str_save_path;
	CString m_pathName = dlg.GetPathName();
	CString m_Name = dlg.GetFileTitle();
	CImage image;
	image.Load(m_pathName);
	str_save_path = m_mkdir_path + m_Name + _T(".bmp");
	image.Save(str_save_path); 
	CRect rect;
	GetDlgItem(53111)->GetWindowRect(rect);		
	CStatic *pWnd = (CStatic*)GetDlgItem(53111);
	pWnd->ModifyStyle(0xF,SS_BITMAP|SS_CENTERIMAGE);
	pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
		str_save_path,
		IMAGE_BITMAP,
		rect.Width(),rect.Height(),
		LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
	m_filePath[11] = str_save_path;
}


void AddMsgDlg::OnBnClickedBtmaddpic312()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = "JPG Files (*.jpg)|*.jpg|BMP Files (*.bmp)|*.bmp|GIF Files (*.gif)|*.gif|All Files (*.*)|*.*||";
	CFileDialog dlg(TRUE, "BMP", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString str_save_path;
	CString m_pathName = dlg.GetPathName();
	CString m_Name = dlg.GetFileTitle();
	CImage image;
	image.Load(m_pathName);
	str_save_path = m_mkdir_path + m_Name + _T(".bmp");
	image.Save(str_save_path); 
	CRect rect;
	GetDlgItem(53112)->GetWindowRect(rect);		
	CStatic *pWnd = (CStatic*)GetDlgItem(53112);
	pWnd->ModifyStyle(0xF,SS_BITMAP|SS_CENTERIMAGE);
	pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
		str_save_path,
		IMAGE_BITMAP,
		rect.Width(),rect.Height(),
		LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
	m_filePath[12] = str_save_path;
}


void AddMsgDlg::OnBnClickedBtmaddpic313()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = "JPG Files (*.jpg)|*.jpg|BMP Files (*.bmp)|*.bmp|GIF Files (*.gif)|*.gif|All Files (*.*)|*.*||";
	CFileDialog dlg(TRUE, "BMP", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString str_save_path;
	CString m_pathName = dlg.GetPathName();
	CString m_Name = dlg.GetFileTitle();
	CImage image;
	image.Load(m_pathName);

	str_save_path = m_mkdir_path + m_Name + _T(".bmp");
	image.Save(str_save_path); 
	CRect rect;
	GetDlgItem(53113)->GetWindowRect(rect);		
	CStatic *pWnd = (CStatic*)GetDlgItem(53113);
	pWnd->ModifyStyle(0xF,SS_BITMAP|SS_CENTERIMAGE);
	pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
		str_save_path,
		IMAGE_BITMAP,
		rect.Width(),rect.Height(),
		LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
	m_filePath[13] = str_save_path;
}


void AddMsgDlg::OnBnClickedBtmaddpic314()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = "JPG Files (*.jpg)|*.jpg|BMP Files (*.bmp)|*.bmp|GIF Files (*.gif)|*.gif|All Files (*.*)|*.*||";
	CFileDialog dlg(TRUE, "BMP", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString str_save_path;
	CString m_pathName = dlg.GetPathName();
	CString m_Name = dlg.GetFileTitle();
	CImage image;
	image.Load(m_pathName);

	str_save_path = m_mkdir_path + m_Name + _T(".bmp");
	image.Save(str_save_path); 
	CRect rect;
	GetDlgItem(53114)->GetWindowRect(rect);		
	CStatic *pWnd = (CStatic*)GetDlgItem(53114);
	pWnd->ModifyStyle(0xF,SS_BITMAP|SS_CENTERIMAGE);
	pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
		str_save_path,
		IMAGE_BITMAP,
		rect.Width(),rect.Height(),
		LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
	m_filePath[14] = str_save_path;
}


void AddMsgDlg::OnBnClickedBtmaddpic315()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = "JPG Files (*.jpg)|*.jpg|BMP Files (*.bmp)|*.bmp|GIF Files (*.gif)|*.gif|All Files (*.*)|*.*||";
	CFileDialog dlg(TRUE, "BMP", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString str_save_path;
	CString m_pathName = dlg.GetPathName();
	CString m_Name = dlg.GetFileTitle();
	CImage image;
	image.Load(m_pathName);
	str_save_path = m_mkdir_path + m_Name + _T(".bmp");
	image.Save(str_save_path); 
	CRect rect;
	GetDlgItem(53115)->GetWindowRect(rect);		
	CStatic *pWnd = (CStatic*)GetDlgItem(53115);
	pWnd->ModifyStyle(0xF,SS_BITMAP|SS_CENTERIMAGE);
	pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
		str_save_path,
		IMAGE_BITMAP,
		rect.Width(),rect.Height(),
		LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
	m_filePath[15] = str_save_path;
}


void AddMsgDlg::OnBnClickedBtmaddpic316()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = "JPG Files (*.jpg)|*.jpg|BMP Files (*.bmp)|*.bmp|GIF Files (*.gif)|*.gif|All Files (*.*)|*.*||";
	CFileDialog dlg(TRUE, "BMP", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString str_save_path;
	CString m_pathName = dlg.GetPathName();
	CString m_Name = dlg.GetFileTitle();
	CImage image;
	image.Load(m_pathName);

	str_save_path = m_mkdir_path + m_Name + _T(".bmp");
	image.Save(str_save_path); 
	CRect rect;
	GetDlgItem(53116)->GetWindowRect(rect);		
	CStatic *pWnd = (CStatic*)GetDlgItem(53116);
	pWnd->ModifyStyle(0xF,SS_BITMAP|SS_CENTERIMAGE);
	pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
		str_save_path,
		IMAGE_BITMAP,
		rect.Width(),rect.Height(),
		LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
	m_filePath[16] = str_save_path;
}


void AddMsgDlg::OnBnClickedBtmaddpic317()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = "JPG Files (*.jpg)|*.jpg|BMP Files (*.bmp)|*.bmp|GIF Files (*.gif)|*.gif|All Files (*.*)|*.*||";
	CFileDialog dlg(TRUE, "BMP", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString str_save_path;
	CString m_pathName = dlg.GetPathName();
	CString m_Name = dlg.GetFileTitle();
	CImage image;
	image.Load(m_pathName);

	str_save_path = m_mkdir_path + m_Name + _T(".bmp");
	image.Save(str_save_path); 
	CRect rect;
	GetDlgItem(53117)->GetWindowRect(rect);		
	CStatic *pWnd = (CStatic*)GetDlgItem(53117);
	pWnd->ModifyStyle(0xF,SS_BITMAP|SS_CENTERIMAGE);
	pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
		str_save_path,
		IMAGE_BITMAP,
		rect.Width(),rect.Height(),
		LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
	m_filePath[17] = str_save_path;
}


void AddMsgDlg::OnBnClickedBtmaddpic318()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = "JPG Files (*.jpg)|*.jpg|BMP Files (*.bmp)|*.bmp|GIF Files (*.gif)|*.gif|All Files (*.*)|*.*||";
	CFileDialog dlg(TRUE, "BMP", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString str_save_path;
	CString m_pathName = dlg.GetPathName();
	CString m_Name = dlg.GetFileTitle();
	CImage image;
	image.Load(m_pathName);

	str_save_path = m_mkdir_path + m_Name + _T(".bmp");
	image.Save(str_save_path); 
	CRect rect;
	GetDlgItem(53118)->GetWindowRect(rect);		
	CStatic *pWnd = (CStatic*)GetDlgItem(53118);
	pWnd->ModifyStyle(0xF,SS_BITMAP|SS_CENTERIMAGE);
	pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
		str_save_path,
		IMAGE_BITMAP,
		rect.Width(),rect.Height(),
		LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
	m_filePath[18] = str_save_path;
}


void AddMsgDlg::OnBnClickedBtmaddpic319()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = "JPG Files (*.jpg)|*.jpg|BMP Files (*.bmp)|*.bmp|GIF Files (*.gif)|*.gif|All Files (*.*)|*.*||";
	CFileDialog dlg(TRUE, "BMP", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString str_save_path;
	CString m_pathName = dlg.GetPathName();
	CString m_Name = dlg.GetFileTitle();
	CImage image;
	image.Load(m_pathName);

	str_save_path = m_mkdir_path + m_Name + _T(".bmp");
	image.Save(str_save_path); 

	CRect rect;
	GetDlgItem(53119)->GetWindowRect(rect);		
	CStatic *pWnd = (CStatic*)GetDlgItem(53119);
	pWnd->ModifyStyle(0xF,SS_BITMAP|SS_CENTERIMAGE);
	pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
		str_save_path,
		IMAGE_BITMAP,
		rect.Width(),rect.Height(),
		LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
	m_filePath[19] = str_save_path;
}



void AddMsgDlg::OnBnClickedBtmdlg10head()
{
	// TODO: 在此添加控件通知处理程序代码

	int iimg = 0,iaffix = 0,idate = 0;
	int breakmsg=0;
	int nullpathmsg=0;
	CString nullpath;
	CString keyvaluestr;
	for (int i = 0; i < keyvaluenum; i++)
	{
		if (strcmp(val1[i],_T("图片"))==0)
		{
			
			if (m_filePath[iimg].IsEmpty())
			{
				keyvaluestr = keyvaluestr + "k(e}y" + key[i] + "v(a}l" + val[i];
			} 
			else
			{
				CString m_pathName;
				CString str_save_path = m_filePath[iimg];			
				FileSave(str_save_path, &m_pathName, 0);
				m_filePath[iimg] = m_pathName;

				int pos = m_pathName.ReverseFind('\\');
				int img_name_len = strlen(m_pathName) - pos-1;
				CString img_name = m_pathName.Mid(pos+1, img_name_len);

				keyvaluestr = keyvaluestr + "k(e}y" + key[i] + "v(a}l" + img_name;
			}				
			iimg++;
			
		} 
		else if(strcmp(val1[i],_T("文本"))==0||strcmp(val1[i],_T("文本块"))==0)
		{
			CString str,str1;
			m_edit_val[0]->GetWindowText(str1);
			if (str1.IsEmpty() == 1)
			{
				breakmsg=1;
				break;
			}
		//	
			if (strcmp(val1[i],_T("文本"))==0)
			{
				m_edit_val[i]->GetWindowTextA(str);
			}
			else
			{
               textblockToHtml(m_edit_val[i],&str);
			}			
			keyvaluestr = keyvaluestr + "k(e}y" + key[i] + "v(a}l" + str;
		}
		else if(strcmp(val1[i],_T("日期"))==0)
		{
			CString strdate;
			m_dateCtrl[idate]->GetWindowText(strdate);

			keyvaluestr = keyvaluestr + "k(e}y" + key[i] + "v(a}l" + strdate;					
			idate++;
		}
		else if(strcmp(val1[i],_T("附件"))==0||strcmp(val1[i],_T("文档"))==0)
		{

			CString straffix = m_txtandacc_path[iaffix];
			CString save;
			int msg;
			//m_editbrowse[iaffix]->GetWindowText(straffix);
			if (straffix.IsEmpty())
			{
				keyvaluestr = keyvaluestr + "k(e}y" + key[i] + "v(a}l" + val[i];
		     }
			//m_editbrowse[iaffix]->GetWindowText(straffix);
			else
			{
				if (strcmp(val1[i],_T("附件"))==0)
				{

					msg = FileSave(straffix,&save,2);
				} 
				else
				{

					msg = FileSave(straffix,&save,1);
				}
				if (msg !=SUCCESS_VALUE)
				{
					nullpathmsg=1;
					nullpath = straffix;
					break;
				}
				int posfile = save.ReverseFind('\\');
				int file_name_len = strlen(save) - posfile-1;
				CString file_name = save.Mid(posfile+1, file_name_len);

				keyvaluestr = keyvaluestr + "k(e}y" + key[i] + "v(a}l" + file_name;


				//keyvaluestr = keyvaluestr + "k(e}y" + key[i] + "v(a}l" + save;
			}
			iaffix++;
		}
	}
	keyvaluestr = keyvaluestr + "k(e}y";
	INDEX_NODE filenode;
	int msg;
	if (strlen(keyvaluestr)>1300)
	{
         MessageBox(_T("文件内容过大，编辑失败"),_T("操作提示"),MB_OK|MB_ICONERROR);
	}
	else if (breakmsg==1)
	{
		MessageBox(_T("第一个标签文本不可为空"),_T("操作提示"),MB_OK|MB_ICONERROR);
		
	}
	else if (nullpathmsg==1)
	{
		MessageBox(nullpath+_T("文件不存在"),_T("操作提示"),MB_OK|MB_ICONERROR);
	}
 	else
	{
		strcpy_s(filenode.content, keyvaluestr);
		filenode.IsFolder=0;
		CString time;
		GetCurrTime(&time);
		if (isedit == 0)
		{		
			filenode.iPID = index.ID;
			CString str,time;
			GetCurrTime(&time);
			m_edit_val[0]->GetWindowText(str);
			strcpy_s(filenode.name , str);	
			strcpy_s(filenode.createTime,time);
			strcpy_s(filenode.modifyTime,time);
			msg = IMVL_Create(index.ID,&filenode);
		} 
		else
		{
			filenode.ID=folder.ID;
			filenode.iPID=folder.iPID;
			strcpy_s(filenode.name , folder.name);
			strcpy_s(filenode.createTime,folder.createTime);
			strcpy_s(filenode.modifyTime,time);
			msg = IMVL_Update(&filenode);


			INDEX_NODE foldernode;
			IMVL_GetNode(filenode.iPID,&foldernode);
			CString key[MAX_DATA_NUM],val[MAX_DATA_NUM],val1[MAX_DATA_NUM];
			//AfxMessageBox(indexnode.content);
			int num = Getkeyval(filenode.content, key, val );
			Getkeyval(foldernode.content, key, val1 );

			SetHtml(val1,val,key,filenode.name,exe_path, num);

				//CHAR		szPath[MAX_PATH];
				//memset(szPath, 0, sizeof(CHAR)*MAX_PATH);
				//GetCurrentDirectory(MAX_PATH, szPath);
				//StrCat(szPath, (exe_path+_T("/html/MFCHtml.htm")));


				m_nyweb->Navigate((exe_path+_T("\\html\\MFCHtml.htm")),NULL,NULL,NULL,NULL);	

			//SetHtml(val1,val,key,filenode.name,"MFCHtml.htm", num);
			//CHAR		szPath[MAX_PATH];
			//memset(szPath, 0, sizeof(CHAR)*MAX_PATH);
			//GetCurrentDirectory(MAX_PATH, szPath);
			//StrCat(szPath, _T("./html/MFCHtml.htm"));
			//m_nyweb->Navigate(szPath,NULL,NULL,NULL,NULL);	

		}	

		if (msg == SUCCESS_VALUE)
		{
			int back = MessageBox(_T("文件内容编辑成功"),_T("操作提示"),MB_OK|MB_ICONASTERISK  );
			if (isedit==0)
			{
				if (filenode.iPID==27)
				{
					if (strcmp(sorttag1,_T("名字"))==0)
					{
						SortByDay(m_tree,m_tree->GetSelectedItem(),27);
					} 
					else
					{
						SortByTag(m_tree,m_tree->GetSelectedItem(),sorttag1);
					}

				} 
				else
				{
					UpdateTree(m_tree,filenode.ID,filenode.name);
				}
			}		
			OnCancel();

			
		} 
		else
		{
			MessageBox(_T("文件内容编辑失败，请检查相关设置"),_T("操作提示"),MB_OK|MB_ICONERROR);
		}
	}	
  //this->OnCancel();	
}




void AddMsgDlg::OnPaint()
{
	CPaintDC dc(this); // device context for painting
	// TODO: 在此处添加消息处理程序代码
	// 不为绘图消息调用 CDialogEx::OnPaint()
}

void AddMsgDlg::ONSaveBTNEND()
{
	// TODO: 在此添加控件通知处理程序代码

	int iimg = 0,iaffix = 0,idate = 0;
	int breakmsg=0;
	int nullpathmsg=0;
	CString nullpath;
	CString keyvaluestr;
	for (int i = 0; i < keyvaluenum; i++)
	{
		if (strcmp(val1[i],_T("图片"))==0)
		{

			if (m_filePath[iimg].IsEmpty())
			{
				keyvaluestr = keyvaluestr + "k(e}y" + key[i] + "v(a}l" + val[i];
			} 
			else
			{
				CString str_save_path = m_filePath[iimg];
				CString m_pathName;
				FileSave(str_save_path, &m_pathName, 0);
				m_filePath[iimg] = m_pathName;

				int pos = m_pathName.ReverseFind('\\');
				int img_name_len = strlen(m_pathName) - pos-1;
				CString img_name = m_pathName.Mid(pos+1, img_name_len);

				keyvaluestr = keyvaluestr + "k(e}y" + key[i] + "v(a}l" + img_name;
				//keyvaluestr = keyvaluestr + "k(e}y" + key[i] + "v(a}l" + m_pathName;
			}				
			iimg++;

		} 
		else if(strcmp(val1[i],_T("文本"))==0||strcmp(val1[i],_T("文本块"))==0)
		{
			CString str,str1;
			m_edit_val[0]->GetWindowText(str1);
			if (str1.IsEmpty()==1)
			{
				breakmsg=1;//MessageBox(_T("第一个标签文本不可为空"),_T("操作提示"),MB_OK|MB_ICONERROR);
				break;
			}
			if (strcmp(val1[i],_T("文本"))==0)
			{
				m_edit_val[i]->GetWindowTextA(str);
			}
			else
			{
				textblockToHtml(m_edit_val[i],&str);
			}			
			keyvaluestr = keyvaluestr + "k(e}y" + key[i] + "v(a}l" + str;
		}
		else if(strcmp(val1[i],_T("日期"))==0)
		{
			CString strdate;
			m_dateCtrl[idate]->GetWindowText(strdate);

			keyvaluestr = keyvaluestr + "k(e}y" + key[i] + "v(a}l" + strdate;					
			idate++;
		}
		else if(strcmp(val1[i],_T("附件"))==0||strcmp(val1[i],_T("文档"))==0)
		{

			CString straffix = m_txtandacc_path[iaffix];
			CString save;
			int msg ;
			if (straffix.IsEmpty())
			{
				keyvaluestr = keyvaluestr + "k(e}y" + key[i] + "v(a}l" + val[i];
		     }
			//m_editbrowse[iaffix]->GetWindowText(straffix);
			else
			{
				if (strcmp(val1[i],_T("附件"))==0)
				{

					msg = FileSave(straffix,&save,2);
				} 
				else
				{

					msg = FileSave(straffix,&save,1);
				}
				if (msg !=SUCCESS_VALUE)
				{
					nullpathmsg=1;
					nullpath = straffix;
					break;
				}
				int posfile = save.ReverseFind('\\');
				int file_name_len = strlen(save) - posfile-1;
				CString file_name = save.Mid(posfile+1, file_name_len);

				keyvaluestr = keyvaluestr + "k(e}y" + key[i] + "v(a}l" + file_name;
			}
			
			iaffix++;
		}
	}
	keyvaluestr = keyvaluestr + "k(e}y";
	INDEX_NODE filenode;
	int msg;
	if (strlen(keyvaluestr)>1300)
	{
		MessageBox(_T("文件内容过大，编辑失败"),_T("操作提示"),MB_OK|MB_ICONERROR);
	}
	else if (breakmsg==1)
	{
		MessageBox(_T("第一个标签文本不可为空"),_T("操作提示"),MB_OK|MB_ICONERROR);
	}
	else if (nullpathmsg==1)
	{
		MessageBox(nullpath+_T("文件不存在"),_T("操作提示"),MB_OK|MB_ICONERROR);
	}
	else
	{
		strcpy_s(filenode.content, keyvaluestr);
		filenode.IsFolder=0;
		CString time;
		GetCurrTime(&time);
		if (isedit == 0)
		{		
			filenode.iPID = index.ID;
			CString str,time;
			GetCurrTime(&time);
			m_edit_val[0]->GetWindowText(str);
			strcpy_s(filenode.name , str);	
			strcpy_s(filenode.createTime,time);
			strcpy_s(filenode.modifyTime,time);
			msg = IMVL_Create(index.ID,&filenode);
		} 
		else
		{
			filenode.ID=folder.ID;
			filenode.iPID=folder.iPID;
			strcpy_s(filenode.name , folder.name);
			strcpy_s(filenode.createTime,folder.createTime);
			strcpy_s(filenode.modifyTime,time);
			msg = IMVL_Update(&filenode);


			INDEX_NODE foldernode;
			IMVL_GetNode(filenode.iPID,&foldernode);
			CString key[MAX_DATA_NUM],val[MAX_DATA_NUM],val1[MAX_DATA_NUM];
			//AfxMessageBox(indexnode.content);
			int num = Getkeyval(filenode.content, key, val );
			Getkeyval(foldernode.content, key, val1 );

							SetHtml(val1,val,key,filenode.name,exe_path, num);

				//CHAR		szPath[MAX_PATH];
				//memset(szPath, 0, sizeof(CHAR)*MAX_PATH);
				//GetCurrentDirectory(MAX_PATH, szPath);
				//StrCat(szPath, (exe_path+_T("/html/MFCHtml.htm")));


				m_nyweb->Navigate((exe_path+_T("\\html\\MFCHtml.htm")),NULL,NULL,NULL,NULL);	


			/*SetHtml(val1,val,key,filenode.name,"MFCHtml.htm", num);
			CHAR		szPath[MAX_PATH];
			memset(szPath, 0, sizeof(CHAR)*MAX_PATH);
			GetCurrentDirectory(MAX_PATH, szPath);
			StrCat(szPath, _T("./html/MFCHtml.htm"));
			m_nyweb->Navigate(szPath,NULL,NULL,NULL,NULL);*/
		}	

		if (msg == SUCCESS_VALUE)
		{
			int back = MessageBox(_T("文件内容编辑成功"),_T("操作提示"),MB_OK|MB_ICONASTERISK  );
			if (isedit==0)
			{
				if (filenode.iPID==27)
				{
					if (strcmp(sorttag1,_T("名字"))==0)
					{
						SortByDay(m_tree,m_tree->GetSelectedItem(),27);
					} 
					else
					{
						SortByTag(m_tree,m_tree->GetSelectedItem(),sorttag1);
					}
				} 
				else
				{
					UpdateTree(m_tree,filenode.ID,filenode.name);
				}
				
			}
			OnCancel();

		} 
		else
		{
			MessageBox(_T("文件内容编辑失败，请检查相关设置"),_T("操作提示"),MB_OK|MB_ICONERROR);
		}
	}	
}


HBRUSH AddMsgDlg::OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor)
{
	HBRUSH hbr = CDialogEx::OnCtlColor(pDC, pWnd, nCtlColor);

	// TODO:  在此更改 DC 的任何特性

	// TODO:  如果默认的不是所需画笔，则返回另一个画笔
	switch (nCtlColor) //对所有同一类型的控件进行判断  
	{  
		// process my edit controls by ID.  
	case CTLCOLOR_EDIT:  
		//case CTLCOLOR_MSGBOX:
		//case CTLCOLOR_BTN:
	case CTLCOLOR_STATIC: //假设控件是文本框或者消息框，则进入下一个switch  
		switch (pWnd->GetDlgCtrlID())//对某一个特定控件进行判断  
		{      

		default:  
			hbr=CDialog::OnCtlColor(pDC,pWnd,nCtlColor);  
			pDC->SetBkColor(m_whitecolor);    // change the background  
			pDC->SetTextColor(m_blackecolor); // change the text color  
			hbr = (HBRUSH) m_whitebrush;    // apply the blue brush  
			break;  
		}  
		break;  
	}  
	// TODO:  如果默认的不是所需画笔，则返回另一个画笔
	return m_whitebrush;//改变对话框背景颜色
}


BOOL AddMsgDlg::OnMouseWheel(UINT nFlags, short zDelta, CPoint pt)
{
	// TODO: 在此添加消息处理程序代码和/或调用默认值
	if(zDelta < 0)
	{
		OnVScroll(SB_LINEDOWN, GetScrollPos(SB_VERT),  GetScrollBarCtrl(SB_VERT));
	}
	else if (zDelta > 0)
	{
		OnVScroll(SB_LINEUP, GetScrollPos(SB_VERT),  GetScrollBarCtrl(SB_VERT));
	}

	return CDialogEx::OnMouseWheel(nFlags, zDelta, pt);
}


void AddMsgDlg::OnBnClickedTxtandaccBtn0()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = _T("Doc Files(*.doc)|*.doc|All Files (*.*)|*.*||");
	CFileDialog dlg(TRUE, "doc", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;
	CString m_pathName = dlg.GetPathName();
	m_txtandacc_path[0] = m_pathName;
	m_edit_txt[0]->SetWindowText(m_pathName);
	m_edit_txt[0]->SetFont(&TextFont);
}


void AddMsgDlg::OnBnClickedTxtandaccBtn1()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = _T("Doc Files(*.doc)|*.doc|All Files (*.*)|*.*||");
	CFileDialog dlg(TRUE, "doc", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString m_pathName = dlg.GetPathName();
	m_txtandacc_path[1] = m_pathName;
	m_edit_txt[1]->SetWindowText(m_pathName);
	m_edit_txt[1]->SetFont(&TextFont);
}


void AddMsgDlg::OnBnClickedTxtandaccBtn2()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = _T("Doc Files(*.doc)|*.doc|All Files (*.*)|*.*||");
	CFileDialog dlg(TRUE, "doc", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString m_pathName = dlg.GetPathName();
	m_txtandacc_path[2] = m_pathName;
	m_edit_txt[2]->SetWindowText(m_pathName);
	m_edit_txt[2]->SetFont(&TextFont);
}


void AddMsgDlg::OnBnClickedTxtandaccBtn3()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = _T("Doc Files(*.doc)|*.doc|All Files (*.*)|*.*||");
	CFileDialog dlg(TRUE, "doc", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString m_pathName = dlg.GetPathName();
	m_txtandacc_path[3] = m_pathName;
	m_edit_txt[3]->SetWindowText(m_pathName);
	m_edit_txt[3]->SetFont(&TextFont);
}


void AddMsgDlg::OnBnClickedTxtandaccBtn4()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = _T("Doc Files(*.doc)|*.doc|All Files (*.*)|*.*||");
	CFileDialog dlg(TRUE, "doc", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString m_pathName = dlg.GetPathName();
	m_txtandacc_path[4] = m_pathName;
	m_edit_txt[4]->SetWindowText(m_pathName);
	m_edit_txt[4]->SetFont(&TextFont);
}


void AddMsgDlg::OnBnClickedTxtandaccBtn5()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = _T("Doc Files(*.doc)|*.doc|All Files (*.*)|*.*||");
	CFileDialog dlg(TRUE, "doc", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString m_pathName = dlg.GetPathName();
	m_txtandacc_path[5] = m_pathName;
	m_edit_txt[5]->SetWindowText(m_pathName);
	m_edit_txt[5]->SetFont(&TextFont);
}


void AddMsgDlg::OnBnClickedTxtandaccBtn6()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = _T("Doc Files(*.doc)|*.doc|All Files (*.*)|*.*||");
	CFileDialog dlg(TRUE, "doc", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString m_pathName = dlg.GetPathName();
	m_txtandacc_path[6] = m_pathName;
	m_edit_txt[6]->SetWindowText(m_pathName);
	m_edit_txt[6]->SetFont(&TextFont);
}


void AddMsgDlg::OnBnClickedTxtandaccBtn7()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = _T("Doc Files(*.doc)|*.doc|All Files (*.*)|*.*||");
	CFileDialog dlg(TRUE, "doc", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString m_pathName = dlg.GetPathName();
	m_txtandacc_path[7] = m_pathName;
	m_edit_txt[7]->SetWindowText(m_pathName);
	m_edit_txt[7]->SetFont(&TextFont);
}


void AddMsgDlg::OnBnClickedTxtandaccBtn8()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = _T("Doc Files(*.doc)|*.doc|All Files (*.*)|*.*||");
	CFileDialog dlg(TRUE, "doc", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString m_pathName = dlg.GetPathName();
	m_txtandacc_path[8] = m_pathName;
	m_edit_txt[8]->SetWindowText(m_pathName);
	m_edit_txt[8]->SetFont(&TextFont);
}


void AddMsgDlg::OnBnClickedTxtandaccBtn9()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = _T("Doc Files(*.doc)|*.doc|All Files (*.*)|*.*||");
	CFileDialog dlg(TRUE, "doc", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString m_pathName = dlg.GetPathName();
	m_txtandacc_path[9] = m_pathName;
	m_edit_txt[9]->SetWindowText(m_pathName);
	m_edit_txt[9]->SetFont(&TextFont);
}


void AddMsgDlg::OnBnClickedTxtandaccBtn10()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = _T("Doc Files(*.doc)|*.doc|All Files (*.*)|*.*||");
	CFileDialog dlg(TRUE, "doc", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString m_pathName = dlg.GetPathName();
	m_txtandacc_path[10] = m_pathName;
	m_edit_txt[10]->SetWindowText(m_pathName);
	m_edit_txt[10]->SetFont(&TextFont);
}


void AddMsgDlg::OnBnClickedTxtandaccBtn11()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = _T("Doc Files(*.doc)|*.doc|All Files (*.*)|*.*||");
	CFileDialog dlg(TRUE, "doc", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString m_pathName = dlg.GetPathName();
	m_txtandacc_path[11] = m_pathName;
	m_edit_txt[11]->SetWindowText(m_pathName);
	m_edit_txt[11]->SetFont(&TextFont);
}


void AddMsgDlg::OnBnClickedTxtandaccBtn12()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = _T("Doc Files(*.doc)|*.doc|All Files (*.*)|*.*||");
	CFileDialog dlg(TRUE, "doc", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString m_pathName = dlg.GetPathName();
	m_txtandacc_path[12] = m_pathName;
	m_edit_txt[12]->SetWindowText(m_pathName);
	m_edit_txt[12]->SetFont(&TextFont);
}


void AddMsgDlg::OnBnClickedTxtandaccBtn13()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = _T("Doc Files(*.doc)|*.doc|All Files (*.*)|*.*||");
	CFileDialog dlg(TRUE, "doc", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString m_pathName = dlg.GetPathName();
	m_txtandacc_path[13] = m_pathName;
	m_edit_txt[13]->SetWindowText(m_pathName);
	m_edit_txt[13]->SetFont(&TextFont);
}


void AddMsgDlg::OnBnClickedTxtandaccBtn14()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = _T("Doc Files(*.doc)|*.doc|All Files (*.*)|*.*||");
	CFileDialog dlg(TRUE, "doc", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString m_pathName = dlg.GetPathName();
	m_txtandacc_path[14] = m_pathName;
	m_edit_txt[14]->SetWindowText(m_pathName);
	m_edit_txt[14]->SetFont(&TextFont);
}


void AddMsgDlg::OnBnClickedTxtandaccBtn15()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = _T("Doc Files(*.doc)|*.doc|All Files (*.*)|*.*||");
	CFileDialog dlg(TRUE, "doc", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString m_pathName = dlg.GetPathName();
	m_txtandacc_path[15] = m_pathName;
	m_edit_txt[15]->SetWindowText(m_pathName);
	m_edit_txt[15]->SetFont(&TextFont);
}


void AddMsgDlg::OnBnClickedTxtandaccBtn16()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = _T("Doc Files(*.doc)|*.doc|All Files (*.*)|*.*||");
	CFileDialog dlg(TRUE, "doc", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString m_pathName = dlg.GetPathName();
	m_txtandacc_path[16] = m_pathName;
	m_edit_txt[16]->SetWindowText(m_pathName);
	m_edit_txt[16]->SetFont(&TextFont);
}


void AddMsgDlg::OnBnClickedTxtandaccBtn17()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = _T("Doc Files(*.doc)|*.doc|All Files (*.*)|*.*||");
	CFileDialog dlg(TRUE, "doc", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString m_pathName = dlg.GetPathName();
	m_txtandacc_path[17] = m_pathName;
	m_edit_txt[17]->SetWindowText(m_pathName);
	m_edit_txt[17]->SetFont(&TextFont);
}


void AddMsgDlg::OnBnClickedTxtandaccBtn18()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = _T("Doc Files(*.doc)|*.doc|All Files (*.*)|*.*||");
	CFileDialog dlg(TRUE, "doc", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString m_pathName = dlg.GetPathName();
	m_txtandacc_path[18] = m_pathName;
	m_edit_txt[18]->SetWindowText(m_pathName);
	m_edit_txt[18]->SetFont(&TextFont);
}


void AddMsgDlg::OnBnClickedTxtandaccBtn19()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = _T("Doc Files(*.doc)|*.doc|All Files (*.*)|*.*||");
	CFileDialog dlg(TRUE, "doc", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString m_pathName = dlg.GetPathName();
	m_txtandacc_path[19] = m_pathName;
	m_edit_txt[19]->SetWindowText(m_pathName);
	m_edit_txt[19]->SetFont(&TextFont);
}


void AddMsgDlg::OnBnClickedTxtandaccBtn20()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = _T("Doc Files(*.doc)|*.doc|All Files (*.*)|*.*||");
	CFileDialog dlg(TRUE, "doc", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString m_pathName = dlg.GetPathName();
	m_txtandacc_path[20] = m_pathName;
	m_edit_txt[20]->SetWindowText(m_pathName);
	m_edit_txt[20]->SetFont(&TextFont);
}


void AddMsgDlg::OnBnClickedTxtandaccBtn21()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = _T("Doc Files(*.doc)|*.doc|All Files (*.*)|*.*||");
	CFileDialog dlg(TRUE, "doc", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString m_pathName = dlg.GetPathName();
	m_txtandacc_path[21] = m_pathName;
	m_edit_txt[21]->SetWindowText(m_pathName);
	m_edit_txt[21]->SetFont(&TextFont);
}


void AddMsgDlg::OnBnClickedTxtandaccBtn22()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = _T("Doc Files(*.doc)|*.doc|All Files (*.*)|*.*||");
	CFileDialog dlg(TRUE, "doc", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString m_pathName = dlg.GetPathName();
	m_txtandacc_path[22] = m_pathName;
	m_edit_txt[22]->SetWindowText(m_pathName);
	m_edit_txt[22]->SetFont(&TextFont);
}


void AddMsgDlg::OnBnClickedTxtandaccBtn23()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = _T("Doc Files(*.doc)|*.doc|All Files (*.*)|*.*||");
	CFileDialog dlg(TRUE, "doc", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString m_pathName = dlg.GetPathName();
	m_txtandacc_path[23] = m_pathName;
	m_edit_txt[23]->SetWindowText(m_pathName);
	m_edit_txt[23]->SetFont(&TextFont);
}


void AddMsgDlg::OnBnClickedTxtandaccBtn24()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = _T("Doc Files(*.doc)|*.doc|All Files (*.*)|*.*||");
	CFileDialog dlg(TRUE, "doc", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString m_pathName = dlg.GetPathName();
	m_txtandacc_path[24] = m_pathName;
	m_edit_txt[24]->SetWindowText(m_pathName);
	m_edit_txt[24]->SetFont(&TextFont);
}


void AddMsgDlg::OnBnClickedTxtandaccBtn25()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = _T("Doc Files(*.doc)|*.doc|All Files (*.*)|*.*||");
	CFileDialog dlg(TRUE, "doc", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString m_pathName = dlg.GetPathName();
	m_txtandacc_path[25] = m_pathName;
	m_edit_txt[25]->SetWindowText(m_pathName);
	m_edit_txt[25]->SetFont(&TextFont);
}


void AddMsgDlg::OnBnClickedTxtandaccBtn26()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = _T("Doc Files(*.doc)|*.doc|All Files (*.*)|*.*||");
	CFileDialog dlg(TRUE, "doc", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString m_pathName = dlg.GetPathName();
	m_txtandacc_path[26] = m_pathName;
	m_edit_txt[26]->SetWindowText(m_pathName);
	m_edit_txt[26]->SetFont(&TextFont);
}


void AddMsgDlg::OnBnClickedTxtandaccBtn27()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = _T("Doc Files(*.doc)|*.doc|All Files (*.*)|*.*||");
	CFileDialog dlg(TRUE, "doc", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString m_pathName = dlg.GetPathName();
	m_txtandacc_path[27] = m_pathName;
	m_edit_txt[27]->SetWindowText(m_pathName);
	m_edit_txt[27]->SetFont(&TextFont);
}


void AddMsgDlg::OnBnClickedTxtandaccBtn28()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = _T("Doc Files(*.doc)|*.doc|All Files (*.*)|*.*||");
	CFileDialog dlg(TRUE, "doc", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString m_pathName = dlg.GetPathName();
	m_txtandacc_path[28] = m_pathName;
	m_edit_txt[28]->SetWindowText(m_pathName);
	m_edit_txt[28]->SetFont(&TextFont);
}


void AddMsgDlg::OnBnClickedTxtandaccBtn29()
{
	// TODO: 在此添加控件通知处理程序代码
	static char szFilter[] = _T("Doc Files(*.doc)|*.doc|All Files (*.*)|*.*||");
	CFileDialog dlg(TRUE, "doc", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;

	CString m_pathName = dlg.GetPathName();
	m_txtandacc_path[29] = m_pathName;
	m_edit_txt[29]->SetWindowText(m_pathName);
	m_edit_txt[29]->SetFont(&TextFont);
}


void AddMsgDlg::OnLButtonDown(UINT nFlags, CPoint point)
{
	// TODO: 在此添加消息处理程序代码和/或调用默认值

	if (true)
	{
		GetDlgItem(IDC_SCROLLBAR1)->SetFocus();

	}

	CDialogEx::OnLButtonDown(nFlags, point);
}

void AddMsgDlg::OnCancel()
{
	// TODO: 在此添加专用代码和/或调用基类
	//CFile   TempFile;
	//CString str = m_mkdir_path.Mid(0,m_mkdir_path.GetLength() - 1);
	//TempFile.Remove(str);

	if (PathFileExists(m_mkdir_path))
	{
		CString PUBPATH;
		PUBPATH=m_mkdir_path;
		CFileFind tempFind;
		m_mkdir_path+="\\*.*";
		BOOL IsFinded=(BOOL)tempFind.FindFile(m_mkdir_path);
		while(IsFinded)
		{
			IsFinded=(BOOL)tempFind.FindNextFile();
			if(!tempFind.IsDots())
			{
				CString strDirName;
				strDirName+=PUBPATH;
				strDirName+="\\";
				strDirName+=tempFind.GetFileName();
				SetFileAttributes(strDirName,FILE_ATTRIBUTE_NORMAL); //去掉文件的系统和隐藏属性
				DeleteFile(strDirName);
			}
		}
		tempFind.Close();
		if(!RemoveDirectory(PUBPATH))
		{

		}

	}
	CDialogEx::OnCancel();
}

//
//void AddMsgDlg::OnBnClickedBtmdlg1head()
//{
//	// TODO: 在此添加控件通知处理程序代码
//}

//
//void AddMsgDlg::OnBnClickedBtmdlg1head()
//{
//	// TODO: 在此添加控件通知处理程序代码
//}


