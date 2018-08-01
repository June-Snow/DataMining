// 性能最高，其数组和像素一一对应
 /*static void test1(Image img)
{
	Bitmap bmp = new Bitmap(img);
	BitmapData bitmapData = bmp.LockBits(new Rectangle(new Point(0, 0), img.Size), ImageLockMode.ReadWrite, PixelFormat.Format24bppRgb);

	byte[] BGRValues = new byte[bitmapData.Stride * bitmapData.Height];

	IntPtr Ptr = bitmapData.Scan0;
	System.Runtime.InteropServices.Marshal.Copy(Ptr, BGRValues, 0, BGRValues.Length);

	bmp.UnlockBits(bitmapData);
}*/
/******************************************************
* Copyright (c) 
* 
* Current Version : 1.0
* Author          : OleNet
* Email           : issacc.me@gmail.com 
* Create Date     : 2013/5/17
* Created by OleNet, 2013/5/17, Directed by Chen Li
*
* Alter History: 
*			Author:OleNet:2013/5/23, Directed by Chen Li
*			改动范围：让代码更加规范
* Alter History: 
*			Author:OleNet:2013/11/27, Directed by Chen Li
*			改动范围：

******************************************************/

/*#include <stdio.h>
#include "stripe_main.h"


#define BORDER		(8)
const int TSCORE = 60;

int global_TBrightAVG;
double global_TROWSTDRATE;
double global_T_Sym_YMIN;


typedef struct ProjInfo
{
	double* px;
	double max_px_v;
	int max_px_pos;

	double* py;
	double max_py_v;
	int max_py_pos;	

	double avg_v;
}ProjInfo;

typedef struct SVMData
{
	int stdpos;
	int avgpos;
	double max_py_v;

	double avg_v;
	int xnum;
}SVMData;
SVMData sSvmdata;


static void GetImgRowAvg(const IplImage* pImgColor, int row, double* vavg);
static void	GetProjInfo(const IplImage* pImgGray, ProjInfo* p);



static void GetImgRectAvg(const IplImage* pImgColor, CvRect r, double* vavg)
{
	uchar* ptr;
	int sum;
	int i, j;

	sum = 0;
	for (i= r.y; i<r.y+r.height; i++)
	{
		ptr = (uchar*)(pImgColor->imageData +i*pImgColor->widthStep);
		for (j=r.x; j<r.x+r.width; j++)
		{ 
			sum += *(ptr++);
			sum += *(ptr++);
			sum += *(ptr++);
		}
	}
	*vavg = sum/(r.height*r.width*3);
}

static void	GetProjInfo(const IplImage* pImgGray, ProjInfo* p)
{
	const int width = pImgGray->width;
	const int height = pImgGray->height;

	double* px = p->px;
	double* py = p->py;
	uchar* ptr;

	double avgV, maxV;
	int maxID;
	int i, j;

	memset(py, 0, sizeof(double)*height);
	for (i=0; i<height; i++)
	{
		ptr = (uchar*)(pImgGray->imageData + i*pImgGray->widthStep);		
		for (j=0; j<width; j++)
		{ 
			py[i] += (double)ptr[j];
		}
	}
	for (i=0; i<height; i++)
	{
		py[i] = (py[i]/width);
	}

	//////////////////////////////////////////////////////////////////////////
	memset(px, 0, sizeof(double)*width);
	for (i=0; i<height; i++)
	{
		ptr = (uchar*)(pImgGray->imageData +i*pImgGray->widthStep);		
		for (j=0; j<width; j++)
		{ 
			px[j] += (double)ptr[j];
		}
	}
	for (j=0; j<width; j++)
	{
		px[j] = (px[j]/height);	
	}

	GetVecMax(py, height, &maxV, &maxID);	
	p->max_py_v = maxV;
	p->max_py_pos = maxID;

	GetVecMax(px, width, &maxV, &maxID);	
	p->max_px_v = maxV;
	p->max_px_pos = maxID;

	GetVecAvg(px, width, &avgV);
	p->avg_v = avgV;
}*/
