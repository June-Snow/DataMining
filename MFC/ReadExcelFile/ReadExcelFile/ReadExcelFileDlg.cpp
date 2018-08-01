
// ReadExcelFileDlg.cpp : ʵ���ļ�
//

#include "stdafx.h"
#include "ReadExcelFile.h"
#include "ReadExcelFileDlg.h"
#include "afxdialogex.h"
#include "ExcelOperate.h"

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


// CReadExcelFileDlg �Ի���




CReadExcelFileDlg::CReadExcelFileDlg(CWnd* pParent /*=NULL*/)
	: CDialogEx(CReadExcelFileDlg::IDD, pParent)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	m_type = 1;
}

void CReadExcelFileDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CReadExcelFileDlg, CDialogEx)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_BUTTON1, &CReadExcelFileDlg::OnBnClickedButton1)
	ON_BN_CLICKED(IDC_BUTTON2, &CReadExcelFileDlg::OnBnClickedButton2)
	ON_BN_CLICKED(IDC_BUTTON3, &CReadExcelFileDlg::OnBnClickedButton3)
	ON_BN_CLICKED(IDC_BUTTON4, &CReadExcelFileDlg::OnBnClickedButton4)
	ON_BN_CLICKED(IDC_BUTTON5, &CReadExcelFileDlg::OnBnClickedButton5)
	ON_WM_TIMER()
END_MESSAGE_MAP()


// CReadExcelFileDlg ��Ϣ�������

BOOL CReadExcelFileDlg::OnInitDialog()
{
	CDialogEx::OnInitDialog();

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

	// TODO: �ڴ���Ӷ���ĳ�ʼ������

	return TRUE;  // ���ǽ��������õ��ؼ������򷵻� TRUE
}

void CReadExcelFileDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialogEx::OnSysCommand(nID, lParam);
	}
}

// �����Ի��������С����ť������Ҫ����Ĵ���
//  �����Ƹ�ͼ�ꡣ����ʹ���ĵ�/��ͼģ�͵� MFC Ӧ�ó���
//  �⽫�ɿ���Զ���ɡ�

void CReadExcelFileDlg::OnPaint()
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
		CDialogEx::OnPaint();
	}
}

//���û��϶���С������ʱϵͳ���ô˺���ȡ�ù��
//��ʾ��
HCURSOR CReadExcelFileDlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}


//excel�ļ�
void CReadExcelFileDlg::OnBnClickedButton1()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	//CString path = _T("C:\\Users\\Serissa\\Desktop\\�㷨�鹤���ܱ�\\�����ܱ�-20160526-����.xls");


	static char szFilter[] = "Excel Files (*.xls)|*.xls|Excel Files (*.xlsx)|*.xlsx||";
	CFileDialog dlg(TRUE, "xls", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
	if(dlg.DoModal() != IDOK)
		return;
	CString m_pathName = dlg.GetPathName();
	GetDlgItem(IDC_EDIT1)->SetWindowText(m_pathName);
}

//ԭʼ��Ƶ
void CReadExcelFileDlg::OnBnClickedButton2()
{
	char szPath[MAX_PATH];     //���ѡ���Ŀ¼·�� 
	CString str;
	ZeroMemory(szPath, sizeof(szPath));   
	BROWSEINFO bi;   
	bi.hwndOwner = m_hWnd;   
	bi.pidlRoot = NULL;   
	bi.pszDisplayName = szPath;   
	bi.lpszTitle = "��ѡ����Ҫ�򿪵��ļ��У�";   
	bi.ulFlags = 0;   
	bi.lpfn = NULL;   
	bi.lParam = 0;   
	bi.iImage = 0;   
	//����ѡ��Ŀ¼�Ի���
	LPITEMIDLIST lp = SHBrowseForFolder(&bi);   

	if(lp && SHGetPathFromIDList(lp, szPath))   
	{
		str.Format("%s",  szPath);
		GetDlgItem(IDC_EDIT2)->SetWindowText(str);
	}
	else   
		AfxMessageBox("��Ч���ļ��У�������ѡ��");   
}

