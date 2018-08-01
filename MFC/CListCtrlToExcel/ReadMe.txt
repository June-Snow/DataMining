========================================================================
       导出List控件数据到Excel文件: CListCtrlToExcel
========================================================================

CListCtrl获得列的属性可以使用
BOOL CListCtrl::GetColumn( int nCol, LVCOLUMN* pColumn )
nCol为需要获得获得属性值的列序号，pColumn 为 LVCOLUMN 结构体的指针。
LVCOLUMN结构体中的 UINT mask 作为输入，决定返回哪些属性的值，如果 mask 的
值包含 LVCF_TEXT ，则需要将字符串缓存的首地址指针置入结构体中的
 LPTSTR  pszText; 变量，缓存大小置入 int cchTextMax; 变量。

使用这个函数的主要问题是主要问题期望返回 LVCF_TEXT ，设置了 pszText 却没有
设置 cchTextMax 变量，并且通常都在分配 LVCOLUMN 结构体空间时将所分配的内存
清0，因此总是不能返回列名。反而是没有清0所分配空间，直接设置 mask 为  
LVCF_TEXT ，那么可能可以获得列名的值。当然只要正确设置 pszText 和 
cchTextMax 就不会有这些问题。

还有一个问题是列的数量。没有直接的函数可以获得列的数量，只能从0开始不断自
增 nCol 的值，判断 GetColumn( nCol,pColumn ) 的返回值是否为 False 以计算列
的数量。


2014.3.5

/////////////////////////////////////////////////////////////////////////////