#include "StdAfx.h"
#include "wordcore.h"
#include "WordSDK.h"

//���� vOpt �������������� ��Ϊ���Լ�ϲ���� CComVariant vOpt;��д ������һЩ���⻷������ִ���
//COleVariant vOpt(( long )DISP_E_PARAMNOTFOUND,  VT_ERROR);
//////////////////////////////////////////////////////////////////////////
int IMVL_WordCore::InitCOM()
{
	if(CoInitialize(NULL) != S_OK)
	{
		//AfxMessageBox("��ʼ��com��ʧ��");
		return ERROR_FAILED_VALUE;
	}
	else
	{
		return SUCCESS_VALUE;
	}
}


IMVL_WordCore::IMVL_WordCore()
{
	InitCOM();
}


IMVL_WordCore::~IMVL_WordCore()
{
	CoUninitialize();
	//m_doc.ReleaseDispatch();
	//m_docs.ReleaseDispatch();
	//m_app.ReleaseDispatch();
	//m_selection.ReleaseDispatch();
}


int IMVL_WordCore::CreateDoc()
{
	int ret = ERROR_FAILED_VALUE;

	if(OpenConnection())
	{
		if(CreateDocument())
		{
			ret = SUCCESS_VALUE;
		}
	}

	return ret;
}


int IMVL_WordCore::Save()
{
	int ret = ERROR_FAILED_VALUE;

	if(!m_doc.m_lpDispatch)
	{
		#ifdef _DEBUG
			AfxMessageBox("Documents����δ�����ɹ�. ����ʧ�ܣ�");
		#endif
		ret  = ERROR_FAILED_VALUE;
	}
	else
	{
		m_doc.Save();
		ret = SUCCESS_VALUE;
	}

	return ret;
}


void IMVL_WordCore::NewLine(int nLine)
{
	if(nLine<=0)
	{
		nLine = 0;
	}
	
	for(int i = 0; i < nLine; i++)
	{
		m_selection.TypeParagraph();//new Paragraph
	}
}


void IMVL_WordCore::WriteText(CString text)
{
	m_selection.TypeText(text);
}


void IMVL_WordCore::WriteTextAfterLines(CString text, int nLine)
{
	NewLine(nLine);
	WriteText(text);
}


int IMVL_WordCore::SetFont(BOOL bold, BOOL italic, BOOL underLine)
{
	int ret = ERROR_FAILED_VALUE;
	_Font font;

	if(!m_selection.m_lpDispatch)
	{
		#ifdef _DEBUG
			AfxMessageBox("�༭����ʧ��,�������岻������");
		#endif
		ret = ERROR_FAILED_VALUE;
	}
	else
	{
		m_selection.SetText(_T("F"));
		font = m_selection.GetFont();//�������༭����;
		font.SetBold(bold);
		font.SetItalic(italic);
		font.SetUnderline(underLine);
		m_selection.SetFont(font);
		ret = SUCCESS_VALUE;
	}

	return ret;
}


int IMVL_WordCore::SetFont(CString fontName,int fontSize, long fontColor, long fontBackColor)
{
	int ret = ERROR_FAILED_VALUE;
	_Font font;

	if(!m_selection.m_lpDispatch)
	{		
		#ifdef _DEBUG
			AfxMessageBox("Select Ϊ��,��������ʧ��!");
		#endif
		ret = ERROR_FAILED_VALUE;
	}
	else
	{
		m_selection.SetText(_T("a"));
		font = m_selection.GetFont();
		font.SetSize(20);
		font.SetName(fontName);
		font.SetColor(fontColor);
		m_selection.SetFont(font);

		ret = SUCCESS_VALUE;
	}

	return ret;
}


void IMVL_WordCore::SetParaphformat(int alignment)
{
	_ParagraphFormat parag;
	parag = m_selection.GetParagraphFormat();
	parag.SetAlignment(alignment);
	m_selection.SetParagraphFormat(parag);
}


