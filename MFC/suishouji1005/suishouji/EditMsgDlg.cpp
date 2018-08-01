// EditMsgDlg.cpp : 实现文件
//

#include "stdafx.h"
#include "suishouji.h"
#include "EditMsgDlg.h"
#include "afxdialogex.h"
#include "DB_operater.h"

// EditMsgDlg 对话框

IMPLEMENT_DYNAMIC(EditMsgDlg, CDialogEx)

EditMsgDlg::EditMsgDlg(CWnd* pParent /*=NULL*/)
	: CDialogEx(EditMsgDlg::IDD, pParent)
{
	isfresh=NULL;
}

EditMsgDlg::~EditMsgDlg()
{
}

void EditMsgDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
}

BOOL EditMsgDlg::OnInitDialog()
{	
	CDialogEx::OnInitDialog();	
	NameFont.CreatePointFont(140,_T("宋体"));
	TextFont.CreatePointFont(120,_T("宋体"));
	TitleFont.CreatePointFont(120,_T("黑体"));
	linelink.CreatePointFont(40,_T("宋体"));
	
	m_blackecolor = RGB(0,0,0);                   //黑色
	m_redcolor=RGB(255,0,0);                      // 红色  
	m_bluecolor=RGB(0,0,255);                     // 蓝色  
	m_whitecolor=RGB(255,255,255);                 // 文本颜色设置为白色  
	m_whitebrush.CreateSolidBrush(m_whitecolor);   //白色背景色
	m_redbrush.CreateSolidBrush(m_redcolor);      // 红色背景色  
	m_bluebrush.CreateSolidBrush(m_bluecolor);    // 蓝色背景色  

	IMVL_GetNode(selectno,&index);   //wenjian
	IMVL_GetNode(index.iPID,&folder);  //wenjianjia
	
	keyvaluenum = Getkeyval(index.content, key, val );
	Getkeyval(folder.content, key, val1 );



	GetDlgItem(IDC_saveBUTTON1)->SetWindowText(index.name);
	GetDlgItem(IDC_saveBUTTON1)->SetFont(&TitleFont);
	GetDlgItem(IDC_STATIC1234)->SetFont(&TitleFont);
	int count=80;//控制输出高度
	int i, j=0;
	//int line_link = 0;
	for (i=0;i<keyvaluenum;i++)
	{
		if (strcmp(val1[i],_T("图片"))==0)
		{			
			//m_static[line_link] = new CStatic;
			//m_static[line_link]->Create(_T("--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------")
			//	,WS_CHILD|WS_VISIBLE,CRect(0,count,600,count+10),this,123);
			//m_static[line_link]->SetFont(&linelink);
			////m_static[line_link]->text
			//count = count + 10;
			//line_link = line_link + 1;

			m_edit_key[i] = new CStatic;
			m_edit_key[i]->Create(key[i],WS_CHILD|WS_VISIBLE,CRect(40,count,400,count+30),this,123);
			m_edit_key[i]->SetFont(&NameFont);			
			count = count + 40;


			//m_static[line_link] = new CStatic;
			//m_static[line_link]->Create(_T("--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------")
			//	,WS_CHILD|WS_VISIBLE,CRect(0,count,600,count+10),this,123);
			//m_static[line_link]->SetFont(&TextFont);			
			//count = count + 10;
			//line_link = line_link + 1;
			//picture control 添加图片、、IDC_STATIC
			/*		int cx, cy;  */
			CImage  image;  
			CRect   rect; 

			str_picture = val[i];//_T("C:\\Users\\litao\\Desktop\\最新\\staticEdit\\6_conew1.bmp");
			image.Load(str_picture);  

			int idcnum = 1042;
			idcnum = idcnum + j;
			
			GetDlgItem(idcnum)->ShowWindow(1);
			GetDlgItem(idcnum)->GetWindowRect(&rect);  
			ScreenToClient(&rect);  
			GetDlgItem(idcnum)->MoveWindow(80,count,270,180, TRUE);  
			

			CStatic *pWnd = (CStatic*)GetDlgItem(idcnum);
			pWnd->ModifyStyle(0xF,SS_BITMAP|SS_CENTERIMAGE);
			pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
				str_picture,
				IMAGE_BITMAP,
				180,120,
				LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
			count = count + 180;

			int btmnum = 1061;
			btmnum = btmnum + j;
			GetDlgItem(btmnum)->GetWindowRect(&rect);  
			ScreenToClient(&rect);  
			GetDlgItem(btmnum)->MoveWindow(350,count-30,80,30, TRUE);  
			GetDlgItem(btmnum)->ShowWindow(SW_SHOW);
			j ++;

		} 
		else
		{			

			//m_static[line_link] = new CStatic;
			//m_static[line_link]->Create(_T("--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------")
			//	,WS_CHILD|WS_VISIBLE,CRect(0,count,600,count+10),this,123);
			//m_static[line_link]->SetFont(&linelink);			
			//count = count + 10;
			//line_link = line_link + 1;

			m_edit_key[i] = new CStatic;
			m_edit_key[i]->Create(key[i],WS_CHILD|WS_VISIBLE,CRect(40,count,400,count+30),this,123);
			m_edit_key[i]->SetFont(&NameFont);			
			count = count + 40;	

			//m_static[line_link] = new CStatic;
			//m_static[line_link]->Create(_T("------------------------------------------------------------------------------------------------------------------------------")
			//	,WS_CHILD|WS_VISIBLE,CRect(0,count,600,count+10),this,123);
			//m_static[line_link]->SetFont(&NameFont);			
			//count = count + 10;
			//line_link = line_link + 1;

			m_edit_val[i]= new CEdit;
			m_edit_val[i]->Create(WS_CHILD | WS_VISIBLE | ES_MULTILINE | ES_LEFT | ES_AUTOVSCROLL //| WS_VSCROLL
				,CRect(80,count,540,count+60),this,123);
			m_edit_val[i]->SetWindowText(val[i]);
			m_edit_val[i]->SetFont(&TextFont);
			count = count + 60;	


		}
	}
	return TRUE;
}


