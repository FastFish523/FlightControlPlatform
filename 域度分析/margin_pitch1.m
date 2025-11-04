close all;
clear;
clc;
load longchannel.dat;
load pitch.dat;
load roll.dat;
load fcsTraj.dat;
load lateralchannel.dat;

d2r=pi/180;
r2d=180/pi;

NN=5;
row=length(longchannel(:,1));
residue= mod(row,NN);
integer= row-residue;

Grud = tf([1],[0.01 1]);
Max_L10=[4.0 6.0 8.0 10 15 16];
for jj=1:1:integer/NN

    ii=jj*NN;    
    
    data(jj,1)= longchannel(ii,1);
    a11= longchannel(ii,3);
      
    a13= longchannel(ii,7);
    a14= longchannel(ii,9);  
      
    a21= longchannel(ii,4);
    a22= longchannel(ii,6);    
    a24= longchannel(ii,10);
    a24t= longchannel(ii,11);  %%%%%%%%%%%
    a25= longchannel(ii,13);
    
    a31= longchannel(ii,5); 
    a33= longchannel(ii,8);      
    a34= longchannel(ii,12);  
    a35= longchannel(ii,14);     
   

    AIZ= 1;%%longchannel(ii,15);
    V  = longchannel(ii,16); 
    
    Kp = pitch(ii,4);
    Ki=  pitch(ii,5);
    Kwz= pitch(ii,6);
    
    alpha=fcsTraj(ii,17);
    beta=fcsTraj(ii,18);
    Ma=fcsTraj(ii,19);
 
    data(jj,1)= pitch(ii,1);%time
    data(jj,2)= AIZ;
    data(jj,3)= longchannel(ii,2);%Q
    data(jj,5)= Kp;
    data(jj,6)= Ki;
    data(jj,7)= Kwz;
    
    Km= (-a25*a34+a35*a24)/(a22*a34+a24);
    Tm= 1/(-a24-a22*a34)^0.5;
    Zeta= 0.5*(-a22+a34)/(-a24-a22*a34)^0.5;
    T1= (-a35*a24t+a25)/(a25*a34-a35*a24);
    
    KKm(jj) = Km;
    TTm(jj) = Tm;
    ZZeta(jj) =Zeta;
    TT1(jj) = T1;
    TT(jj) = pitch(ii,1);
    
    data(jj,8)= Km;
    data(jj,9)= T1;
    data(jj,10)= Zeta;
    data(jj,11)= Tm;
    
    Gc=tf([Kp,Ki],[1 0]);
    
    if(a24 < 0)
        body=Grud*tf([Km*T1 Km],[Tm^2 2*Tm*Zeta 1]);   
    else
        body= Grud*tf([ -a35*a24t+a25  a25*a34-a35*a24 ],[1  -a22-a24t+a34 -a24-a22*a34]);
    end
    
    body_kwz= feedback(-AIZ*d2r*body,Kwz);

    [Gm,Pm,wcg,wcp]=margin(-AIZ*d2r*body*Kwz);
    delay_t(jj) =  Pm/(wcp*57.3)*1000;  %允许延迟时间
     
    Zeta_kwz= (2*Zeta*Tm-Kwz*Km*AIZ*d2r*T1)/2/Tm/((1-Kwz*Km*AIZ*d2r)^0.5);
    KKwz(jj) = 2* 0.7*Tm/Km/T1/AIZ/d2r;

    Tm_kwz=Tm/(1-Kwz*Km*AIZ*d2r)^0.5;
    data(jj,12)= Zeta_kwz;
    data(jj,13)= Tm_kwz;  
    
    SysOpen= Gc*body_kwz*tf(1,[T1 1])*V;
    
    SysClose= feedback(SysOpen,1);

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

end

if 1
Vaver=mean(longchannel(:,16));
Vunitary=longchannel(:,16)/Vaver;

% figure('name','V')
% plot(longchannel(:,1),longchannel(:,16));grid on;
% 
% figure('name','a24 a25')
% subplot(2,1,1);  plot(longchannel(:,1),longchannel(:,10),longchannel(:,1),longchannel(:,10).*longchannel(:,15),'r');grid; legend('a24','a24/Q*mean(Q)'); 
% subplot(2,1,2);  plot(longchannel(:,1),longchannel(:,13),longchannel(:,1),longchannel(:,13).*longchannel(:,15),'r');grid; legend('a25','a25/Q*mean(Q)'); xlabel('t(s)');
% figure('name','a24 a25')
% subplot(2,1,1);  plot(longchannel(:,1),longchannel(:,10));grid; legend('a24'); 
% subplot(2,1,2);  plot(longchannel(:,1),longchannel(:,13));grid; legend('a25'); xlabel('t(s)');

