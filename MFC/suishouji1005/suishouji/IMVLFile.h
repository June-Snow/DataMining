#pragma once

#define _S(str) ((str).c_str())
#define _QS(str) (QString(_S(str)))

#ifdef IMVLAPI
#else
#define IMVLAPI _declspec(dllexport)
#endif


#include <strstream>
#include <vector>
#include "stdio.h"
#include <assert.h>
#include <string>
#include <xstring>
#include <map>
#include <functional>
#include <algorithm>
#include <iostream>
#include <exception>
#include <cmath>
#include <time.h>
#include <set>
#include <queue>
#include <list>
#include <limits>
#include <fstream>
#include <sstream>
#include <random>
#include <atlstr.h>
#include <atltypes.h>
#include <omp.h>
using namespace std;




using namespace std;

class IMVLAPI IMVLFile
{
private:

public:
	IMVLFile();

	static string BrowseFile(const char* strFilter = "Images (*.jpg;*.png)\0*.jpg;*.png\0All (*.*)\0*.*\0\0", bool isOpen = true);
 	static string BrowseFolder(); 

	static inline string GetFolder(const string& path);
	static inline string GetSubFolder(const string& path);
	static inline string GetName(const string& path);
	static inline string GetNameNE(const string& path);// what's NE?
	static inline string GetPathNE(const string& path);
	static inline string GetNameNoSuffix(const string& path, const string &suffix);

	// Get file names from a wildcard. Eg: GetNames("D:\\*.jpg", imgNames);
	static int GetNames(const string &nameW, vector<string> &names, string &dir);
	static int GetNames(const string &nameW, vector<string> &names){string dir; return GetNames(nameW, names, dir);};
	static int GetNames(const string& rootFolder, const string &fileW, vector<string> &names);
	static int GetNamesNE(const string& nameWC, vector<string> &names, string &dir, string &ext);
	static int GetNamesNE(const string& rootFolder, const string &fileW, vector<string> &names);
	static int GetNamesNE(const string& nameWC, vector<string> &names) {string dir, ext; return GetNamesNE(nameWC, names, dir, ext);} // what's nameWC? is it a wide char?
	static int GetNamesNoSuffix(const string& nameWC, vector<string> &namesNS, const string suffix, string &dir); //e.g. suffix = "_C.jpg" // then what's the nameNS
	static int GetNamesNoSuffix(const string& nameWC, vector<string> &namesNS, const string suffix) {string dir; return GetNamesNoSuffix(nameWC, namesNS, suffix, dir);}

	static inline string GetExtention(const string name);

	static inline bool FileExist(const string& filePath);
	static inline bool FilesExist(const string& fileW);
	static inline bool FolderExist(const string& strPath);

	static inline string GetWkDir();

	static BOOL MkDir(const string&  path);

	// Eg: RenameImages("D:/DogImages/*.jpg", "F:/Images", "dog", ".jpg");
	static int Rename(const string& srcNames, const string& dstDir, const char* nameCommon, const char* nameExt);
	static void RenameSuffix(const string dir, const string orgSuf, const string dstSuf);

	// static int ChangeImgFormat(const string &imgW, const string dstW); // "./*.jpg", "./Out/%s_O.png"

	static inline void RmFile(const string& fileW);
	static void RmFolder(const string& dir);
	static void CleanFolder(const string& dir, bool subFolder = false);

	static int GetSubFolders(const string& folder, vector<string>& subFolders);
	static string GetFatherFolder(const string &folder) {return GetFolder(folder.substr(0, folder.size() - 1));}

	inline static BOOL Copy(const string &src, const string &dst, BOOL failIfExist = FALSE);
	inline static BOOL Move(const string &src, const string &dst, DWORD dwFlags = MOVEFILE_REPLACE_EXISTING | MOVEFILE_COPY_ALLOWED | MOVEFILE_WRITE_THROUGH);
	static BOOL Move2Dir(const string &srcW, const string dstDir);
	static BOOL Copy2Dir(const string &srcW, const string dstDir);

	static void WriteNullFile(const string& fileName) {FILE *f = fopen(_S(fileName), "w"); fclose(f);}
	static void AppendStr(const string fileName, const string str);

	static void ChkImgs(const string &imgW);

