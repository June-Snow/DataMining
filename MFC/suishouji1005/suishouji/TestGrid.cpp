// TestGrid.cpp : 实现文件
//

#include "stdafx.h"
#include "suishouji.h"
#include "TestGrid.h"
#include "afxdialogex.h"
#include "GridCtrl.h"
#include "GridURLCell.h"
#include "GridCellCombo.h"
#include "GridCellCheck.h"
#include "GridCellNumeric.h"
#include "GridCellDateTime.h"


// CTestGrid 对话框

IMPLEMENT_DYNAMIC(CTestGrid, CDialogEx)

CTestGrid::CTestGrid(CWnd* pParent /*=NULL*/)
	: CDialogEx(CTestGrid::IDD, pParent)
{

}

CTestGrid::~CTestGrid()
{
}

void CTestGrid::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
}

BOOL CTestGrid::OnInitDialog()
{	
	CDialogEx::OnInitDialog();
	CGridCtrl* m_pGrid;
	m_pGrid = new CGridCtrl;     // Create the Gridctrl object
	CRect rect;                  // Create the Gridctrl window
	GetClientRect(rect);
	m_pGrid->Create(rect, this, 100);

	m_pGrid->SetRowCount(50);     // fill it up with stuff
	m_pGrid->SetColumnCount(10);

	return TRUE;
}


BEGIN_MESSAGE_MAP(CTestGrid, CDialogEx)
END_MESSAGE_MAP()


// CTestGrid 消息处理程序
