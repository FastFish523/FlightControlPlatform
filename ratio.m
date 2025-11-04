%%%%%%%%%%%%%%%%说明%%%%%%%%%%%%%%%%%%%%%%%%%%
% 此程序为比例导引法设计程序，具体设计方法参考导弹
% 飞行力学，为了实现快速设计的目的，这里提供了比例
% 导引法的接口变量，设计人员只需对：以下是设计人员
% 添加的部分进行编程操作
%弹目距离
R=((missile_position(1)-target_position(1))^2+(missile_position(2)-target_position(2))^2+(missile_position(3)-target_position(3))^2)^0.5;
%视线偏角
lamd_T = atan(-(target_position(3)-missile_position(3))/(target_position(1)-missile_position(1)));
%视线倾角
lamd_D = atan((target_position(2)-missile_position(2))/sqrt((target_position(1)-missile_position(1))^2+(target_position(3)-missile_position(3))^2));
%地理系下的合速度（目标静止）
vx = missile_v*cos(missile_theta)*cos(missile_phiv);
vy = missile_v*sin(missile_theta);
vz = -missile_v*cos(missile_theta)*sin(missile_phiv);
%坐标转换矩阵,将合速度由地理系转换到视线坐标系
T_G_W(1,1) = cos(lamd_D)*cos(lamd_T);
T_G_W(1,2) = sin(lamd_D);
T_G_W(1,3) = -cos(lamd_D)*sin(lamd_T);
T_G_W(2,1) = -sin(lamd_D)*cos(lamd_T);
T_G_W(2,2) = cos(lamd_D);
T_G_W(2,3) = sin(lamd_D)*sin(lamd_T);
T_G_W(3,1) = sin(lamd_T);
T_G_W(3,2) = 0;
T_G_W(3,3) = cos(lamd_T);

V_W(1) = T_G_W(1,1)*vx + T_G_W(1,2)*vy + T_G_W(1,3)*vz;
V_W(2) = T_G_W(2,1)*vx + T_G_W(2,2)*vy + T_G_W(2,3)*vz;
V_W(3) = T_G_W(3,1)*vx + T_G_W(3,2)*vy + T_G_W(3,3)*vz;
%视线倾角导数
lamd_D_Dot = -V_W(2)/R;
%视线偏角导数
lamd_T_Dot = V_W(3)/R;
%制导用升力
% % Lift
%制导用侧力
% % Ce
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%以下是设计人员添加的部分%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ky=4;
kz=4;
k_limit=4;
kalpha=1;
if (simtime<0.3)
Ft = 0; 
end
if (simtime>=0.3&&simtime<3.5)
Ft = 2400; 
end
if (simtime>=3.5&&simtime<18.5)
Ft = 800; 
end
if (simtime>=18.5)
Ft = 0; 
end

if (simtime<0.1)
    Lift = 0;
    Ce = 0;
end
if (simtime>=0.1)
    if ((R)>120)
        Lift = ky*lamd_D_Dot*missile_mass*missile_v - kalpha*Ft*sin(missile_alpha) +missile_mass*g*cos(missile_theta)+k_limit * (lamd_D-(-45)/57.3)*missile_v/(R/missile_v)*missile_mass;
        Lift1=Lift;
        Ce = kalpha*Ft*cos(missile_alpha)*sin(missile_beta)-kz*lamd_T_Dot*missile_mass*missile_v*cos(missile_theta);
        Ce1=Ce;
        if((R)<3000)
        Lift = ky*lamd_D_Dot*missile_mass*missile_v - kalpha*Ft*sin(missile_alpha) +missile_mass*g*cos(missile_theta)+0 * (lamd_D-(-45)/57.3)*missile_v/(R/missile_v)*missile_mass;
        Lift1=Lift;
        Ce = kalpha*Ft*cos(missile_alpha)*sin(missile_beta)-kz*lamd_T_Dot*missile_mass*missile_v*cos(missile_theta);
        Ce1=Ce;
        end
    else
        Lift= Lift1;
        Ce=Ce1;
    end
end
ayc1=(Lift+0*kalpha*Ft*sin(missile_alpha))/missile_mass;
azc1=(Ce-0*kalpha*Ft*cos(missile_alpha)*sin(missile_beta))/missile_mass;
if simtime>=1.1&&simtime<3
    k_cut=(simtime-1)/2;
    ayc=ayc1*k_cut;
    azc=azc1;
else
    ayc=ayc1;
    azc=azc1;
