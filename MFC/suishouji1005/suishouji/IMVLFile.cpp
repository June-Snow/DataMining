
#include "stdafx.h"
#include <shlobj.h>
#include <Commdlg.h>
#include <ShellAPI.h>
#include <sys\stat.h> 
#include "IMVLFile.h"

IMVLFile::IMVLFile()
{

}

BOOL IMVLFile::MkDir(const string&  _path)
{
	if(_path.size() == 0)
		return FALSE;

	static char buffer[1024];
	strcpy(buffer, _S(_path));
	for (int i = 0; buffer[i] != 0; i ++) {
		if (buffer[i] == '\\' || buffer[i] == '/') {
			buffer[i] = '\0';
			CreateDirectoryA(buffer, 0);
			buffer[i] = '/';
		}
	}
	return CreateDirectoryA(_S(_path), 0);
}


string IMVLFile::BrowseFolder()   
{
	static char Buffer[MAX_PATH];
	BROWSEINFOA bi;//Initial bi 	
	bi.hwndOwner = NULL; 
	bi.pidlRoot = NULL;
	bi.pszDisplayName = Buffer; // Dialog can't be shown if it's NULL
	bi.lpszTitle = "BrowseFolder";
	bi.ulFlags = 0;
	bi.lpfn = NULL;
	bi.iImage = NULL;


	LPITEMIDLIST pIDList = SHBrowseForFolderA(&bi); // Show dialog
	if(pIDList)	{	
		SHGetPathFromIDListA(pIDList, Buffer);
		if (Buffer[strlen(Buffer) - 1]  == '\\')
			Buffer[strlen(Buffer) - 1] = 0;

		return string(Buffer);
	}
	return string();   
}

string IMVLFile::BrowseFile(const char* strFilter, bool isOpen)
{
	static char Buffer[MAX_PATH];
	OPENFILENAMEA   ofn;  
	memset(&ofn, 0, sizeof(ofn));
	ofn.lStructSize = sizeof(ofn);
	ofn.lpstrFile = Buffer;
	ofn.lpstrFile[0] = '\0';   
	ofn.nMaxFile = MAX_PATH;   
	ofn.lpstrFilter = strFilter;   
	ofn.nFilterIndex = 1;    
	ofn.Flags = OFN_PATHMUSTEXIST;   

	if (isOpen) {
		ofn.Flags = OFN_PATHMUSTEXIST | OFN_FILEMUSTEXIST;
		GetOpenFileNameA(&ofn);
		return Buffer;
	}

	GetSaveFileNameA(&ofn);
	return string(Buffer);

}


int IMVLFile::Rename(const string& _srcNames, const string& _dstDir, const char *nameCommon, const char *nameExt)
{
	vector<string> names;
	string inDir;
	int fNum = GetNames(_srcNames, names, inDir);
	for (int i = 0; i < fNum; i++) {
		string dstName = "";//format("%s\\%.4d%s.%s", _S(_dstDir), i, nameCommon, nameExt);
		string srcName = inDir + names[i];
		::CopyFileA(srcName.c_str(), dstName.c_str(), FALSE);
	}
	return fNum;
}


void IMVLFile::RenameSuffix(const string dir, const string orgSuf, const string dstSuf)
{
	vector<string> namesNS;
	int fNum = IMVLFile::GetNamesNoSuffix(dir + "*" + orgSuf, namesNS, orgSuf);
	for (int i = 0; i < fNum; i++)
		IMVLFile::Move(dir + namesNS[i] + orgSuf, dir + namesNS[i] + dstSuf);
}

void IMVLFile::RmFolder(const string& dir)
{
	CleanFolder(dir);
	if (FolderExist(dir))
		;
		//RunProgram("Cmd.exe", format("/c rmdir /s /q \"%s\"", _S(dir)), true, false);
}

void IMVLFile::CleanFolder(const string& dir, bool subFolder)
{
	vector<string> names;
	int fNum = IMVLFile::GetNames(dir + "/*.*", names);
	for (int i = 0; i < fNum; i++)
		RmFile(dir + "/" + names[i]);

	vector<string> subFolders;
	int subNum = GetSubFolders(dir, subFolders);
	if (subFolder)
		for (int i = 0; i < subNum; i++)
			CleanFolder(dir + "/" + subFolders[i], true);
}

