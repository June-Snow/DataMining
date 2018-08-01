
// GridCtrlDemoDlg.h : 头文件
//

#pragma once

//#include "GridCtrl/GridCtrl.h"
#include "GridCtrl/GridCtrl_src/GridCtrl.h"
// CGridCtrlDemoDlg 对话框
struct DeviceItemNode
{
	int startPos;
	int endPos;
};
class CGridCtrlDemoDlg : public CDialog
{
// 构造
public:
	CGridCtrlDemoDlg(CWnd* pParent = NULL);	// 标准构造函数

// 对话框数据
	enum { IDD = IDD_GRIDCTRLDEMO_DIALOG };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV 支持


// 实现
protected:
	HICON m_hIcon;

	// 生成的消息映射函数
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	DECLARE_MESSAGE_MAP()

public:
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	afx_msg void OnSize(UINT nType, int cx, int cy);
	void AddData();
	int GroupPaintGrid(CGridCtrl &m_gird);
	int GetGroupInfo(std::vector<CString>serialStr, std::vector<DeviceItemNode> &serialArray1,std::vector<DeviceItemNode> &serialArray2,std::vector<DeviceItemNode> &serialArray3);
	afx_msg void OnGridClick(NMHDR *pNotifyStruct, LRESULT* pResult);
	afx_msg void OnGridRClick(NMHDR *pNotifyStruct, LRESULT* pResult);
	afx_msg void OnGridAdd();
	afx_msg void OnGridDelete();
	afx_msg void OnGridMerge();
	afx_msg void OnGridUnMerge();
	void OnAddTree();
	afx_msg void OnTreeClick(NMHDR *pNotifyStruct, LRESULT* pResult);
	afx_msg void OnTreeRClick(NMHDR *pNotifyStruct, LRESULT* pResult);
	afx_msg void OnCreatItem();
	afx_msg void OnTreeDelete();
	afx_msg void CGridSetCellCheck();

	int GroupLevelGrid(CString str);
	int GridNumberLayer(std::vector<CString>serialStr, std::vector<std::vector<DeviceItemNode> > &layerArray);
	void GridSameLayer(std::vector<CString>serialStr, 
		std::vector<DeviceItemNode> serialArray,
		std::vector<DeviceItemNode> &serialArray1);
	void GridCascadeSequenceNumber(std::vector<CString>serialStr, int row, std::vector<int> &pos);
	afx_msg void OnGridStartSelChange(NMHDR *pNotifyStruct, LRESULT* pResult);
	void GridCascadingChanges(std::vector<int> pos);
	void GridCascadingChangesRow(int row, double balance, int num, int level);
	afx_msg void OnGridEdit(NMHDR *pNMHDR, LRESULT* pResult);
public:
	CGridCtrl m_grid;
	int curGridPos[4];
	CTreeCtrl m_tree;
	CImageList m_imageList;
};