BEGIN_MESSAGE_MAP(EditMsgDlg, CDialogEx)
	ON_BN_CLICKED(IDC_BTMIMG0, &EditMsgDlg::OnBnClickedBtmimg0)
	ON_BN_CLICKED(IDC_BTMIMG1, &EditMsgDlg::OnBnClickedBtmimg1)
	ON_BN_CLICKED(IDC_BTMIMG2, &EditMsgDlg::OnBnClickedBtmimg2)
	ON_BN_CLICKED(IDC_BTMIMG3, &EditMsgDlg::OnBnClickedBtmimg3)
	ON_BN_CLICKED(IDC_BTMIMG4, &EditMsgDlg::OnBnClickedBtmimg4)
	ON_BN_CLICKED(IDC_BTMIMG5, &EditMsgDlg::OnBnClickedBtmimg5)
	ON_BN_CLICKED(IDC_BTMIMG6, &EditMsgDlg::OnBnClickedBtmimg6)
	ON_BN_CLICKED(IDC_BTMIMG7, &EditMsgDlg::OnBnClickedBtmimg7)
	ON_BN_CLICKED(IDC_BTMIMG8, &EditMsgDlg::OnBnClickedBtmimg8)
	ON_BN_CLICKED(IDC_BTMIMG9, &EditMsgDlg::OnBnClickedBtmimg9)
	ON_BN_CLICKED(IDC_BUTTON2, &EditMsgDlg::OnBnClickedButton2)
	ON_WM_VSCROLL()
	ON_WM_SIZE()

	ON_WM_CTLCOLOR()
END_MESSAGE_MAP()