int IMVLFile::GetSubFolders(const string& folder, vector<string>& subFolders)
{
	subFolders.clear();
	WIN32_FIND_DATAA fileFindData;
	string nameWC = folder + "\\*";
	HANDLE hFind = ::FindFirstFileA(nameWC.c_str(), &fileFindData);
	if (hFind == INVALID_HANDLE_VALUE)
		return 0;

	do {
		if (fileFindData.cFileName[0] == '.')
			continue; // filter the '..' and '.' in the path
		if (fileFindData.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
			subFolders.push_back(fileFindData.cFileName);
	} while (::FindNextFileA(hFind, &fileFindData));
	FindClose(hFind);
	return (int)subFolders.size();
}

// Get image names from a wildcard. Eg: GetNames("D:\\*.jpg", imgNames);
// Will skip the subfolder.
int IMVLFile::GetNames(const string &nameW, vector<string> &names, string &dir)
{
	dir = GetFolder(nameW);
	names.clear();
	names.reserve(10000);
	WIN32_FIND_DATAA fileFindData;
	HANDLE hFind = ::FindFirstFileA(_S(nameW), &fileFindData);
	if (hFind == INVALID_HANDLE_VALUE)
		return 0;

	do{
		if (fileFindData.cFileName[0] == '.')
			continue; // filter the '..' and '.' in the path
		if (fileFindData.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
			continue; // Ignore sub-folders
		names.push_back(fileFindData.cFileName);
	} while (::FindNextFileA(hFind, &fileFindData));
	FindClose(hFind);
	return (int)names.size();
}

// Function : Get all the 'fileW' type file's name in the rootFolder, 
// include the subFolder
// args: fileW: file type filter
// Eg : GetNames("D:\\", "*.jpg", names)
int IMVLFile::GetNames(const string& rootFolder, const string &fileW, vector<string> &names)
{
	GetNames(rootFolder + fileW, names);
	vector<string> subFolders, tmpNames;
	int subNum = IMVLFile::GetSubFolders(rootFolder, subFolders);
	for (int i = 0; i < subNum; i++){
		subFolders[i] += "/";
		int subNum = GetNames(rootFolder + subFolders[i], fileW, tmpNames);
		for (int j = 0; j < subNum; j++)
			names.push_back(subFolders[i] + tmpNames[j]);
	}
	return (int)names.size();
}

// NE for No extension
int IMVLFile::GetNamesNE(const string& nameWC, vector<string> &names, string &dir, string &ext)
{
	int fNum = GetNames(nameWC, names, dir);
	ext = GetExtention(nameWC);
	for (int i = 0; i < fNum; i++)
		names[i] = GetNameNE(names[i]);
	return fNum;
}

// NE for No extension
int IMVLFile::GetNamesNE(const string& rootFolder, const string &fileW, vector<string> &names)
{
	int fNum = GetNames(rootFolder, fileW, names);
	int extS = (int)GetExtention(fileW).size();
	for (int i = 0; i < fNum; i++)
		names[i].resize(names[i].size() - extS);
	return fNum;
}

int IMVLFile::GetNamesNoSuffix(const string& nameWC, vector<string> &namesNS, const string suffix, string &dir)
{
	int fNum = IMVLFile::GetNames(nameWC, namesNS, dir);
	for (int i = 0; i < fNum; i++)
		namesNS[i] = GetNameNoSuffix(namesNS[i], suffix);
	return fNum;
}

BOOL IMVLFile::Move2Dir(const string &srcW, const string dstDir)
{
	vector<string> names;
	string inDir;
	int fNum = IMVLFile::GetNames(srcW, names, inDir);
	BOOL r = TRUE;
	for (int i = 0; i < fNum; i++)	
		if (Move(inDir + names[i], dstDir + names[i]) == FALSE)
			r = FALSE;
	return r;
}

BOOL IMVLFile::Copy2Dir(const string &srcW, const string dstDir)
{
	vector<string> names;
	string inDir;
	int fNum = IMVLFile::GetNames(srcW, names, inDir);
	BOOL r = TRUE;
	for (int i = 0; i < fNum; i++)	
		if (Copy(inDir + names[i], dstDir + names[i]) == FALSE)
			r = FALSE;
	return r;
}


void IMVLFile::AppendStr(const string fileName, const string str)
{
	FILE *f = fopen(_S(fileName), "a");
	if (f == NULL){
		printf("File %s can't be opened\n", _S(fileName));
		return;
	}
	fprintf(f, "%s", _S(str));
	fclose(f);
}


string IMVLFile::GetCompName() 
{
	char buf[1024];
	DWORD dwCompNameLen = 1024;
	GetComputerNameA(buf, &dwCompNameLen);
	return string(buf);
}


int IMVLFile::TellFileSize(const string fullfilepath)
{
	const char* filepath = const_cast<char*>(fullfilepath.c_str());
	struct _stat info;
	_stat(filepath, &info);
	int size = info.st_size;	
	return size; //Bytes
}


void IMVLFile::WriteLog(string file_name, string text)
{
	ofstream file;
	file.open(file_name, ios::app);
	if(!file.is_open())
	{
		cerr<<"找不到文件！"<<endl;
	}
	file<<text;	
	file.close();
}
