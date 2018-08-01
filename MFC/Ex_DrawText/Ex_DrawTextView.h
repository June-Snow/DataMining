// Ex_DrawTextView.h : interface of the CEx_DrawTextView class
//
/////////////////////////////////////////////////////////////////////////////

#if !defined(AFX_EX_DRAWTEXTVIEW_H__ABC139E6_BA29_463A_B25F_8268336F5551__INCLUDED_)
#define AFX_EX_DRAWTEXTVIEW_H__ABC139E6_BA29_463A_B25F_8268336F5551__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000


class CEx_DrawTextView : public CView
{
protected: // create from serialization only
	CEx_DrawTextView();
	DECLARE_DYNCREATE(CEx_DrawTextView)

// Attributes
public:
	CEx_DrawTextDoc* GetDocument();

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CEx_DrawTextView)
	public:
	virtual void OnDraw(CDC* pDC);  // overridden to draw this view
	virtual BOOL PreCreateWindow(CREATESTRUCT& cs);
	protected:
	virtual BOOL OnPreparePrinting(CPrintInfo* pInfo);
	virtual void OnBeginPrinting(CDC* pDC, CPrintInfo* pInfo);
	virtual void OnEndPrinting(CDC* pDC, CPrintInfo* pInfo);
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CEx_DrawTextView();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// Generated message map functions
protected:
	//{{AFX_MSG(CEx_DrawTextView)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

#ifndef _DEBUG  // debug version in Ex_DrawTextView.cpp
inline CEx_DrawTextDoc* CEx_DrawTextView::GetDocument()
   { return (CEx_DrawTextDoc*)m_pDocument; }
#endif

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_EX_DRAWTEXTVIEW_H__ABC139E6_BA29_463A_B25F_8268336F5551__INCLUDED_)