void EditMsgDlg::OnBnClickedBtmimg0()
{
	// TODO: 在此添加控件通知处理程序代码
	CFileDialog dlg(TRUE);
	if(dlg.DoModal() == IDOK)
	{
		m_fileName[0] = dlg.GetFileName();
		m_filePath[0] = dlg.GetPathName();
		m_suffixName[0] =m_fileName[0].Right(m_fileName[0].GetLength()-m_fileName[0].ReverseFind('.')-1);
		CStatic* pWnd = (CStatic*)GetDlgItem(IDC_bmpPicture0);
		pWnd->ModifyStyle(0xF,SS_BITMAP| SS_CENTERIMAGE);
		if(m_suffixName[0].MakeUpper() == "BMP")
		{
			pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
				m_filePath[0],
				IMAGE_BITMAP,
				180,
				120,
				LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
		}
		else
		{
			pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
				_T("..\\ControlDisplay\\res\\bmpwarning.bmp"),
				IMAGE_BITMAP,
				160,
				120,
				LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
		}
	}
}


void EditMsgDlg::OnBnClickedBtmimg1()
{
	// TODO: 在此添加控件通知处理程序代码
	CFileDialog dlg(TRUE);
	if(dlg.DoModal() == IDOK)
	{
		m_fileName[1] = dlg.GetFileName();
		m_filePath[1] = dlg.GetPathName();
		m_suffixName[1] =m_fileName[1].Right(m_fileName[1].GetLength()-m_fileName[1].ReverseFind('.')-1);
		CStatic* pWnd = (CStatic*)GetDlgItem(IDC_bmpPicture1);
		pWnd->ModifyStyle(0xF,SS_BITMAP| SS_CENTERIMAGE);
		if(m_suffixName[1].MakeUpper() == "BMP")
		{
			pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
				m_filePath[1],
				IMAGE_BITMAP,
				180,
				120,
				LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
		}
		else
		{
			pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
				_T("..\\ControlDisplay\\res\\bmpwarning.bmp"),
				IMAGE_BITMAP,
				160,
				120,
				LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
		}
	}
}


void EditMsgDlg::OnBnClickedBtmimg2()
{
	// TODO: 在此添加控件通知处理程序代码
	CFileDialog dlg(TRUE);
	if(dlg.DoModal() == IDOK)
	{
		m_fileName[2] = dlg.GetFileName();
		m_filePath[2] = dlg.GetPathName();
		m_suffixName[2] =m_fileName[2].Right(m_fileName[2].GetLength()-m_fileName[2].ReverseFind('.')-1);
		CStatic* pWnd = (CStatic*)GetDlgItem(IDC_bmpPicture2);
		pWnd->ModifyStyle(0xF,SS_BITMAP| SS_CENTERIMAGE);
		if(m_suffixName[2].MakeUpper() == "BMP")
		{
			pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
				m_filePath[2],
				IMAGE_BITMAP,
				180,
				120,
				LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
		}
		else
		{
			pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
				_T("..\\ControlDisplay\\res\\bmpwarning.bmp"),
				IMAGE_BITMAP,
				160,
				120,
				LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
		}
	}
}


void EditMsgDlg::OnBnClickedBtmimg3()
{
	// TODO: 在此添加控件通知处理程序代码
	CFileDialog dlg(TRUE);
	if(dlg.DoModal() == IDOK)
	{
		m_fileName[3] = dlg.GetFileName();
		m_filePath[3] = dlg.GetPathName();
		m_suffixName[3] =m_fileName[3].Right(m_fileName[3].GetLength()-m_fileName[3].ReverseFind('.')-1);
		CStatic* pWnd = (CStatic*)GetDlgItem(IDC_bmpPicture3);
		pWnd->ModifyStyle(0xF,SS_BITMAP| SS_CENTERIMAGE);
		if(m_suffixName[3].MakeUpper() == "BMP")
		{
			pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
				m_filePath[3],
				IMAGE_BITMAP,
				180,
				120,
				LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
		}
		else
		{
			pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
				_T("..\\ControlDisplay\\res\\bmpwarning.bmp"),
				IMAGE_BITMAP,
				160,
				120,
				LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
		}
	}
}


