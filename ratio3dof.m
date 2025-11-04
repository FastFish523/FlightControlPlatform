%%%%%%%%%%%%%%%%%%%%%%%%%%%%插值处理%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ma=missile_v/340;
missile_alpha=alpha/57.3;
missile_beta=beta/57.3;
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
Y=Y*Q*missile_serf;
X=X*Q*missile_serf;
Z=Z*Q*missile_serf;
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
sim_3dof_result(i,15)=(0*Ft*(sin(missile_alpha)*cos(missile_bank)+cos(missile_alpha)*sin(missile_beta)*sin(missile_bank))+Y*cos(missile_bank)-Z*sin(missile_bank)-0*missile_mass*g*cos(missile_theta))/missile_mass;
sim_3dof_result(i,16)=(0*Ft*(sin(missile_alpha)*sin(missile_bank)-cos(missile_alpha)*sin(missile_beta)*cos(missile_bank))+Y*sin(missile_bank)+Z*cos(missile_bank))/missile_mass;
sim_3dof_result(i,17)=Q;
sim_3dof_result(i,18)=Ft;
sim_3dof_result(i,19)=R;
sim_3dof_result(i,20)=lamd_D*57.3;
sim_3dof_result(i,21)=lamd_T*57.3;
sim_3dof_result(i,22)=lamd_D_Dot;
sim_3dof_result(i,23)=lamd_T_Dot;
sim_3dof_result(i,24)=dz;
sim_3dof_result(i,25)=missile_mass;
sim_3dof_result(i,26)=ayc;
sim_3dof_result(i,27)=azc;
i=i+1;