	static void RunProgram(const string &fileName, const string &parameters = "", bool waiteF = false, bool showW = true);
	static string GetCompName(); // Get the name of computer

	static void SegOmpThrdNum(double ratio = 0.8);

	// Copy files and add suffix. e.g. copyAddSuffix("./*.jpg", "./Imgs/", "_Img.jpg")
	static void copyAddSuffix(const string &srcW, const string &dstDir, const string &dstSuffix);

	static vector<string> loadStrList(const string &fName);
	
	static int TellFileSize(const string fullfilepath);

	static void WriteLog(string file_name, string text);

};


/************************************************************************/
/* Implementation of inline functions                                   */
/************************************************************************/
string IMVLFile::GetFolder(const string& path)
{
	return path.substr(0, path.find_last_of("\\/")+1);
}

string IMVLFile::GetSubFolder(const string& path)
{
	string folder = path.substr(0, path.find_last_of("\\/"));
	return folder.substr(folder.find_last_of("\\/")+1);
}

string IMVLFile::GetName(const string& path)
{
	int start = path.find_last_of("\\/")+1;
	int end = path.find_last_not_of(' ')+1;
	return path.substr(start, end - start);
}

string IMVLFile::GetNameNE(const string& path)
{
	int start = path.find_last_of("\\/")+1;
	int end = path.find_last_of('.');
	if (end >= 0)
		return path.substr(start, end - start);
	else
		return path.substr(start,  path.find_last_not_of(' ')+1 - start);
}

string IMVLFile::GetNameNoSuffix(const string& path, const string &suffix)
{
	int start = path.find_last_of("\\/")+1;
	int end = path.size() - suffix.size();
	// CV_Assert(path.substr(end) == suffix);
	if (end >= 0)
		return path.substr(start, end - start);
	else
		return path.substr(start,  path.find_last_not_of(' ')+1 - start);	
}

string IMVLFile::GetPathNE(const string& path)
{
	int end = path.find_last_of('.');
	if (end >= 0)
		return path.substr(0, end);
	else
		return path.substr(0,  path.find_last_not_of(' ') + 1);
}

string IMVLFile::GetExtention(const string name)
{
	return name.substr(name.find_last_of('.'));
}

BOOL IMVLFile::Copy(const string &src, const string &dst, BOOL failIfExist)
{
	return ::CopyFileA(src.c_str(), dst.c_str(), failIfExist);
}

BOOL IMVLFile::Move(const string &src, const string &dst, DWORD dwFlags)
{
	return MoveFileExA(src.c_str(), dst.c_str(), dwFlags);
}

void IMVLFile::RmFile(const string& fileW)
{ 
	vector<string> names;
	string dir;
	int fNum = IMVLFile::GetNames(fileW, names, dir);
	for (int i = 0; i < fNum; i++)
		::DeleteFileA(_S(dir + names[i]));
}


//Test whether a file exist
bool IMVLFile::FileExist(const string& filePath)
{
	if (filePath.size() == 0)
		return false;
	DWORD attr = GetFileAttributesA(_S(filePath));
	return attr == FILE_ATTRIBUTE_NORMAL ||  attr == FILE_ATTRIBUTE_ARCHIVE;//GetLastError() != ERROR_FILE_NOT_FOUND;
}

bool IMVLFile::FilesExist(const string& fileW)
{
	vector<string> names;
	int fNum = GetNames(fileW, names);
	return fNum > 0;
}

string IMVLFile::GetWkDir()
{	
	string wd;
	wd.resize(1024);
	DWORD len = GetCurrentDirectoryA(1024, &wd[0]);
	wd.resize(len);
	return wd;
}

bool IMVLFile::FolderExist(const string& strPath)
{
	int i = (int)strPath.size() - 1;
	for (; i >= 0 && (strPath[i] == '\\' || strPath[i] == '/'); i--)
		;
	string str = strPath.substr(0, i+1);

	WIN32_FIND_DATAA  wfd;
	HANDLE hFind = FindFirstFileA(_S(str), &wfd);
	bool rValue = (hFind != INVALID_HANDLE_VALUE) && (wfd.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY);   
	FindClose(hFind);
	return rValue;
}

/************************************************************************/
/*                   Implementations                                    */
/************************************************************************/