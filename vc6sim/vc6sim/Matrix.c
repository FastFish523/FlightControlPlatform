#include<math.h>
#include "GeneralVarFun.h"



/*
*函数介绍：
	MATRIX_T(...) 矩阵转置
*输入参数：
	b_matrix			待转矩阵
	krow				行数
	kline				列数
*输出参数：
	a_matrix			转后矩阵
*返回值：
	无	
*/

void MATRIX_T(float *a_matrix,float *b_matrix,int krow,int kline)
{
int k, k2;
  for( k = 0; k < krow; k++ )
	for( k2 = 0; k2 < kline; k2++ )
	   *(a_matrix + (k2*krow) + k) = *(b_matrix + k*kline + k2);
  return;
}

/*
*函数介绍：
	MATRIX_A(...) 矩阵相加
*输入参数：
	b_matrix			待加矩阵
	c_matrix			待加矩阵
	krow				行数
	kline				列数
	ktrl				加/减控制
*输出参数：
	a_matrix			加后矩阵
*返回值：
	无	
*/
void MATRIX_A(float *a_matrix,float *b_matrix,float *c_matrix,int krow,int kline,int ktrl)
{
int k, k2;


	for( k = 0; k < krow; k++ )
	for( k2 = 0; k2 < kline; k2++ )
	   *(a_matrix + (k * kline) + k2) = *(b_matrix + (k*kline) + k2)
	   								   + ( (ktrl > 0)?
	   								   	 	  *(c_matrix + (k*kline) + k2)
	   								   		: -*(c_matrix + (k*kline) + k2));
  return;
}


/*
*函数介绍：
	MATRIX_M(...) 矩阵相乘
*输入参数：
	b_matrix			待乘矩阵
	c_matrix			待乘矩阵
	krow				行数
	kmiddle				列数/行数
	kline				列数
	ktrl				加/减控制
*输出参数：
	a_matrix			乘后矩阵
*返回值：
	无	
*/
void MATRIX_M(float *a_matrix,float *b_matrix,float *c_matrix,int krow,int kline,int kmiddle,int ktrl)
{
int k, k2, k4;
float stmp;
  for( k=0; k<krow; k++ ) 
  {
	for( k2=0; k2<kline; k2++ )
	{
		 stmp=0.0;
		 for( k4=0; k4<kmiddle; k4++ )
		 {
		  if( *(b_matrix + (k*kmiddle) + k4) == 0.0
		  	  || *(c_matrix + (k4*kline) + k2) == 0.0 ) 
		  continue;
		  
		  stmp += (*(b_matrix + k*kmiddle + k4)) * (*(c_matrix + (k4*kline) + k2));
	     }
	     
		 *(a_matrix + (k*kline) + k2)=( ( ktrl>0 )? stmp: -stmp );
	}
  }
  return;
}


/****************************************************************
** 函 数 名: MATRIX_INV(...)
** 功能描述: 矩阵求逆
** 输入参数: a[] - n 维矩阵
             n - 输入矩阵的维数
** 输出参数: a[] - 输入矩阵求逆后自身发生改变
** 返回参数: 求逆的状态, 1 - 正常, 其他 - 错误
****************************************************************/
int MATRIX_INV(float a[], int n)
{
	int *is, *js, i, j, k, l, u, v;
	float d,p;

	is = (int*)malloc(n*sizeof(int));
	js = (int*)malloc(n*sizeof(int));

	for(k=0; k<=n-1; k++)
	{
		d = 0.0;
		for (i=k; i<=n-1; i++)
			for (j=k; j<=n-1; j++)
			{
				l = i*n + j;
				p = (float)fabs(a[l]);
				if (p>d)
				{
					d = p;
					is[k] = i;
					js[k] = j;
				}
			}
		if (d + 1.0 == 1.0)
		{
			free(is);
			free(js);
			return(0);
		}
		if (is[k] != k)
			for (j=0; j<=n-1; j++)
			{
				u = k*n + j;
				v = is[k]*n + j;
				p = a[u];

				a[u] = a[v];
				a[v] = p;
			}
		if (js[k]!=k)
			for (i=0; i<=n-1; i++)
			{
				u = i*n + k;
				v = i*n + js[k];
				p = a[u];
				a[u] = a[v];
				a[v]=p;
			}
		l = k*n + k;
		a[l] = 1/a[l];
		for (j=0; j<=n-1; j++)
			if (j!=k)
			{
				u = k*n + j;
				a[u] = a[u]*a[l];
			}
		for (i=0; i<=n-1; i++)
			if (i!=k)
				for (j=0; j<=n-1; j++)
					if (j!=k)
					{
						u = i*n + j;
						a[u] = a[u] - a[i*n+k]*a[k*n+j];
					}
		for (i=0; i<=n-1; i++)
			if (i!=k)
			{
				u = i*n + k;
				a[u] = -a[u]*a[l];
			}
	}
	for (k=n-1; k>=0; k--)
	{ 
		if (js[k] != k)
			for (j=0; j<=n-1; j++)
			{
				u = k*n + j;
				v = js[k]*n + j;
				p = a[u];
				a[u] = a[v];
				a[v] = p;
			}
		if (is[k]!=k)
			for (i=0; i<=n-1; i++)
			{
				u = i*n + k; v = i*n + is[k];
				p = a[u];
				a[u] = a[v];
				a[v] = p;
			}
	}
	free(is);
	free(js);
	return(1);
}
