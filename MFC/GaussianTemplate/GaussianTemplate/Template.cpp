#include"gaussianblur.h "
#include<opencv2\opencv.hpp>
#include <iostream>
#include<stdio.h>
#include<string>
#include<cmath>
#include<algorithm>
#include<cstdlib>
#include<vector>
using namespace cv;
using namespace std;

#define PI 3.141592653

extern IplImage* img;

vector<CvMat> GaussianTemplate(const int row,double sigma)
{
	double scale = -0.5/(sigma*sigma);
	double cons = -scale/PI;
	double uint = 0,num = 0,sum = 0;
	vector<CvMat> matTem;
	vector<CvMat>::iterator iter = matTem.begin ();
	//vector<double>mat;
	for(int i=0;i<2*row+1;i++)
	{
		for(int j=0;j<2*row+1;j++)
		{
			num=(i-row)*(i-row)+(j-row)*(j-row);
			//cout<<num<<"";
			uint=cons*exp(-(num)/(-scale));
			matTem.push_back();
			//cout<<uint<<"   ";
			sum+=uint;
		}
	}
	for(vector<CvMat>::iterator iter=matTem.begin();iter!=matTem.end();++iter )
	{
		*iter=*iter/sum;
	}

	return(matTem);
}

vector<CvMat> MatCha(CvMat *mat,int row)
{
	//vector<double>::iterator iterblue;
	vector<CvMat>vec((img->height+2*row)*(img->width+2*row)) ;
	//double *mat=new double[m+2*row][n+2*row];
	for(int i=row;i<img->height+row;++i)
	{
		for(int j=row;j<img->width+row;++j)
		{
			vec.push_back( *mat++);
		}
	}
	
	return(vec);
}

double Gaussianblue(vector<double> VecTem,vector<double> VecMat,float *Mat,int row)
{
	double num;
	for(int k=row;k<img->height+row;++k)
	{
		for(int l=row;l<img->width+row;++l)
		{
			for(int i=0;i<2*row+1;i++)
			{
				for(int j=0;j<2*row+1;j++)
				{
					num+=VecMat[(l-row)*(img->width+2*row)+i*(img->width+2*row)+l-row+j]*VecTem[(i)*(2*row+1)+(j)];
				}
			}
			*Mat=num;
			Mat++;
		}
	}
	return(0);
}
int main()
{
	//double n,m;
	int row=0,col=0;
	double sigma;
	cout<<"输入模板方正大小：正态分布方差："<<endl;
	cin>>row>>sigma;
	 
	/*cout<<"进入系统----------->"<<endl;
	//1、读入150*130灰度图片，将矩阵拉成一行
	IplImage* img = cvLoadImage("F:\\MtalabPicture\\6.jpg",0);
	cout<<"----------------------图片加载成功!--------------------"<<endl;
	CvMat* imgMat = cvCreateMat(img->height,img->width,CV_32FC1);//定义一个指向CvMat对象的指针,CV_32FC1,32位浮点数，一通道
	cvConvert(img,imgMat);

	cout<<"图像转换成矩阵成功！"<<endl;
	CvMat row_header, *Row;
	Row = cvReshape( imgMat, &row_header, 0, 1 );
	cvNamedWindow("window",CV_WINDOW_AUTOSIZE);
	cvShowImage("window",img);
	cvWaitKey(0);
	cvReleaseImage(&img);
	cvDestroyWindow("window");
	*/
	vector<double> VecTem;
	VecTem=GaussianTemplate(row,sigma);
	for(vector<double>::size_type ix=0;ix!=VecTem.size();++ix)
	{
		cout<<VecTem[ix]<<"  ";
	
		if(ix%row==0)
			cout<<endl;
	}
		//waitKey();
	
	//vector<double> VecMat;
	//VecMat=MatCha(Row, row);
	//double Gaussianblue(vector<double> VecTem,vector<double> VecMat,float *Mat,int row);

	return(0);
}
