function varargout = sim_3dof(varargin)
% SIM_3DOF M-file for sim_3dof.fig
%      SIM_3DOF, by itself, creates a new SIM_3DOF or raises the existing
%      singleton*.
%
%      H = SIM_3DOF returns the handle to a new SIM_3DOF or the handle to
%      the existing singleton*.
%
%      SIM_3DOF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIM_3DOF.M with the given input arguments.
%
%      SIM_3DOF('Property','Value',...) creates a new SIM_3DOF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sim_3dof_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sim_3dof_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sim_3dof

% Last Modified by GUIDE v2.5 31-Dec-2015 14:18:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sim_3dof_OpeningFcn, ...
                   'gui_OutputFcn',  @sim_3dof_OutputFcn, ...
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


% --- Executes just before sim_3dof is made visible.
function sim_3dof_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sim_3dof (see VARARGIN)

% Choose default command line output for sim_3dof
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
set(gcf,'menubar','figure')
set(gcf,'toolbar','figure')
set(handles.edit_mubiao_position,'string','0');
set(handles.edit_mubiao_position,'Enable','off');
set(handles.text_state,'string','否');
set(handles.sim_stat,'string','off');
% UIWAIT makes sim_3dof wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sim_3dof_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in radiobutton_if_mubiao.
function radiobutton_if_mubiao_Callback(hObject, eventdata, handles)
flag=get(handles.radiobutton_if_mubiao,'Value');
if flag==1
set(handles.edit_mubiao_position,'string','[4000 0 0]');
set(handles.edit_mubiao_position,'Enable','on');
set(handles.text_state,'string','是');
Choose_zhidao;
end
if flag==0
set(handles.edit_mubiao_position,'string','0');
set(handles.edit_mubiao_position,'Enable','off');
set(handles.text_state,'string','否');
end
% hObject    handle to radiobutton_if_mubiao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_if_mubiao



function edit_mubiao_position_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mubiao_position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mubiao_position as text
%        str2double(get(hObject,'String')) returns contents of edit_mubiao_position as a double


% --- Executes during object creation, after setting all properties.
function edit_mubiao_position_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mubiao_position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_missile_position_Callback(hObject, eventdata, handles)
% hObject    handle to edit_missile_position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_missile_position as text
%        str2double(get(hObject,'String')) returns contents of edit_missile_position as a double


% --- Executes during object creation, after setting all properties.
function edit_missile_position_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_missile_position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_missile_vel_Callback(hObject, eventdata, handles)
% hObject    handle to edit_missile_vel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_missile_vel as text
%        str2double(get(hObject,'String')) returns contents of edit_missile_vel as a double


% --- Executes during object creation, after setting all properties.
function edit_missile_vel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_missile_vel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_missile_theta_Callback(hObject, eventdata, handles)
% hObject    handle to edit_missile_theta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_missile_theta as text
%        str2double(get(hObject,'String')) returns contents of edit_missile_theta as a double


% --- Executes during object creation, after setting all properties.
function edit_missile_theta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_missile_theta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_missile_phiv_Callback(hObject, eventdata, handles)
% hObject    handle to edit_missile_phiv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_missile_phiv as text
%        str2double(get(hObject,'String')) returns contents of edit_missile_phiv as a double


