// Ex_DrawTextDoc.h : interface of the CEx_DrawTextDoc class
//
/////////////////////////////////////////////////////////////////////////////

#if !defined(AFX_EX_DRAWTEXTDOC_H__FEA4E661_82D8_41E9_B318_8CD0ABC682B2__INCLUDED_)
#define AFX_EX_DRAWTEXTDOC_H__FEA4E661_82D8_41E9_B318_8CD0ABC682B2__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000


class CEx_DrawTextDoc : public CDocument
{
protected: // create from serialization only
	CEx_DrawTextDoc();
	DECLARE_DYNCREATE(CEx_DrawTextDoc)

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CEx_DrawTextDoc)
	public:
	virtual BOOL OnNewDocument();
	virtual void Serialize(CArchive& ar);
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CEx_DrawTextDoc();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// Generated message map functions
protected:
	//{{AFX_MSG(CEx_DrawTextDoc)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_EX_DRAWTEXTDOC_H__FEA4E661_82D8_41E9_B318_8CD0ABC682B2__INCLUDED_)
