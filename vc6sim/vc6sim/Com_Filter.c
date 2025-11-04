#include<math.h>
#include<stdio.h>
#include "GeneralVarFun.h"



#define PI 3.14159265358979323
/*
*函数介绍：
	KALMAN_FILTER_COM() 组合导航卡尔曼滤波器函数
*输入参数：
	d_Posi_KF_COM	即时位置(全局变量)
	f_Vnc_KF_COM    即时速度(全局变量)
	f_Fn_KF_COM		加速度(全局变量)
*输出参数：
	com_Xk			状态变量(全局变量)
	com_Pk			方差阵(全局变量)
*返回值：
	无	
*/
void KALMAN_FILTER_COM()
{
	int k1,k2,k3,k4;
	float f_slati,f_clati,f_tlati;
	
	if(i_KF_Init_Flag_COM == 0)
	{
	   INITIALIZATION_KF_COM();
	   i_KF_Init_Flag_COM =1;
    }   
	if(i_KF_Init_Flag_COM == 1)
	{	
		for(k1=0;k1<kno1;k1++)     
		{
			for(k2=0;k2<kno1;k2++)   com_sys_a[k1][k2] = 0.0;
			for(k2=0;k2<kno2;k2++)   com_sys_g[k1][k2] = 0.0;
			for(k2=0;k2<kno3;k2++)   com_sys_h[k2][k1] = 0.0;
		}
			
		f_slati = sin(d_Posi_KF_COM[1]);
		f_clati = cos(d_Posi_KF_COM[1]);
		f_tlati = tan(d_Posi_KF_COM[1]);


		d_EarthR_M = EARTHR * (1 - 2*E + 3*E*sin(d_Posi_KF_COM[1])*sin(d_Posi_KF_COM[1]));
		d_EarthR_N = EARTHR * (1 + E*sin(d_Posi_KF_COM[1])*sin(d_Posi_KF_COM[1]));
		f_H = d_Posi_KF_COM[2];

		com_sys_a[0][1] = WIE*f_slati + f_Vnc_KF_COM[0]*f_tlati/(d_EarthR_N + f_H);
		com_sys_a[0][2] = -(WIE*f_clati + f_Vnc_KF_COM[0] / (d_EarthR_N + f_H));
		com_sys_a[0][4] = -1.0 / (d_EarthR_M + f_H);

		com_sys_a[1][0] = -(WIE*f_slati+f_Vnc_KF_COM[0]*f_tlati/(d_EarthR_N+f_H));
		com_sys_a[1][2] = -f_Vnc_KF_COM[1]/(d_EarthR_M+f_H);
		com_sys_a[1][3] = 1.0/(d_EarthR_N+f_H);
		com_sys_a[1][7] = -WIE*f_slati;

		com_sys_a[2][0] = WIE*f_clati+f_Vnc_KF_COM[0]/(d_EarthR_N+f_H);
		com_sys_a[2][1] = f_Vnc_KF_COM[1]/(d_EarthR_M+f_H);
		com_sys_a[2][3] = f_tlati/(d_EarthR_N+f_H);
		com_sys_a[2][7] = WIE*f_clati+f_Vnc_KF_COM[0]/(d_EarthR_N+f_H)/f_clati/f_clati;


		com_sys_a[3][1] = -f_Fn_KF_COM[2];
		com_sys_a[3][2] = f_Fn_KF_COM[1];   	
		com_sys_a[3][3] = -f_Vnc_KF_COM[2]/(d_EarthR_M+f_H)+f_Vnc_KF_COM[1]*f_tlati/(d_EarthR_M+f_H);
		com_sys_a[3][4] = 2.0*WIE*f_slati+f_Vnc_KF_COM[0]*f_tlati/(d_EarthR_N+f_H);
		com_sys_a[3][5] = -2.0*WIE*f_clati-f_Vnc_KF_COM[0]/(d_EarthR_N+f_H);
		com_sys_a[3][7] = 2.0*WIE*f_Vnc_KF_COM[1]*f_clati+f_Vnc_KF_COM[0]*f_Vnc_KF_COM[1]/(d_EarthR_N+f_H)/f_clati/f_clati+2.0*WIE*f_Vnc_KF_COM[2]*f_slati;

		com_sys_a[4][0] = f_Fn_KF_COM[2];
		com_sys_a[4][2] = -f_Fn_KF_COM[0];	
		com_sys_a[4][3] = -2.0*(f_Vnc_KF_COM[0]*f_tlati/(d_EarthR_N+f_H)+WIE*f_slati);
		com_sys_a[4][4] = -f_Vnc_KF_COM[2]/(d_EarthR_M+f_H);	
		com_sys_a[4][5] = -f_Vnc_KF_COM[1]/(d_EarthR_M+f_H);
		com_sys_a[4][7] = -(2.0*WIE*f_clati+f_Vnc_KF_COM[0]/(d_EarthR_N+f_H)/f_clati/f_clati)*f_Vnc_KF_COM[0];

		com_sys_a[5][0] = -f_Fn_KF_COM[1];
		com_sys_a[5][1] = f_Fn_KF_COM[0];	
		com_sys_a[5][3] = 2.0*(f_Vnc_KF_COM[0]/(d_EarthR_N+f_H)+WIE*f_clati);
		com_sys_a[5][4] = 2.0*f_Vnc_KF_COM[1]/(d_EarthR_M+f_H);	
		com_sys_a[5][7] = -2.0*WIE*f_Vnc_KF_COM[0]*f_slati;
		
		com_sys_a[6][3] = 1.0/f_clati/(d_EarthR_N+f_H);
		com_sys_a[6][7] = f_Vnc_KF_COM[0]*f_tlati/(d_EarthR_N+f_H)/f_clati;	
		
		com_sys_a[7][4] = 1.0/(d_EarthR_M+f_H);
		
		com_sys_a[8][5] = 1.0;
	
		
		com_sys_g[0][0] = -f_Cbn_COM[0][0];  com_sys_g[0][1] = -f_Cbn_COM[0][1];  com_sys_g[0][2] = -f_Cbn_COM[0][2];
		com_sys_g[1][0] = -f_Cbn_COM[1][0];  com_sys_g[1][1] = -f_Cbn_COM[1][1];  com_sys_g[1][2] = -f_Cbn_COM[1][2];
		com_sys_g[2][0] = -f_Cbn_COM[2][0];  com_sys_g[2][1] = -f_Cbn_COM[2][1];  com_sys_g[2][2] = -f_Cbn_COM[2][2];

		com_sys_g[3][3] = f_Cbn_COM[0][0];   com_sys_g[3][4] = f_Cbn_COM[0][1];   com_sys_g[3][5] = f_Cbn_COM[0][2];
		com_sys_g[4][3] = f_Cbn_COM[1][0];   com_sys_g[4][4] = f_Cbn_COM[1][1];   com_sys_g[4][5] = f_Cbn_COM[1][2];
		com_sys_g[5][3] = f_Cbn_COM[2][0];   com_sys_g[5][4] = f_Cbn_COM[2][1];   com_sys_g[5][5] = f_Cbn_COM[2][2];	
	

		com_sys_h[0][6] = 1.0*(d_EarthR_N+f_H)*f_clati;
		com_sys_h[1][7] = 1.0*(d_EarthR_M+f_H);
		com_sys_h[2][8] = 1.0;
		com_sys_h[3][3] = 1.0;
		com_sys_h[4][4] = 1.0;
		com_sys_h[5][5] = 1.0;

		for( k1=0; k1<kno1; k1++)
		{
			for(k2=0;k2<kno1;k2++) com_disaT[k1][k2]=com_sys_a[k1][k2]=com_sys_a[k1][k2]*f_KF_Periods;  
			for(k2=0;k2<kno2;k2++) com_disgT[k1][k2]=com_sys_g[k1][k2]*f_KF_Periods;
		}

		for( k3=2; k3<4; k3++ )
		{
			k4=(float)(5-k3);
			for( k1=0; k1<kno1; k1++ )
			{
				for( k2=0; k2<kno1; k2++ )    com_distemp[k1][k2]=com_sys_a[k1][k2]/k4;
				com_distemp[k1][k1]=1.0+com_distemp[k1][k1];
			}
			MATRIX_M(com_sys_a, com_disaT, com_distemp, kno1, kno1, kno1, 1 );
		}
		MATRIX_M( com_sys_g, com_distemp, com_disgT, kno1, kno2, kno1, 1 );
		for(k1=0;k1<kno1;k1++)	
		{
			com_sys_a[k1][k1]=1.0+com_sys_a[k1][k1];
		}
			
		com_Z_measure[0] = (d_Posi_KF_COM[0]-d_Gps_Long)*(d_EarthR_N+f_H)*f_clati+f_Rn_pole_KF_COM[0];
		com_Z_measure[1] = (d_Posi_KF_COM[1]-d_Gps_Lat)*(d_EarthR_M+f_H)+f_Rn_pole_KF_COM[1];
		com_Z_measure[2] = (d_Posi_KF_COM[2]-(f_Gps_Alt-f_Rn_pole_KF_COM[2]));			
		com_Z_measure[3] = (f_Vnc_KF_COM[0]-(f_Gps_Ve-f_Vn_pole_KF_COM[0]));
		com_Z_measure[4] = (f_Vnc_KF_COM[1]-(f_Gps_Vn-f_Vn_pole_KF_COM[1]));
		com_Z_measure[5] = (f_Vnc_KF_COM[2]-(f_Gps_Vu-f_Vn_pole_KF_COM[2]));


		MATRIX_T( com_tmpe,  com_sys_a, kno1, kno1 );                         
		MATRIX_M( com_tmpf,  com_Pk, com_tmpe, kno1, kno1, kno1, 1 );         
		MATRIX_M( com_tmpfk, com_sys_a, com_tmpf, kno1, kno1, kno1, 1 );      
		MATRIX_T( com_tmpbz, com_sys_g, kno1, kno2 );                          
		MATRIX_M( com_tmpfq, com_QQ, com_tmpbz, kno2, kno1, kno2, 1 );        
		MATRIX_M( com_tmpf,  com_sys_g, com_tmpfq, kno1, kno1, kno2, 1 );     
		MATRIX_A( com_Pkk_1, com_tmpf, com_tmpfk, kno1, kno1, 1 );            

		MATRIX_T( com_tmphz, com_sys_h, kno3, kno1);                        
		MATRIX_M( com_tmpgh, com_Pkk_1, com_tmphz, kno1, kno3, kno1, 1 );   
		MATRIX_M( com_tmpdz, com_sys_h, com_tmpgh, kno3, kno3, kno1, 1 );   
		MATRIX_A( com_tmpd, com_tmpdz, com_RR, kno3, kno3, 1 );              
		MATRIX_INV( com_tmpd, kno3 );                                        
		MATRIX_M( com_tmpgh, com_tmphz, com_tmpd, kno1, kno3, kno3, 1 );    
		MATRIX_M( com_Kk, com_Pkk_1, com_tmpgh, kno1, kno3, kno1, 1 );      

		MATRIX_M( com_tmpf, com_Kk, com_sys_h, kno1, kno1, kno3, -1 );   
		for( k1=0; k1<kno1; k1++ )    
		{
			com_tmpf[k1][k1] = com_tmpf[k1][k1]+1.0;      
		}
		
		
		MATRIX_T( com_tmpe,   com_tmpf, kno1, kno1 );                 
		MATRIX_M( com_tmpfk, com_Pkk_1, com_tmpe, kno1, kno1, kno1, 1 );
		MATRIX_M( com_tmpe,  com_tmpf, com_tmpfk, kno1, kno1, kno1, 1 ); 
		MATRIX_T( com_tmpakz,  com_Kk,  kno1, kno3 );                 
		MATRIX_M( com_tmpgk, com_RR, com_tmpakz, kno3, kno1, kno3, 1 ); 
		MATRIX_M( com_tmpfk, com_Kk, com_tmpgk, kno1, kno1, kno3, 1 );  
		MATRIX_A( com_Pk, com_tmpe, com_tmpfk, kno1, kno1, 1 );         

			
		MATRIX_M( com_Xkk_1, com_sys_a, com_Xk, kno1, 1, kno1, 1 );    
		MATRIX_M( com_hx, com_sys_h, com_Xkk_1, kno3, 1, kno1, 1 );    
		MATRIX_A( com_temp6, com_Z_measure, com_hx, kno3, 1,  -1 );    
		MATRIX_M( com_temp18, com_Kk, com_temp6, kno1, 1, kno3, 1 );   
		MATRIX_A( com_Xk, com_Xkk_1, com_temp18, kno1, 1, 1 );     	  
			
		f_KF_Phix_COM = com_Xk[0];	
		f_KF_Phiy_COM = com_Xk[1];		
		f_KF_Phiz_COM = com_Xk[2];			

//		交给总体室屏蔽此段							
		f_KF_Xk_COM[0] = com_Xk[0];
		f_KF_Xk_COM[1] = com_Xk[1];
		f_KF_Xk_COM[2] = com_Xk[2];
		f_KF_Xk_COM[3] = com_Xk[3];
		f_KF_Xk_COM[4] = com_Xk[4];
		f_KF_Xk_COM[5] = com_Xk[5];
		f_KF_Xk_COM[6] = com_Xk[6];
		f_KF_Xk_COM[7] = com_Xk[7];
		f_KF_Xk_COM[8] = com_Xk[8];
//		交给总体室屏蔽此段	
	    
	    
		KF_FEEDBACK_COM();

 	}	
    return;
}