void IMVL_WordCore::GetWordText(CString *text)
{
	int ret;
	COleVariant vOpt(( long )DISP_E_PARAMNOTFOUND,  VT_ERROR); 
	_Document doc;
	Range range;

	doc= m_app.GetActiveDocument();
	if(!doc.m_lpDispatch)
	{
		ret = ERROR_FAILED_VALUE;
	}
	else
	{
		range = doc.Range(vOpt, vOpt);
		*text = range.GetText();
	}
}



int IMVL_WordCore::OpenConnection()
{
	int ret=ERROR_FAILED_VALUE;

	if(!m_app.CreateDispatch("Word.Application"))
	{
#ifdef _DEBUG
		AfxMessageBox("��֧�ִ˼������OFFICE�汾");
#endif
		ret = ERROR_OFFICE_VERSION;
	}
	else
	{
		m_app.SetVisible(FALSE);
		ret = SUCCESS_VALUE;
	}

	return ret;
}


int IMVL_WordCore::ShowConnection(BOOL doShowAPP)
{
	int ret = ERROR_FAILED_VALUE;

	if(!m_app.m_lpDispatch)
	{
#ifdef _DEBUG
		AfxMessageBox("��û�л��Word����");
#endif
		ret = ERROR_FAILED_VALUE;
	}
	else
	{
		m_app.SetVisible(doShowAPP);
		ret = SUCCESS_VALUE;
	}

	return ret;
}


int IMVL_WordCore::Print()
{
	int ret = ERROR_FAILED_VALUE;
	_Document doc;

	doc = m_app.GetActiveDocument();
	if(!doc.m_lpDispatch)
	{
		#ifdef _DEBUG
			AfxMessageBox("��ȡ�����ĵ�����ʧ��");
		#endif		
		ret = ERROR_FAILED_VALUE;
	}
	else
	{
		COleVariant covTrue((short)TRUE);
		COleVariant covFalse((short)FALSE);
		COleVariant covOptional((long)DISP_E_PARAMNOTFOUND, VT_ERROR);

		doc.PrintOut(covFalse,             // Background.
					covOptional,           // Append.
					covOptional,           // Range.
					covOptional,           // OutputFileName.
					covOptional,           // From.
					covOptional,           // To.
					covOptional,           // Item.
					COleVariant((long)1),  // Copies.
					covOptional,           // Pages.
					covOptional,           // PageType.
					covOptional,           // PrintToFile.
					covOptional,           // Collate.
					covOptional,           // ActivePrinterMacGX.
					covOptional,           // ManualDuplexPrint.
					covOptional,           // PrintZoomColumn  New with Word 2002
					covOptional,           // PrintZoomRow          ditto
					covOptional,           // PrintZoomPaperWidth   ditto
					covOptional);          // PrintZoomPaperHeight  ditto*/
		ret = SUCCESS_VALUE;
	}
	
	return ret;
}


int IMVL_WordCore::SaveAs(CString fileName, int saveType/* =0 */)
{
	int ret = ERROR_FAILED_VALUE;
	CComVariant vTrue(TRUE);
	CComVariant vFalse(FALSE);
	CComVariant vOpt;
	CComVariant cFileName(fileName);
	CComVariant fileFormat(saveType);
	_Document doc;

	doc = m_app.GetActiveDocument();
	if(!doc.m_lpDispatch)
	{
		#ifdef _DEBUG
			//AfxMessageBox("Document ����û�н��� ���Ϊʧ��");
		#endif		
		ret = ERROR_FAILED_VALUE;
	}
	else
	{  
		doc.SaveAs(&cFileName, &fileFormat, &vFalse, COleVariant(""), &vTrue,	\
					COleVariant(""), &vFalse, &vFalse, &vFalse, &vFalse,		\
					&vFalse, &vOpt, &vOpt, &vOpt, &vOpt, &vOpt);
		ret = SUCCESS_VALUE;
	}

	return ret;
}


