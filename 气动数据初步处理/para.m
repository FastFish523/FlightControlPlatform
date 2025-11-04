clear
clc
%基本参数设定 
dz_vec = [-20.0,-10.0, 0.0, 10.0,20.0];
dy_vec = [-10 0 10];
dx_vec = [-10 0 10];
beta_vec = [0 4 10];
Ma_vec=[0.4 0.6 0.8 1.05];
alpha_vec=[-6.0, -2.0, 0.0, 2.0, 4.0, 8.0, 12.0, 16.0, 20.0, 23];

save('para.mat','dz_vec','dy_vec','dx_vec','beta_vec','Ma_vec','alpha_vec');