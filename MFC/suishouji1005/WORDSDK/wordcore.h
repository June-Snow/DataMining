#ifndef WORDCORE_H
#define WORDCORE_H

#include "msword.h"
#include <ATLBASE.H>

//////////////////////////////////////////////////////////////////////////
//段落对齐的属性
enum Alignment{wdAlignParagraphCenter=1,wdAlignParagraphRight,wdAlignParagraphJustify};


/* Word save type 
wdFormatDocument		
wdFormatWebArchiv		
wdFormatHTML			
wdFormatFilteredHTML	
wdFormatTemplate    */
enum SaveType{
	wdFormatDocument=0,
	wdFormatWebArchive=9,
	wdFormatHTML=8,
    wdFormatFilteredHTML=10,
    wdFormatTemplate=1
};


//////////////////////////////////////////////////////////////////////////
class IMVL_WordCore
{
public:
	_Application m_app;// create word
	Documents m_docs;//set of word doc
	_Document m_doc;//one single word //?assigned more than one time
	Selection m_selection;//选择编辑对象 没有对象的时候就是插入点
	

public:
	IMVL_WordCore();
	virtual ~IMVL_WordCore();
	
	int OpenConnection();// Create A Word Instance
	int CloseConnection();
	int ShowConnection(BOOL doShowAPP);
	int CreateDoc();
	int OpenDoc(CString fileName, BOOL readOnly = FALSE, BOOL addToRecentFiles = FALSE);//?
	int CloseDoc(BOOL saveChange= FALSE);

	int CreateTable(int row, int column);
	void NewLine(int nline = 1);
	void WriteText(CString text);
	void WriteTextAfterLines(CString text,int nLine = 1);
	void SetParaphformat(int alignment);// set property for alignment 	
	int SetFont(BOOL bold, BOOL italic = FALSE, BOOL underLine = FALSE);
	int SetFont(CString fontName,int fontSize = 9, long fontColor = 0, long fontBackColor = 0);
	int SetTableFont(int row, int column, CString fontName, int fontSize = 9, long fontColor = 0, long fontBackColor = 0);

	int SaveAs(CString fileName, int saveType = 0);
	int ReplaceWord(CString keyword, CString replword);
	int FindWord(CString keyword);
	void GetWordText(CString *text);
	int Print();

	//////////////////////////////////////////////////////////////////////////
	BOOL Save();
	
private:
	int InitCOM(); // Called in Initialize Function
	BOOL IMVL_WordCore::CreateDocument(); //Called by CreateDoc
};

#endif //WORDCORE_H