end
%%%%%%%%%%%%%%%%以上是设计人员添加的部分%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%反插值求攻角%%%%%%%%%%%%%%%%%%%
rou=9.80665*(10.19716213*exp(log(0.101324*10000)-9.80665/(-6.5*0.001)/287.05287*log(1+(-6.5*0.001)*(missile_position(2))/288.15)))/287.05287/(288.15-0.65*missile_position(2)/100);
Q=0.5*rou*missile_v*missile_v;
ma=missile_v/340;
Lift=Lift/Q/missile_serf;
Ce=Ce/Q/missile_serf;

if ma>max(Ma_vec)
    ma=max(Ma_vec);
end
if ma<min(Ma_vec)
    ma=min(Ma_vec);
end
if num_Ma>1
ma_cnt=1;
while(ma_cnt<num_Ma)
    if (ma>=Ma_vec(ma_cnt)&&ma<=Ma_vec(ma_cnt+1))
        break;
    end
    ma_cnt=ma_cnt+1;
end
ma_cnt_1=ma_cnt+1;
else
    ma_cnt=1;
    ma_cnt_1=ma_cnt;
end
for i3=1:num_alpha
    l1(i3)=l(ma_cnt,i3)+(ma-Ma_vec(ma_cnt))*(l(ma_cnt_1,i3)-l(ma_cnt,i3))/(0.000001+Ma_vec(ma_cnt_1)-Ma_vec(ma_cnt));
    d1(i3)=d(ma_cnt,i3)+(ma-Ma_vec(ma_cnt))*(d(ma_cnt_1,i3)-d(ma_cnt,i3))/(0.000001+Ma_vec(ma_cnt_1)-Ma_vec(ma_cnt));
    c1(i3)=c(ma_cnt,i3)+(ma-Ma_vec(ma_cnt))*(c(ma_cnt_1,i3)-c(ma_cnt,i3))/(0.000001+Ma_vec(ma_cnt_1)-Ma_vec(ma_cnt));
end
for i2=1:num_alpha-1
    if(Lift < l1(1))
        break;
    end
    if(Lift >= l1(i2) && Lift < l1(i2+1))
        break;
     end
end
al_cnt=i2;
cxy=(Lift - l1(al_cnt))/(l1(al_cnt+1) - l1(al_cnt));
if(cxy > 1)
    cxy = 1;
end
if(cxy < 0)
    cxy = 0;
end
alpha = alpha_vec(al_cnt) + cxy*(alpha_vec(al_cnt+1) - alpha_vec(al_cnt));
%%%%%%%%%%%%%攻角限幅%%%%%%%%%%%%%%%%%%%%%%%%%
if alpha>6
alpha=6;
end
if alpha<-6
alpha=-6;
end
alp11=alp11+(alpha-alp11)*0.05/0.5;
alpha=alp11;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%求侧滑角
beta=10;
dz=0;
chazhi_dz;
CC=z(ma_cnt,al_cnt);
beta=10*Ce/CC;
%%%%%%%%%%%%%侧滑限幅%%%%%%%%%%%%%%%%%%%%%%%%%
if beta>5
beta=5;
end
if beta<-5
beta=-5;
end
bt11=bt11+(beta-bt11)*0.05/0.5;
beta=bt11;
%%%%%%%%%%%%%%%%%%%%%%%%%反差舵偏%%%%%%%%%%%%%%%%%%%%%%%%%
chazhi_beta=abs(beta);
chazhi_alpha=alpha;
chazhi_ma=missile_v/340;
if chazhi_ma>max(Ma_vec)
    chazhi_ma=max(Ma_vec);
end
if chazhi_ma<min(Ma_vec)
    chazhi_ma=min(Ma_vec);
end
if chazhi_alpha>max(alpha_vec)
    chazhi_alpha=max(alpha_vec);
end
if chazhi_alpha<min(alpha_vec)
    chazhi_alpha=min(alpha_vec);
end
if chazhi_beta>max(beta_vec)
    chazhi_beta=max(beta_vec);
end
if chazhi_beta<min(beta_vec)
    chazhi_beta=min(beta_vec);
end

if num_Ma>1
ma_cnt=1;
while(ma_cnt<num_Ma)
    if (chazhi_ma>=Ma_vec(ma_cnt)&&chazhi_ma<=Ma_vec(ma_cnt+1))
        break;
    end
    ma_cnt=ma_cnt+1;
end
    ma_cnt_1=ma_cnt+1;
else
    ma_cnt=1;
    ma_cnt_1=ma_cnt;
end

alpha_cnt=1;
while(alpha_cnt<num_alpha)
    if (chazhi_alpha>=alpha_vec(alpha_cnt)&&chazhi_alpha<=alpha_vec(alpha_cnt+1))
        break;
    end
    alpha_cnt=alpha_cnt+1;