void EditMsgDlg::OnBnClickedBtmimg4()
{
	// TODO: 在此添加控件通知处理程序代码
	CFileDialog dlg(TRUE);
	if(dlg.DoModal() == IDOK)
	{
		m_fileName[4] = dlg.GetFileName();
		m_filePath[4] = dlg.GetPathName();
		m_suffixName[4] =m_fileName[4].Right(m_fileName[4].GetLength()-m_fileName[4].ReverseFind('.')-1);
		CStatic* pWnd = (CStatic*)GetDlgItem(IDC_bmpPicture4);
		pWnd->ModifyStyle(0xF,SS_BITMAP| SS_CENTERIMAGE);
		if(m_suffixName[4].MakeUpper() == "BMP")
		{
			pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
				m_filePath[4],
				IMAGE_BITMAP,
				180,
				120,
				LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
		}
		else
		{
			pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
				_T("..\\ControlDisplay\\res\\bmpwarning.bmp"),
				IMAGE_BITMAP,
				160,
				120,
				LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
		}
	}
}


void EditMsgDlg::OnBnClickedBtmimg5()
{
	// TODO: 在此添加控件通知处理程序代码
	CFileDialog dlg(TRUE);
	if(dlg.DoModal() == IDOK)
	{
		m_fileName[5] = dlg.GetFileName();
		m_filePath[5] = dlg.GetPathName();
		m_suffixName[5] =m_fileName[5].Right(m_fileName[5].GetLength()-m_fileName[5].ReverseFind('.')-1);
		CStatic* pWnd = (CStatic*)GetDlgItem(IDC_bmpPicture5);
		pWnd->ModifyStyle(0xF,SS_BITMAP| SS_CENTERIMAGE);
		if(m_suffixName[5].MakeUpper() == "BMP")
		{
			pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
				m_filePath[5],
				IMAGE_BITMAP,
				180,
				120,
				LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
		}
		else
		{
			pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
				_T("..\\ControlDisplay\\res\\bmpwarning.bmp"),
				IMAGE_BITMAP,
				160,
				120,
				LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
		}
	}
}


void EditMsgDlg::OnBnClickedBtmimg6()
{
	// TODO: 在此添加控件通知处理程序代码
	CFileDialog dlg(TRUE);
	if(dlg.DoModal() == IDOK)
	{
		m_fileName[6] = dlg.GetFileName();
		m_filePath[6] = dlg.GetPathName();
		m_suffixName[6] =m_fileName[6].Right(m_fileName[6].GetLength()-m_fileName[6].ReverseFind('.')-1);
		CStatic* pWnd = (CStatic*)GetDlgItem(IDC_bmpPicture6);
		pWnd->ModifyStyle(0xF,SS_BITMAP| SS_CENTERIMAGE);
		if(m_suffixName[6].MakeUpper() == "BMP")
		{
			pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
				m_filePath[6],
				IMAGE_BITMAP,
				180,
				120,
				LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
		}
		else
		{
			pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
				_T("..\\ControlDisplay\\res\\bmpwarning.bmp"),
				IMAGE_BITMAP,
				160,
				120,
				LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
		}
	}
}


void EditMsgDlg::OnBnClickedBtmimg7()
{
	// TODO: 在此添加控件通知处理程序代码
	CFileDialog dlg(TRUE);
	if(dlg.DoModal() == IDOK)
	{
		m_fileName[7] = dlg.GetFileName();
		m_filePath[7] = dlg.GetPathName();
		m_suffixName[7] =m_fileName[7].Right(m_fileName[7].GetLength()-m_fileName[7].ReverseFind('.')-1);
		CStatic* pWnd = (CStatic*)GetDlgItem(IDC_bmpPicture7);
		pWnd->ModifyStyle(0xF,SS_BITMAP| SS_CENTERIMAGE);
		if(m_suffixName[7].MakeUpper() == "BMP")
		{
			pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
				m_filePath[7],
				IMAGE_BITMAP,
				180,
				120,
				LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
		}
		else
		{
			pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
				_T("..\\ControlDisplay\\res\\bmpwarning.bmp"),
				IMAGE_BITMAP,
				160,
				120,
				LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
		}
	}
}


