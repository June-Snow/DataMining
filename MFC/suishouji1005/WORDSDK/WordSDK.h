#include <afx.h>

#define WDDLL_API __declspec(dllexport)  

#define MAX_CHAR				(256)
#define MAX_DATA_NUM			(200)
#define MAX_INDEX_NUM			(2000)
#define MAX_CHAR_CONTENT		(2000)

#define SUCCESS_VALUE			(0x00000000)
#define ERROR_FAILED_VALUE      (0x10000000)
#define ERROR_OFFICE_VERSION    (0x01000000)
#define ERROR_REPEATED_VALUE    (0x00100000)
#define ERROR_INVALID_ID        (0x00010000)
#define ERROR_INVALID_PTR       (0x00010001)
#define ERROR_NOT_EXIST         (0x10010000)
#define ERROR_ALREADY_EXIST     (0x10110000)
#define ERROR_UNKNOW_TYPE       (0x00001000)
#define INIT_VALUE              (-1000000)

WDDLL_API int IMVL_WordSDKInit(CString wordpath);
WDDLL_API int IMVL_WordSDKUnInit();
WDDLL_API int IMVL_WordSDKOpen(CString wordpath);
WDDLL_API int IMVL_WordSDKClose();
WDDLL_API int IMVL_Find(CString keyWord);
