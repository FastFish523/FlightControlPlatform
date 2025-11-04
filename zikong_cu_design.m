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

% Last Modified by GUIDE v2.5 23-Dec-2015 15:29:43

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
cnt=max(size(tf_wz));

t_tolorance=str2num(get(handles.edit_yanshi,'string'));

    h = waitbar(0.5,'Please wait...');
    for ct=1:cnt
        for kwz=0.001:0.001:100
            [Gm,Pm,Wcg,Wcp]=margin(-1*kwz*tf_wz(ct));
            t=Pm/Wcp/57.3;
            if t<t_tolorance*2
                break;
            end
        end
        kwz1(ct)=kwz;
        [p,z]=pzmap(feedback(tf_wz(ct),kwz,1));
        rea=real(min(p));
        ima=imag(min(p));
        zt(ct)=-sign(rea)*cos(atan(ima/rea));
    end
    close(h);
    set(handles.edit_kwz,'string',num2str(kwz1));
    set(handles.edit_zuni,'string',num2str(zt));
        axes(handles.axes1);
        cla
    for ct=1:cnt
        axes(handles.axes1);
        hold on
        margin(-1*kwz1(ct)*tf_wz(ct));
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
cla
flag=get(handles.popupmenu_choose_loop,'Value');
load zongxiang.mat;
load hengce.mat;
load tf_wz_bihuan.mat;
jifen=tf([1],[1 0]);
fuzhi=str2num(get(handles.fuzhi,'string'));
xiangwei=str2num(get(handles.xiangwei,'string'));
wcp1=str2num(get(handles.wcp,'string'));
h = waitbar(0.5,'Please wait...');
if flag==1%姿态控制
    for ct=1:max(size(tf_wz_bihuan))
    wcp=wcp1(ct);
    GA_cu;
    kpp(ct)=kp;
    kii(ct)=ki;
    end
    set(handles.KP,'string',num2str(-kpp));
    set(handles.KI,'string',num2str(-kii));
    for ct=1:max(size(tf_wz_bihuan))
    axes(handles.axes1)
    hold on
    margin(tf_fy_open(ct));
    end
end
if flag==2%过载控制
    for ct=1:max(size(tf_wz_bihuan))
        wcp=wcp1(ct);
    GA_cu;
    kpp(ct)=kp;
    kii(ct)=ki;
    end
    set(handles.KP,'string',num2str(-kpp));
    set(handles.KI,'string',num2str(-kii));
    for ct=1:max(size(tf_wz_bihuan))
    axes(handles.axes1)
    hold on
    margin(tf_ny_open(ct));
    end
end
if flag==3%过载控制
    for ct=1:max(size(tf_wz_bihuan))
        wcp=wcp1(ct);
    GA_cu;
    kpp(ct)=kp;
    kii(ct)=ki;
    end
    set(handles.KP,'string',num2str(-kpp));
    set(handles.KI,'string',num2str(-kii));
    for ct=1:max(size(tf_wz_bihuan))
    axes(handles.axes1)
    hold on
    margin(tf_ny_open(ct));
    end
end
    close(h);
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
        cla
load zongxiang.mat;
load hengce.mat;
jifen=tf([1],[1 0]);
h = waitbar(0.5,'Please wait...');
kwz=str2num(get(handles.edit_kwz,'string'));
cnt=max(size(kwz));
for ct=1:cnt
tf_wz_bihuan(ct)=feedback(tf_wz(ct),kwz(ct),1);
end
save('tf_wz_bihuan.mat','tf_wz_bihuan');
flag=get(handles.popupmenu_choose_loop,'Value');

if flag==1%姿态控制
    close(h);
    for ct=1:cnt
    tf_fy_open(ct)=tf_wz_bihuan(ct)*jifen;
    axes(handles.axes1);
    hold on
    margin(-tf_fy_open(ct));
    aa(ct)=1;
    end
    assignin('base','tf_fy_open',tf_fy_open);
end
if flag==2%过载
    close(h);
    for ct=1:cnt
    tf_ny_open(ct)=tf_wz_bihuan(ct)*tf([V(ct)],[t1(ct) 1]);
    axes(handles.axes1);
    hold on
    margin(-tf_ny_open(ct));
    aa(ct)=1;
    end
    assignin('base','tf_ny_open',tf_ny_open);