void EditMsgDlg::OnBnClickedBtmimg8()
{
	// TODO: 在此添加控件通知处理程序代码
	CFileDialog dlg(TRUE);
	if(dlg.DoModal() == IDOK)
	{
		m_fileName[8] = dlg.GetFileName();
		m_filePath[8] = dlg.GetPathName();
		m_suffixName[8] =m_fileName[8].Right(m_fileName[8].GetLength()-m_fileName[8].ReverseFind('.')-1);
		CStatic* pWnd = (CStatic*)GetDlgItem(IDC_bmpPicture8);
		pWnd->ModifyStyle(0xF,SS_BITMAP| SS_CENTERIMAGE);
		if(m_suffixName[8].MakeUpper() == "BMP")
		{
			pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
				m_filePath[8],
				IMAGE_BITMAP,
				180,
				120,
				LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
		}
		else
		{
			pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
				_T("..\\ControlDisplay\\res\\bmpwarning.bmp"),
				IMAGE_BITMAP,
				160,
				120,
				LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
		}
	}
}


void EditMsgDlg::OnBnClickedBtmimg9()
{
	// TODO: 在此添加控件通知处理程序代码
	CFileDialog dlg(TRUE);
	if(dlg.DoModal() == IDOK)
	{
		m_fileName[9] = dlg.GetFileName();
		m_filePath[9] = dlg.GetPathName();
		m_suffixName[9] =m_fileName[9].Right(m_fileName[9].GetLength()-m_fileName[9].ReverseFind('.')-1);
		CStatic* pWnd = (CStatic*)GetDlgItem(IDC_bmpPicture9);
		pWnd->ModifyStyle(0xF,SS_BITMAP| SS_CENTERIMAGE);
		if(m_suffixName[9].MakeUpper() == "BMP")
		{
			pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
				m_filePath[9],
				IMAGE_BITMAP,
				180,
				120,
				LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
		}
		else
		{
			pWnd->SetBitmap((HBITMAP)::LoadImage(NULL,
				_T("..\\ControlDisplay\\res\\bmpwarning.bmp"),
				IMAGE_BITMAP,
				160,
				120,
				LR_CREATEDIBSECTION | LR_DEFAULTSIZE | LR_LOADFROMFILE));
		}
	}
}


void EditMsgDlg::OnBnClickedButton2()
{
	// TODO: 在此添加控件通知处理程序代码
	int j=0;
	CString keyvaluestr,str;
	for (int i = 0; i < keyvaluenum; i++)
	{
		if (strcmp(val1[i],_T("图片"))==0)
		{
			
			if (m_filePath[j].IsEmpty())
			{				
				keyvaluestr = keyvaluestr + "k(e}y" + key[i] + "v(a}l" + val[i];
			} 
			else
			{
				//该相对路径
				CString save;
				int msg = FileSave(m_filePath[j],&save,0);				
				keyvaluestr = keyvaluestr + "k(e}y" + key[i] + "v(a}l" + save;
			}				
			j++;
			
		} 
		else
		{
			m_edit_val[i]->GetWindowText(str);
			keyvaluestr = keyvaluestr + "k(e}y" + key[i] + "v(a}l" + str;
		}
	}
	keyvaluestr = keyvaluestr + "k(e}y";
	INDEX_NODE filenode;
	strcpy_s(filenode.content, keyvaluestr);
	filenode.ID = index.ID;
	filenode.iPID = index.iPID;
	strcpy_s(filenode.name , index.name);
	filenode.IsFolder = index.IsFolder;
	int msg = IMVL_Update(&filenode);
	if (msg == SUCCESS_VALUE)
	{
		MessageBox(_T("文件内容编辑成功"),_T("操作提示"),MB_OK|MB_ICONASTERISK  );
		*isfresh =1;
	} 
	else
	{
		MessageBox(_T("文件内容编辑失败，请检查相关设置"),_T("操作提示"),MB_OK|MB_ICONERROR);
	}
}


