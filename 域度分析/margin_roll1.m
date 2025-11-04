close all;
clear;
clc;
load longchannel.dat;
% load  longchannel1.dat;
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

% Grud=tf([125.1/499.2 1],[1/499.2 125.1/499.2 1]);
Grud = tf([62.814],[1,62.814]);
Max_L10=[4.0 6.0 8.0 10 15 16];
for jj=1:1:integer/NN
% for jj=Max_L10
    s = tf('s');
    ii=jj*NN;    
    data(jj,1)= lateralchannel(ii,1);
    Q  = lateralchannel(ii,2);
    b11 = lateralchannel(ii,4);
    b17 = lateralchannel(ii,8);
    
    Kmx= -b17/b11;
    Tmx=  -1/b11;

    KpX = roll(ii,5);
    KiX =  roll(ii,6);
    Kwx =  roll(ii,7);
    
    alpha=fcsTraj(ii,17);
    beta=fcsTraj(ii,18);
    Ma=fcsTraj(ii,19);
 
    Gpi=tf([KpX KiX],[1 0]);
    zpk(Gpi);

    body = tf(-d2r*Kmx,[Tmx,1]);
    zpk(body);

    Gr = tf([90*90],[1,2*0.7*90,90*90]);
    G0 = body*Gr; zpk(G0);
    
    SysIner=feedback(G0,Kwx);
    [Gm1,Pm1,wcg1,wcp1]=margin(G0*Kwx);
    delay_t(jj) =  Pm1/(wcp1*57.3)*1000;
    
    Gb2=SysIner/s;
    
    SysOpen=Gpi*Gb2;
    SysClose=feedback(SysOpen,1);
    
    bd=bandwidth(SysClose)/2/pi;
   
    [Gm,Pm,wcg,wcp]=margin(SysOpen);  %wcp截止频率

%     figure;
%     margin(SysClose);

    data(jj,4)= Pm;
    data(jj,5)= Gm;
    data(jj,6)= wcp;
    bd=bandwidth(SysClose);
    data(jj,7)= bd;
    
   
    if Gm>100
        data(jj,16)=100;
    end
    data(jj,3)=bd;

end
if 1


figure('name','V')
plot(longchannel(:,1),longchannel(:,16));grid on;

figure('name','b11 b17')
subplot(2,1,1);  plot(lateralchannel(:,1),lateralchannel(:,4));grid; legend('b11'); 
subplot(2,1,2);  plot(lateralchannel(:,1),lateralchannel(:,8));grid; legend('b17'); 
% % 


figure('name','margin')
subplot(3,1,1);  plot(data(:,1),data(:,4));grid;ylabel('Pm(\circ)');
subplot(3,1,2);  plot(data(:,1),data(:,5));grid;ylabel('Gm(dB)');
subplot(3,1,3);  plot(data(:,1),data(:,6)/2/pi,data(:,1),data(:,7)/2/pi,'r');grid;ylabel('截频与带宽');legend('wc(Hz)','wb(Hz)');xlabel('t(s)');


% figure('name','弹体阻尼')
% plot(data(:,1),data(:,21));grid;ylabel('kesi');xlabel('t(s)');

figure('name','过载')
subplot(2,1,1); plot(fcsTraj(:,1),fcsTraj(:,24), fcsTraj(:,1),fcsTraj(:,26),'r'); legend('flight','command');grid on; ylabel('ny(m/s^2)'); set(gca,'fontsize',8);
subplot(2,1,2); plot(fcsTraj(:,1),fcsTraj(:,25), fcsTraj(:,1),fcsTraj(:,27),'r');legend('flight','command');grid on; xlabel('t(s)');   ylabel('nz(m/s^2)'); set(gca,'fontsize',8);

figure('name','PID参数')
subplot(3,1,1);  plot(roll(:,1),roll(:,5));grid;ylabel('Kp');
subplot(3,1,2);  plot(roll(:,1),roll(:,6));grid;ylabel('Ki');
subplot(3,1,3);  plot(roll(:,1),roll(:,7));grid;ylabel('Kw');xlabel('t(s)');


figure('name','攻角 侧滑角、马赫数')
subplot(3,1,1);plot(fcsTraj(:,1),fcsTraj(:,17));grid on; ylabel('\alpha(\circ)'); set(gca,'fontsize',8);
subplot(3,1,2);plot(fcsTraj(:,1),fcsTraj(:,18));grid on; ylabel('\beta(\circ)');  set(gca,'fontsize',8);
subplot(3,1,3);plot(fcsTraj(:,1),fcsTraj(:,19));grid on; ylabel('Mach');          set(gca,'fontsize',8); xlabel('t(s)');

figure('name','延迟时间')
plot(data(:,1),delay_t(:));xlabel('t(s)');ylabel('延时时间(ms）');grid on
end