end
if flag==3%过载
    close(h);
    for ct=1:cnt
    tf_ny_open(ct)=tf_wz_bihuan(ct)*tf([V(ct)],[t1(ct) 1]);
    axes(handles.axes1);
    hold on
    margin(-tf_ny_open(ct));
        aa(ct)=1;
    end
    assignin('base','tf_ny_open',tf_ny_open);
end
set(handles.wcp,'string',num2str(aa));
% hObject    handle to pushbutton_zuni_bihuan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_out_bihuan.
function pushbutton_out_bihuan_Callback(hObject, eventdata, handles)
axes(handles.axes1);
cla
flag=get(handles.popupmenu_choose_loop,'Value');
load zongxiang.mat;
load hengce.mat;
load tf_wz_bihuan.mat;
jifen=tf([1],[1 0]);
h = waitbar(0.5,'Please wait...');
kp=str2num(get(handles.KP,'string'));
ki=str2num(get(handles.KI,'string'));
for ct=1:max(size(tf_wz_bihuan))
gc(ct)=ki(ct)*tf([kp(ct)/ki(ct) 1],[1 0]);
end
if flag==1%姿态控制
    for ct=1:max(size(tf_wz_bihuan))
    tf_fy_open=gc(ct)*tf_wz_bihuan(ct)*jifen;
    tf_fy_close=feedback(tf_fy_open,1,-1);
    axes(handles.axes1)
    hold on
    margin(tf_fy_close);
    end
end
if flag==2%过载控制
 for ct=1:max(size(tf_wz_bihuan))
    tf_ny_open=tf_wz_bihuan(ct)*V(ct)*tf([1],[t1(ct) 1]);
    tf_ny_open=gc(ct)*tf_ny_open;
    tf_ny_close=feedback(tf_ny_open,1,-1);
    axes(handles.axes1)
    hold on
    margin(tf_ny_close);
    end
end
if flag==3%过载控制
 for ct=1:max(size(tf_wz_bihuan))
    tf_ny_open=tf_wz_bihuan(ct)*V(ct)*tf([1],[t1(ct) 1]);
    tf_ny_open=gc(ct)*tf_ny_open;
    tf_ny_close=feedback(tf_ny_open,1,-1);
    axes(handles.axes1)
    hold on
    margin(tf_ny_close);
    end
end
    close(h);
% hObject    handle to pushbutton_out_bihuan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
flag=get(handles.popupmenu_choose_loop,'Value');
P=str2num(get(handles.KP,'string'));
I=str2num(get(handles.KI,'string'));
D=str2num(get(handles.edit_kwz,'string'));
if flag==3
KA=str2num(get(handles.edit_ka,'string'));
end
assignin('base','P',P);
assignin('base','I',I);
assignin('base','D',D);
if flag==3
assignin('base','KA',KA);
end
cftool;
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
rea=real(p(1));
ima=imag(p(1));
zt=cos(atan(ima/rea));
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
    tf_ny_open=tf_wz_bihuan*v/9.8*tf([1],[t1 1]);
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
    tf_ny_open=tf_wz_bihuan*v/9.8*tf([1],[t1 1]);
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




% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
axes(handles.axes1);
cla
flag=get(handles.popupmenu_choose_loop,'Value');
load zongxiang.mat;
load hengce.mat;

tt=str2num(get(handles.edit_yanshi,'string'));
[num,den]=pade(tt,20);
delay=tf(num,den);
kwz=str2num(get(handles.edit_kwz,'string'));
ka=str2num(get(handles.edit_ka,'string'));
cnt=max(size(kwz));
for ct=1:cnt
    if flag==3
        tf_wz_bihuan(ct)=feedback(delay*tf_wz(ct),tf([kwz(ct)*t1(ct) kwz(ct)+ka(ct)*V(ct)],[t1(ct) 1]),1);
    else
        tf_wz_bihuan(ct)=feedback(delay*tf_wz(ct),kwz(ct),1);
    end
end

jifen=tf([1],[1 0]);
kp=str2num(get(handles.KP,'string'));
ki=str2num(get(handles.KI,'string'));
for ct=1:max(size(tf_wz_bihuan))
gc(ct)=ki(ct)*tf([kp(ct)/ki(ct) 1],[1 0]);
end
if flag==1%姿态控制
    for ct=1:max(size(tf_wz_bihuan))
    tf_fy_open=gc(ct)*tf_wz_bihuan(ct)*jifen;
    tf_fy_close=feedback(tf_fy_open,1,-1);
    axes(handles.axes1)
    hold on
    step(tf_fy_close);
    end
