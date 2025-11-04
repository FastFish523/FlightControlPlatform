%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
c1=1.5;c2=1.5;w=0.1;D=2;N=200;MaxDT=10;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 初始化粒子群
P_ga=round(rand(N,10));
I_ga=round(rand(N,10));
for i_ga=1:N
    x(i_ga,1)=0;
    x(i_ga,2)=0;
    for j_ga=1:10
        x(i_ga,1)=x(i_ga,1)+P_ga(i_ga,j_ga)*2^(j_ga-1)*(1)/1023;
        x(i_ga,2)=x(i_ga,2)+I_ga(i_ga,j_ga)*2^(j_ga-1)*(1)/1023;
    end
end
v_ga=zeros(N,1);
v_ga(:,1)=0.1.*(rand(N,1)-0.5);
v_ga(:,2)=0.1.*(rand(N,1)-0.5);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%5%%%% 计算适应度函数
sum=0;
kp_ga=x(:,1);
ki_ga=x(:,2);
for i_ga=1:N
gc=-1*ki_ga(i_ga)*tf([kp_ga(i_ga)/ki_ga(i_ga) 1],[1 0]);
if flag==1%姿态控制
tf_fy_open(ct)=gc*tf_wz_bihuan(ct)*jifen;
[Gm,Pm,Wcg,Wcp]=margin(tf_fy_open(ct));
end
if flag==2%过载控制
tf_ny_open(ct)=tf_wz_bihuan(ct)*V(ct)*tf([1],[t1(ct) 1]);
tf_ny_open(ct)=gc*tf_ny_open(ct);
[Gm,Pm,Wcg,Wcp]=margin(tf_ny_open(ct));
end
if flag==3%过载控制
tf_ny_open(ct)=tf_wz_bihuan(ct)*V(ct)*tf([1],[t1(ct) 1]);
tf_ny_open(ct)=gc*tf_ny_open(ct);
[Gm,Pm,Wcg,Wcp]=margin(tf_ny_open(ct));
end
pp(i_ga)=1/(1*(Pm/57.3-xiangwei/57.3)^2+1*(Wcp-wcp)^2);
y(i_ga,:)=x(i_ga,:);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%最佳粒子
[a,b]=max(pp);
pg=y(b,:);
p=pp(b);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for count=1:MaxDT%循环总次数
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%粒子群更新
for i_ga=1:N
v_ga(i_ga,:)=w*v_ga(i_ga,:)+c1*rand*(y(i_ga,:)-x(i_ga,:))+c2*rand*(pg-x(i_ga,:));
if abs(v_ga(i_ga,1))>10
    v_ga(i_ga,1)=0.05*sign(v_ga(i_ga,1));
end
if abs(v_ga(i_ga,2))>10
    v_ga(i_ga,2)=0.05*sign(v_ga(i_ga,2));
end
x(i_ga,:)=x(i_ga,:)+v_ga(i_ga,:);
%%%%%%%%%%%%%%%%%%%%%%%%5%%%% 计算适应度函数
sum=0;
if x(i_ga,1)<0
   x(i_ga,1)=0;
end
if x(i_ga,2)<0
   x(i_ga,2)=0;
end
if x(i_ga,1)<x(i_ga,2)*0.02
    x(i_ga,1)=x(i_ga,2)*0.02;
end
kp=x(i_ga,1);
ki=x(i_ga,2);
gc=-1*ki*tf([kp/ki 1],[1 0]);
if flag==1%姿态控制
tf_fy_open(ct)=gc*tf_wz_bihuan(ct)*jifen;
[Gm,Pm,Wcg,Wcp]=margin(tf_fy_open(ct));
end
if flag==2%过载控制
tf_ny_open(ct)=tf_wz_bihuan(ct)*V(ct)*tf([1],[t1(ct) 1]);
tf_ny_open(ct)=gc*tf_ny_open(ct);
[Gm,Pm,Wcg,Wcp]=margin(tf_ny_open(ct));
end
if flag==3%过载控制
tf_ny_open(ct)=tf_wz_bihuan(ct)*V(ct)*tf([1],[t1(ct) 1]);
tf_ny_open(ct)=gc*tf_ny_open(ct);
[Gm,Pm,Wcg,Wcp]=margin(tf_ny_open(ct));
end
ppp(i_ga)=1/(1*(Pm/57.3-xiangwei/57.3)^2+1*(Wcp-wcp)^2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ppp(i_ga)>pp(i_ga)
    pp(i_ga)=ppp(i_ga);
    y(i_ga,:)=x(i_ga,:);
end
if pp(i_ga)>p
    p=pp(i_ga);
    pg=y(i_ga,:);
end

end
pbest=pg;
%%%%%%%%%%%%%%%%%%%%%%%%5%%%% 计算适应度函数
sum=0;
kp=pg(1,1);
ki=pg(1,2);
gc=-1*ki*tf([kp/ki 1],[1 0]);
if flag==1%姿态控制
tf_fy_open(ct)=gc*tf_wz_bihuan(ct)*jifen;
[Gm,Pm,Wcg,Wcp]=margin(tf_fy_open(ct));
end
if flag==2%过载控制
tf_ny_open(ct)=tf_wz_bihuan(ct)*V(ct)*tf([1],[t1(ct) 1]);
tf_ny_open(ct)=gc*tf_ny_open(ct);
[Gm,Pm,Wcg,Wcp]=margin(tf_ny_open(ct));
end
if flag==3%过载控制
tf_ny_open(ct)=tf_wz_bihuan(ct)*V(ct)*tf([1],[t1(ct) 1]);
tf_ny_open(ct)=gc*tf_ny_open(ct);
[Gm,Pm,Wcg,Wcp]=margin(tf_ny_open(ct));
end
OUT(count)=(1*(Pm/57.3-xiangwei/57.3)^2+1*(Wcp-wcp)^2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
% 选择pi
kp=pbest(1,1);
ki=pbest(1,2);
