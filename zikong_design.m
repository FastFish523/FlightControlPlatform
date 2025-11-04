function varargout = zikong_design(varargin)
% ZIKONG_DESIGN M-file for zikong_design.fig
%      ZIKONG_DESIGN, by itself, creates a new ZIKONG_DESIGN or raises the existing
%      singleton*.
%
%      H = ZIKONG_DESIGN returns the handle to a new ZIKONG_DESIGN or the handle to
%      the existing singleton*.
%
%      ZIKONG_DESIGN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ZIKONG_DESIGN.M with the given input arguments.
%
%      ZIKONG_DESIGN('Property','Value',...) creates a new ZIKONG_DESIGN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before zikong_design_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to zikong_design_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help zikong_design

% Last Modified by GUIDE v2.5 23-Feb-2016 15:00:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @zikong_design_OpeningFcn, ...
                   'gui_OutputFcn',  @zikong_design_OutputFcn, ...
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


% --- Executes just before zikong_design is made visible.
function zikong_design_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to zikong_design (see VARARGIN)

% Choose default command line output for zikong_design
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
% set(gcf,'menubar','figure')
% h=axes(handles.axes1);
% clear;
set(gcf,'toolbar','figure')
load zongxiang.mat;
load hengce.mat;
kp_flag=get(handles.radiobutton_KP,'value');
if(kp_flag==0)
    set(handles.KP,'Enable','off');
end
if(kp_flag==1)
    set(handles.KP,'Enable','on');
end

ki_flag=get(handles.radiobutton_KI,'value');
if(ki_flag==0)
    set(handles.KI,'Enable','off');
end
if(ki_flag==1)
    set(handles.KI,'Enable','on');
end

zuni_flag=get(handles.radiobutton_zuni,'value');
if(zuni_flag==0)
    set(handles.edit_zuni,'Enable','off');
end
if(zuni_flag==1)
    set(handles.edit_zuni,'Enable','on');
end

kwz_flag=get(handles.radiobutton_kwz,'value');
if(kwz_flag==0)
    set(handles.edit_kwz,'Enable','off');
end
if(kwz_flag==1)
    set(handles.edit_kwz,'Enable','on');
end
% UIWAIT makes zikong_design wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = zikong_design_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_yanshi_Callback(hObject, eventdata, handles)
% hObject    handle to edit_yanshi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_yanshi as text
%        str2double(get(hObject,'String')) returns contents of edit_yanshi as a double


% --- Executes during object creation, after setting all properties.
function edit_yanshi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_yanshi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_kwz_Callback(hObject, eventdata, handles)
% hObject    handle to edit_kwz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_kwz as text
%        str2double(get(hObject,'String')) returns contents of edit_kwz as a double