/*
*函数介绍：
	KF_FEEDBACK_COM() 卡尔曼滤波反馈函数
*输入参数：
	d_Gps_Long		GPS经度(全局变量)
	d_Gps_Lat    	GPS纬度(全局变量)
	f_Gps_Alt		GPS高度(全局变量)
	f_Gps_Ve		GPS东速(全局变量)
	f_Gps_Vn		GPS北速(全局变量)
	f_Gps_Vu		GPS天速(全局变量)
	f_dPosix_Sum	GPS经度补偿量(全局变量)
	f_dPosiy_Sum	GPS纬度补偿量(全局变量)
	f_dPosiz_Sum	GPS高度补偿量(全局变量)
*输出参数：
	d_Posi_COM		补偿后的位置数据(全局变量)
	f_Vnc_COM		补偿后的速度数据(全局变量)
	f_Qu_COM		补偿后的姿态四元数(全局变量)
*返回值：
	无	
*/
void KF_FEEDBACK_COM(void)
{

		float tmpqu[4],tmpsum,tmpsqrtsum;
		float c01 = 0.0, c11 = 0.0, c20 = 0.0, c21 = 0.0, c22 = 0.0;
		float f_att[3];  
		float sp[3],cp[3];
	
		int k;
	
		/*
		for(k=0;k<2;k++)                        																																			
	    {
			f_Vnc_COM[k]  = f_Vnc_COM[k] -com_Xk[k+3][0]; 
			d_Posi_COM[k] = d_Posi_COM[k]-com_Xk[k+6][0];
	    }
		*/   
		/* 	
		//有杆臂补偿
		d_Posi_COM[0]=(d_Gps_Long-f_Rn_pole_KF_COM[0]/((d_EarthR_N+f_H)*cos(d_Posi_KF_COM[1])))+f_dPosix_Sum;  
		d_Posi_COM[1]=(d_Gps_Lat-f_Rn_pole_KF_COM[1]/(d_EarthR_M+f_H))+f_dPosiy_Sum; 
		d_Posi_COM[2]=(f_Gps_Alt-f_Rn_pole_KF_COM[2])+f_dPosiz_Sum; 
	      		             					  
		f_Vnc_COM[0]=(f_Gps_Ve-f_Vn_pole_KF_COM[0])+f_dVx_Sum; 
		f_Vnc_COM[1]=(f_Gps_Vn-f_Vn_pole_KF_COM[1])+f_dVy_Sum;
		f_Vnc_COM[2]=(f_Gps_Vu-f_Vn_pole_KF_COM[2])+f_dVz_Sum;
		*/
	
		d_Posi_COM[0] = d_Gps_Long + f_dPosix_Sum;  //没减杆臂
		d_Posi_COM[1] = d_Gps_Lat + f_dPosiy_Sum; 
		d_Posi_COM[2] = f_Gps_Alt + f_dPosiz_Sum; 
	      		             					  
		f_Vnc_COM[0] = f_Gps_Ve + f_dVx_Sum; 
		f_Vnc_COM[1] = f_Gps_Vn + f_dVy_Sum;
		f_Vnc_COM[2] = f_Gps_Vu + f_dVz_Sum;
	 	
		if(i_Flag_KFAngleBack == 0)
		{
					f_KF_Phiz_COM = 0.0;
					   
					c01 = f_Cbn_COM[0][1]-f_Cbn_COM[1][1]*f_KF_Phiz_COM+f_Cbn_COM[2][1]*f_KF_Phiy_COM;
					c11 = f_Cbn_COM[0][1]*f_KF_Phiz_COM+f_Cbn_COM[1][1]-f_Cbn_COM[2][1]*f_KF_Phix_COM;
					c20 = -f_Cbn_COM[0][0]*f_KF_Phiy_COM+f_Cbn_COM[1][0]*f_KF_Phix_COM+f_Cbn_COM[2][0];
					c21 = -f_Cbn_COM[0][1]*f_KF_Phiy_COM+f_Cbn_COM[1][1]*f_KF_Phix_COM+f_Cbn_COM[2][1];
					c22 = -f_Cbn_COM[0][2]*f_KF_Phiy_COM+f_Cbn_COM[1][2]*f_KF_Phix_COM+f_Cbn_COM[2][2];
								
				    f_att[0] = atan(c21/sqrt(c20*c20+c22*c22));
				    f_att[1] = atan2(-c20,c22);	
				    	
		     if(sqrt(f_Vnc_COM[0]*f_Vnc_COM[0]+f_Vnc_COM[1]*f_Vnc_COM[1])>f_GpsgetHead_V_Limit)
		     {   
					
				if(fabs(f_Vnc_COM[0]) < 0.01)  
				{ 
					if(f_Vnc_COM[1] >= 0.0)   f_att[2] = 0.0;
				  	if(f_Vnc_COM[1] < 0.0)   f_att[2] = PI;
				}
				else if(fabs(f_Vnc_COM[1]) < 0.01)
				{ 
					if(f_Vnc_COM[0] >= 0.0)   f_att[2] = PI*3.0/2.0;
					if(f_Vnc_COM[0] < 0.0)   f_att[2] = PI/2.0;
				}
				else
				{   
					f_att[2] = atan(-f_Vnc_COM[0]/f_Vnc_COM[1]);
					
					if((f_Vnc_COM[0] >0.0) && (f_Vnc_COM[1] > 0.0))
						f_att[2] += 2.0*PI;
					else if(f_Vnc_COM[1] < 0.0)
						f_att[2] += PI;
				}
				
		      }	
		      else
		      {
				  f_att[2] = f_Atti_COM[2];			      	
		      }
		      
		}
		else
		{
				  f_att[0] = f_Atti_COM[0];
				  f_att[1] = f_Atti_COM[1];		
				  f_att[2] = f_Atti_COM[2];	
		}

							 
		for(k=0;k<3;k++)
		{ 
			   sp[k] = sin(f_att[k]/2.0);
			   cp[k] = cos(f_att[k]/2.0);
		}
						     
		tmpqu[0] = cp[2]*cp[0]*cp[1]-sp[2]*sp[0]*sp[1];
		tmpqu[1] = cp[2]*sp[0]*cp[1]-sp[2]*cp[0]*sp[1];
		tmpqu[2] = cp[2]*cp[0]*sp[1]+sp[2]*sp[0]*cp[1];
		tmpqu[3] = cp[2]*sp[0]*sp[1]+sp[2]*cp[0]*cp[1];
		
		tmpsum = 0.0;  
		                           																																			
		for(k = 0; k < 4; k++)                        																																			
		{
				tmpsum += tmpqu[k] * tmpqu[k];              																																			
		}
		
		tmpsqrtsum = sqrt(tmpsum);                																																			
		for(k = 0; k < 4; k++)
		{
				f_Qu_COM[k] = tmpqu[k]/tmpsqrtsum;              																																			
		}
	
		
		i_Flag_KFAngleBack = 0;            //姿态角反馈标志  
			
		for(k = 0; k < kno1; k++) 
			com_Xk[k] = 0.0;
	
		INITIALIZATION_KF_COM();	      //卡尔曼滤波每秒初始化滤波参数
}