void EditMsgDlg::OnVScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar)
{
	// TODO: 在此添加消息处理程序代码和/或调用默认值
	static int oldpos = 0;
	int minpos = 0;
	int maxpos = 0;
	GetScrollRange(SB_VERT, &minpos, &maxpos); 
	maxpos = GetScrollLimit(SB_VERT);

	// Get the current position of scroll box.
	int curpos = GetScrollPos(SB_VERT);

	// Determine the new position of scroll box.
	switch (nSBCode)
	{
	case SB_TOP:      // Scroll to far left.
		curpos = minpos;
		break;

	case SB_BOTTOM:      // Scroll to far right.
		curpos = maxpos;
		break;

	case SB_ENDSCROLL:   // End scroll.
		break;

	case SB_LINEUP:      // Scroll left.
		if (curpos > minpos)
			curpos--;
		break;

	case SB_LINEDOWN:   // Scroll right.
		if (curpos < maxpos)
			curpos++;
		break;

	case SB_PAGEUP:    // Scroll one page left.
		{
			// Get the page size. 
			SCROLLINFO   info;
			GetScrollInfo(SB_VERT, &info, SIF_ALL);

			if (curpos > minpos)
				curpos = max(minpos, curpos - (int) info.nPage);
		}
		break;

	case SB_PAGEDOWN:      // Scroll one page right.
		{
			// Get the page size. 
			SCROLLINFO   info;
			GetScrollInfo(SB_VERT, &info, SIF_ALL);

			if (curpos < maxpos)
				curpos = min(maxpos, curpos + (int) info.nPage);
		}
		break;

	case SB_THUMBPOSITION: // Scroll to absolute position. nPos is the position
		curpos = nPos;      // of the scroll box at the end of the drag operation.
		break;

	case SB_THUMBTRACK:   // Drag scroll box to specified position. nPos is the
		curpos = nPos;     // position that the scroll box has been dragged to.
		break;
	}

	// Set the new position of the thumb (scroll box).
	SetScrollPos(SB_VERT, curpos);
	ScrollWindow(0,oldpos-curpos);

	oldpos = curpos;
	UpdateWindow();
	CDialogEx::OnVScroll(nSBCode, nPos, pScrollBar);
}



void EditMsgDlg::OnSize(UINT nType, int cx, int cy)
{
	CDialogEx::OnSize(nType, cx, cy);

	// TODO: 在此处添加消息处理程序代码

	SCROLLINFO si;
	si.cbSize = sizeof(si);
	si.fMask = SIF_RANGE | SIF_PAGE;
	si.nMin = 0;
	si.nMax = 500;
	si.nPage = cx;
	SetScrollInfo(SB_HORZ,&si,TRUE);
	si.nMax = 1500;
	si.nPage = cy;
	SetScrollInfo(SB_VERT,&si,TRUE);

	int icurxpos = GetScrollPos(SB_HORZ);
	int icurypos = GetScrollPos(SB_VERT);

	if (icurxpos < m_ixoldpos || icurypos < m_iyoldpos)
	{
		ScrollWindow(m_ixoldpos-icurxpos, 0);
		ScrollWindow(0, m_iyoldpos-icurypos);

	}	
	m_ixoldpos = icurxpos;
	m_iyoldpos = icurypos;

	Invalidate(TRUE);
}





HBRUSH EditMsgDlg::OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor)
{
	HBRUSH hbr = CDialogEx::OnCtlColor(pDC, pWnd, nCtlColor);

	// TODO:  在此更改 DC 的任何特性

	// TODO:  如果默认的不是所需画笔，则返回另一个画笔
	switch (nCtlColor) //对所有同一类型的控件进行判断  
	{  
		// process my edit controls by ID.  
	case CTLCOLOR_EDIT:  
		//case CTLCOLOR_MSGBOX:
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
