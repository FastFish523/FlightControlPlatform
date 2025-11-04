#include<math.h>
#include<stdio.h>
#include "GeneralVarFun.h"


/*
*函数介绍：
	INITIALIZATION_KF_COM() 卡尔曼滤波器初始化函数
*输入参数：
	无
*输出参数：
	com_Xk			状态变量(全局变量)
	com_Pk			方差阵(全局变量)
	com_QQ			过程噪声阵(全局变量)
	com_RR			测量噪声阵(全局变量)
*返回值：
	无	
*/
void INITIALIZATION_KF_COM(void)
{
	int k1,k2;

	for(k1 = 0; k1 < kno1; k1++)
	{
		for(k2 = 0; k2 < kno1; k2++)
		{
			com_Pk[k1][k2]    = 0.0;
			com_Pkk_1[k1][k2] = 0.0;
		}
	}
	for(k1 = 0; k1 < kno1; k1++)
		for(k2 = 0; k2 < kno3; k2++)
			com_Kk[k1][k2] = 0.0;     

	for(k1 = 0; k1 < kno2; k1++)
		for(k2 = 0; k2 < kno2; k2++)
			com_QQ[k1][k2] = 0.0;

	for(k1 = 0; k1 < kno3; k1++)
		for(k2 = 0; k2 < kno3; k2++)
			com_RR[k1][k2] = 0.0;

	com_Xk[0] = 60.0*1.5/60.0*DEGTORAD; 
	com_Xk[1] = 60.0*1.0/60.0*DEGTORAD; 	
	com_Xk[2] = 1.5*60.0/60.0*DEGTORAD;       //angel erro   Raylion  e n u
	com_Xk[3] = 0.1;             
	com_Xk[4] = 0.1; 
	com_Xk[5] = 10*0.05;               
	com_Xk[6] = 0.00001; 
	com_Xk[7] = 0.00001;               
	com_Xk[8] = 10.0; 

	for(k1 = 0; k1 < kno1; k1++)
		com_Pk[k1][k1] = com_Xk[k1] * com_Xk[k1];
	for(k1=0;k1<kno1;k1++)
		com_Pkk_1[k1][k1] = com_Pk[k1][k1];

	com_QQ[0][0]=5.29e-6;     com_QQ[1][1]=5.29e-6;   com_QQ[2][2]=5.29e-6; 
	com_QQ[3][3]=2.5e-1;      com_QQ[4][4]=2.5e-1;   com_QQ[5][5]=2.5e-1;

  	com_RR[0][0] = 100;  	   com_RR[1][1] = 100;  	com_RR[2][2] = 400;  	
	com_RR[3][3] = 1.0e-2;     com_RR[4][4] = 1.0e-2;   com_RR[5][5] = 1.0e-2;

  
	com_Xk[0] = 0.0;	 	com_Xk[1] = 0.0;    com_Xk[2] = 0.0;     
	com_Xk[3] = 0.0;    	com_Xk[4] = 0.0;    com_Xk[5] = 0.0;               
	com_Xk[6] = 0.0; 	    com_Xk[7] = 0.0;    com_Xk[8] = 0.0;      


	for(k1=0;k1<kno2;k1++) 
	      com_QQ[k1][k1]=com_QQ[k1][k1]/f_KF_Periods;
	      
	for(k1=0;k1<kno3;k1++) 
	      com_RR[k1][k1]=com_RR[k1][k1]/f_KF_Periods;

	return;
} 

