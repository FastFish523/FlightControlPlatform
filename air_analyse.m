function varargout = air_analyse(varargin)
% AIR_ANALYSE M-file for air_analyse.fig
%      AIR_ANALYSE, by itself, creates a new AIR_ANALYSE or raises the existing
%      singleton*.
%
%      H = AIR_ANALYSE returns the handle to a new AIR_ANALYSE or the handle to
%      the existing singleton*.
%
%      AIR_ANALYSE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AIR_ANALYSE.M with the given input arguments.
%
%      AIR_ANALYSE('Property','Value',...) creates a new AIR_ANALYSE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before air_analyse_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to air_analyse_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help air_analyse

% Last Modified by GUIDE v2.5 21-Dec-2015 15:04:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @air_analyse_OpeningFcn, ...
                   'gui_OutputFcn',  @air_analyse_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});

end
% End initialization code - DO NOT EDIT


% --- Executes just before air_analyse is made visible.
function air_analyse_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to air_analyse (see VARARGIN)

% Choose default command line output for air_analyse
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
set(gcf,'menubar','figure')
set(gcf,'toolbar','figure')
% UIWAIT makes air_analyse wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = air_analyse_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_lift.
function pushbutton_lift_Callback(hObject, eventdata, handles)
hold off;
load('air_Data.mat');
beta=str2num(get(handles.edit_beta,'string'));
dz=str2num(get(handles.edit_dz,'string'));

chazhi_dz;
color=[{'r'},{'b'},{'g'},{'k'},{'m'},{'y'},{'c'},{'.-'},{'--'},{'*-'},{'o-'}];
for j=1:num_Ma
for i=1:num_alpha
    l(j,i)=n(j,i)*cos(alpha_vec(i)/57.3)-a(j,i)*sin(alpha_vec(i)/57.3);
    d(j,i)=n(j,i)*sin(alpha_vec(i)/57.3)+a(j,i)*cos(alpha_vec(i)/57.3)-z(j,i)*sin(beta/57.3);
    c(j,i)=n(j,i)*sin(alpha_vec(i)/57.3)*sin(beta/57.3)+a(j,i)*cos(alpha_vec(i)/57.3)*sin(beta/57.3)+z(j,i)*cos(beta/57.3);
end
end
temp=cell(1,num_Ma);
for j=1:num_Ma
     plot(alpha_vec,l(j,:),char(color(j)),'LineWidth',2);
     temp{1,j}=num2str(Ma_vec(j));
     hold on
end
grid on;
legend(temp)
xlabel('\alpha/度')
ylabel('L')
title('升力系数')