% --- Executes during object creation, after setting all properties.
function edit_missile_phiv_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_missile_phiv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_missile_bank_Callback(hObject, eventdata, handles)
% hObject    handle to edit_missile_bank (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_missile_bank as text
%        str2double(get(hObject,'String')) returns contents of edit_missile_bank as a double


% --- Executes during object creation, after setting all properties.
function edit_missile_bank_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_missile_bank (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function edit_missile_alpha_Callback(hObject, eventdata, handles)
% hObject    handle to edit_missile_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_missile_alpha as text
%        str2double(get(hObject,'String')) returns contents of edit_missile_alpha as a double


% --- Executes during object creation, after setting all properties.
function edit_missile_alpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_missile_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_missile_beta_Callback(hObject, eventdata, handles)
% hObject    handle to edit_missile_beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_missile_beta as text
%        str2double(get(hObject,'String')) returns contents of edit_missile_beta as a double


% --- Executes during object creation, after setting all properties.
function edit_missile_beta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_missile_beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function edit_wind_h_Callback(hObject, eventdata, handles)
% hObject    handle to edit_wind_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_wind_h as text
%        str2double(get(hObject,'String')) returns contents of edit_wind_h as a double


% --- Executes during object creation, after setting all properties.
function edit_wind_h_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_wind_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_wind_size_Callback(hObject, eventdata, handles)
% hObject    handle to edit_wind_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_wind_size as text
%        str2double(get(hObject,'String')) returns contents of edit_wind_size as a double


% --- Executes during object creation, after setting all properties.
function edit_wind_size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_wind_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_wind_position_Callback(hObject, eventdata, handles)
% hObject    handle to edit_wind_position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_wind_position as text
%        str2double(get(hObject,'String')) returns contents of edit_wind_position as a double


% --- Executes during object creation, after setting all properties.
function edit_wind_position_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_wind_position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_sim_start.
function pushbutton_sim_start_Callback(hObject, eventdata, handles)
alp11=0;
bt11=0;
ayc=0;azc=0;
set(handles.sim_stat,'string','on');
load('air_Data.mat');
if(get(handles.radiobutton_if_mubiao,'Value')==0)%不加入制导率
    %%%%%%%%%%%%%%%%%%%%%%%%%%%读入初值%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    missile_position=str2num(get(handles.edit_missile_position,'string'));
    missile_v=str2num(get(handles.edit_missile_vel,'string'));
    missile_theta=str2num(get(handles.edit_missile_theta,'string'))/57.3;
    missile_phiv=str2num(get(handles.edit_missile_phiv,'string'))/57.3;
    missile_bank=str2num(get(handles.edit_missile_bank,'string'))/57.3;
    missile_alpha=str2num(get(handles.edit_missile_alpha,'string'))/57.3;
    missile_beta=str2num(get(handles.edit_missile_beta,'string'))/57.3;
    missile_mass=str2num(get(handles.edit_missile_mass,'string'));
    missile_serf=str2num(get(handles.edit_missile_serf,'string'));
    missile_l=str2num(get(handles.edit_l,'string'));
    Ft=str2num(get(handles.edit_Ft,'string'));
    sim_time_max=str2num(get(handles.edit_sim_time,'string'));
    simtime=0;
    g=9.8;
    simu_step=0.05;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    beta=missile_beta*57.3;
    dz=0;
    chazhi_dz;
    for j=1:num_Ma
        for i=1:num_alpha
            l(j,i)=n(j,i)*cos(alpha_vec(i)/57.3)-a(j,i)*sin(alpha_vec(i)/57.3);
            d(j,i)=n(j,i)*sin(alpha_vec(i)/57.3)+a(j,i)*cos(alpha_vec(i)/57.3)-z(j,i)*sin(beta/57.3);
            c(j,i)=n(j,i)*sin(alpha_vec(i)/57.3)*sin(beta/57.3)+a(j,i)*cos(alpha_vec(i)/57.3)*sin(beta/57.3)+z(j,i)*cos(beta/57.3);
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    i=1;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    h = waitbar(0.5,'Please wait...');
    while(simtime<sim_time_max&&missile_position(2)>0)
    free3dof;
    end
    close(h)
    save('sim_3dof_result.mat','sim_3dof_result');
    date=datestr(now);
    y=num2str(year(date));mon=num2str(month(date));d=num2str(day(date));h=num2str(hour(date));mint=num2str(minute(date));s=num2str(second(date));
    ddd=[y,'-',mon,'-',d,'-',h,'-',mint,'-',s];
    save(['.\result\',ddd,'sim_3dof_result.mat'],'sim_3dof_result');
    set(handles.sim_stat,'string','off');
end
if(get(handles.radiobutton_if_mubiao,'Value')==1)%加入制导率
    %%%%%%%%%%%%%%%%%%%%%%%%%%%读入初值%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    target_position=str2num(get(handles.edit_mubiao_position,'string'));
    missile_position=str2num(get(handles.edit_missile_position,'string'));
    missile_v=str2num(get(handles.edit_missile_vel,'string'));
    missile_theta=str2num(get(handles.edit_missile_theta,'string'))/57.3;
    missile_phiv=str2num(get(handles.edit_missile_phiv,'string'))/57.3;
    missile_bank=str2num(get(handles.edit_missile_bank,'string'))/57.3;
    missile_alpha=str2num(get(handles.edit_missile_alpha,'string'))/57.3;
    missile_beta=str2num(get(handles.edit_missile_beta,'string'))/57.3;
    missile_mass=str2num(get(handles.edit_missile_mass,'string'));
    missile_serf=str2num(get(handles.edit_missile_serf,'string'));
    missile_l=str2num(get(handles.edit_l,'string'));
    Ft=str2num(get(handles.edit_Ft,'string'));
    sim_time_max=str2num(get(handles.edit_sim_time,'string'));
    simtime=0;
    g=9.8;
    simu_step=0.05;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    beta=missile_beta*57.3;
    dz=0;
    chazhi_dz;
    for j=1:num_Ma
        for i=1:num_alpha
            l(j,i)=n(j,i)*cos(alpha_vec(i)/57.3)-a(j,i)*sin(alpha_vec(i)/57.3);
            d(j,i)=n(j,i)*sin(alpha_vec(i)/57.3)+a(j,i)*cos(alpha_vec(i)/57.3)-z(j,i)*sin(beta/57.3);
            c(j,i)=n(j,i)*sin(alpha_vec(i)/57.3)*sin(beta/57.3)+a(j,i)*cos(alpha_vec(i)/57.3)*sin(beta/57.3)+z(j,i)*cos(beta/57.3);
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    i=1;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    zhidao_flag=evalin('base','zhidao_flag');
    if zhidao_flag==1%比例导引
        h = waitbar(0.5,'Please wait...');
        R=((missile_position(1)-target_position(1))^2+(missile_position(2)-target_position(2))^2+(missile_position(3)-target_position(3))^2)^0.5;
        while(simtime<sim_time_max&&missile_position(2)>0&&R>1)
            ratio;
            ratio3dof;
        end
        close(h)
        save('sim_3dof_result.mat','sim_3dof_result');
        date=datestr(now);
        y=num2str(year(date));mon=num2str(month(date));d=num2str(day(date));h=num2str(hour(date));mint=num2str(minute(date));s=num2str(second(date));
        ddd=[y,'-',mon,'-',d,'-',h,'-',mint,'-',s];
        save(['.\result\',ddd,'sim_3dof_result.mat'],'sim_3dof_result');
        set(handles.sim_stat,'string','off');
    end
    if zhidao_flag==2%约束条件比例导引
        h = waitbar(0.5,'Please wait...');
        R=((missile_position(1)-target_position(1))^2+(missile_position(2)-target_position(2))^2+(missile_position(3)-target_position(3))^2)^0.5;
        while(simtime<sim_time_max&&missile_position(2)>0&&R>1)
            ratio;
            ratio3dof;
        end
        close(h)
        save('sim_3dof_result.mat','sim_3dof_result');
        date=datestr(now);
        y=num2str(year(date));mon=num2str(month(date));d=num2str(day(date));h=num2str(hour(date));mint=num2str(minute(date));s=num2str(second(date));
        ddd=[y,'-',mon,'-',d,'-',h,'-',mint,'-',s];
        save(['.\result\',ddd,'sim_3dof_result.mat'],'sim_3dof_result');
        set(handles.sim_stat,'string','off');
    end
    if zhidao_flag==3%固定弹道倾角飞行
        h = waitbar(0.5,'Please wait...');
        R=((missile_position(1)-target_position(1))^2+(missile_position(2)-target_position(2))^2+(missile_position(3)-target_position(3))^2)^0.5;
        while(simtime<sim_time_max&&missile_position(2)>0&&R>1)
            ratio;
            ratio3dof;
        end
        close(h)
        save('sim_3dof_result.mat','sim_3dof_result');
        date=datestr(now);
        y=num2str(year(date));mon=num2str(month(date));d=num2str(day(date));h=num2str(hour(date));mint=num2str(minute(date));s=num2str(second(date));
        ddd=[y,'-',mon,'-',d,'-',h,'-',mint,'-',s];
        save(['.\result\',ddd,'sim_3dof_result.mat'],'sim_3dof_result');
        set(handles.sim_stat,'string','off');
    end

end   

% hObject    handle to pushbutton_sim_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in pushbutton_sim_inloop.
function pushbutton_sim_inloop_Callback(hObject, eventdata, handles)
sisotool
% hObject    handle to pushbutton_sim_inloop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_V.
function pushbutton_V_Callback(hObject, eventdata, handles)
flag=get(handles.radiobutton_history_data,'Value');
if flag==1
file=['.\result\',get(handles.edit_history_data,'string')];
load(file)
end
if flag==0
load('sim_3dof_result.mat')
end
hold off

plot(sim_3dof_result(:,1),sim_3dof_result(:,5),'LineWidth',2)
xlabel('时间/s')
ylabel('速度/m/s')
title('速度曲线')
hold on
grid on
% hObject    handle to pushbutton_V (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_theta.
function pushbutton_theta_Callback(hObject, eventdata, handles)
flag=get(handles.radiobutton_history_data,'Value');
if flag==1
file=['.\result\',get(handles.edit_history_data,'string')];
load(file)
end
if flag==0
load('sim_3dof_result.mat')
end
hold off
plot(sim_3dof_result(:,1),sim_3dof_result(:,6),'LineWidth',2)
xlabel('时间/s')
ylabel('弹道倾角/度')
title('弹道倾角曲线')
grid on
% hObject    handle to pushbutton_theta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_phiv.
function pushbutton_phiv_Callback(hObject, eventdata, handles)
flag=get(handles.radiobutton_history_data,'Value');
if flag==1
file=['.\result\',get(handles.edit_history_data,'string')];
load(file)
end
if flag==0
load('sim_3dof_result.mat')
end
hold off
plot(sim_3dof_result(:,1),sim_3dof_result(:,7),'LineWidth',2)
xlabel('时间/s')
ylabel('弹道偏角/度')
title('弹道偏角曲线')
grid on
% hObject    handle to pushbutton_phiv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_Vz.
function pushbutton_Vz_Callback(hObject, eventdata, handles)
flag=get(handles.radiobutton_history_data,'Value');
if flag==1
file=['.\result\',get(handles.edit_history_data,'string')];
load(file)
end
if flag==0
load('sim_3dof_result.mat')
end
hold off
plot(sim_3dof_result(:,1),sim_3dof_result(:,13),'LineWidth',2)
xlabel('时间/s')
ylabel('vz速度/m/s')
title('速度曲线')
grid on
% hObject    handle to pushbutton_Vz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_Vx.
function pushbutton_Vx_Callback(hObject, eventdata, handles)
flag=get(handles.radiobutton_history_data,'Value');
if flag==1
file=['.\result\',get(handles.edit_history_data,'string')];
load(file)
end
if flag==0
load('sim_3dof_result.mat')
end
hold off
plot(sim_3dof_result(:,1),sim_3dof_result(:,11),'LineWidth',2)
xlabel('时间/s')
ylabel('vx速度/m/s')
title('速度曲线')
grid on
% hObject    handle to pushbutton_Vx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_Vy.
function pushbutton_Vy_Callback(hObject, eventdata, handles)
flag=get(handles.radiobutton_history_data,'Value');
if flag==1
file=['.\result\',get(handles.edit_history_data,'string')];
load(file)
end
if flag==0
load('sim_3dof_result.mat')
end
hold off
plot(sim_3dof_result(:,1),sim_3dof_result(:,12),'LineWidth',2)
xlabel('时间/s')
ylabel('vy速度/m/s')
title('速度曲线')
grid on
% hObject    handle to pushbutton_Vy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit_missile_mass_Callback(hObject, eventdata, handles)
% hObject    handle to edit_missile_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_missile_mass as text
%        str2double(get(hObject,'String')) returns contents of edit_missile_mass as a double


% --- Executes during object creation, after setting all properties.
function edit_missile_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_missile_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_X.
function pushbutton_X_Callback(hObject, eventdata, handles)
flag=get(handles.radiobutton_history_data,'Value');
if flag==1
file=['.\result\',get(handles.edit_history_data,'string')];
load(file)
end
if flag==0
load('sim_3dof_result.mat')
end
hold off
plot(sim_3dof_result(:,1),sim_3dof_result(:,2),'LineWidth',2)
xlabel('时间/s')
ylabel('X/m')
title('位置x曲线')
grid on
% hObject    handle to pushbutton_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_Y.
function pushbutton_Y_Callback(hObject, eventdata, handles)
flag=get(handles.radiobutton_history_data,'Value');
if flag==1
file=['.\result\',get(handles.edit_history_data,'string')];
load(file)
end
if flag==0
load('sim_3dof_result.mat')
end
hold off
plot(sim_3dof_result(:,1),sim_3dof_result(:,3),'LineWidth',2)
xlabel('时间/s')
ylabel('Y/m')
title('位置Y曲线')
grid on
% hObject    handle to pushbutton_Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_Z.
function pushbutton_Z_Callback(hObject, eventdata, handles)
flag=get(handles.radiobutton_history_data,'Value');
if flag==1
file=['.\result\',get(handles.edit_history_data,'string')];
load(file)
end
if flag==0
load('sim_3dof_result.mat')
end
hold off
plot3(sim_3dof_result(:,2),sim_3dof_result(:,4),sim_3dof_result(:,3),'LineWidth',2)
xlabel('X/m')
ylabel('Z/m')
zlabel('Y/m')
title('位置XYZ曲线')
grid on
% hObject    handle to pushbutton_Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in pushbutton_Ax.
function pushbutton_Ax_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Ax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_ay.
function pushbutton_ay_Callback(hObject, eventdata, handles)
flag=get(handles.radiobutton_history_data,'Value');
if flag==1
file=['.\result\',get(handles.edit_history_data,'string')];
load(file)
end
if flag==0
load('sim_3dof_result.mat')
end
hold off
plot(sim_3dof_result(:,1),sim_3dof_result(:,15),'LineWidth',2)
hold on
plot(sim_3dof_result(:,1),sim_3dof_result(:,26),'r','LineWidth',2)
xlabel('时间/s')
ylabel('法向加速度/m/s2')
title('法向加速度(不计推力)')
grid on
legend('ay','ayc');
% hObject    handle to pushbutton_ay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_az.
function pushbutton_az_Callback(hObject, eventdata, handles)
flag=get(handles.radiobutton_history_data,'Value');
if flag==1
file=['.\result\',get(handles.edit_history_data,'string')];
load(file)
end
if flag==0
load('sim_3dof_result.mat')
end
hold off
plot(sim_3dof_result(:,1),sim_3dof_result(:,16),'LineWidth',2)
hold on
plot(sim_3dof_result(:,1),sim_3dof_result(:,27),'r','LineWidth',2)
xlabel('时间/s')
ylabel('侧向加速度/m/s2')
title('侧向加速度(不计推力)')
grid on
legend('az','azc');
% hObject    handle to pushbutton_az (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_beta.
function pushbutton_beta_Callback(hObject, eventdata, handles)
flag=get(handles.radiobutton_history_data,'Value');
if flag==1
file=['.\result\',get(handles.edit_history_data,'string')];
load(file)
end
if flag==0
load('sim_3dof_result.mat')
end
hold off
plot(sim_3dof_result(:,1),sim_3dof_result(:,9),'LineWidth',2)
xlabel('时间/s')
ylabel('侧滑/度')
title('侧滑曲线')
grid on
% hObject    handle to pushbutton_beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_alpha.
function pushbutton_alpha_Callback(hObject, eventdata, handles)
flag=get(handles.radiobutton_history_data,'Value');
if flag==1
file=['.\result\',get(handles.edit_history_data,'string')];
load(file)
end
if flag==0
load('sim_3dof_result.mat')
end
hold off
plot(sim_3dof_result(:,1),sim_3dof_result(:,8),'LineWidth',2)
hold on
plot(sim_3dof_result(:,1),sim_3dof_result(:,24),'r','LineWidth',2)
xlabel('时间/s')
ylabel('攻角vs舵偏/度')
title('攻角及配平曲线')
legend('攻角','舵偏')
grid on
% hObject    handle to pushbutton_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_ax.
function pushbutton_ax_Callback(hObject, eventdata, handles)
flag=get(handles.radiobutton_history_data,'Value');
if flag==1
file=['.\result\',get(handles.edit_history_data,'string')];
load(file)
end
if flag==0
load('sim_3dof_result.mat')
end
hold off
plot(sim_3dof_result(:,1),sim_3dof_result(:,14),'LineWidth',2)
xlabel('时间/s')
ylabel('轴向加速度/m/s2')
title('轴向加速度')
grid on
% hObject    handle to pushbutton_ax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit_missile_serf_Callback(hObject, eventdata, handles)
% hObject    handle to edit_missile_serf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_missile_serf as text
%        str2double(get(hObject,'String')) returns contents of edit_missile_serf as a double


% --- Executes during object creation, after setting all properties.
function edit_missile_serf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_missile_serf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function edit_sim_time_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sim_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sim_time as text
%        str2double(get(hObject,'String')) returns contents of edit_sim_time as a double


% --- Executes during object creation, after setting all properties.
function edit_sim_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sim_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in radiobutton_history_data.
function radiobutton_history_data_Callback(hObject, eventdata, handles)
flag=get(handles.radiobutton_history_data,'Value');
if flag==1
set(handles.edit_history_data,'Enable','on');
set(handles.pushbutton_history_data,'Enable','on');
end
if flag==0
set(handles.edit_history_data,'Enable','off');
set(handles.pushbutton_history_data,'Enable','off');
end
% hObject    handle to radiobutton_history_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_history_data



function edit_history_data_Callback(hObject, eventdata, handles)
% hObject    handle to edit_history_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_history_data as text
%        str2double(get(hObject,'String')) returns contents of edit_history_data as a double


% --- Executes during object creation, after setting all properties.
function edit_history_data_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_history_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_history_data.
function pushbutton_history_data_Callback(hObject, eventdata, handles)
file=uigetfile;
set(handles.edit_history_data,'string',file);
% hObject    handle to pushbutton_history_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in pushbutton_bank.
function pushbutton_bank_Callback(hObject, eventdata, handles)
flag=get(handles.radiobutton_history_data,'Value');
if flag==1
file=['.\result\',get(handles.edit_history_data,'string')];
load(file)
end
if flag==0
load('sim_3dof_result.mat')
end
hold off
for i=2:max(size(sim_3dof_result(:,1)))
    R_DOT(i,1)=(sim_3dof_result(i,19)-sim_3dof_result(i-1,19))/0.05;
end
R_DOT(1,1)=R_DOT(2,1);

plot(sim_3dof_result(:,1),((2-3).*R_DOT./sim_3dof_result(:,19)),'LineWidth',2)
xlabel('时间/s')
ylabel('制导带宽/HZ')
title('制导带宽')

% plot(sim_3dof_result(:,1),sim_3dof_result(:,10),'LineWidth',2)
% xlabel('时间/s')
% ylabel('倾侧/度')
% title('倾侧曲线')
grid on
% hObject    handle to pushbutton_bank (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)





function edit_l_Callback(hObject, eventdata, handles)
% hObject    handle to edit_l (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_l as text
%        str2double(get(hObject,'String')) returns contents of edit_l as a double


% --- Executes during object creation, after setting all properties.
function edit_l_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_l (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in pushbutton_CopyFigure.
function pushbutton_CopyFigure_Callback(hObject, eventdata, handles)
new_f_handle=figure('visible','on');
new_axes=copyobj(handles.axes1,new_f_handle);
load('air_Data.mat');
set(new_axes,'units','default','position','default');
% hObject    handle to pushbutton_CopyFigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in pushbutton_Q.
function pushbutton_Q_Callback(hObject, eventdata, handles)
flag=get(handles.radiobutton_history_data,'Value');
if flag==1
file=['.\result\',get(handles.edit_history_data,'string')];
load(file)
end
if flag==0
load('sim_3dof_result.mat')
end
hold off

plot(sim_3dof_result(:,1),sim_3dof_result(:,17),'LineWidth',2)
xlabel('时间/s')
ylabel('动压')
title('动压曲线')
hold on
grid on
% hObject    handle to pushbutton_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)





function edit_Ft_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Ft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Ft as text
%        str2double(get(hObject,'String')) returns contents of edit_Ft as a double


% --- Executes during object creation, after setting all properties.
function edit_Ft_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Ft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in pushbutton_Ft.
function pushbutton_Ft_Callback(hObject, eventdata, handles)
flag=get(handles.radiobutton_history_data,'Value');
if flag==1
file=['.\result\',get(handles.edit_history_data,'string')];
load(file)
end
if flag==0
load('sim_3dof_result.mat')
end
hold off

plot(sim_3dof_result(:,1),sim_3dof_result(:,18),'LineWidth',2)
xlabel('时间/s')
ylabel('推力')
title('推力曲线')
hold on
grid on
% hObject    handle to pushbutton_Ft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in pushbutton_lamd_D.
function pushbutton_lamd_D_Callback(hObject, eventdata, handles)
flag=get(handles.radiobutton_history_data,'Value');
if flag==1
file=['.\result\',get(handles.edit_history_data,'string')];
load(file)
end
if flag==0
load('sim_3dof_result.mat')
end
hold off
plot(sim_3dof_result(:,1),sim_3dof_result(:,20),'LineWidth',2)
xlabel('时间/s')
ylabel('视线倾角/度')
title('视线倾角曲线')
grid on
% hObject    handle to pushbutton_lamd_D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_lamd_T.
function pushbutton_lamd_T_Callback(hObject, eventdata, handles)
flag=get(handles.radiobutton_history_data,'Value');
if flag==1
file=['.\result\',get(handles.edit_history_data,'string')];
load(file)
end
if flag==0
load('sim_3dof_result.mat')
end
hold off
plot(sim_3dof_result(:,1),sim_3dof_result(:,21),'LineWidth',2)
xlabel('时间/s')
ylabel('视线偏角/度')
title('视线偏角曲线')
grid on
% hObject    handle to pushbutton_lamd_T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_R.
function pushbutton_R_Callback(hObject, eventdata, handles)
flag=get(handles.radiobutton_history_data,'Value');
if flag==1
file=['.\result\',get(handles.edit_history_data,'string')];
load(file)
end
if flag==0
load('sim_3dof_result.mat')
end
hold off
plot(sim_3dof_result(:,1),sim_3dof_result(:,19),'LineWidth',2)
xlabel('时间/s')
ylabel('弹目距离/m')
title('弹目距离曲线')
grid on
% hObject    handle to pushbutton_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in pushbutton_dandao_character.
function pushbutton_dandao_character_Callback(hObject, eventdata, handles)
h = waitbar(0.5,'Please wait...');
flag=get(handles.radiobutton_history_data,'Value');
if flag==0
    load('sim_3dof_result.mat')
end
if flag==1
    path=['./result/',get(handles.edit_history_data,'string')];
    load(path);
end

count=ceil(str2num(get(handles.edit_t,'string'))/0.05);

for tf_i=1:max(size(count))
    load('air_Data.mat');
    alpha=sim_3dof_result(count(tf_i),8);%度
    theta=sim_3dof_result(count(tf_i),6);
    beta=sim_3dof_result(count(tf_i),9);
    dz=sim_3dof_result(count(tf_i),24);
    ma=sim_3dof_result(count(tf_i),5)/340;
    v=sim_3dof_result(count(tf_i),5);
    Q=sim_3dof_result(count(tf_i),17);
    dongya(tf_i)=Q/20000;
    Ft=sim_3dof_result(count(tf_i),18);
    m=sim_3dof_result(count(tf_i),25);
    serf=str2num(get(handles.edit_missile_serf,'string'));
    L=str2num(get(handles.edit_l,'string'));
    g=9.8;
    jx=str2num(get(handles.edit_jx,'string'));
    jy=str2num(get(handles.edit_jy,'string'));
    jz=str2num(get(handles.edit_jz,'string'));
    if ma<min(Ma_vec)
        ma=min(Ma_vec);
    end
     if ma>max(Ma_vec)
        ma=max(Ma_vec);
    end
    if alpha>max(alpha_vec)
        alpha=max(alpha_vec);
    end
    if alpha<min(alpha_vec)
        alpha=min(alpha_vec);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%纵向传递函数%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    chazhi_dz;
    for j=1:num_Ma
        for i=1:num_alpha
            l(j,i)=n(j,i)*cos(alpha_vec(i)/57.3)-a(j,i)*sin(alpha_vec(i)/57.3);
            d(j,i)=n(j,i)*sin(alpha_vec(i)/57.3)+a(j,i)*cos(alpha_vec(i)/57.3)-z(j,i)*sin(beta/57.3);
            c(j,i)=n(j,i)*sin(alpha_vec(i)/57.3)*sin(beta/57.3)+a(j,i)*cos(alpha_vec(i)/57.3)*sin(beta/57.3)+z(j,i)*cos(beta/57.3);
            %   gz(j,i)
            %   ph(j,i)
            %   fy(j,i)
        end
    end
    l1=l;d1=d;gz1=gz;ph1=ph;fy1=fy;
    dz=dz+1;
    chazhi_dz;
    for j=1:num_Ma
        for i=1:num_alpha
            l(j,i)=n(j,i)*cos(alpha_vec(i)/57.3)-a(j,i)*sin(alpha_vec(i)/57.3);
            d(j,i)=n(j,i)*sin(alpha_vec(i)/57.3)+a(j,i)*cos(alpha_vec(i)/57.3)-z(j,i)*sin(beta/57.3);
            c(j,i)=n(j,i)*sin(alpha_vec(i)/57.3)*sin(beta/57.3)+a(j,i)*cos(alpha_vec(i)/57.3)*sin(beta/57.3)+z(j,i)*cos(beta/57.3);
            %   gz(j,i)
            %   ph(j,i)
            %   fy(j,i)
        end
    end
    dz=dz-1;
    l2=l;d2=d;gz2=gz;ph2=ph;fy2=fy;

    ma_cnt=1;
    while(ma_cnt<num_Ma)
        if (ma>=Ma_vec(ma_cnt)&&ma<=Ma_vec(ma_cnt+1))
            break;
        end
        ma_cnt=ma_cnt+1;
    end

    alpha_cnt=1;
    while(alpha_cnt<num_alpha)
        if (alpha>=alpha_vec(alpha_cnt)&&alpha<=alpha_vec(alpha_cnt+1))
            break;
        end
        alpha_cnt=alpha_cnt+1;
    end

    a11=(0-Q*serf*d1(ma_cnt,alpha_cnt)*2/v)/(m);
    a12=0;
    a13=-g*cos(theta/57.3);
    a14=-((d1(ma_cnt,alpha_cnt+1)-d1(ma_cnt,alpha_cnt))/(alpha_vec(alpha_cnt+1)/57.3-alpha_vec(alpha_cnt)/57.3)*Q*serf+Ft*alpha/57.3)/m;
    a15=-(d2(ma_cnt,alpha_cnt)-d1(ma_cnt,alpha_cnt))/(1/57.3)/m*Q*serf;
    a16=1/m;

    a21=fy1(ma_cnt,alpha_cnt)*2/v*Q*serf*L/jz;
    a22=-1.67*Q*serf*L*L/jz/v;
    a23=0;
    a24=(fy1(ma_cnt,alpha_cnt+1)-fy1(ma_cnt,alpha_cnt))/(alpha_vec(alpha_cnt+1)/57.3-alpha_vec(alpha_cnt)/57.3)/jz*Q*serf*L;
    a24_1=a22;
    a25=(fy2(ma_cnt,alpha_cnt)-fy1(ma_cnt,alpha_cnt))/(1/57.3)/jz*Q*serf*L;
    a25_1=0;
    a26=1/jz;

    a31=(l1(ma_cnt,alpha_cnt)*2/v*Q*serf)/m/v;
    a32=0;
    a33=g*sin(theta/57.3)/v;
    a34=(Ft+(l1(ma_cnt,alpha_cnt+1)-l1(ma_cnt,alpha_cnt))/(alpha_vec(alpha_cnt+1)/57.3-alpha_vec(alpha_cnt)/57.3)*Q*serf)/m/v;
    a35=(l2(ma_cnt,alpha_cnt)-l1(ma_cnt,alpha_cnt))/(1/57.3)/m/v*Q*serf;
    a36=1/m/v;
    if -a24-a22*a34>=0
        km(tf_i)=(-a25*a34+a35*a24)/(a22*a34+a24);
        tm(tf_i)=1/(-a24-a22*a34)^0.5;
        ztam(tf_i)=(-a22-a24_1+a34)/(-a24-a22*a34)^0.5/2;
        t1(tf_i)=(-a35*a24_1+a25)/(a25*a34-a35*a24);
        num1=[km(tf_i)*t1(tf_i) km(tf_i)];
        den1=[tm(tf_i)*tm(tf_i) 2*tm(tf_i)*ztam(tf_i) 1 0];
        den11=[tm(tf_i)*tm(tf_i) 2*tm(tf_i)*ztam(tf_i) 1];

        num2=[km(tf_i)];
        den2=[tm(tf_i)*tm(tf_i) 2*tm(tf_i)*ztam(tf_i) 1 0];

        num3=[km(tf_i)*t1(tf_i)];
        den3=[tm(tf_i)*tm(tf_i) 2*tm(tf_i)*ztam(tf_i) 1];

        num4=[km(tf_i)*v];
        den4=[tm(tf_i)*tm(tf_i) 2*tm(tf_i)*ztam(tf_i) 1];
    end
    if -a24-a22*a34<0
        km(tf_i)=(-a25*a34+a35*a24)/(a22*a34+a24);
        tm(tf_i)=-1/(a24+a22*a34)^0.5;
        ztam(tf_i)=-0.5*(-a22-a24_1+a34)*tm(tf_i);
        t1(tf_i)=(-a35*a24_1+a25)/(a25*a34-a35*a24);
        
        num1=[km(tf_i)*t1(tf_i) km(tf_i)];
        den1=[-tm(tf_i)*tm(tf_i) 2*tm(tf_i)*ztam(tf_i) 1 0];
        den11=[-tm(tf_i)*tm(tf_i) 2*tm(tf_i)*ztam(tf_i) 1];

        num2=[km(tf_i)];
        den2=[-tm(tf_i)*tm(tf_i) 2*tm(tf_i)*ztam(tf_i) 1 0];

        num3=[km(tf_i)*t1(tf_i)];
        den3=[-tm(tf_i)*tm(tf_i) 2*tm(tf_i)*ztam(tf_i) 1];

        num4=[km(tf_i)*v];
        den4=[-tm(tf_i)*tm(tf_i) 2*tm(tf_i)*ztam(tf_i) 1];
    end
    

    tf_wz(tf_i)=tf(num1,den11);
    tf_fy(tf_i)=tf(num1,den1);
    tf_theta(tf_i)=tf(num2,den2);
    tf_alpha(tf_i)=tf(num3,den3);
    tf_ny(tf_i)=tf(num4,den4);
    V(tf_i)=v;
    %%%%%%%%%%%%%%%%%%%%%%%%%%横侧向传递函数%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    dx=0;dy=0;
    chazhi_dx;
    C1=z;gz1=gz;ph1=ph;fy1=fy;

    beta=beta+1;
    chazhi_dx;
    beta=beta-1;
    C2=z;gz2=gz;ph2=ph;fy2=fy;

    dx=dx+1;
    chazhi_dx;
    dx=dx-1;
    C3=z;gz3=gz;ph3=ph;fy3=fy;

    dy=dy+1;
    chazhi_dy;
    dy=dy-1;
    C4=z;gz4=gz;ph4=ph;fy4=fy;

    b11=-0.05*Q*serf*L*L/jx/v;
    b12=0;
    b13=0;
    b14=(gz2(ma_cnt,alpha_cnt)-gz1(ma_cnt,alpha_cnt))/(1/57.3)/jx*Q*serf*L;
    b15=(gz4(ma_cnt,alpha_cnt)-gz1(ma_cnt,alpha_cnt))/(1/57.3)/jx*Q*serf*L;
    b16=0;
    b17=(gz3(ma_cnt,alpha_cnt)-gz1(ma_cnt,alpha_cnt))/(1/57.3)/jx*Q*serf*L;
    b18=1/jx;

    b21=0;
    b22=-1.67*Q*serf*L*L/jy/v;
    b23=0;
    b24=(ph2(ma_cnt,alpha_cnt)-ph1(ma_cnt,alpha_cnt))/(1/57.3)/jy*Q*serf*L;
    b24_1=0;
    b25=(ph4(ma_cnt,alpha_cnt)-ph1(ma_cnt,alpha_cnt))/(1/57.3)/jy*Q*serf*L;
    b25_1=0;
    b26=0;
    b27=0;
    b28=1/jy;

    b31=0;
    b32=-cos(theta/57.3)/cos((theta+alpha)/57.3);
    b33=0;
    b34=(Ft-(C2(ma_cnt,alpha_cnt)-C1(ma_cnt,alpha_cnt))/(1/57.3)*Q*serf)/(m*v);
    b35=-(C4(ma_cnt,alpha_cnt)-C1(ma_cnt,alpha_cnt))/(1/57.3)*Q*serf/(m*v);
    b36=-g*cos((theta+alpha)/57.3)/v;
    b37=0;
    b38=-1/m/v;
    if -b24-b22*b34>=0
        km_h(tf_i)=(-b25*b34+b35*b24)/(b22*b34+b24);
        tm_h(tf_i)=1/(-b24-b22*b34)^0.5;
        zeta_h(tf_i)=(-b22-b24_1+b34)/(2*(-b24-b22*b34)^0.5);
        t1_h(tf_i)=(-b35*b24_1+b25)/(b25*b34-b35*b24);
        num_wx=b17;
        den_wx=[1 -b11];
        num_gama=b17;
        den_gama=[1 -b11 0];
        tf_wx(tf_i)=tf(num_wx,den_wx);
        tf_gama(tf_i)=tf(num_gama,den_gama);

        num_wy=[km_h(tf_i)*t1_h(tf_i) km_h(tf_i)];
        den_wy=[tm_h(tf_i)*tm_h(tf_i) 2*tm_h(tf_i)*zeta_h(tf_i) 1];
        den_ph=[tm_h(tf_i)*tm_h(tf_i) 2*tm_h(tf_i)*zeta_h(tf_i) 1 0];
        tf_wy(tf_i)=tf(num_wy,den_wy);
        tf_ph(tf_i)=tf(num_wy,den_ph);
        num_beta=[km_h(tf_i)*t1_h(tf_i)];
        den_beta=[tm_h(tf_i)*tm_h(tf_i) 2*tm_h(tf_i)*zeta_h(tf_i) 1];
        tf_beta(tf_i)=tf(num_beta,den_beta);
        num_nz=[km_h(tf_i)*v];
        den_nz=[tm_h(tf_i)*tm_h(tf_i) 2*tm_h(tf_i)*zeta_h(tf_i) 1];
        tf_nz(tf_i)=tf(num_nz,den_nz);
    end
    if -b24-b22*b34<0
        km_h(tf_i)=(-b25*b34+b35*b24)/(b22*b34+b24);
        tm_h(tf_i)=-1/(b24+b22*b34)^0.5;
        zeta_h(tf_i)=-0.5*(-b22-b24_1+b34)*tm_h(tf_i);
        t1_h(tf_i)=(-b35*b24_1+b25)/(b25*b34-b35*b24);
        
        num_wx=b17;
        den_wx=[1 -b11];
        num_gama=b17;
        den_gama=[1 -b11 0];
        tf_wx(tf_i)=tf(num_wx,den_wx);
        tf_gama(tf_i)=tf(num_gama,den_gama);

        num_wy=[km_h(tf_i)*t1_h(tf_i) km_h(tf_i)];
        den_wy=[-tm_h(tf_i)*tm_h(tf_i) 2*tm_h(tf_i)*zeta_h(tf_i) 1];
        den_ph=[-tm_h(tf_i)*tm_h(tf_i) 2*tm_h(tf_i)*zeta_h(tf_i) 1 0];
        tf_wy(tf_i)=tf(num_wy,den_wy);
        tf_ph(tf_i)=tf(num_wy,den_ph);
        num_beta=[km_h(tf_i)*t1_h(tf_i)];
        den_beta=[-tm_h(tf_i)*tm_h(tf_i) 2*tm_h(tf_i)*zeta_h(tf_i) 1];
        tf_beta(tf_i)=tf(num_beta,den_beta);
        num_nz=[km_h(tf_i)*v];
        den_nz=[-tm_h(tf_i)*tm_h(tf_i) 2*tm_h(tf_i)*zeta_h(tf_i) 1];
        tf_nz(tf_i)=tf(num_nz,den_nz);
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    tf_wz(tf_i)=tf_wz(tf_i)*tf(1,[0.01 1]);tf_wy(tf_i)=tf_wy(tf_i)*tf(1,[0.01 1]);tf_wx(tf_i)=tf_wx(tf_i)*tf(1,[0.01 1]);
end
if max(size(count))==1
    save('zongxiang.mat','V','v','a11','a12','a13','a14','a15','a16','a21','a22','a23','a24','a25',...
        'a26','a24_1','a31','a32','a33','a34','a35','a36','km','tm','ztam','t1','tf_wz',...
        'tf_fy','tf_theta','tf_alpha','tf_ny');

    save('hengce.mat','b11','b12','b13','b14','b15','b16','b17','b18',...
        'b21','b22','b23','b24','b25','b26','b27','b28','b24_1',...
        'b31','b32','b33','b34','b35','b36','b37','b38',...
        'km_h','tm_h','zeta_h','t1_h',...
        'tf_wx','tf_gama',...
        'tf_wy','tf_ph','tf_beta','tf_nz');
else
    save('zongxiang.mat','V','km','tm','ztam','t1','tf_wz','tf_fy','tf_theta','tf_alpha','tf_ny');
    save('hengce.mat','km_h','tm_h','zeta_h','t1_h',...
        'tf_wx','tf_gama',...
        'tf_wy','tf_ph','tf_beta','tf_nz');
end
close(h);
assignin('base','dongya',dongya);
close sim_3dof;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if max(size(count))==1
trf;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hObject    handle to pushbutton_dandao_character (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit_t_Callback(hObject, eventdata, handles)
% hObject    handle to edit_t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_t as text
%        str2double(get(hObject,'String')) returns contents of edit_t as a double


% --- Executes during object creation, after setting all properties.
function edit_t_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function edit_jx_Callback(hObject, eventdata, handles)
% hObject    handle to edit_jx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_jx as text
%        str2double(get(hObject,'String')) returns contents of edit_jx as a double


% --- Executes during object creation, after setting all properties.
function edit_jx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_jx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_jy_Callback(hObject, eventdata, handles)
% hObject    handle to edit_jy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_jy as text
%        str2double(get(hObject,'String')) returns contents of edit_jy as a double


% --- Executes during object creation, after setting all properties.
function edit_jy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_jy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_jz_Callback(hObject, eventdata, handles)
% hObject    handle to edit_jz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_jz as text
%        str2double(get(hObject,'String')) returns contents of edit_jz as a double


% --- Executes during object creation, after setting all properties.
function edit_jz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_jz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end










% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton30.
function pushbutton30_Callback(hObject, eventdata, handles)
h = waitbar(0.5,'Please wait...');
flag=get(handles.radiobutton_history_data,'Value');
if flag==0
load('sim_3dof_result.mat')
end
if flag==1
path=['./result/',get(handles.edit_history_data,'string')];
load(path);
end
Qq=sim_3dof_result(:,17);
q_num=max(size(Qq));
xielv=abs(Qq(2)-Qq(1));
qq=1;
findq=ceil(q_num/2);
for q_count=1:q_num-1
    xielv1=abs(Qq(q_count+1,1)-Qq(q_count,1));
    if abs(xielv1-xielv)>10
        findq(qq)=q_count;
        qq=qq+1;
    end
     xielv=xielv1;
end
count1=[1,findq,q_num];
count=1;
for ct=1:max(size(count1))-1
    count=[count,ceil((count1(ct+1)+count1(ct))/2),count1(ct+1)];
end
for tf_i=1:max(size(count))
    load('air_Data.mat');
alpha=sim_3dof_result(count(tf_i),8);%度
theta=sim_3dof_result(count(tf_i),6);
beta=sim_3dof_result(count(tf_i),9);
dz=sim_3dof_result(count(tf_i),24);
ma=sim_3dof_result(count(tf_i),5)/340;
v=sim_3dof_result(count(tf_i),5);
Q=sim_3dof_result(count(tf_i),17);
dongya(tf_i)=Q/20000;
Ft=sim_3dof_result(count(tf_i),18);
m=sim_3dof_result(count(tf_i),25);
serf=str2num(get(handles.edit_missile_serf,'string'));
L=str2num(get(handles.edit_l,'string'));
g=9.8;
jx=str2num(get(handles.edit_jx,'string'));
jy=str2num(get(handles.edit_jy,'string'));
jz=str2num(get(handles.edit_jz,'string'));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%纵向传递函数%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
chazhi_dz;
for j=1:num_Ma
for i=1:num_alpha
    l(j,i)=n(j,i)*cos(alpha_vec(i)/57.3)-a(j,i)*sin(alpha_vec(i)/57.3);
    d(j,i)=n(j,i)*sin(alpha_vec(i)/57.3)+a(j,i)*cos(alpha_vec(i)/57.3);
%   gz(j,i)
%   ph(j,i)
%   fy(j,i)
end
end
l1=l;d1=d;gz1=gz;ph1=ph;fy1=fy;
dz=dz+1;
chazhi_dz;
for j=1:num_Ma
for i=1:num_alpha
    l(j,i)=n(j,i)*cos(alpha_vec(i)/57.3)-a(j,i)*sin(alpha_vec(i)/57.3);
    d(j,i)=n(j,i)*sin(alpha_vec(i)/57.3)+a(j,i)*cos(alpha_vec(i)/57.3);
%   gz(j,i)
%   ph(j,i)
%   fy(j,i)
end
end
dz=dz-1;
l2=l;d2=d;gz2=gz;ph2=ph;fy2=fy;

ma_cnt=1;
while(ma_cnt<num_Ma)
    if (ma>=Ma_vec(ma_cnt)&&ma<=Ma_vec(ma_cnt+1))
        break;
    end
    ma_cnt=ma_cnt+1;
end

alpha_cnt=1;
while(alpha_cnt<num_alpha)
    if (alpha>=alpha_vec(alpha_cnt)&&alpha<=alpha_vec(alpha_cnt+1))
        break;
    end
    alpha_cnt=alpha_cnt+1;
end

a11=(0-Q*serf*d1(ma_cnt,alpha_cnt)*2/v)/(m);
    a12=0;
    a13=-g*cos(theta/57.3);
    a14=-((d1(ma_cnt,alpha_cnt+1)-d1(ma_cnt,alpha_cnt))/(alpha_vec(alpha_cnt+1)/57.3-alpha_vec(alpha_cnt)/57.3)*Q*serf+Ft*alpha/57.3)/m;
    a15=-(d2(ma_cnt,alpha_cnt)-d1(ma_cnt,alpha_cnt))/(1/57.3)/m*Q*serf;
    a16=1/m;

    a21=fy1(ma_cnt,alpha_cnt)*2/v*Q*serf*L/jz;
    a22=0;
    a23=0;
    a24=(fy1(ma_cnt,alpha_cnt+1)-fy1(ma_cnt,alpha_cnt))/(alpha_vec(alpha_cnt+1)/57.3-alpha_vec(alpha_cnt)/57.3)/jz*Q*serf*L;
    a24_1=a22;
    a25=(fy2(ma_cnt,alpha_cnt)-fy1(ma_cnt,alpha_cnt))/(1/57.3)/jz*Q*serf*L;
    a25_1=0;
    a26=1/jz;

    a31=(l1(ma_cnt,alpha_cnt)*2/v*Q*serf)/m/v;
    a32=0;
    a33=g*sin(theta/57.3)/v;
    a34=(Ft+(l1(ma_cnt,alpha_cnt+1)-l1(ma_cnt,alpha_cnt))/(alpha_vec(alpha_cnt+1)/57.3-alpha_vec(alpha_cnt)/57.3)*Q*serf)/m/v;
    a35=(l2(ma_cnt,alpha_cnt)-l1(ma_cnt,alpha_cnt))/(1/57.3)/m/v*Q*serf;
    a36=1/m/v;
    if -a24-a22*a34>=0
        km(tf_i)=(-a25*a34+a35*a24)/(a22*a34+a24);
        tm(tf_i)=1/(-a24-a22*a34)^0.5;
        ztam(tf_i)=(-a22-a24_1+a34)/(-a24-a22*a34)^0.5/2;
        t1(tf_i)=(-a35*a24_1+a25)/(a25*a34-a35*a24);
        num1=[km(tf_i)*t1(tf_i) km(tf_i)];
        den1=[tm(tf_i)*tm(tf_i) 2*tm(tf_i)*ztam(tf_i) 1 0];
        den11=[tm(tf_i)*tm(tf_i) 2*tm(tf_i)*ztam(tf_i) 1];

        num2=[km(tf_i)];
        den2=[tm(tf_i)*tm(tf_i) 2*tm(tf_i)*ztam(tf_i) 1 0];

        num3=[km(tf_i)*t1(tf_i)];
        den3=[tm(tf_i)*tm(tf_i) 2*tm(tf_i)*ztam(tf_i) 1];

        num4=[km(tf_i)*v];
        den4=[tm(tf_i)*tm(tf_i) 2*tm(tf_i)*ztam(tf_i) 1];
    end
    if -a24-a22*a34<0
        km(tf_i)=(-a25*a34+a35*a24)/(a22*a34+a24);
        tm(tf_i)=-1/(a24+a22*a34)^0.5;
        ztam(tf_i)=-0.5*(-a22-a24_1+a34)*tm(tf_i);
        t1(tf_i)=(-a35*a24_1+a25)/(a25*a34-a35*a24);
        
        num1=[km(tf_i)*t1(tf_i) km(tf_i)];
        den1=[-tm(tf_i)*tm(tf_i) 2*tm(tf_i)*ztam(tf_i) 1 0];
        den11=[-tm(tf_i)*tm(tf_i) 2*tm(tf_i)*ztam(tf_i) 1];

        num2=[km(tf_i)];
        den2=[-tm(tf_i)*tm(tf_i) 2*tm(tf_i)*ztam(tf_i) 1 0];

        num3=[km(tf_i)*t1(tf_i)];
        den3=[-tm(tf_i)*tm(tf_i) 2*tm(tf_i)*ztam(tf_i) 1];

        num4=[km(tf_i)*v];
        den4=[-tm(tf_i)*tm(tf_i) 2*tm(tf_i)*ztam(tf_i) 1];
    end
    

    tf_wz(tf_i)=tf(num1,den11);
    tf_fy(tf_i)=tf(num1,den1);
    tf_theta(tf_i)=tf(num2,den2);
    tf_alpha(tf_i)=tf(num3,den3);
    tf_ny(tf_i)=tf(num4,den4);
    V(tf_i)=v;
    %%%%%%%%%%%%%%%%%%%%%%%%%%横侧向传递函数%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    dx=0;dy=0;
    chazhi_dx;
    C1=z;gz1=gz;ph1=ph;fy1=fy;

    beta=beta+1;
    chazhi_dx;
    beta=beta-1;
    C2=z;gz2=gz;ph2=ph;fy2=fy;

    dx=dx+1;
    chazhi_dx;
    dx=dx-1;
    C3=z;gz3=gz;ph3=ph;fy3=fy;

    dy=dy+1;
    chazhi_dy;
    dy=dy-1;
    C4=z;gz4=gz;ph4=ph;fy4=fy;

    b11=-0.05*Q*serf*L*L/jx/v;
    b12=0;
    b13=0;
    b14=(gz2(ma_cnt,alpha_cnt)-gz1(ma_cnt,alpha_cnt))/(1/57.3)/jx*Q*serf*L;
    b15=(gz4(ma_cnt,alpha_cnt)-gz1(ma_cnt,alpha_cnt))/(1/57.3)/jx*Q*serf*L;
    b16=0;
    b17=(gz3(ma_cnt,alpha_cnt)-gz1(ma_cnt,alpha_cnt))/(1/57.3)/jx*Q*serf*L;
    b18=1/jx;

    b21=0;
    b22=0;
    b23=0;
    b24=(ph2(ma_cnt,alpha_cnt)-ph1(ma_cnt,alpha_cnt))/(1/57.3)/jy*Q*serf*L;
    b24_1=0;
    b25=(ph4(ma_cnt,alpha_cnt)-ph1(ma_cnt,alpha_cnt))/(1/57.3)/jy*Q*serf*L;
    b25_1=0;
    b26=0;
    b27=0;
    b28=1/jy;

    b31=0;
    b32=-cos(theta/57.3)/cos((theta+alpha)/57.3);
    b33=0;
    b34=(Ft-(C2(ma_cnt,alpha_cnt)-C1(ma_cnt,alpha_cnt))/(1/57.3)*Q*serf)/(m*v);
    b35=-(C4(ma_cnt,alpha_cnt)-C1(ma_cnt,alpha_cnt))/(1/57.3)*Q*serf/(m*v);
    b36=-g*cos((theta+alpha)/57.3)/v;
    b37=0;
    b38=-1/m/v;
    if -b24-b22*b34>=0
        km_h(tf_i)=(-b25*b34+b35*b24)/(b22*b34+b24);
        tm_h(tf_i)=1/(-b24-b22*b34)^0.5;
        zeta_h(tf_i)=(-b22-b24_1+b34)/(2*(-b24-b22*b34)^0.5);
        t1_h(tf_i)=(-b35*b24_1+b25)/(b25*b34-b35*b24);
        num_wx=b17;
        den_wx=[1 -b11];
        num_gama=b17;
        den_gama=[1 -b11 0];
        tf_wx(tf_i)=tf(num_wx,den_wx);
        tf_gama(tf_i)=tf(num_gama,den_gama);

        num_wy=[km_h(tf_i)*t1_h(tf_i) km_h(tf_i)];
        den_wy=[tm_h(tf_i)*tm_h(tf_i) 2*tm_h(tf_i)*zeta_h(tf_i) 1];
        den_ph=[tm_h(tf_i)*tm_h(tf_i) 2*tm_h(tf_i)*zeta_h(tf_i) 1 0];
        tf_wy(tf_i)=tf(num_wy,den_wy);
        tf_ph(tf_i)=tf(num_wy,den_ph);
        num_beta=[km_h(tf_i)*t1_h(tf_i)];
        den_beta=[tm_h(tf_i)*tm_h(tf_i) 2*tm_h(tf_i)*zeta_h(tf_i) 1];
        tf_beta(tf_i)=tf(num_beta,den_beta);
        num_nz=[km_h(tf_i)*v];
        den_nz=[tm_h(tf_i)*tm_h(tf_i) 2*tm_h(tf_i)*zeta_h(tf_i) 1];
        tf_nz(tf_i)=tf(num_nz,den_nz);
    end
    if -b24-b22*b34<0
        km_h(tf_i)=(-b25*b34+b35*b24)/(b22*b34+b24);
        tm_h(tf_i)=-1/(b24+b22*b34)^0.5;
        zeta_h(tf_i)=-0.5*(-b22-b24_1+b34)*tm_h(tf_i);
        t1_h(tf_i)=(-b35*b24_1+b25)/(b25*b34-b35*b24);
        
        num_wx=b17;
        den_wx=[1 -b11];
        num_gama=b17;
        den_gama=[1 -b11 0];
        tf_wx(tf_i)=tf(num_wx,den_wx);
        tf_gama(tf_i)=tf(num_gama,den_gama);

        num_wy=[km_h(tf_i)*t1_h(tf_i) km_h(tf_i)];
        den_wy=[-tm_h(tf_i)*tm_h(tf_i) 2*tm_h(tf_i)*zeta_h(tf_i) 1];
        den_ph=[-tm_h(tf_i)*tm_h(tf_i) 2*tm_h(tf_i)*zeta_h(tf_i) 1 0];
        tf_wy(tf_i)=tf(num_wy,den_wy);
        tf_ph(tf_i)=tf(num_wy,den_ph);
        num_beta=[km_h(tf_i)*t1_h(tf_i)];
        den_beta=[-tm_h(tf_i)*tm_h(tf_i) 2*tm_h(tf_i)*zeta_h(tf_i) 1];
        tf_beta(tf_i)=tf(num_beta,den_beta);
        num_nz=[km_h(tf_i)*v];
        den_nz=[-tm_h(tf_i)*tm_h(tf_i) 2*tm_h(tf_i)*zeta_h(tf_i) 1];
        tf_nz(tf_i)=tf(num_nz,den_nz);
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tf_wz(tf_i)=tf_wz(tf_i)*tf(1,[0.01 1]);tf_wy(tf_i)=tf_wy(tf_i)*tf(1,[0.01 1]);tf_wx(tf_i)=tf_wx(tf_i)*tf(1,[0.01 1]);
end

save('zongxiang.mat','V','km','tm','ztam','t1','tf_wz','tf_fy','tf_theta','tf_alpha','tf_ny');
save('hengce.mat','km_h','tm_h','zeta_h','t1_h',...
                  'tf_wx','tf_gama',...
                  'tf_wy','tf_ph','tf_beta','tf_nz');
              close(h);
              assignin('base','dongya',dongya);
              close sim_3dof;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hObject    handle to pushbutton30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --- Executes on button press in pushbutton31.
function pushbutton31_Callback(hObject, eventdata, handles)
flag=get(handles.radiobutton_history_data,'Value');
if flag==1
file=['.\result\',get(handles.edit_history_data,'string')];
load(file)
end
if flag==0
load('sim_3dof_result.mat')
end
hold off
plot(sim_3dof_result(:,1),sim_3dof_result(:,4),'LineWidth',2)
xlabel('时间/s')
ylabel('Z/m')
title('位置Z曲线')
grid on

% hObject    handle to pushbutton31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


