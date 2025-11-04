close all;
clear;
clc;
load lateralchannel.dat;
load yaw.dat;
load guidance.dat;
load roll.dat;
load fcsTraj.dat;
load AeroData.dat;

figure('name','b24 b25')
subplot(2,1,1);  plot(lateralchannel(:,1),lateralchannel(:,10));grid; legend('b24'); 
subplot(2,1,2);  plot(lateralchannel(:,1),lateralchannel(:,11));grid; legend('b25'); xlabel('t(s)');



NN=10;
row=length(yaw(:,1));
residue= mod(row,NN);
integer= row-residue;
data=zeros(integer/NN,16);
r2d=180/pi;
d2r=pi/180;
data=zeros(integer/NN,16);
Grud=tf([125.1/499.2 1],[1/499.2 125.1/499.2 1]);
zz=0;
for jj=1:1:integer/NN
    ii=jj*NN;   
    
    data(jj,1)= lateralchannel(ii,1);
     
    
    b22= lateralchannel(ii,10);
    b24=lateralchannel(ii,11);
    b25= lateralchannel(ii,19);
    b34= lateralchannel(ii,13);
    b35= lateralchannel(ii,14);
   
    

    V  = lateralchannel(ii,18);
    pathangle= guidance(ii,4);
    pitch=lateralchannel(ii,3);
    AIY= 1;%%yaw(ii,11);
    Kpy = yaw(ii,4);
    Kiy= yaw(ii,5);
    Kwy= yaw(ii,6);
    
    data(jj,1)= yaw(ii,1);
    data(jj,2)= AIY;
    data(jj,3)= roll(ii,11);;
    data(jj,5)= Kpy;
    data(jj,6)= Kiy;
    data(jj,7)= Kwy;
    
     if(b24 < 0)
    Km= (-b25*b34+b35*b24)/(b22*b34+b24);
    Tm= 1/(-b24-b22*b34)^0.5;
    Zeta= 0.5*(-b22+b34)/(-b24-b22*b34)^0.5;
    T1= b25/(b25*b34-b35*b24);
    
    body=tf(-d2r*[Km*T1 Km],[Tm^2 2*Tm*Zeta 1]);
 else
    Km= (-b25*b34+b35*b24)/(b22*b34+b24);
    Tm= -1/(b24+b22*b34)^0.5;
    Zeta= 0.5*(-b22+b34)/(b24+b22*b34)^0.5;
    T1= b25/(b25*b34-b35*b24);
   
%     body=Grud*tf(-d2r*[Km*T1 Km],[Tm^2 2*Tm*Zeta 1]);   
   body=-d2r* tf([ b25  b25*b34-b35*b24 ],[1  -b22+b34 -b24-b22*b34]);
     end 
 

%     Km= (-b25*b34+b35*b24)/(b22*b34+b24);
%     Tm= 1/(-b24-b22*b34)^0.5;
%     Zeta= 0.5*(-b22+b34)/(-b24-b22*b34)^0.5;
%     T1= b25/(b25*b34-b35*b24);
  
    data(jj,8)= Km;
    data(jj,9)= T1;
    data(jj,10)= Zeta;
    data(jj,11)= Tm;

    Gc=tf([Kpy,Kiy],[1 0]);
    Gr = tf([90*90],[1,2*0.7*90,90*90]);

    zpk(body);
    [Gm,Pm,wcg,wcp]=margin(body*Kwy);
    delay_t(jj) =  Pm/(wcp*57.3)*1000;  %允许延迟时间
    
    body_kwy= feedback(body,Kwy,-1);
    Zeta_kwy= (2*Zeta*Tm-Kwy*Km*AIY*d2r*T1)/2/Tm/(1-Kwy*Km*AIY*d2r)^0.5;
    Tm_kwy=Tm/(1-Kwy*Km*AIY*d2r)^0.5;
    data(jj,12)= Zeta_kwy;
    data(jj,13)= Tm_kwy;
     
    
    
    SysOpen= Gc*body_kwy*tf(1,[T1 1])*V*cos(pathangle);
    SysClose= feedback(SysOpen,1);
    step(SysClose)
    bd=bandwidth(SysClose)/2/pi;
    
   [Gm,Pm,wcg,wcp]=margin(SysOpen);  %wcp截止频率
    Gmdb=20*log10(Gm);
    
    data(jj,14)= Pm;
    data(jj,15)= wcp;
    data(jj,16)= Gmdb;
    if Gmdb>100
        data(jj,16)=100;
    end
    data(jj,4)=bd;
