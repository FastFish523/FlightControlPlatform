%%%%%%%%%%%%%%%%%%%%%%%%%%%%插值处理%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ma=missile_v/340;
alpha=missile_alpha*57.3;
rou=9.80665*(10.19716213*exp(log(0.101324*10000)-9.80665/(-6.5*0.001)/287.05287*log(1+(-6.5*0.001)*(missile_position(2))/288.15)))/287.05287/(288.15-0.65*missile_position(2)/100);
Q=0.5*rou*missile_v*missile_v;
if ma>max(Ma_vec)
    ma=max(Ma_vec);
end
if ma<min(Ma_vec)
    ma=min(Ma_vec);
end
if alpha>max(alpha_vec)
    alpha=max(alpha_vec);
end
if alpha<min(alpha_vec)
    alpha=min(alpha_vec);
end
if num_Ma>1
ma_cnt=1;
while(ma_cnt<num_Ma)
    if (ma>=Ma_vec(ma_cnt)&&ma<=Ma_vec(ma_cnt+1))
        break;
    end
    ma_cnt=ma_cnt+1;
end
for i3=1:num_alpha
    l1(i3)=l(ma_cnt,i3)+(ma-Ma_vec(ma_cnt))*(l(ma_cnt+1,i3)-l(ma_cnt,i3))/(Ma_vec(ma_cnt+1)-Ma_vec(ma_cnt));
    d1(i3)=d(ma_cnt,i3)+(ma-Ma_vec(ma_cnt))*(d(ma_cnt+1,i3)-d(ma_cnt,i3))/(Ma_vec(ma_cnt+1)-Ma_vec(ma_cnt));
    c1(i3)=c(ma_cnt,i3)+(ma-Ma_vec(ma_cnt))*(c(ma_cnt+1,i3)-c(ma_cnt,i3))/(Ma_vec(ma_cnt+1)-Ma_vec(ma_cnt));
end
else 
    ma_cnt=1;
    for i3=1:num_alpha
    l1(i3)=l(ma_cnt,i3);
    d1(i3)=d(ma_cnt,i3);
    c1(i3)=c(ma_cnt,i3);
end
end

alpha_cnt=1;
while(alpha_cnt<num_alpha)
    if (alpha>=alpha_vec(alpha_cnt)&&alpha<=alpha_vec(alpha_cnt+1))
        break;
    end
    alpha_cnt=alpha_cnt+1;
end
Y=l1(alpha_cnt)+(alpha-alpha_vec(alpha_cnt))*(l1(alpha_cnt+1)-l1(alpha_cnt))/(alpha_vec(alpha_cnt+1)-alpha_vec(alpha_cnt));
X=d1(alpha_cnt)+(alpha-alpha_vec(alpha_cnt))*(d1(alpha_cnt+1)-d1(alpha_cnt))/(alpha_vec(alpha_cnt+1)-alpha_vec(alpha_cnt));
Z=c1(alpha_cnt)+(alpha-alpha_vec(alpha_cnt))*(c1(alpha_cnt+1)-c1(alpha_cnt))/(alpha_vec(alpha_cnt+1)-alpha_vec(alpha_cnt));
Y=Y*Q*missile_serf*missile_l;
X=X*Q*missile_serf*missile_l;
Z=Z*Q*missile_serf*missile_l;
%%%%%%%%%%%%%%%%%%%%%%%%%%动力学解算%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
v_dot=(Ft*cos(missile_alpha)*cos(missile_beta)-X-missile_mass*g*sin(missile_theta))/missile_mass;
theta_dot=(Ft*(sin(missile_alpha)*cos(missile_bank)+cos(missile_alpha)*sin(missile_beta)*sin(missile_bank))+Y*cos(missile_bank)-Z*sin(missile_bank)-missile_mass*g*cos(missile_theta))/missile_mass/missile_v;
phiv_dot=-(Ft*(sin(missile_alpha)*sin(missile_bank)-cos(missile_alpha)*sin(missile_beta)*cos(missile_bank))+Y*sin(missile_bank)+Z*cos(missile_bank))/missile_mass/missile_v/cos(missile_theta);
x_dot = missile_v*cos(missile_theta)*cos(missile_phiv);
y_dot = missile_v*sin(missile_theta);
z_dot = -missile_v*cos(missile_theta)*sin(missile_phiv);

missile_v = missile_v + v_dot*simu_step;
missile_theta = missile_theta + theta_dot*simu_step;
missile_phiv = missile_phiv + phiv_dot*simu_step;
missile_position(1) = missile_position(1) + x_dot*simu_step;
missile_position(2) = missile_position(2) + y_dot*simu_step;
missile_position(3) = missile_position(3) + z_dot*simu_step;

simtime = simtime +simu_step;
%%%%%%%%%%%%%%%%%%%%%%%%%反差舵偏%%%%%%%%%%%%%%%%%%%%%%%%%
chazhi_beta=abs(missile_beta*57.3);
chazhi_alpha=missile_alpha*57.3;
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
    chazhi_g1=(chazhi_beta-beta_vec(beta_cnt))/(0.000001+beta_vec(beta_cnt_1)-beta_vec(beta_cnt))*(chazhi_f2-chazhi_f1)+chazhi_f1;
    
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
dz=dz_vec(dz_cnt)+((dz_vec(dz_cnt_1)-dz_vec(dz_cnt))/(0.00000001+chazhi_mz(dz_cnt_1)-chazhi_mz(dz_cnt))*(0-chazhi_mz(dz_cnt)));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sim_3dof_result(i,1)=simtime;
sim_3dof_result(i,2)=missile_position(1);
sim_3dof_result(i,3)=missile_position(2);
sim_3dof_result(i,4)=missile_position(3);
sim_3dof_result(i,5)=missile_v;
sim_3dof_result(i,6)=missile_theta*57.3;
sim_3dof_result(i,7)=missile_phiv*57.3;
sim_3dof_result(i,8)=missile_alpha*57.3;
sim_3dof_result(i,9)=missile_beta*57.3;
sim_3dof_result(i,10)=missile_bank*57.3;
sim_3dof_result(i,11)=x_dot;
sim_3dof_result(i,12)=y_dot;
sim_3dof_result(i,13)=z_dot;
sim_3dof_result(i,14)=v_dot+9.8*sin(missile_theta);
sim_3dof_result(i,15)=(Ft*(sin(missile_alpha)*cos(missile_bank)+cos(missile_alpha)*sin(missile_beta)*sin(missile_bank))+Y*cos(missile_bank)-Z*sin(missile_bank)-0*missile_mass*g*cos(missile_theta))/missile_mass;
sim_3dof_result(i,16)=(Ft*(sin(missile_alpha)*sin(missile_bank)-cos(missile_alpha)*sin(missile_beta)*cos(missile_bank))+Y*sin(missile_bank)+Z*cos(missile_bank))/missile_mass;
sim_3dof_result(i,17)=Q;
sim_3dof_result(i,18)=Ft;
sim_3dof_result(i,19)=0;
sim_3dof_result(i,20)=0;
sim_3dof_result(i,21)=0;
sim_3dof_result(i,22)=0;
sim_3dof_result(i,23)=0;
sim_3dof_result(i,24)=dz;
sim_3dof_result(i,25)=missile_mass;
sim_3dof_result(i,26)=ayc;
sim_3dof_result(i,27)=azc;
i=i+1;