end
alpha_cnt_1=alpha_cnt+1;

if num_beta>1
beta_cnt=1;
while(beta_cnt<num_beta)
    if (chazhi_beta>=beta_vec(beta_cnt)&&chazhi_beta<=beta_vec(beta_cnt+1))
        break;
    end
    beta_cnt=beta_cnt+1;
end
    beta_cnt_1=beta_cnt+1;
else 
    beta_cnt=1;
    beta_cnt_1=beta_cnt;
end

for i_dz=1:num_dz
    chazhi_f1=mz_dz(i_dz,beta_cnt,ma_cnt,alpha_cnt);
    chazhi_f2=mz_dz(i_dz,beta_cnt_1,ma_cnt,alpha_cnt);
    chazhi_g1=(chazhi_beta-beta_vec(beta_cnt))/(0.00000001+beta_vec(beta_cnt_1)-beta_vec(beta_cnt))*(chazhi_f2-chazhi_f1)+chazhi_f1;
    
    chazhi_f3=mz_dz(i_dz,beta_cnt,ma_cnt_1,alpha_cnt);
    chazhi_f4=mz_dz(i_dz,beta_cnt_1,ma_cnt_1,alpha_cnt);
    chazhi_g2=(chazhi_beta-beta_vec(beta_cnt))/(0.00000001+beta_vec(beta_cnt_1)-beta_vec(beta_cnt))*(chazhi_f4-chazhi_f3)+chazhi_f3;
    
    chazhi_f5=mz_dz(i_dz,beta_cnt,ma_cnt,alpha_cnt_1);
    chazhi_f6=mz_dz(i_dz,beta_cnt_1,ma_cnt,alpha_cnt_1);
    chazhi_g3=(chazhi_beta-beta_vec(beta_cnt))/(0.00000001+beta_vec(beta_cnt_1)-beta_vec(beta_cnt))*(chazhi_f6-chazhi_f5)+chazhi_f5;
    
    chazhi_f7=mz_dz(i_dz,beta_cnt,ma_cnt_1,alpha_cnt_1);
    chazhi_f8=mz_dz(i_dz,beta_cnt_1,ma_cnt_1,alpha_cnt_1);
    chazhi_g4=(chazhi_beta-beta_vec(beta_cnt))/(0.00000001+beta_vec(beta_cnt_1)-beta_vec(beta_cnt))*(chazhi_f8-chazhi_f7)+chazhi_f7;
    
    chazhi_m1=(chazhi_ma-Ma_vec(ma_cnt))/(0.00000001+Ma_vec(ma_cnt_1)-Ma_vec(ma_cnt))*(chazhi_g2-chazhi_g1)+chazhi_g1;
    chazhi_m2=(chazhi_ma-Ma_vec(ma_cnt))/(0.00000001+Ma_vec(ma_cnt_1)-Ma_vec(ma_cnt))*(chazhi_g4-chazhi_g3)+chazhi_g3;
    chazhi_mz(i_dz)=(chazhi_alpha-alpha_vec(alpha_cnt))/(0.00000001+alpha_vec(alpha_cnt_1)-alpha_vec(alpha_cnt))*(chazhi_m2-chazhi_m1)+chazhi_m1;
end
if num_dz>1
dz_cnt=1;
while(dz_cnt<num_dz)
    if (chazhi_mz(dz_cnt)*chazhi_mz(dz_cnt+1)<=0||dz_cnt==num_dz-1)
        break;
    end
    dz_cnt=dz_cnt+1;
end
    dz_cnt_1=dz_cnt+1;
else
    dz_cnt=1;
    dz_cnt_1=dz_cnt;
end
dz=dz_vec(dz_cnt)+((dz_vec(dz_cnt_1)-dz_vec(dz_cnt))/(0.000001+chazhi_mz(dz_cnt_1)-chazhi_mz(dz_cnt))*(0-chazhi_mz(dz_cnt)));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%正向插值
chazhi_dz;
for JJ=1:num_Ma
    for II=1:num_alpha
        l(JJ,II)=n(JJ,II)*cos(alpha_vec(II)/57.3)-a(JJ,II)*sin(alpha_vec(II)/57.3);
        d(JJ,II)=n(JJ,II)*sin(alpha_vec(II)/57.3)+a(JJ,II)*cos(alpha_vec(II)/57.3)-z(JJ,II)*sin(beta/57.3);
        c(JJ,II)=n(JJ,II)*sin(alpha_vec(II)/57.3)*sin(beta/57.3)+a(JJ,II)*cos(alpha_vec(II)/57.3)*sin(beta/57.3)+z(JJ,II)*cos(beta/57.3);
    end
end
%%%%%%%%%%%%%