%     data(jj,17)=lateralchannel(ii,30);

    
end

% Ts=lateralchannel(2,1)-lateralchannel(1,1);
% ii= 100/Ts;
% b22= lateralchannel(ii,9);
% b24= lateralchannel(ii,10);
% b34= lateralchannel(ii,13);
% b25= lateralchannel(ii,11);
% b35= lateralchannel(ii,14);
% AIY= yaw(ii,11);
% V  = lateralchannel(ii,18);
% 
% Km= (-b25*b34+b35*b24)/(b22*b34+b24);
% Tm= 1/(-b24-b22*b34)^0.5;
% Zeta= 0.5*(-b22+b34)/(-b24-b22*b34)^0.5;
% T1= b25/(b25*b34-b35*b24);
% 
% body= tf([-Km],[Tm^2 2*Tm*Zeta 1]);
% figure('name','弹体特性');
% bode(body);grid;
% 
% figure('name','state')
% subplot(3,1,1);plot(fcsTraj(:,1),fcsTraj(:,17));grid on; ylabel('\alpha(\circ)'); set(gca,'fontsize',8);
% subplot(3,1,2);plot(fcsTraj(:,1),fcsTraj(:,18));grid on; ylabel('\beta(\circ)');  set(gca,'fontsize',8);
% subplot(3,1,3);plot(fcsTraj(:,1),fcsTraj(:,19));grid on; ylabel('Mach');          set(gca,'fontsize',8); xlabel('t(s)');
% 
% figure('name','b24 b25')
% subplot(2,1,1);  plot(lateralchannel(:,1),lateralchannel(:,10),lateralchannel(:,1),lateralchannel(:,10).*yaw(:,11),'r');grid; legend('b24','b24*mean(Q)/Q'); 
% subplot(2,1,2);  plot(lateralchannel(:,1),lateralchannel(:,11),lateralchannel(:,1),lateralchannel(:,11).*yaw(:,11),'r');grid; legend('b25','b25*mean(Q)/Q'); xlabel('t(s)');
% 
% Vaver=mean(lateralchannel(:,18));
% Vunitary=lateralchannel(:,18)/Vaver;
% figure('name','b22 b34 b35')
% subplot(3,1,1);  plot(lateralchannel(:,1),lateralchannel(:,9),lateralchannel(:,1),lateralchannel(:,9).*yaw(:,11).*Vunitary,'r');grid; legend('b22','b22*mean(Q)/Q*V/mean(V)'); 
% subplot(3,1,2);  plot(lateralchannel(:,1),lateralchannel(:,13),lateralchannel(:,1),lateralchannel(:,13).*yaw(:,11).*Vunitary,'r');grid; legend('b34','b34*mean(Q)/Q*V/mean(V)'); 
% subplot(3,1,3);  plot(lateralchannel(:,1),lateralchannel(:,14),lateralchannel(:,1),lateralchannel(:,14).*yaw(:,11).*Vunitary,'r');grid; legend('b35','b35*mean(Q)/Q*V/mean(V)'); xlabel('t(s)');
% figure('name','Km T1')
% subplot(2,1,1);  plot(data(:,1),data(:,8));grid; ylabel('Km'); 
% subplot(2,1,2);  plot(data(:,1),data(:,9));grid; ylabel('T1'); xlabel('t(s)');
% figure('name','Zeta Tm')
% subplot(2,1,1);  plot(data(:,1),data(:,10),data(:,1),data(:,12),'r');grid; ylabel('Zeta');legend('origin','modified');
% subplot(2,1,2);  plot(data(:,1),data(:,11),data(:,1),data(:,13),'r');grid; ylabel('Tm'); xlabel('t(s)');legend('origin','modified');
% figure('name','pathangle V')
% subplot(2,1,1); plot(guidance(:,1),guidance(:,4)*57.3);grid; ylabel('\theta(\circ)');
% subplot(2,1,2); plot(lateralchannel(:,1),lateralchannel(:,18));grid; ylabel('V(m\cdots^{-2})');
% figure('name','Q AIZ')
% subplot(2,1,1);  plot(data(:,1),data(:,3));grid; ylabel('Q');
% subplot(2,1,2);  plot(data(:,1),data(:,2)); grid; ylabel('AIY');
figure('name','PID')
subplot(3,1,1);  plot(data(:,1),data(:,5));grid; ylabel('P');   
subplot(3,1,2);  plot(data(:,1),data(:,6));grid; ylabel('I'); 
subplot(3,1,3);  plot(data(:,1),data(:,7));grid; ylabel('Kwy');xlabel('t(s)');
% figure('name','margin')
% subplot(3,1,1);  plot(data(:,1),data(:,14));grid;ylabel('Pm(\circ)');
% subplot(3,1,2);  plot(data(:,1),data(:,16));grid;ylabel('Gm(dB)');
% subplot(3,1,3);  plot(data(:,1),data(:,4));grid;ylabel('wb(Hz)');xlabel('t(s)');