% figure('name','Km Tm')
% subplot(2,1,1);  plot(TT(:),KKm(:));grid; legend('Km'); 
% subplot(2,1,2);  plot(TT(:),TTm(:));grid; legend('Tm'); 
% % % 
% % % 
% figure('name','Zeta T1')
% subplot(2,1,1);  plot(TT(:),ZZeta(:));grid; legend('Zeta'); 
% subplot(2,1,2);  plot(TT(:),TT1(:));grid; legend('T1'); 
% 
% 
% figure('name','Zetam')
% plot(data(:,1),data(:,12));grid; legend('Zetam'); 
% figure('name','a22 a34 a35')
% subplot(3,1,1);  plot(longchannel(:,1),longchannel(:,6),longchannel(:,1),longchannel(:,6).*longchannel(:,15).*Vunitary,'r');grid; legend('a22','a22/Q*mean(Q)*V/mean(V)'); 
% subplot(3,1,2);  plot(longchannel(:,1),longchannel(:,12),longchannel(:,1),longchannel(:,12).*longchannel(:,15).*Vunitary,'r');grid; legend('a34','a34/Q*mean(Q)*V/mean(V)'); 
% subplot(3,1,3);  plot(longchannel(:,1),longchannel(:,14),longchannel(:,1),longchannel(:,14).*longchannel(:,15).*Vunitary,'r');grid; legend('a35','a35/Q*mean(Q)*V/mean(V)'); xlabel('t(s)');
% figure('name','Km T1')
% subplot(2,1,1);  plot(data(:,1),data(:,8),data(:,1),data(:,8).*data(:,2).*data(jj,17),'r');grid; legend('Km','Km/Q*mean(Q)*V/mean(V)'); 
% subplot(2,1,2);  plot(data(:,1),data(:,9));grid; ylabel('T1'); xlabel('t(s)');
% figure('name','Zeta Tm')
% subplot(2,1,1);  plot(data(:,1),data(:,10),data(:,1),data(:,12),'r');grid; ylabel('Zeta');legend('origin','modified');
% subplot(2,1,2);  plot(data(:,1),data(:,11),data(:,1),data(:,13),'r');grid; ylabel('Tm'); xlabel('t(s)');legend('origin','modified');
figure('name','Q AIZ')
subplot(2,1,1);  plot(data(:,1),data(:,3));grid; ylabel('Q');
subplot(2,1,2);  plot(data(:,1),data(:,2)); grid; ylabel('AIZ');

figure('name','margin')
subplot(3,1,1);  plot(data(:,1),data(:,14));grid;ylabel('Pm(\circ)');
subplot(3,1,2);  plot(data(:,1),data(:,16));grid;ylabel('Gm(dB)');
subplot(3,1,3);  plot(data(:,1),data(:,4),data(:,1),data(:,15)/2/pi,'r');grid;legend('wb(Hz)','wc(Hz)');xlabel('t(s)');

figure('name','wb/wc')
subplot(2,1,1);  plot(data(:,1),data(:,4));grid;ylabel('wb(Hz)');xlabel('t(s)');
subplot(2,1,2);  plot(data(:,1),data(:,15));grid;ylabel('wc(rad/s)');xlabel('t(s)');
% 
figure('name','弹体阻尼')
plot(data(:,1),data(:,10));grid;ylabel('kesi');xlabel('t(s)');

figure('name','过载')
subplot(2,1,1); plot(fcsTraj(:,1),fcsTraj(:,24), fcsTraj(:,1),fcsTraj(:,26),'r'); legend('flight','command');grid on; ylabel('ny(m/s^2)'); set(gca,'fontsize',8);
subplot(2,1,2); plot(fcsTraj(:,1),fcsTraj(:,25), fcsTraj(:,1),fcsTraj(:,27),'r');legend('flight','command');grid on; xlabel('t(s)');   ylabel('nz(m/s^2)'); set(gca,'fontsize',8);

figure('name','PID参数')
subplot(3,1,1);  plot(pitch(:,1),pitch(:,4));grid;ylabel('Kp');
subplot(3,1,2);  plot(pitch(:,1),pitch(:,5));grid;ylabel('Ki');
subplot(3,1,3);  plot(pitch(:,1),pitch(:,6));grid;xlabel('Kwz');xlabel('t(s)');
hold on;plot(data(:,1),-KKwz(:),'r');

figure('name','攻角 侧滑角、马赫数')
subplot(3,1,1);plot(fcsTraj(:,1),fcsTraj(:,17));grid on; ylabel('\alpha(\circ)'); set(gca,'fontsize',8);
subplot(3,1,2);plot(fcsTraj(:,1),fcsTraj(:,18));grid on; ylabel('\beta(\circ)');  set(gca,'fontsize',8);
subplot(3,1,3);plot(fcsTraj(:,1),fcsTraj(:,19));grid on; ylabel('Mach');          set(gca,'fontsize',8); xlabel('t(s)');

figure('name','延迟时间')
plot(data(:,1),delay_t(:));

% figure('name','mzalpha')
% plot(longchannel(:,1),longchannel(:,17),'b',longchannel(:,1),longchannel(:,23),'r');


% figure('name','wc')
% plot(longchannel(:,1),sqrt(abs(longchannel(:,10)))/2/3.14,'r');
% grid on;
end