% --- Executes during object creation, after setting all properties.
function edit_kwz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_kwz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_zuni_Callback(hObject, eventdata, handles)
% hObject    handle to edit_zuni (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_zuni as text
%        str2double(get(hObject,'String')) returns contents of edit_zuni as a double


% --- Executes during object creation, after setting all properties.
function edit_zuni_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_zuni (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton_kwz.
function radiobutton_kwz_Callback(hObject, eventdata, handles)
kwz_flag=get(handles.radiobutton_kwz,'value');
if(kwz_flag==0)
    set(handles.edit_kwz,'Enable','off');
    set(handles.kwz_adjust,'Enable','off');
end
if(kwz_flag==1)
    set(handles.edit_kwz,'Enable','on');
    set(handles.kwz_adjust,'Enable','on');
    set(handles.kwz_adjust,'Value',0.5);
end
% hObject    handle to radiobutton_kwz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_kwz


% --- Executes on button press in radiobutton_zuni.
function radiobutton_zuni_Callback(hObject, eventdata, handles)
zuni_flag=get(handles.radiobutton_zuni,'value');
if(zuni_flag==0)
    set(handles.edit_zuni,'Enable','off');
end
if(zuni_flag==1)
    set(handles.edit_zuni,'Enable','on');
end
% hObject    handle to radiobutton_zuni (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_zuni


% --- Executes on button press in pushbutton_zuni_design.
function pushbutton_zuni_design_Callback(hObject, eventdata, handles)
load zongxiang.mat;
load hengce.mat;
axes(handles.axes1);
zuni_flag=get(handles.radiobutton_zuni,'value');
t_tolorance=str2num(get(handles.edit_yanshi,'string'));
if(zuni_flag==0)
    h = waitbar(0.5,'Please wait...');
    for kwz=0.001:0.001:100
    [Gm,Pm,Wcg,Wcp]=margin(-1*kwz*tf_wz);
    t=Pm/Wcp/57.3;
    if t<t_tolorance*2
        break;
    end
    end
    close(h);
    set(handles.edit_kwz,'string',num2str(kwz));
    set(handles.t1,'string',num2str(kwz));
    [p,z]=pzmap(feedback(tf_wz,kwz,1));
    rea=real(min(p));
    ima=imag(min(p));
    zt=-sign(rea)*cos(atan(ima/rea));
    set(handles.edit_zuni,'string',num2str(zt));
    hold off
    margin(-1*kwz*tf_wz);
end
if(zuni_flag==1)
    zt_tolorance=str2num(get(handles.edit_zuni,'string'));
    h = waitbar(0.5,'Please wait...');
    for kwz=0.001:0.001:100
        [p,z]=pzmap(feedback(tf_wz,kwz,1));
        rea=real(min(p));
        ima=imag(min(p));
        zt=-sign(rea)*cos(atan(ima/rea));
        if zt>=zt_tolorance
        break;
        end
    end
    close(h);    
    [Gm,Pm,Wcg,Wcp]=margin(-1*kwz*tf_wz);
    t=Pm/Wcp/57.3;
    set(handles.edit_kwz,'string',num2str(kwz));
    set(handles.t1,'string',num2str(kwz));
    set(handles.edit_yanshi,'string',num2str(t));
    hold off
    margin(-1*kwz*tf_wz);
end
% hObject    handle to pushbutton_zuni_design (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in zitai.
function zitai_Callback(hObject, eventdata, handles)
% hObject    handle to zitai (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of zitai



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4


% --- Executes on button press in pushbutton_out_design.
function pushbutton_out_design_Callback(hObject, eventdata, handles)
warning off all;
axes(handles.axes1);
flag=get(handles.popupmenu_choose_loop,'Value');
load zongxiang.mat;
load hengce.mat;
load tf_wz_bihuan.mat;
jifen=tf([1],[1 0]);
fuzhi=str2num(get(handles.fuzhi,'string'));
xiangwei=str2num(get(handles.xiangwei,'string'));
wcp=str2num(get(handles.wcp,'string'));
if flag==1%姿态控制
    h = waitbar(0.5,'Please wait...');
    GA;
    close(h);
    set(handles.KP,'string',num2str(-kp));
    set(handles.KI,'string',num2str(-ki));
    set(handles.t2,'string',num2str(-kp));
    set(handles.t3,'string',num2str(-ki));
    margin(tf_fy_open);
end
if flag==2%过载控制
    h = waitbar(0.5,'Please wait...');
    GA;
    close(h);
    set(handles.KP,'string',num2str(-kp));
    set(handles.KI,'string',num2str(-ki));
    set(handles.t2,'string',num2str(-kp));
    set(handles.t3,'string',num2str(-ki));
    margin(tf_ny_open);
end
if flag==3%过载控制
    h = waitbar(0.5,'Please wait...');
    GA;
    close(h);
    set(handles.KP,'string',num2str(-kp));
    set(handles.KI,'string',num2str(-ki));
    set(handles.t2,'string',num2str(-kp));
    set(handles.t3,'string',num2str(-ki));
    margin(tf_ny_open);
end
% hObject    handle to pushbutton_out_design (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in guozai.
function guozai_Callback(hObject, eventdata, handles)
% hObject    handle to guozai (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of guozai


% --- Executes on button press in pushbutton_zuni_bihuan.
function pushbutton_zuni_bihuan_Callback(hObject, eventdata, handles)
axes(handles.axes1);
load zongxiang.mat;
load hengce.mat;
jifen=tf([1],[1 0]);

h = waitbar(0.5,'Please wait...');
flag=get(handles.popupmenu_choose_loop,'Value');

if flag==1%姿态控制
    kwz=str2num(get(handles.edit_kwz,'string'));
    tf_wz_bihuan=feedback(tf_wz,kwz,1);
    save('tf_wz_bihuan.mat','tf_wz_bihuan');
    close(h);
    tf_fy_open=tf_wz_bihuan*jifen;
    margin(-tf_fy_open);
    assignin('base','tf_fy_open',tf_fy_open);
    [Gm,Pm,Wcg,Wcp]=margin(-1*kwz*tf_wz);
    set(handles.wcp,'string',num2str(Wcp/8));
end
if flag==2%2回路过载
    kwz=str2num(get(handles.edit_kwz,'string'));
    tf_wz_bihuan=feedback(tf_wz,kwz,1);
    save('tf_wz_bihuan.mat','tf_wz_bihuan');
    close(h);
    tf_ny_open=tf_wz_bihuan*tf([v],[t1 1]);
    margin(-tf_ny_open);
    assignin('base','tf_ny_open',tf_ny_open);
    [Gm,Pm,Wcg,Wcp]=margin(-1*kwz*tf_wz);
    set(handles.wcp,'string',num2str(Wcp/5));
end
if flag==3%3回路过载
    kwz=str2num(get(handles.edit_kwz,'string'));
    tf_wz_bihuan=feedback(tf_wz,kwz,1);
    save('tf_wz_bihuan.mat','tf_wz_bihuan');
    close(h);
    tf_ny_open=tf_wz_bihuan*tf([v],[t1 1]);
    margin(-tf_ny_open);
    assignin('base','tf_ny_open',tf_ny_open);
    [Gm,Pm,Wcg,Wcp]=margin(-1*kwz*tf_wz);
    set(handles.wcp,'string',num2str(Wcp/5));
end

% hObject    handle to pushbutton_zuni_bihuan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_out_bihuan.
function pushbutton_out_bihuan_Callback(hObject, eventdata, handles)
axes(handles.axes1);
flag=get(handles.popupmenu_choose_loop,'Value');
load zongxiang.mat;
load hengce.mat;
load tf_wz_bihuan.mat;
jifen=tf([1],[1 0]);
if flag==1%姿态控制
    h = waitbar(0.5,'Please wait...');
    kp=str2num(get(handles.KP,'string'));
    ki=str2num(get(handles.KI,'string'));
    gc=ki*tf([kp/ki 1],[1 0]);
    tf_fy_open=gc*tf_wz_bihuan*jifen;
    tf_fy_close=feedback(tf_fy_open,1,-1);
    close(h);
    margin(tf_fy_close);
end
if flag==2%过载控制
h = waitbar(0.5,'Please wait...');
    kp=str2num(get(handles.KP,'string'));
    ki=str2num(get(handles.KI,'string'));
    gc=ki*tf([kp/ki 1],[1 0]);
    tf_ny_open=tf_wz_bihuan*v*tf([1],[t1 1]);
    tf_ny_open=gc*tf_ny_open;
    tf_ny_close=feedback(tf_ny_open,1,-1);
    close(h);
    margin(tf_ny_close);
end
if flag==3%过载控制
h = waitbar(0.5,'Please wait...');
    kp=str2num(get(handles.KP,'string'));
    ki=str2num(get(handles.KI,'string'));
    gc=ki*tf([kp/ki 1],[1 0]);
    tf_ny_open=tf_wz_bihuan*v*tf([1],[t1 1]);
    tf_ny_open=gc*tf_ny_open;
    tf_ny_close=feedback(tf_ny_open,1,-1);
    close(h);
    margin(tf_ny_close);
end
% hObject    handle to pushbutton_out_bihuan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
sisotool;
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function FUZHI_Callback(hObject, eventdata, handles)
% hObject    handle to FUZHI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FUZHI as text
%        str2double(get(hObject,'String')) returns contents of FUZHI as a double


% --- Executes during object creation, after setting all properties.
function FUZHI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FUZHI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xiangwei_Callback(hObject, eventdata, handles)
% hObject    handle to xiangwei (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xiangwei as text
%        str2double(get(hObject,'String')) returns contents of xiangwei as a double


% --- Executes during object creation, after setting all properties.
function xiangwei_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xiangwei (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function wcp_Callback(hObject, eventdata, handles)
% hObject    handle to wcp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of wcp as text
%        str2double(get(hObject,'String')) returns contents of wcp as a double


% --- Executes during object creation, after setting all properties.
function wcp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wcp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function KP_Callback(hObject, eventdata, handles)
% hObject    handle to KP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of KP as text
%        str2double(get(hObject,'String')) returns contents of KP as a double


% --- Executes during object creation, after setting all properties.
function KP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to KP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function KI_Callback(hObject, eventdata, handles)
% hObject    handle to KI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of KI as text
%        str2double(get(hObject,'String')) returns contents of KI as a double


% --- Executes during object creation, after setting all properties.
function KI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to KI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton_KI.
function radiobutton_KI_Callback(hObject, eventdata, handles)
ki_flag=get(handles.radiobutton_KI,'value');
if(ki_flag==0)
    set(handles.KI,'Enable','off');
    set(handles.ki_adjust,'Enable','off');
end
if(ki_flag==1)
    set(handles.KI,'Enable','on');
    set(handles.ki_adjust,'Enable','on');
    set(handles.ki_adjust,'Value',0.5);
end
% hObject    handle to radiobutton_KI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_KI


% --- Executes on button press in radiobutton_KP.
function radiobutton_KP_Callback(hObject, eventdata, handles)
kp_flag=get(handles.radiobutton_KP,'value');
if(kp_flag==0)
    set(handles.KP,'Enable','off');
    set(handles.kp_adjust,'Enable','off');
end
if(kp_flag==1)
    set(handles.KP,'Enable','on');
    set(handles.kp_adjust,'Enable','on');
    set(handles.kp_adjust,'Value',0.5);
end
% hObject    handle to radiobutton_KP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_KP



function fuzhi_Callback(hObject, eventdata, handles)
% hObject    handle to fuzhi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fuzhi as text
%        str2double(get(hObject,'String')) returns contents of fuzhi as a double


% --- Executes during object creation, after setting all properties.
function fuzhi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fuzhi (see GCBO)
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




% --- Executes on slider movement.
function kwz_adjust_Callback(hObject, eventdata, handles)
load zongxiang.mat;
load hengce.mat;
axes(handles.axes1);

posi=get(handles.kwz_adjust,'Value');
add=(posi-0.5)*5;
kwz_fix=str2num(get(handles.t1,'string'));
kwz=kwz_fix+add;
set(handles.edit_kwz,'string',num2str(kwz));
[p,z]=pzmap(feedback(tf_wz,kwz,1));
rea=real(min(p));
ima=imag(min(p));
zt=-sign(rea)*cos(atan(ima/rea));
set(handles.edit_zuni,'string',num2str(zt));

[Gm,Pm,Wcg,Wcp]=margin(-1*kwz*tf_wz);
t=Pm/Wcp/57.3;
set(handles.edit_yanshi,'string',num2str(t));

margin(-1*kwz*tf_wz);
% hObject    handle to kwz_adjust (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function kwz_adjust_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kwz_adjust (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end




% --- Executes on slider movement.
function kp_adjust_Callback(hObject, eventdata, handles)
load zongxiang.mat;
load hengce.mat;
load tf_wz_bihuan.mat;
axes(handles.axes1);

posi=get(handles.kp_adjust,'Value');
add=(posi-0.5)*5;
kp=-str2num(get(handles.t2,'string'));
ki=-str2num(get(handles.KI,'string'));
kp=kp+add;
set(handles.KP,'string',num2str(-kp));
flag=get(handles.popupmenu_choose_loop,'Value');
jifen=tf([1],[1 0]);

if flag==1%姿态控制
    gc=-1*ki*tf([kp/ki 1],[1 0]);
    tf_fy_open=gc*tf_wz_bihuan*jifen;
    margin(tf_fy_open);
end
if flag==2%过载控制
    tf_ny_open=tf_wz_bihuan*v*tf([1],[t1 1]);
    gc=-1*ki*tf([kp/ki 1],[1 0]);
    tf_ny_open=gc*tf_ny_open;
    margin(tf_ny_open);
end
% hObject    handle to kp_adjust (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function kp_adjust_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kp_adjust (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function ki_adjust_Callback(hObject, eventdata, handles)
load zongxiang.mat;
load hengce.mat;
load tf_wz_bihuan.mat;
axes(handles.axes1);

posi=get(handles.ki_adjust,'Value');
add=(posi-0.5)*5;
ki=-str2num(get(handles.t3,'string'));
kp=-str2num(get(handles.KP,'string'));
ki=ki+add;
set(handles.KI,'string',num2str(-ki));
flag=get(handles.popupmenu_choose_loop,'Value');
jifen=tf([1],[1 0]);
if flag==1%姿态控制
    gc=-1*ki*tf([kp/ki 1],[1 0]);
    tf_fy_open=gc*tf_wz_bihuan*jifen;
    margin(tf_fy_open);
end
if flag==2%过载控制
    tf_ny_open=tf_wz_bihuan*v*tf([1],[t1 1]);
    gc=-1*ki*tf([kp/ki 1],[1 0]);
    tf_ny_open=gc*tf_ny_open;
    margin(tf_ny_open);
end
% hObject    handle to ki_adjust (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function ki_adjust_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ki_adjust (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end




% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
flag=get(handles.popupmenu_choose_loop,'Value');
if flag==1
    zx_zitai;
end
if flag==2
    zx_guozai;
end
if flag==3
    zx_guozai;
end
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
axes(handles.axes1);
flag=get(handles.popupmenu_choose_loop,'Value');
load zongxiang.mat;
load hengce.mat;
tt=str2num(get(handles.edit_yanshi,'string'));
[num,den]=pade(tt,20);
delay=tf(num,den);
kwz=str2num(get(handles.edit_kwz,'string'));
ka=str2num(get(handles.edit_ka,'string'));
if flag==3
tf_wz_bihuan=feedback(delay*tf_wz,tf([kwz*t1 kwz+ka*v],[t1 1]),1);
else
tf_wz_bihuan=feedback(delay*tf_wz,kwz,1);
end
jifen=tf([1],[1 0]);
if flag==1%姿态控制
    h = waitbar(0.5,'Please wait...');
    kp=str2num(get(handles.KP,'string'));
    ki=str2num(get(handles.KI,'string'));
    gc=ki*tf([kp/ki 1],[1 0]);
    tf_fy_open=gc*tf_wz_bihuan*jifen;
    tf_fy_close=feedback(tf_fy_open,1,-1);
    close(h);
    step(tf_fy_close);
end
if flag==2%过载控制

h = waitbar(0.5,'Please wait...');
    kp=str2num(get(handles.KP,'string'));
    ki=str2num(get(handles.KI,'string'));
    gc=ki*tf([kp/ki 1],[1 0]);
    tf_ny_open=tf_wz_bihuan*v*tf([1],[t1 1]);
    tf_ny_open=gc*tf_ny_open;
    tf_ny_close=feedback(tf_ny_open,1,-1);
    close(h);
    step(tf_ny_close);
end
if flag==3%过载控制

h = waitbar(0.5,'Please wait...');
    kp=str2num(get(handles.KP,'string'));
    ki=str2num(get(handles.KI,'string'));
    gc=ki*tf([kp/ki 1],[1 0]);
    tf_ny_open=tf_wz_bihuan*v*tf([1],[t1 1]);
    tf_ny_open=gc*tf_ny_open;
    tf_ny_close=feedback(tf_ny_open,1,-1);
    close(h);
    step(tf_ny_close);
end
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)





function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ka_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ka (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ka as text
%        str2double(get(hObject,'String')) returns contents of edit_ka as a double


% --- Executes during object creation, after setting all properties.
function edit_ka_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ka (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_3design.
function pushbutton_3design_Callback(hObject, eventdata, handles)
t_tolorance=str2num(get(handles.edit_yanshi1,'string'));
warning off all;
axes(handles.axes1);
load zongxiang.mat;
load hengce.mat;
load tf_wz_bihuan.mat;
tf_ny_open=tf_wz_bihuan*tf([v],[t1 1]);
h = waitbar(0.5,'Please wait...');
for ka=0.001:0.001:100
    [Gm,Pm,Wcg,Wcp]=margin(-1*ka*tf_ny_open);
    t=Pm/Wcp/57.3;
    if t<t_tolorance*2
        break;
    end
end
close(h);
set(handles.edit_ka,'string',num2str(ka));
 [p,z]=pzmap(feedback(tf_ny_open,ka,1));
    rea=real(p(2));
    ima=imag(p(2));
    zt=-sign(rea)*cos(atan(ima/rea));
    set(handles.edit_zuni,'string',num2str(zt));
hold off
margin(-1*ka*tf_ny_open);
% hObject    handle to pushbutton_3design (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_3bihuan.
function pushbutton_3bihuan_Callback(hObject, eventdata, handles)
axes(handles.axes1);
load zongxiang.mat;
load hengce.mat;
jifen=tf([1],[1 0]);

kwz=str2num(get(handles.edit_kwz,'string'));
ka=str2num(get(handles.edit_ka,'string'));
tf_wz_bihuan=feedback(tf_wz,tf([kwz*t1 kwz+ka*v],[t1 1]),1);
tf_ny_open=tf_wz_bihuan*tf([v],[t1 1]);
margin(-tf_ny_open);
assignin('base','tf_ny_open',tf_ny_open);
save('tf_wz_bihuan.mat','tf_wz_bihuan');
% hObject    handle to pushbutton_3bihuan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu_choose_loop.
function popupmenu_choose_loop_Callback(hObject, eventdata, handles)
flag=get(handles.popupmenu_choose_loop,'Value');
if flag~=3
    set(handles.edit_ka,'Enable','off');
    set(handles.pushbutton_3design,'Enable','off');
    set(handles.pushbutton_3bihuan,'Enable','off');
    set(handles.edit_yanshi1,'Enable','off');
else
    set(handles.edit_ka,'Enable','on');
    set(handles.pushbutton_3design,'Enable','on');
    set(handles.pushbutton_3bihuan,'Enable','on');
    set(handles.edit_yanshi1,'Enable','on');
end
% hObject    handle to popupmenu_choose_loop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu_choose_loop contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_choose_loop





function edit_yanshi1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_yanshi1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_yanshi1 as text
%        str2double(get(hObject,'String')) returns contents of edit_yanshi1 as a double


% --- Executes during object creation, after setting all properties.
function edit_yanshi1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_yanshi1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton11.

% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