int IMVL_WordCore::FindWord(CString keyword)
{
	int ret = ERROR_FAILED_VALUE;
	Find find;
	COleVariant text(keyword);
	COleVariant vTrue((short)TRUE), vFalse((short)FALSE);
	COleVariant vOpt((long)DISP_E_PARAMNOTFOUND, VT_ERROR);
	CComVariant v1(1); //�����ǿ���������Χ�ı���
	CComVariant v2(2);
	CComVariant v3(_T(""));

	m_selection = m_app.GetSelection();
	find = m_selection.GetFind();
	if(!find.m_lpDispatch)
	{
		#ifdef _DEBUG
			AfxMessageBox("��ȡFind ����ʧ��");
		#endif	

		ret = ERROR_FAILED_VALUE;
	}
	else
	{
		try{
			find.ClearFormatting();
			find.Execute(text, vFalse, vFalse, vFalse, vFalse, vFalse, vTrue, &v1,\
						vFalse, vFalse, vFalse, vOpt, vOpt, vOpt, vOpt);
			ret = find.GetFound();
		}
		catch(...)
		{
			ret = ERROR_FAILED_VALUE;
		}
	}
	return ret;
}


int IMVL_WordCore::ReplaceWord(CString keyword, CString replword)
{
	int ret = 0;
	COleVariant Text(keyword);
	COleVariant repword(replword);
	COleVariant vTrue((short)TRUE), vFalse((short)FALSE);
	COleVariant vOpt((long)DISP_E_PARAMNOTFOUND, VT_ERROR);
	CComVariant v1(1);// v1, v2�����Ƕ�Ӧ���滻�ķ�Χ:
	CComVariant v2(2);// 1 ����һ��, 2 ���������ĵ�
	CComVariant v3(_T(""));
	Find find;

	m_selection=m_app.GetSelection();
	find=m_selection.GetFind();
	if(!find.m_lpDispatch)
	{
		#ifdef _DEBUG
			AfxMessageBox("��ȡFind ����ʧ��");
		#endif
	}
	else
	{
		//? Replacement replace;
		//? replace=find.GetReplacement();
		//? replace.ClearFormatting();
		find.ClearFormatting();
		find.Execute(Text, vFalse, vFalse, vFalse, vFalse, vFalse,
					vTrue, &v1, vFalse, &repword, &v2, vOpt, vOpt, vOpt, vOpt);

		ret = SUCCESS_VALUE;
	}

	return ret;
}



BOOL IMVL_WordCore::CreateDocument()
{
	if(!m_app.m_lpDispatch)
	{
		//MessageBox("ApplicationΪ��,Documents����ʧ��!", MB_OK|MB_ICONWARNING);
		return FALSE;
	}
	else
	{
		m_docs = m_app.GetDocuments();
		if(m_docs.m_lpDispatch==NULL)
		{
			//MessageBox("����DOCUMENTS ʧ��");
			return FALSE;
		}
		else
		{
			CComVariant Template(_T(""));//����һ���յ�ģ��
			CComVariant NewTemplate(false);
			CComVariant DocumentType(0);
			CComVariant Visible;//������ ��Ĭ��ֵ
			m_doc = m_docs.Add(&Template,&NewTemplate,&DocumentType,&Visible);
			if(!m_doc.m_lpDispatch)
			{
				//AfxMessageBox("����wordʧ��");
				return FALSE;
			}
			else
			{
				m_selection = m_app.GetSelection();//��õ�ǰWord��������ʼ��Ϊ����m_doc���selection����ϸ��һ��ȷʵӦ����Word�Ľӿڵ�
				if(!m_selection.m_lpDispatch)
				{
					//AfxMessageBox("selection ��ȡʧ��");
					return FALSE;
				}
				else
				{
					return TRUE;
				}
			}
		}
	}
}