% hObject    handle to pushbutton_lift (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_drag.
function pushbutton_drag_Callback(hObject, eventdata, handles)
hold off;
load('air_Data.mat');
beta=str2num(get(handles.edit_beta,'string'));
dz=str2num(get(handles.edit_dz,'string'));

chazhi_dz;
color=[{'r'},{'b'},{'g'},{'k'},{'m'},{'y'},{'c'},{'.-'},{'--'},{'*-'},{'o-'}];

for j=1:num_Ma
for i=1:num_alpha
    l(j,i)=n(j,i)*cos(alpha_vec(i)/57.3)-a(j,i)*sin(alpha_vec(i)/57.3);
    d(j,i)=n(j,i)*sin(alpha_vec(i)/57.3)+a(j,i)*cos(alpha_vec(i)/57.3)-z(j,i)*sin(beta/57.3);
    c(j,i)=n(j,i)*sin(alpha_vec(i)/57.3)*sin(beta/57.3)+a(j,i)*cos(alpha_vec(i)/57.3)*sin(beta/57.3)+z(j,i)*cos(beta/57.3);
end
end
temp=cell(1,num_Ma);
for j=1:num_Ma
    plot(alpha_vec,d(j,:),char(color(j)),'LineWidth',2);
     temp{1,j}=num2str(Ma_vec(j));
     hold on
end
grid on
xlabel('\alpha/度')
ylabel('D')
title('阻力系数')
legend(temp)
% hObject    handle to pushbutton_drag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_l_d.
function pushbutton_l_d_Callback(hObject, eventdata, handles)
hold off;
load('air_Data.mat');
beta=str2num(get(handles.edit_beta,'string'));
dz=str2num(get(handles.edit_dz,'string'));

chazhi_dz;
color=[{'r'},{'b'},{'g'},{'k'},{'m'},{'y'},{'c'},{'.-'},{'--'},{'*-'},{'o-'}];

for j=1:num_Ma
for i=1:num_alpha
    l(j,i)=n(j,i)*cos(alpha_vec(i)/57.3)-a(j,i)*sin(alpha_vec(i)/57.3);
    d(j,i)=n(j,i)*sin(alpha_vec(i)/57.3)+a(j,i)*cos(alpha_vec(i)/57.3)-z(j,i)*sin(beta/57.3);
    c(j,i)=n(j,i)*sin(alpha_vec(i)/57.3)*sin(beta/57.3)+a(j,i)*cos(alpha_vec(i)/57.3)*sin(beta/57.3)+z(j,i)*cos(beta/57.3);
end
end
temp=cell(1,num_Ma);
for j=1:num_Ma
       plot(alpha_vec,l(j,:)./d(j,:),char(color(j)),'LineWidth',2)
       temp{1,j}=num2str(Ma_vec(j));
       hold on
end
grid on
xlabel('\alpha/度')
ylabel('L/D')
title('升阻比')
legend(temp)
% hObject    handle to pushbutton_l_d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit_beta_Callback(hObject, eventdata, handles)
% hObject    handle to edit_beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_beta as text
%        str2double(get(hObject,'String')) returns contents of edit_beta as a double


% --- Executes during object creation, after setting all properties.
function edit_beta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dz_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dz as text
%        str2double(get(hObject,'String')) returns contents of edit_dz as a double


% --- Executes during object creation, after setting all properties.
function edit_dz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dx_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dx as text
%        str2double(get(hObject,'String')) returns contents of edit_dx as a double


% --- Executes during object creation, after setting all properties.
function edit_dx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_mz.
function pushbutton_mz_Callback(hObject, eventdata, handles)
hold off;
load('air_Data.mat');
beta=str2num(get(handles.edit_beta,'string'));
dz=str2num(get(handles.edit_dz,'string'));

chazhi_dz;
color=[{'r'},{'b'},{'g'},{'k'},{'m'},{'y'},{'c'},{'.-'},{'--'},{'*-'},{'o-'}];
temp=cell(1,num_Ma);
for j=1:num_Ma
    plot(alpha_vec,fy(j,:),char(color(j)),'LineWidth',2)
    temp{1,j}=num2str(Ma_vec(j));
    hold on
end
grid on
xlabel('\alpha/度')
ylabel('mz')
title('俯仰力矩系数随攻角变化曲线')
legend(temp)
% hObject    handle to pushbutton_mz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_mz_alpha.
function pushbutton_mz_alpha_Callback(hObject, eventdata, handles)
hold off;
load('air_Data.mat');
beta=str2num(get(handles.edit_beta,'string'));
dz=str2num(get(handles.edit_dz,'string'));

chazhi_dz;
color=[{'r'},{'b'},{'g'},{'k'},{'m'},{'y'},{'c'},{'.-'},{'--'},{'*-'},{'o-'}];

for j=1:num_Ma
for i=2:num_alpha
    fy_alpha(j,i)=(fy(j,i)-fy(j,i-1))/(alpha_vec(i)-alpha_vec(i-1));
    fy_alpha(j,1)=fy_alpha(j,2);
end
end

temp=cell(1,num_Ma);
for j=1:num_Ma
        plot(alpha_vec,fy_alpha(j,:),char(color(j)),'LineWidth',2)
        temp{1,j}=num2str(Ma_vec(j));
        hold on
end
grid on
xlabel('\alpha/度')
ylabel('mz_\alpha')
title('mz_\alpha')
legend(temp)
% hObject    handle to pushbutton_mz_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_jwd.
function pushbutton_jwd_Callback(hObject, eventdata, handles)
hold off;
load('air_Data.mat');
beta=str2num(get(handles.edit_beta,'string'));
dz=str2num(get(handles.edit_dz,'string'));

chazhi_dz;
color=[{'r'},{'b'},{'g'},{'k'},{'m'},{'y'},{'c'},{'.-'},{'--'},{'*-'},{'o-'}];

for j=1:num_Ma
for i=1:num_alpha
    l(j,i)=n(j,i)*cos(alpha_vec(i)/57.3)-a(j,i)*sin(alpha_vec(i)/57.3);
    d(j,i)=n(j,i)*sin(alpha_vec(i)/57.3)+a(j,i)*cos(alpha_vec(i)/57.3)-z(j,i)*sin(beta/57.3);
    c(j,i)=n(j,i)*sin(alpha_vec(i)/57.3)*sin(beta/57.3)+a(j,i)*cos(alpha_vec(i)/57.3)*sin(beta/57.3)+z(j,i)*cos(beta/57.3);
end
end

for j=1:num_Ma
for i=2:num_alpha
    fy_alpha(j,i)=(fy(j,i)-fy(j,i-1))/(alpha_vec(i)-alpha_vec(i-1));
    fy_alpha(j,1)=fy_alpha(j,2);
    
    cy_alpha(j,i)=(l(j,i)-l(j,i-1))/(alpha_vec(i)-alpha_vec(i-1));
    cy_alpha(j,1)=cy_alpha(j,2);
end
end
temp=cell(1,num_Ma);
for j=1:num_Ma
      plot(alpha_vec,fy_alpha(j,:)./cy_alpha(j,:),char(color(j)),'LineWidth',2)
      temp{1,j}=num2str(Ma_vec(j));
      hold on
end
grid on
xlabel('\alpha/度')
ylabel('纵向静稳定度')
title('纵向静稳定度')
legend(temp)
% hObject    handle to pushbutton_jwd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_mz_dz.
function pushbutton_mz_dz_Callback(hObject, eventdata, handles)
hold off;
load('air_Data.mat');
beta=str2num(get(handles.edit_beta,'string'));
dz=str2num(get(handles.edit_dz,'string'));

chazhi_dz;
color=[{'r'},{'b'},{'g'},{'k'},{'m'},{'y'},{'c'},{'.-'},{'--'},{'*-'},{'o-'}];
fy1=fy;
dz=dz+2;
chazhi_dz;
fy2=fy;
for j=1:num_Ma
for i=1:num_alpha
    fy_dz(j,i)=(fy2(j,i)-fy1(j,i))/2;
end
end
temp=cell(1,num_Ma);
for j=1:num_Ma
      plot(alpha_vec,fy_dz(j,:),char(color(j)),'LineWidth',2)
      temp{1,j}=num2str(Ma_vec(j));
      hold on
end
grid on
xlabel('\alpha/度')
ylabel('mz_d_z')
title('mz_d_z')
legend(temp)
% hObject    handle to pushbutton_mz_dz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_peiping.
function pushbutton_peiping_Callback(hObject, eventdata, handles)
hold off;
load('air_Data.mat');
beta=str2num(get(handles.edit_beta,'string'));
dz=str2num(get(handles.edit_dz,'string'));

chazhi_dz;
color=[{'r'},{'b'},{'g'},{'k'},{'m'},{'y'},{'c'},{'.-'},{'--'},{'*-'},{'o-'}];

for j=1:num_Ma
for i=2:num_alpha
    fy_alpha(j,i)=(fy(j,i)-fy(j,i-1))/(alpha_vec(i)-alpha_vec(i-1));
    fy_alpha(j,1)=fy_alpha(j,2);
end
end

fy1=fy;
dz=dz+2;
chazhi_dz;
fy2=fy;
for j=1:num_Ma
for i=1:num_alpha
    fy_dz(j,i)=(fy2(j,i)-fy1(j,i))/2;
end
end
temp=cell(1,num_Ma);
for j=1:num_Ma
    plot(alpha_vec,fy_dz(j,:)./fy_alpha(j,:),char(color(j)),'LineWidth',2)
    temp{1,j}=num2str(Ma_vec(j));        
    hold on        
end
grid on
xlabel('\alpha/度')
ylabel('mz_d_z/mz_\alpha')
title('mz_d_z/mz_\alpha')
legend(temp)
% hObject    handle to pushbutton_peiping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_mz_dy.
function pushbutton_mz_dy_Callback(hObject, eventdata, handles)
hold off;
load('air_Data.mat');
beta=str2num(get(handles.edit_beta,'string'));
dy=str2num(get(handles.edit_dy,'string'));

chazhi_dy;
fy1=fy;
dy=dy+2;
chazhi_dy;
fy2=fy;
color=[{'r'},{'b'},{'g'},{'k'},{'m'},{'y'},{'c'},{'.-'},{'--'},{'*-'},{'o-'}];

for j=1:num_Ma
for i=1:num_alpha
    fy_dy(j,i)=(fy2(j,i)-fy1(j,i))/(2);
end
end
temp=cell(1,num_Ma);
for j=1:num_Ma
    plot(alpha_vec,fy_dy(j,:),char(color(j)),'LineWidth',2)
    temp{1,j}=num2str(Ma_vec(j));  
    hold on
end
grid on
xlabel('\alpha/度')
ylabel('mz_d_y')
title('mz_d_y')
legend(temp)
% hObject    handle to pushbutton_mz_dy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_mz_dx.
function pushbutton_mz_dx_Callback(hObject, eventdata, handles)
hold off;
load('air_Data.mat');
beta=str2num(get(handles.edit_beta,'string'));
dx=str2num(get(handles.edit_dx,'string'));

chazhi_dx;
fy1=fy;
dx=dx+2;
chazhi_dx;
fy2=fy;
color=[{'r'},{'b'},{'g'},{'k'},{'m'},{'y'},{'c'},{'.-'},{'--'},{'*-'},{'o-'}];

for j=1:num_Ma
for i=1:num_alpha
    fy_dx(j,i)=(fy2(j,i)-fy1(j,i))/(2);
end
end
temp=cell(1,num_Ma);
for j=1:num_Ma
    plot(alpha_vec,fy_dx(j,:),char(color(j)),'LineWidth',2)
    temp{1,j}=num2str(Ma_vec(j));  
    hold on
end
grid on
xlabel('\alpha/度')
ylabel('mz_d_x')
title('mz_d_x')
legend(temp)

% hObject    handle to pushbutton_mz_dx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_my.
function pushbutton_my_Callback(hObject, eventdata, handles)
hold off;
load('air_Data.mat');
beta=str2num(get(handles.edit_beta,'string'));
dy=str2num(get(handles.edit_dy,'string'));

chazhi_dy;
color=[{'r'},{'b'},{'g'},{'k'},{'m'},{'y'},{'c'},{'.-'},{'--'},{'*-'},{'o-'}];
temp=cell(1,num_Ma);
for j=1:num_Ma
    plot(alpha_vec,ph(j,:),char(color(j)),'LineWidth',2)
    temp{1,j}=num2str(Ma_vec(j));  
    hold on
end
grid on
legend(temp)
xlabel('\alpha/度')
ylabel('my')
title('偏航力矩系数')
% hObject    handle to pushbutton_my (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_my_beta.
function pushbutton_my_beta_Callback(hObject, eventdata, handles)
hold off;
load('air_Data.mat');
beta=str2num(get(handles.edit_beta,'string'));
dy=str2num(get(handles.edit_dy,'string'));

chazhi_dy;
ph1=ph;
beta=beta+2;
chazhi_dy;
ph2=ph;
color=[{'r'},{'b'},{'g'},{'k'},{'m'},{'y'},{'c'},{'.-'},{'--'},{'*-'},{'o-'}];
for j=1:num_Ma
for i=1:num_alpha
    ph_beta(j,i)=(ph2(j,i)-ph1(j,i))/(2);
end
end
temp=cell(1,num_Ma);
for j=1:num_Ma
    plot(alpha_vec,ph_beta(j,:),char(color(j)),'LineWidth',2)
    temp{1,j}=num2str(Ma_vec(j));  
    hold on
end
grid on
xlabel('\alpha/度')
ylabel('my_\beta')
title('my_\beta')
legend(temp)
% hObject    handle to pushbutton_my_beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_my_dy.
function pushbutton_my_dy_Callback(hObject, eventdata, handles)
hold off;
load('air_Data.mat');
beta=str2num(get(handles.edit_beta,'string'));
dy=str2num(get(handles.edit_dy,'string'));

chazhi_dy;
ph1=ph;
dy=dy+2;
chazhi_dy;
ph2=ph;
color=[{'r'},{'b'},{'g'},{'k'},{'m'},{'y'},{'c'},{'.-'},{'--'},{'*-'},{'o-'}];
for j=1:num_Ma
for i=1:num_alpha
    ph_dy(j,i)=(ph2(j,i)-ph1(j,i))/(2);
end
end
temp=cell(1,num_Ma);
for j=1:num_Ma
    plot(alpha_vec,ph_dy(j,:),char(color(j)),'LineWidth',2)
    temp{1,j}=num2str(Ma_vec(j));  
    hold on
end
grid on
xlabel('\alpha/度')
ylabel('my_d_y')
title('my_d_y')
legend(temp)
% hObject    handle to pushbutton_my_dy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_my_dx.
function pushbutton_my_dx_Callback(hObject, eventdata, handles)
hold off;
load('air_Data.mat');
beta=str2num(get(handles.edit_beta,'string'));
dx=str2num(get(handles.edit_dx,'string'));

chazhi_dx;
ph1=ph;
dx=dx+2;
chazhi_dx;
ph2=ph;
color=[{'r'},{'b'},{'g'},{'k'},{'m'},{'y'},{'c'},{'.-'},{'--'},{'*-'},{'o-'}];
for j=1:num_Ma
for i=1:num_alpha
    ph_dx(j,i)=(ph2(j,i)-ph1(j,i))/(2);
end
end
temp=cell(1,num_Ma);
for j=1:num_Ma
    plot(alpha_vec,ph_dx(j,:),char(color(j)),'LineWidth',2)
    temp{1,j}=num2str(Ma_vec(j));  
    hold on
end
grid on
xlabel('\alpha/度')
ylabel('my_d_x')
title('my_d_x')
legend(temp)
% hObject    handle to pushbutton_my_dx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_my_dz.
function pushbutton_my_dz_Callback(hObject, eventdata, handles)
hold off;
load('air_Data.mat');
beta=str2num(get(handles.edit_beta,'string'));
dz=str2num(get(handles.edit_dz,'string'));

chazhi_dz;
ph1=ph;
dz=dz+2;
chazhi_dz;
ph2=ph;
color=[{'r'},{'b'},{'g'},{'k'},{'m'},{'y'},{'c'},{'.-'},{'--'},{'*-'},{'o-'}];
for j=1:num_Ma
for i=1:num_alpha
    ph_dz(j,i)=(ph2(j,i)-ph1(j,i))/(2);
end
end
temp=cell(1,num_Ma);
for j=1:num_Ma
    plot(alpha_vec,ph_dz(j,:),char(color(j)),'LineWidth',2)
    temp{1,j}=num2str(Ma_vec(j));  
    hold on
end
grid on
xlabel('\alpha/度')
ylabel('my_d_z')
title('my_d_z')
legend(temp)
% hObject    handle to pushbutton_my_dz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_mx.
function pushbutton_mx_Callback(hObject, eventdata, handles)
hold off;
load('air_Data.mat');
beta=str2num(get(handles.edit_beta,'string'));
dx=str2num(get(handles.edit_dx,'string'));

chazhi_dx;
color=[{'r'},{'b'},{'g'},{'k'},{'m'},{'y'},{'c'},{'.-'},{'--'},{'*-'},{'o-'}];
temp=cell(1,num_Ma);
for j=1:num_Ma
    plot(alpha_vec,gz(j,:),char(color(j)),'LineWidth',2)
    temp{1,j}=num2str(Ma_vec(j));  
    hold on
end
grid on
legend(temp)
xlabel('\alpha/度')
ylabel('mx')
title('滚转力矩系数')
% hObject    handle to pushbutton_mx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_mx_beta.
function pushbutton_mx_beta_Callback(hObject, eventdata, handles)
hold off;
load('air_Data.mat');
beta=str2num(get(handles.edit_beta,'string'));
dx=str2num(get(handles.edit_dy,'string'));

chazhi_dx;
gz1=gz;
beta=beta+2;
chazhi_dx;
gz2=gz;
color=[{'r'},{'b'},{'g'},{'k'},{'m'},{'y'},{'c'},{'.-'},{'--'},{'*-'},{'o-'}];
for j=1:num_Ma
for i=1:num_alpha
    gz_beta(j,i)=(gz2(j,i)-gz1(j,i))/(2);
end
end
temp=cell(1,num_Ma);
for j=1:num_Ma
    plot(alpha_vec,gz_beta(j,:),char(color(j)),'LineWidth',2)
    temp{1,j}=num2str(Ma_vec(j));  
    hold on
end
grid on
xlabel('\alpha/度')
ylabel('mx_\beta')
title('mx_\beta')
legend(temp)
% hObject    handle to pushbutton_mx_beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_grid_on.
function pushbutton_grid_on_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_grid_on (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_grid_off.
function pushbutton_grid_off_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_grid_off (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_hold_on.
function pushbutton_hold_on_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_hold_on (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_hold_off.
function pushbutton_hold_off_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_hold_off (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in pushbutton_ok.
function pushbutton_ok_Callback(hObject, eventdata, handles)


% hObject    handle to pushbutton_ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in pushbutton_mx_dx.
function pushbutton_mx_dx_Callback(hObject, eventdata, handles)
hold off;
load('air_Data.mat');
beta=str2num(get(handles.edit_beta,'string'));
dx=str2num(get(handles.edit_dx,'string'));

chazhi_dx;
gz1=gz;
dx=dx+2;
chazhi_dx;
gz2=gz;
color=[{'r'},{'b'},{'g'},{'k'},{'m'},{'y'},{'c'},{'.-'},{'--'},{'*-'},{'o-'}];
for j=1:num_Ma
for i=1:num_alpha
    gz_dx(j,i)=(gz2(j,i)-gz1(j,i))/(2);
end
end
temp=cell(1,num_Ma);
for j=1:num_Ma
    plot(alpha_vec,gz_dx(j,:),char(color(j)),'LineWidth',2)
    temp{1,j}=num2str(Ma_vec(j));  
    hold on
end
grid on
xlabel('\alpha/度')
ylabel('mx_d_x')
title('mx_d_x')
legend(temp)
% hObject    handle to pushbutton_mx_dx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in pushbutton_mx_dy.
function pushbutton_mx_dy_Callback(hObject, eventdata, handles)
hold off;
load('air_Data.mat');
beta=str2num(get(handles.edit_beta,'string'));
dy=str2num(get(handles.edit_dy,'string'));

chazhi_dy;
gz1=gz;
dy=dy+2;
chazhi_dy;
gz2=gz;
color=[{'r'},{'b'},{'g'},{'k'},{'m'},{'y'},{'c'},{'.-'},{'--'},{'*-'},{'o-'}];
for j=1:num_Ma
for i=1:num_alpha
    gz_dy(j,i)=(gz2(j,i)-gz1(j,i))/(2);
end
end
temp=cell(1,num_Ma);
for j=1:num_Ma
    plot(alpha_vec,gz_dy(j,:),char(color(j)),'LineWidth',2)
    temp{1,j}=num2str(Ma_vec(j));  
    hold on
end
grid on
xlabel('\alpha/度')
ylabel('mx_d_y')
title('mx_d_y')
legend(temp)
% hObject    handle to pushbutton_mx_dy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in pushbutton_mx_dz.
function pushbutton_mx_dz_Callback(hObject, eventdata, handles)
hold off;
load('air_Data.mat');
beta=str2num(get(handles.edit_beta,'string'));
dz=str2num(get(handles.edit_dz,'string'));

chazhi_dz;
gz1=gz;
dz=dz+2;
chazhi_dz;
gz2=gz;
color=[{'r'},{'b'},{'g'},{'k'},{'m'},{'y'},{'c'},{'.-'},{'--'},{'*-'},{'o-'}];
for j=1:num_Ma
for i=1:num_alpha
    gz_dz(j,i)=(gz2(j,i)-gz1(j,i))/(2);
end
end
temp=cell(1,num_Ma);
for j=1:num_Ma
    plot(alpha_vec,gz_dz(j,:),char(color(j)),'LineWidth',2)
    temp{1,j}=num2str(Ma_vec(j));  
    hold on
end
grid on
xlabel('\alpha/度')
ylabel('mx_d_z')
title('mx_d_z')
legend(temp)
% hObject    handle to pushbutton_mx_dz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in pushbutton_cy_alpha.
function pushbutton_cy_alpha_Callback(hObject, eventdata, handles)
hold off;
load('air_Data.mat');
beta=str2num(get(handles.edit_beta,'string'));
dz=str2num(get(handles.edit_dz,'string'));

chazhi_dz;
color=[{'r'},{'b'},{'g'},{'k'},{'m'},{'y'},{'c'},{'.-'},{'--'},{'*-'},{'o-'}];
for j=1:num_Ma
    for i=1:num_alpha
        l(j,i)=n(j,i)*cos(alpha_vec(i)/57.3)-a(j,i)*sin(alpha_vec(i)/57.3);
        d(j,i)=n(j,i)*sin(alpha_vec(i)/57.3)+a(j,i)*cos(alpha_vec(i)/57.3)-z(j,i)*sin(beta/57.3);
        c(j,i)=n(j,i)*sin(alpha_vec(i)/57.3)*sin(beta/57.3)+a(j,i)*cos(alpha_vec(i)/57.3)*sin(beta/57.3)+z(j,i)*cos(beta/57.3);
    end
end
for j=1:num_Ma
for i=2:num_alpha
    cy_alpha(j,i)=(l(j,i)-l(j,i-1))/(alpha_vec(i)-alpha_vec(i-1));
    cy_alpha(j,1)=cy_alpha(j,2);
end
end
temp=cell(1,num_Ma);
for j=1:num_Ma
     plot(alpha_vec,cy_alpha(j,:),char(color(j)),'LineWidth',2);
     temp{1,j}=num2str(Ma_vec(j));
     hold on
end
grid on;
legend(temp)
xlabel('\alpha/度')
ylabel('cy_\alpha')
title('升力系数随攻角导数')
% hObject    handle to pushbutton_cy_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_cy_dz.
function pushbutton_cy_dz_Callback(hObject, eventdata, handles)
hold off;
load('air_Data.mat');
beta=str2num(get(handles.edit_beta,'string'));
dz=str2num(get(handles.edit_dz,'string'));
color=[{'r'},{'b'},{'g'},{'k'},{'m'},{'y'},{'c'},{'.-'},{'--'},{'*-'},{'o-'}];

chazhi_dz;
for j=1:num_Ma
for i=1:num_alpha
    l(j,i)=n(j,i)*cos(alpha_vec(i)/57.3)-a(j,i)*sin(alpha_vec(i)/57.3);
    d(j,i)=n(j,i)*sin(alpha_vec(i)/57.3)+a(j,i)*cos(alpha_vec(i)/57.3)-z(j,i)*sin(beta/57.3);
    c(j,i)=n(j,i)*sin(alpha_vec(i)/57.3)*sin(beta/57.3)+a(j,i)*cos(alpha_vec(i)/57.3)*sin(beta/57.3)+z(j,i)*cos(beta/57.3);
end
end
l1=l;
dz=dz+2;
chazhi_dz;
for j=1:num_Ma
for i=1:num_alpha
    l(j,i)=n(j,i)*cos(alpha_vec(i)/57.3)-a(j,i)*sin(alpha_vec(i)/57.3);
    d(j,i)=n(j,i)*sin(alpha_vec(i)/57.3)+a(j,i)*cos(alpha_vec(i)/57.3)-z(j,i)*sin(beta/57.3);
    c(j,i)=n(j,i)*sin(alpha_vec(i)/57.3)*sin(beta/57.3)+a(j,i)*cos(alpha_vec(i)/57.3)*sin(beta/57.3)+z(j,i)*cos(beta/57.3);
end
end
l2=l;
for j=1:num_Ma
for i=2:num_alpha
    cy_dz(j,i)=(l2(j,i)-l1(j,i))/(2);
end
end
temp=cell(1,num_Ma);
for j=1:num_Ma
     plot(alpha_vec,cy_dz(j,:),char(color(j)),'LineWidth',2);
     temp{1,j}=num2str(Ma_vec(j));
     hold on
end
grid on;
legend(temp)
xlabel('\alpha/度')
ylabel('cy_d_z')
title('升力系数随升降舵偏导数')
% hObject    handle to pushbutton_cy_dz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in pushbutton_CopyFigure.
function pushbutton_CopyFigure_Callback(hObject, eventdata, handles)
new_f_handle=figure('visible','on');
new_axes=copyobj(handles.m_plot,new_f_handle);
load('air_Data.mat');
temp=cell(1,num_Ma);
for j=1:num_Ma
     temp{1,j}=num2str(Ma_vec(j));
end
legend(temp)
set(new_axes,'units','default','position','default');

% hObject    handle to pushbutton_CopyFigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in pushbutton_hjwd.
function pushbutton_hjwd_Callback(hObject, eventdata, handles)
hold off;
load('air_Data.mat');
beta=str2num(get(handles.edit_beta,'string'));
dy=str2num(get(handles.edit_dy,'string'));

chazhi_dy;
ph1=ph;
z1=z;
beta=beta+2;
chazhi_dy;
ph2=ph;
z2=z;
color=[{'r'},{'b'},{'g'},{'k'},{'m'},{'y'},{'c'},{'.-'},{'--'},{'*-'},{'o-'}];
for j=1:num_Ma
for i=1:num_alpha
    ph_beta(j,i)=(ph2(j,i)-ph1(j,i))/(2);
    z_beta(j,i)=(z2(j,i)-z1(j,i))/(2);
end
end
cz_ph_beta=ph_beta./z_beta;
temp=cell(1,num_Ma);
for j=1:num_Ma
    plot(alpha_vec,cz_ph_beta(j,:),char(color(j)),'LineWidth',2)
    temp{1,j}=num2str(Ma_vec(j));  
    hold on
end
grid on
xlabel('\alpha/度')
ylabel('my_\beta/cz_\beta')
title('航向静稳定度')
legend(temp)
% hObject    handle to pushbutton_hjwd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in pushbutton_cz_beta.
function pushbutton_cz_beta_Callback(hObject, eventdata, handles)
hold off;
load('air_Data.mat');
beta=str2num(get(handles.edit_beta,'string'));
dy=str2num(get(handles.edit_dy,'string'));

chazhi_dy;
ph1=ph;
z1=z;
beta=beta+2;
chazhi_dy;
ph2=ph;
z2=z;
color=[{'r'},{'b'},{'g'},{'k'},{'m'},{'y'},{'c'},{'.-'},{'--'},{'*-'},{'o-'}];
for j=1:num_Ma
for i=1:num_alpha
    ph_beta(j,i)=(ph2(j,i)-ph1(j,i))/(2);
    z_beta(j,i)=(z2(j,i)-z1(j,i))/(2);
end
end
cz_ph_beta=ph_beta./z_beta;
temp=cell(1,num_Ma);
for j=1:num_Ma
    plot(alpha_vec,z_beta(j,:),char(color(j)),'LineWidth',2)
    temp{1,j}=num2str(Ma_vec(j));  
    hold on
end
grid on
xlabel('\alpha/度')
ylabel('cz_\beta')
title('侧力')
legend(temp)
% hObject    handle to pushbutton_cz_beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)








% --- Executes on button press in pushbutton34.
function pushbutton34_Callback(hObject, eventdata, handles)
hold off;
load('air_Data.mat');
beta=str2num(get(handles.edit_beta,'string'));
dz=str2num(get(handles.edit_dz,'string'));

chazhi_dz;
for j=1:num_Ma
for i=1:num_alpha
    l(j,i)=n(j,i)*cos(alpha_vec(i)/57.3)-a(j,i)*sin(alpha_vec(i)/57.3);
    d(j,i)=n(j,i)*sin(alpha_vec(i)/57.3)+a(j,i)*cos(alpha_vec(i)/57.3)-z(j,i)*sin(beta/57.3);
    c(j,i)=n(j,i)*sin(alpha_vec(i)/57.3)*sin(beta/57.3)+a(j,i)*cos(alpha_vec(i)/57.3)*sin(beta/57.3)+z(j,i)*cos(beta/57.3);
end
end

color=[{'r'},{'b'},{'g'},{'k'},{'m'},{'y'},{'c'},{'.-'},{'--'},{'*-'},{'o-'}];

for j=1:num_Ma
for i=2:num_alpha
    fy_alpha(j,i)=(fy(j,i)-fy(j,i-1))/(alpha_vec(i)-alpha_vec(i-1));
    fy_alpha(j,1)=fy_alpha(j,2);
    
    cy_alpha(j,i)=(l(j,i)-l(j,i-1))/(alpha_vec(i)-alpha_vec(i-1));
    cy_alpha(j,1)=cy_alpha(j,2);
end
end

fy1=fy;
l1=l;
dz=dz+2;
chazhi_dz;
for j=1:num_Ma
for i=1:num_alpha
    l(j,i)=n(j,i)*cos(alpha_vec(i)/57.3)-a(j,i)*sin(alpha_vec(i)/57.3);
    d(j,i)=n(j,i)*sin(alpha_vec(i)/57.3)+a(j,i)*cos(alpha_vec(i)/57.3)-z(j,i)*sin(beta/57.3);
    c(j,i)=n(j,i)*sin(alpha_vec(i)/57.3)*sin(beta/57.3)+a(j,i)*cos(alpha_vec(i)/57.3)*sin(beta/57.3)+z(j,i)*cos(beta/57.3);
end
end
fy2=fy;
l2=l;
for j=1:num_Ma
for i=1:num_alpha
    fy_dz(j,i)=(fy2(j,i)-fy1(j,i))/2;
    cy_dz(j,i)=(l2(j,i)-l1(j,i))/(2);
end
end
temp=cell(1,num_Ma);
for j=1:num_Ma
    plot(alpha_vec,1./(1-(cy_alpha(j,:)./cy_dz(j,:)).*(fy_dz(j,:)./fy_alpha(j,:))),char(color(j)),'LineWidth',2)
    temp{1,j}=num2str(Ma_vec(j));        
    hold on        
end
grid on
xlabel('\alpha/度')
ylabel('配平态下舵偏升力占总升力大小')
title('升力比')
legend(temp)
% hObject    handle to pushbutton34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