figure('name','margin')
subplot(3,1,1);  plot(data(:,1),data(:,14));grid;ylabel('Pm(\circ)');
subplot(3,1,2);  plot(data(:,1),data(:,16));grid;ylabel('Gm(dB)');
subplot(3,1,3);  plot(data(:,1),data(:,4),data(:,1),data(:,15)/2/pi,'r');grid;legend('wb(Hz)','wc(Hz)');xlabel('t(s)');


figure('name','wb/wc')
subplot(2,1,1);  plot(data(:,1),data(:,4));grid;ylabel('wb(Hz)');xlabel('t(s)');
subplot(2,1,2);  plot(data(:,1),data(:,15));grid;ylabel('wc(rad/s)');xlabel('t(s)');

% figure('name','弹体阻尼')
% plot(data(:,1),data(:,17));grid;ylabel('kesi');xlabel('t(s)');

figure('name','acc')
subplot(3,1,1); plot(fcsTraj(:,1),fcsTraj(:,24), fcsTraj(:,1),fcsTraj(:,26),'r', fcsTraj(:,1),fcsTraj(:,28),'g' ); legend('flight','command','maximun');grid on; ylabel('ny(m/s^2)'); set(gca,'fontsize',8);
subplot(3,1,2); plot(fcsTraj(:,1),fcsTraj(:,25), fcsTraj(:,1),fcsTraj(:,27),'r');legend('flight','command');grid on; xlabel('t(s)');   ylabel('nz(m/s^2)'); set(gca,'fontsize',8);
subplot(3,1,3); plot(fcsTraj(:,1),fcsTraj(:,23));legend('flight');  ylabel('nx(m/s^2)');grid on; set(gca,'fontsize',8);
% figure('name','roll')
% subplot(3,1,1);plot(roll(:,1),roll(:,2)*r2d,'r',roll(:,1),roll(:,3)*r2d,'b');grid on;legend('指令','响应'); ylabel('\gamma(\circ)'); set(gca,'fontsize',8);
% subplot(3,1,2);plot(roll(:,1),roll(:,4)*r2d,'r');grid on; ylabel('\omega_x(\circ/s)'),set(gca,'fontsize',8); 
% subplot(3,1,3);plot(fcsTraj(:,1),fcsTraj(:,21), fcsTraj(:,1),fcsTraj(:,30),'r' );grid on;ylabel('\delta_x(\circ)');legend('flight','commamd'), set(gca,'fontsize',8);xlabel('t(s)');

figure('name','mybeta')
plot(lateralchannel(:,1),lateralchannel(:,24));xlabel('t');ylabel('mybeta');grid on;

figure('name','气动力系数')
subplot(3,1,1);plot(AeroData(:,1),AeroData(:,2),'r', AeroData(:,1),AeroData(:,10),'b' );grid on;legend('Ca','Cd');grid on;
subplot(3,1,2);plot(AeroData(:,1),AeroData(:,3),'r', AeroData(:,1),AeroData(:,11),'b' );grid on;hold on;legend('Cn','Cl');grid on;
subplot(3,1,3);plot(AeroData(:,1),AeroData(:,4),'r', AeroData(:,1),AeroData(:,12),'b' );grid on;legend('Cz','Czw');grid on;  xlabel('t(s)');

figure('name','气动力矩系数')
subplot(3,1,1);plot(AeroData(:,1),AeroData(:,5));grid on; legend('Cmx');ylabel('Cmx');grid on;
subplot(3,1,2);plot(AeroData(:,1),AeroData(:,6));grid on; legend('Cmy');ylabel('Cmy');grid on;
subplot(3,1,3);plot(AeroData(:,1),AeroData(:,7));grid on; legend('Cmz');ylabel('Cmz');grid on; xlabel('t(s)');

figure('name','延迟时间')
plot(data(:,1),delay_t(:));

