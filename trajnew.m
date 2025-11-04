clc
clear
close all

p = cd;
p = [p '.\vc6sim\vc6sim\simuResult\'];
pathname = [p];

fcsTraj = load([pathname 'fcsTraj.dat']);
sinTraj = load([pathname 'sinTraj.dat']);
AeroData = load([pathname 'AeroData.dat']);
pitch = load([pathname 'pitch.dat']);
yaw = load([pathname 'yaw.dat']);
roll = load([pathname 'roll.dat']);
guidance = load([pathname 'guidance.dat']);
frequency = load([pathname 'frequency.dat']);
lateralchannel=load([pathname 'lateralchannel.dat']);
longchannel=load([pathname 'longchannel.dat']);

pi = 3.14159265358979323; 

figure('name','飞行高度')
plot(fcsTraj(:,1),fcsTraj(:,4));grid on;
xlabel('飞行时间t(s)');ylabel('飞行高度(m)');

figure('name','弹目相对距离')
plot(fcsTraj(:,1),fcsTraj(:,49));grid on;
xlabel('飞行时间t(s)');ylabel('弹目相对距离(m)');%ylim([0,1800]);

figure('name','飞行高度-射程')
plot(sqrt(  fcsTraj(:,2).*fcsTraj(:,2) + fcsTraj(:,3).*fcsTraj(:,3) ),fcsTraj(:,4));grid on;
xlabel('射程(m)');ylabel('飞行高度(m)');

figure('name','飞行马赫数')
plot(fcsTraj(:,1),fcsTraj(:,19));grid on;
xlabel('飞行时间t(s)');ylabel('飞行马赫数Mach');

% [m,n] = size(fcsTraj);
% figure('name','二维弹目相对运动轨迹')  
% plot(fcsTraj(:,2),fcsTraj(:,3));hold on;grid;
% plot(fcsTraj(1,2),fcsTraj(1,3),'kp','MarkerFaceColor',[1 0 0]);hold on;
% plot(fcsTraj(m,2),fcsTraj(m,3),'ks','MarkerFaceColor',[1 0 0]);hold on;
% plot(fcsTraj(:,34),fcsTraj(:,35),'k','Marker','o','MarkerSize',2,'MarkerFaceColor',[0 0 1]);hold on;
% plot(fcsTraj(m,34),fcsTraj(m,35),'ks','MarkerFaceColor',[1 0 0]);hold on;
% % plot(fcsTraj(:,43),fcsTraj(:,44),'m','Marker','o','MarkerSize',2,'MarkerFaceColor',[0 0 1]);hold on;
% % plot(fcsTraj(m,43),fcsTraj(m,44),'ks','MarkerFaceColor',[0 0 0]);grid on;
% % legend('弹飞行轨迹','真实目标运动','真实目标运动终点','预估目标运动','预估目标运动终点');
% legend('弹飞行轨迹','弹飞行轨迹起点','弹飞行轨迹终点','真实目标运动','真实目标运动终点');

% figure('name','三维运动轨迹')
% h=plot3(fcsTraj(:,2),fcsTraj(:,3),fcsTraj(:,4));hold on;%弹飞行轨迹
% plot3(fcsTraj(:,34),fcsTraj(:,35),fcsTraj(:,36),'k','Marker','o','MarkerSize',2,'MarkerFaceColor',[0 0 1]);hold on;%真实目标运动轨迹
% plot3(fcsTraj(m,34),fcsTraj(m,35),fcsTraj(m,36),'ks','MarkerFaceColor',[1 0 0]);grid on;hold on;
% % plot3(fcsTraj(:,43),fcsTraj(:,44),fcsTraj(:,45),'m','Marker','o','MarkerSize',2,'MarkerFaceColor',[0 0 1]);hold on;%预估目标运动轨迹
% % plot3(fcsTraj(m,43),fcsTraj(m,44),fcsTraj(m,45),'ks','MarkerFaceColor',[0 0 0]);
% a=get(h);
% xmin= min(a.XData);                            
% xmax= max(a.XData);
% ymin= min(a.YData);          
% ymax= max(a.YData);
% xedge = xmin:(xmax-xmin)/1:xmax;
% yedge = ymin:(ymax-ymin)/1:ymax;
% [x,y] = meshgrid(xedge,yedge);
% z = 0*(x+y);
% surf(x,y,z);
% xlabel('东向(m)');ylabel('北向(m)'); zlabel('高度(m)');grid on;zlim([-2000,2000]);
% 
% figure('name','目标运动估计误差')
% xerror = fcsTraj(:,43) - fcsTraj(:,34);
% yerror = fcsTraj(:,44) - fcsTraj(:,35);
% zerror = fcsTraj(:,45) - fcsTraj(:,36);
% subplot(3,1,1);plot(fcsTraj(:,1),xerror);grid on;legend('xerror');ylabel('xerror');
% subplot(3,1,2);plot(fcsTraj(:,1),yerror);grid on;legend('yerror');ylabel('yerror');
% subplot(3,1,3);plot(fcsTraj(:,1),zerror);grid on;legend('zerror');ylabel('zerror');xlabel('时间t(s)');


figure('name','速度')
subplot(3,1,1);plot(fcsTraj(:,1),fcsTraj(:,8),'r',sinTraj(:,1),sinTraj(:,6)); grid on;legend('动力学','导航'); ylabel('Vn(m/s)')
subplot(3,1,2);plot(fcsTraj(:,1),fcsTraj(:,9),'r',sinTraj(:,1),sinTraj(:,7)); grid on;legend('动力学','导航'); ylabel('Vu(m/s)')
subplot(3,1,3);plot(fcsTraj(:,1),fcsTraj(:,10),'r',sinTraj(:,1),sinTraj(:,5)); grid on;legend('动力学','导航');xlabel('t(s)');ylabel('Ve(m/s)')



figure('name','合速度')
[m,n] = size(fcsTraj(:,1));
for i = 1:m
    Vel(i) = sqrt(fcsTraj(i,8)^2 + fcsTraj(i,9)^2  + fcsTraj(i,10)^2 );
end
plot(fcsTraj(:,1),Vel);legend('合速度'); xlabel('时间(s)');ylabel('速度(m/s)');grid on;

figure('name','Q')
plot(fcsTraj(:,1),fcsTraj(:,33));
xlabel('t(s)');ylabel('动压Q(Pa)');
grid on;
hold on;

figure('name','姿态角')
[m,n] = size(sinTraj(:,1));
for i = 1:m
    if sinTraj(i,10) > pi
        sinTraj(i,10) = sinTraj(i,10) - 2*pi;
    end
end
subplot(3,1,1);plot(fcsTraj(:,1),fcsTraj(:,11)*57.3,'r',sinTraj(:,1),sinTraj(:,9)*57.3,'b',roll(:,1),roll(:,2)*57.3,'k');grid on;legend('动力学','导航','指令'); ylabel('滚动(\circ)')
subplot(3,1,2);plot(fcsTraj(:,1),fcsTraj(:,12)*57.3,'r',sinTraj(:,1),sinTraj(:,10)*57.3);hold on;legend('动力学','导航'); ylabel('偏航(\circ)');grid on;
subplot(3,1,3);plot(fcsTraj(:,1),fcsTraj(:,13)*57.3,'r',sinTraj(:,1),sinTraj(:,8)*57.3);hold on;legend('动力学','导航'); ylabel('俯仰(\circ)');grid on; xlabel('t(s)');


figure('name','角速率')
subplot(3,1,1);plot(fcsTraj(:,1),fcsTraj(:,14)*57.3);grid on; ylabel('\omega_x(\circ/s)');set(gca,'fontsize',8);
subplot(3,1,2);plot(fcsTraj(:,1),fcsTraj(:,15)*57.3);grid on; ylabel('\omega_y(\circ/s)');set(gca,'fontsize',8);
subplot(3,1,3);plot(fcsTraj(:,1),fcsTraj(:,16)*57.3);grid on; ylabel('\omega_z(\circ/s)');set(gca,'fontsize',8); xlabel('t(s)');

figure('name','过载')
subplot(3,1,1);plot( fcsTraj(:,1),fcsTraj(:,24),  fcsTraj(:,1),fcsTraj(:,26),'r'); legend('ny(flight)','ny(command)');grid on; ylabel('ny(m/s^2)');
subplot(3,1,2);plot(fcsTraj(:,1),fcsTraj(:,23));legend('nx(flight)');  ylabel('nx(m/s^2)');grid on;
subplot(3,1,3);plot(fcsTraj(:,1),fcsTraj(:,25), fcsTraj(:,1),fcsTraj(:,27),'r');legend('nz(flight)','nz(command)');grid on; xlabel('t(s)');   ylabel('nz(m/s^2)');

figure('name','状态')
subplot(3,1,1);plot(fcsTraj(:,1),fcsTraj(:,17));grid on; legend('angle of side attack'); ylabel('\alpha(\circ)');title('攻角');
subplot(3,1,2);plot(fcsTraj(:,1),fcsTraj(:,18));grid on;legend('angle of side slip'); ylabel('\beta(\circ)');
subplot(3,1,3);plot(fcsTraj(:,1),fcsTraj(:,19));grid on;legend('velocity'); xlabel('t(s)');ylabel('Mach');
% 
figure('name','三通道舵偏')
subplot(3,1,1);plot(fcsTraj(:,1),fcsTraj(:,21), fcsTraj(:,1),fcsTraj(:,30),'r' );grid on;legend('\deltax(flight)','\deltax(commamd)'); ylabel('\delta_x(\circ)');
subplot(3,1,2);plot(fcsTraj(:,1),fcsTraj(:,22), fcsTraj(:,1),fcsTraj(:,31),'r' );grid on;legend('\deltay(flight)','\deltay(commamd)');  ylabel('\delta_y(\circ)');
subplot(3,1,3);plot(fcsTraj(:,1),fcsTraj(:,20), fcsTraj(:,1),fcsTraj(:,29),'r' );grid on;legend('\deltaz(flight)','\deltaz(commamd)'); xlabel('t(s)');ylabel('\delta_z(\circ)');

figure('name','四通道舵偏')
subplot(4,1,1);plot(fcsTraj(:,1),fcsTraj(:,30)-fcsTraj(:,31)-fcsTraj(:,29));grid on;ylabel('舵1');title('四通道舵偏');
subplot(4,1,2);plot(fcsTraj(:,1),fcsTraj(:,30)+fcsTraj(:,31)-fcsTraj(:,29));grid on;ylabel('舵2');
subplot(4,1,3);plot(fcsTraj(:,1),fcsTraj(:,30)+fcsTraj(:,31)+fcsTraj(:,29));grid on;ylabel('舵3');
subplot(4,1,4);plot(fcsTraj(:,1),fcsTraj(:,30)-fcsTraj(:,31)+fcsTraj(:,29));grid on;ylabel('舵4');xlabel('t(s)');

figure('name','导引系数')
subplot(2,1,1); plot(guidance(:,1),guidance(:,8));grid on;title('法向导引系数');
subplot(2,1,2); plot(guidance(:,1),guidance(:,9));grid on;title('侧向导引系数');

% figure('name','舵铰链力矩')
% subplot(4,1,1),plot(AeroData(:,1),AeroData(:,13));ylabel('舵1');grid on;title('铰链力矩');
% subplot(4,1,2),plot(AeroData(:,1),AeroData(:,14));ylabel('舵2');grid on;
% subplot(4,1,3),plot(AeroData(:,1),AeroData(:,15));ylabel('舵3');grid on;
% subplot(4,1,4),plot(AeroData(:,1),AeroData(:,16));ylabel('舵4');grid on;
% xlabel('t(s)');
% 
% figure('name','舵弯矩')
% subplot(4,1,1),plot(AeroData(:,1),AeroData(:,17));ylabel('舵1');grid on;title('弯矩');
% subplot(4,1,2),plot(AeroData(:,1),AeroData(:,18));ylabel('舵2');grid on;
% subplot(4,1,3),plot(AeroData(:,1),AeroData(:,19));ylabel('舵3');grid on;
% subplot(4,1,4),plot(AeroData(:,1),AeroData(:,20));ylabel('舵4');grid on;
% xlabel('t(s)');
% % 
% t_lock = find((guidance(:,2)<=120)&(guidance(:,2)~=0));
% % 
% % % if (t_lock ~= 0)
% % %     figure('name','东向角速率-地理系')
% % %     plot(fcsTraj(1:t_lock(1),1),fcsTraj(1:t_lock(1),37)*57.3);
% % %     xlabel('时间/s');ylabel('东向角速率  (°/s)');grid on;
% % % 
% % %     figure('name','北向角速率-地理系')
% % %     plot(fcsTraj(1:t_lock(1),1),fcsTraj(1:t_lock(1),38)*57.3);
% % %     xlabel('时间/s');ylabel('北向角速率  (°/s)');grid on;
% % % 
% % %     figure('name','天向角速率-地理系')
% % %     plot(fcsTraj(1:t_lock(1),1),fcsTraj(1:t_lock(1),39)*57.3);
% % %     xlabel('时间/s');ylabel('天向角速率  (°/s)');grid on;
% % % else
% % %     figure('name','东向角速率-地理系')
% % %     plot(fcsTraj(:,1),fcsTraj(:,37)*57.3);
% % %     xlabel('时间/s');ylabel('东向角速率  (°/s)');grid on;
% % % 
% % %     figure('name','北向角速率-地理系')
% % %     plot(fcsTraj(:,1),fcsTraj(:,38)*57.3);
% % %     xlabel('时间/s');ylabel('北向角速率  (°/s)');grid on;
% % % 
% % %     figure('name','天向角速率-地理系')
% % %     plot(fcsTraj(:,1),fcsTraj(:,39)*57.3);
% % %     xlabel('时间/s');ylabel('天向角速率  (°/s)');grid on;
% % % end
% % 
% if (t_lock ~= 0)
%     figure('name','轴向角速率-体系')
%     plot(fcsTraj(1:t_lock(1),1),fcsTraj(1:t_lock(1),40)*57.3);
%     xlabel('时间/s');ylabel('轴向角速率  (°/s)');grid on;
% 
%     figure('name','侧向角速率-体系')
%     plot(fcsTraj(1:t_lock(1),1),fcsTraj(1:t_lock(1),41)*57.3);
%     xlabel('时间/s');ylabel('侧向角速率  (°/s)');grid on;
% 
%     figure('name','法向角速率-体系')
%     plot(fcsTraj(1:t_lock(1),1),fcsTraj(1:t_lock(1),42)*57.3);
%     xlabel('时间/s');ylabel('法向角速率  (°/s)');grid on;
% else
%     figure('name','轴向角速率-体系')
%     plot(fcsTraj(:,1),fcsTraj(:,40)*57.3);
%     xlabel('时间/s');ylabel('轴向角速率  (°/s)');grid on;
% 
%     figure('name','侧向角速率-体系')
%     plot(fcsTraj(:,1),fcsTraj(:,41)*57.3);
%     xlabel('时间/s');ylabel('侧向角速率  (°/s)');grid on;
% 
%     figure('name','法向角速率-体系')
%     plot(fcsTraj(:,1),fcsTraj(:,42)*57.3);
%     xlabel('时间/s');ylabel('法向角速率  (°/s)');grid on;
% end

    
figure('name','弹道偏角/视线方位角')
plot(guidance(:,1),guidance(:,5)*57.3,'r',guidance(:,1),guidance(:,7)*57.3,'b',sinTraj(:,1),sinTraj(:,10)*57.3,'k');grid on;
legend('弹道偏角','视线方位角','导航偏航角'); 

figure('name','弹道倾角/视线高低角')
plot(guidance(:,1),guidance(:,4)*57.3,'r',guidance(:,1),guidance(:,6)*57.3,'b',sinTraj(:,1),sinTraj(:,8)*57.3,'k');grid on;
legend('弹道倾角','视线高低角','导航俯仰角');


delta_azimuth = guidance(:,7) - sinTraj(:,10); %方位角与偏航角夹角
delta_elevation = guidance(:,6)- sinTraj(:,8); %高低角与俯仰角夹角

delta_angle = acos( (1./cos(delta_azimuth).^2 + 1./cos(delta_elevation).^2 - (tan(delta_azimuth).^2  + tan(delta_elevation).^2 )  )./...
    (2./(cos(delta_azimuth).*cos(delta_elevation)))  );


figure('name','弹轴与弹目连线夹角分解')
subplot(2,1,1);plot(guidance(:,1),delta_elevation*57.3);legend('高低角与俯仰角夹角');grid on;
subplot(2,1,2);plot(guidance(:,1),delta_azimuth*57.3);legend('方位角与偏航角夹角');grid on;

figure('name','弹轴与弹目连线夹角')
plot(guidance(:,1),guidance(:,12)*57.3,'r',guidance(:,1),delta_angle*57.3,'b');grid on;legend('空间求解','平面转化');

figure('name','弹轴与弹目连线夹角')
plot(guidance(:,1),delta_angle*57.3,'b');grid on;



figure('name','转动惯量')
subplot(3,1,1);plot(fcsTraj(:,1),fcsTraj(:,46));legend('Jx');
subplot(3,1,2);plot(fcsTraj(:,1),fcsTraj(:,47));legend('Jy');
subplot(3,1,3);plot(fcsTraj(:,1),fcsTraj(:,48));legend('Jz');

figure('name','气动力系数')
subplot(3,1,1);plot(AeroData(:,1),AeroData(:,2),'r', AeroData(:,1),AeroData(:,10),'b' );grid on;legend('Ca','Cd');grid on;
subplot(3,1,2);plot(AeroData(:,1),AeroData(:,3),'r', AeroData(:,1),AeroData(:,11),'b' );grid on;hold on;legend('Cn','Cl');grid on;
subplot(3,1,3);plot(AeroData(:,1),AeroData(:,4),'r', AeroData(:,1),AeroData(:,12),'b' );grid on;legend('Cz','Czw');grid on;  xlabel('t(s)');

figure('name','气动力系数')
subplot(3,1,1);plot( AeroData(:,1),AeroData(:,10),'b' );ylabel('阻力');grid on;legend('Cd');grid on;
subplot(3,1,2);plot( AeroData(:,1),AeroData(:,11),'b' );ylabel('升力');grid on;hold on;legend('Cl');grid on;
subplot(3,1,3);plot( AeroData(:,1),AeroData(:,12),'b' );ylabel('侧力');grid on;legend('Cz');grid on;  xlabel('t(s)');

figure('name','气动力矩系数')
subplot(3,1,1);plot(AeroData(:,1),AeroData(:,5));grid on; legend('Cmx');ylabel('滚转力矩系数');grid on;
subplot(3,1,2);plot(AeroData(:,1),AeroData(:,6));grid on; legend('Cmy');ylabel('俯仰力矩系数');grid on;
subplot(3,1,3);plot(AeroData(:,1),AeroData(:,7));grid on; legend('Cmz');ylabel('偏航力矩系数');grid on; xlabel('t(s)');

figure('name','配平比')
plot(longchannel(:,1),longchannel(:,18)./longchannel(:,17));grid on;xlabel('Time');ylabel('俯仰通道配平比');legend('配平比');grid on;
grid on; xlabel('t(s)'); 
 
figure('name','舵偏总量')
plot(fcsTraj(:,1),(abs(fcsTraj(:,30))+abs(fcsTraj(:,31))+abs(fcsTraj(:,29)))),grid on;hold on;

figure('name','推力')
plot(fcsTraj(:,1),fcsTraj(:,50));grid on;hold all;
xlabel('飞行时间t(s)');ylabel('推力(N)');

figure('name','质量')
plot(fcsTraj(:,1),fcsTraj(:,51));grid on;hold all;
xlabel('飞行时间t(s)');ylabel('质量(kg)');
a24 = longchannel(:,10);

figure('name','静稳定性')
subplot(2,1,1);plot(longchannel(:,1),longchannel(:,17)./longchannel(:,19));ylabel('纵向静稳定度');grid on;hold on;
subplot(2,1,2);plot(longchannel(:,1),-lateralchannel(:,21)./lateralchannel(:,23));grid on;xlabel('Time');ylabel('航向静稳定度');hold on;

figure('name','静稳定力矩系数')
subplot(3,1,1);plot(lateralchannel(:,1),lateralchannel(:,21));grid on; legend('my_\beta');ylabel('航向静稳定力矩');grid on;
subplot(3,1,2);plot(lateralchannel(:,1),lateralchannel(:,25));grid on; legend('mx_\beta');ylabel('横向静稳定力矩');grid on;
subplot(3,1,3);plot(longchannel(:,1),longchannel(:,17));grid on; legend('my_\beta');ylabel('纵向静稳定力矩');grid on;
grid on; xlabel('t(s)');

figure('name','弹体固有频率')
subplot(2,1,1);plot(longchannel(:,1),sqrt(abs(longchannel(:,10)))/2/3.14,'r');xlabel('Time');ylabel('纵向固有频率HZ');grid on;hold on;
subplot(2,1,2);plot(lateralchannel(:,1),sqrt(abs(lateralchannel(:,11)))/2/3.14,'r');xlabel('Time');ylabel('航向固有频率HZ');grid on;hold on;
% 


