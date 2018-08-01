
#include "stdafx.h"
#include "wordcore.h"
#include "WordSDK.h"

IMVL_WordCore g_WordCore;


WDDLL_API int IMVL_WordSDKInit(CString wordpath)
{
	int ret = ERROR_FAILED_VALUE;

	ret = SUCCESS_VALUE;
	return ret;
}


WDDLL_API int IMVL_WordSDKUnInit()
{
	int ret = ERROR_FAILED_VALUE;
	//g_WordCore.CloseConnection();
	//g_WordCore.CloseDoc();
	//g_WordCore.~IMVL_WordCore();
	ret = SUCCESS_VALUE;
	return ret;
}


WDDLL_API int IMVL_WordSDKOpen(CString wordpath)
{
 	int ret = ERROR_FAILED_VALUE;
	if(g_WordCore.OpenDoc(wordpath))
	{
		ret = SUCCESS_VALUE;
	}
 	return ret;
}


WDDLL_API int IMVL_WordSDKClose()
{
	int ret = ERROR_FAILED_VALUE;
	g_WordCore.CloseDoc();
	ret = SUCCESS_VALUE;
	return ret;
}


WDDLL_API int IMVL_Find(CString keyWord)
{
	return g_WordCore.FindWord(keyWord);
}