end
if flag==2%过载控制
    for ct=1:max(size(tf_wz_bihuan))
    tf_ny_open=tf_wz_bihuan(ct)*V(ct)*tf([1],[t1(ct) 1]);
    tf_ny_open=gc(ct)*tf_ny_open;
    tf_ny_close=feedback(tf_ny_open,1,-1);
    axes(handles.axes1)
    hold on
    step(tf_ny_close);
    end
end
if flag==3%过载控制
    for ct=1:max(size(tf_wz_bihuan))
    tf_ny_open=tf_wz_bihuan(ct)*V(ct)*tf([1],[t1(ct) 1]);
    tf_ny_open=gc(ct)*tf_ny_open;
    tf_ny_close=feedback(tf_ny_open,1,-1);
    axes(handles.axes1)
    hold on
    step(tf_ny_close);
    end
end
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
flag=get(handles.popupmenu_choose_loop,'Value');
h = waitbar(0.5,'Please wait...');
P=str2num(get(handles.KP,'string'));
I=str2num(get(handles.KI,'string'));
D=str2num(get(handles.edit_kwz,'string'));
if flag==3
KA=str2num(get(handles.edit_ka,'string'));
end
dongya=evalin('base','dongya');
PX = lsqcurvefit(@myfun, [1 1], dongya, P);
IX = lsqcurvefit(@myfun, [1 1], dongya, I);
DX = lsqcurvefit(@myfun, [1 1], dongya, D);
if flag==3
KAX = lsqcurvefit(@myfun, [1 1], dongya, KA);
end
pid=fopen('./cnotrol_para/fy_contorl.txt','w');
fprintf(pid,'%d   %d      ',PX(1),PX(2));
fprintf(pid,'%d   %d      ',IX(1),IX(2));
fprintf(pid,'%d   %d      ',DX(1),DX(2));
if flag==3
fprintf(pid,'%d   %d      ',KA(1),KA(2));
end
fclose(pid);
close(h);
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)





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


% --- Executes on button press in pushbutton_3design.
function pushbutton_3design_Callback(hObject, eventdata, handles)
load zongxiang.mat;
load hengce.mat;
load tf_wz_bihuan.mat;
cnt=max(size(tf_wz));
for ct=1:cnt
    tf_ny_open(ct)=tf_wz_bihuan(ct)*tf([V(ct)],[t1(ct) 1]);
end
t_tolorance=str2num(get(handles.edit_yanshi1,'string'));

    h = waitbar(0.5,'Please wait...');
    for ct=1:cnt
        for ka=0.001:0.001:100
            [Gm,Pm,Wcg,Wcp]=margin(-1*ka*tf_ny_open(ct));
            t=Pm/Wcp/57.3;
            if t<t_tolorance*2
                break;
            end
        end
        ka1(ct)=ka;
        [p,z]=pzmap(feedback(tf_wz(ct),ka,1));
        rea=real(p(2));
        ima=imag(p(2));
        zt(ct)=-sign(rea)*cos(atan(ima/rea));
    end
    close(h);
    set(handles.edit_ka,'string',num2str(ka1));
    set(handles.edit_zuni,'string',num2str(zt));
        axes(handles.axes1);
        cla
    for ct=1:cnt
        axes(handles.axes1);
        hold on
        margin(-1*ka1(ct)*tf_ny_open(ct));
    end
% hObject    handle to pushbutton_3design (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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


% --- Executes on button press in pushbutton_3bihuan.
function pushbutton_3bihuan_Callback(hObject, eventdata, handles)
load zongxiang.mat;
load hengce.mat;
cnt=max(size(tf_wz));
jifen=tf([1],[1 0]);

kwz=str2num(get(handles.edit_kwz,'string'));
ka=str2num(get(handles.edit_ka,'string'));

for ct=1:cnt
tf_wz_bihuan(ct)=feedback(tf_wz(ct),tf([kwz(ct)*t1(ct) kwz(ct)+ka(ct)*V(ct)],[t1(ct) 1]),1);
tf_ny_open(ct)=tf_wz_bihuan(ct)*tf([V(ct)],[t1(ct) 1]);
end
axes(handles.axes1);
        cla
for ct=1:cnt
margin(-tf_ny_open(ct));
axes(handles.axes1);
hold on
end
save('tf_wz_bihuan.mat','tf_wz_bihuan');
assignin('base','tf_ny_open',tf_ny_open);
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


