#include<opencv2\opencv.hpp>
#include<iostream>
#include<stdio.h>
#include<cmath>

using namespace std;
using namespace cv;

double *GaussianTemplate(int TemSize,double sigma)
{
	if(sigma==0)
		return(0);
	if(TemSize == 1)
	{	
		return(0);
	}

	//计算高斯核矩阵
	double *TemNew = new double[TemSize*TemSize];
	double scale = -0.5/(sigma*sigma);
	const double PI = 3.141592653;
	double cons = -scale/PI;

	double sum = 0;

	for(int i = 0; i < TemSize; i++)
	{
		for(int j = 0; j < TemSize; j++)
		{
			int x = i-(TemSize-1)/2;
			int y = j-(TemSize-1)/2;
			TemNew[i*TemSize + j] = cons * exp(scale * (x*x + y*y));

			sum += TemNew[i*TemSize+j];
			//			cout << " " << kernel[i*ksize + j];
		}
		//		cout <<endl;
	}
	//归一化
	for(int i = TemSize*TemSize-1; i >=0; i--)
	{
		*(TemNew+i) /= sum;
	}
	return(TemNew);
}
int main()
{
	int TemSize;
	double sigma;
	double *TemMat;
	cout<<"输入模板方正大小：正态分布方差："<<endl;
	cin>>TemSize>>sigma;
	TemMat=GaussianTemplate(TemSize,sigma);
	cout<<*TemMat<<"   ";
}