//������Ƶ
void CReadExcelFileDlg::OnBnClickedButton3()
{
	char szPath[MAX_PATH];     //���ѡ���Ŀ¼·�� 
	CString str;
	ZeroMemory(szPath, sizeof(szPath));   
	BROWSEINFO bi;   
	bi.hwndOwner = m_hWnd;   
	bi.pidlRoot = NULL;   
	bi.pszDisplayName = szPath;   
	bi.lpszTitle = "��ѡ�񱣴���ļ��У�";   
	bi.ulFlags = 0;   
	bi.lpfn = NULL;   
	bi.lParam = 0;   
	bi.iImage = 0;   
	//����ѡ��Ŀ¼�Ի���
	LPITEMIDLIST lp = SHBrowseForFolder(&bi);   

	if(lp && SHGetPathFromIDList(lp, szPath))   
	{
		str.Format("%s",  szPath);
		GetDlgItem(IDC_EDIT3)->SetWindowText(str);
	}
	else   
		AfxMessageBox("��Ч���ļ��У�������ѡ��");   
}

//������Ƶ
void CReadExcelFileDlg::OnBnClickedButton4()
{
	CString strExcelPath;
	GetDlgItem(IDC_EDIT1)->GetWindowText(strExcelPath);
	CString strAviPath;
	GetDlgItem(IDC_EDIT2)->GetWindowText(strAviPath);
	CString strSavePath;
	GetDlgItem(IDC_EDIT3)->GetWindowText(strSavePath);
	if (strExcelPath.IsEmpty() || strAviPath.IsEmpty() || strSavePath.IsEmpty())
	{
		return;
	}
	std::vector<CString> name;
	OnReadExcel(strExcelPath,name);
	startThread(name, strAviPath, strSavePath, 1);
	m_type = 1;//������־λ��1����ʼ��2������
	SetTimer(5, 500, NULL);

}

//������Ƶ
void CReadExcelFileDlg::OnBnClickedButton5()
{
	CString strExcelPath;
	GetDlgItem(IDC_EDIT1)->GetWindowText(strExcelPath);
	CString strAviPath;
	GetDlgItem(IDC_EDIT2)->GetWindowText(strAviPath);
	CString strSavePath;
	GetDlgItem(IDC_EDIT3)->GetWindowText(strSavePath);
	if (strExcelPath.IsEmpty() || strAviPath.IsEmpty() || strSavePath.IsEmpty())
	{
		return;
	}
	std::vector<CString> name;
	OnReadExcel(strExcelPath,name);

	startThread(name, strAviPath, strSavePath, 2);
	m_type = 1;//������־λ��1����ʼ��2������
	SetTimer(5, 500, NULL);
}

void CReadExcelFileDlg::startThread(std::vector<CString> name, CString source, CString save, int type)
{
	aviName = name;
	sourcePath = source;
	savePath = save;
	moveType = type;
	_beginthread(moveFileThread, 0, this);//���߳�

}

void CReadExcelFileDlg::moveFileThread(void *args)
{
	CReadExcelFileDlg *obj = (CReadExcelFileDlg*)args;
	std::vector<CString> name;
	name = obj->aviName;
	CString source = obj->sourcePath;
	source = source +_T("\\");
	CString save = obj->savePath;
	save = save +_T("\\");
	int type = obj->moveType;
	if (type == 1)
	{
		for (int i=0; i!=name.size(); i++)
		{
			if (PathFileExists(source+name[i]))
			{
				CopyFile(source+name[i],save +name[i], FALSE);
			}
		}

	}
	if (type == 2)
	{
		for (int i=0; i!=name.size(); i++)
		{
			if (PathFileExists(source+name[i]))
			{
				MoveFile( source+name[i],save +name[i]);
			}
		}
	}
	obj->m_type = 2;
}

void CReadExcelFileDlg::OnTimer(UINT_PTR nIDEvent)
{
	// TODO: �ڴ������Ϣ�����������/�����Ĭ��ֵ
	if(nIDEvent  == 5)
	{
		if(m_type  == 2)
		{
			KillTimer(nIDEvent );
		}
	}
	CDialogEx::OnTimer(nIDEvent);
}