int IMVL_WordCore::CloseConnection()//?
{
	int ret = ERROR_FAILED_VALUE;
	COleVariant vOpt(( long )DISP_E_PARAMNOTFOUND,  VT_ERROR);

	if(!m_app.m_lpDispatch)
	{
#ifdef _DEBUG
		AfxMessageBox("��ȡWord ����ʧ��,�رղ���ʧ��");
#endif	
		ret = ERROR_FAILED_VALUE;
	}
	else
	{

		m_app.Quit(vOpt, vOpt, vOpt);
		m_app.ReleaseDispatch();
		if (m_docs.m_lpDispatch)
		{
			m_docs.ReleaseDispatch();
		}
		
		if (m_doc.m_lpDispatch)
		{
			m_doc.ReleaseDispatch();
		}

		if (m_selection.m_lpDispatch)
		{
			m_selection.ReleaseDispatch();
		}
		ret = SUCCESS_VALUE;
	}

	return ret;
}


int IMVL_WordCore::CloseDoc(BOOL saveChange)
{
	int ret = ERROR_FAILED_VALUE;
	CComVariant vTrue(TRUE);
	CComVariant vFalse(FALSE);
	CComVariant vOpt;

	if(!m_doc.m_lpDispatch)
	{
#ifdef _DEBUG
		AfxMessageBox("_Document �����ȡʧ��,�رղ���ʧ��");
#endif		
		ret = ERROR_FAILED_VALUE;
	}
	else
	{
		if(TRUE == saveChange)
		{
			Save();
		}
		m_doc.Close(&vFalse,&vOpt,&vOpt);
		ret = SUCCESS_VALUE;
	}
	CloseConnection();
	return ret;
}


//////////////////////////////////////////////////////////////////////////
int IMVL_WordCore::OpenDoc(CString fileName,BOOL readOnly /*=FALSE*/, BOOL addToRecentFiles /*=FALSE*/)//?
{
	int ret = SUCCESS_VALUE;
	CComVariant Read(readOnly);
	CComVariant AddToR(addToRecentFiles);
	CComVariant Name(fileName);
	COleVariant vTrue((short)TRUE), vFalse((short)FALSE);
	COleVariant varstrNull(_T(""));
	COleVariant varZero((short)0);
	COleVariant varTrue(short(1),VT_BOOL);
	COleVariant varFalse(short(0),VT_BOOL);
	COleVariant vOpt((long)DISP_E_PARAMNOTFOUND, VT_ERROR);

	if(!m_app.m_lpDispatch)
	{
		if(OpenConnection() == ERROR_FAILED_VALUE)//��������
		{
			return FALSE;
		}
	}

	if(!m_docs.m_lpDispatch)
	{
		m_docs = m_app.GetDocuments();
		if(!m_docs.m_lpDispatch)
		{
			//AfxMessageBox("DocuMent ���󴴽�ʧ��");
			return FALSE;
		}
	}

	CComVariant format(0);//�򿪷�ʽ 0 Ϊm_doc�Ĵ򿪷�ʽ
	try
	{
		m_doc = m_docs.Open(			\
							&Name,		//FileName
							varFalse,	//ConfirmConversions
							&Read,		//ReadOnly
							&AddToR,	//AddToRecentFiles
							vOpt,		//PasswordDocument
							vOpt,		//PasswordTemplate
							vFalse,		//Revert
							vOpt,		//WritePasswordDocument
							vOpt,		//WritePasswordTemplate
							&format,	//Format
							vOpt,		//Encoding
							vTrue,		//Visible
							varFalse,	//OpenAndRepair
							vOpt,		//DocumentDirection
							vOpt,		//NoEncodingDialog
							vOpt		//XMLTransform
							);
	}
	catch(...)
	{
		m_app.ReleaseDispatch();
		m_docs.ReleaseDispatch();
		return false;
	}

	if(!m_doc.m_lpDispatch)
	{
		//AfxMessageBox("�ļ���ʧ��");
		return FALSE;
	}
	else
	{
		m_selection = m_app.GetSelection();
		if(!m_selection.m_lpDispatch)
		{
			//AfxMessageBox("��ʧ��");
			return FALSE;
		}
		return TRUE;
	}
	return TRUE;
}


