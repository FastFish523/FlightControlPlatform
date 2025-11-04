function varargout = Control_qidong(varargin)
%CONTROL_QIDONG M-file for Control_qidong.fig
%      CONTROL_QIDONG, by itself, creates a new CONTROL_QIDONG or raises the existing
%      singleton*.
%
%      H = CONTROL_QIDONG returns the handle to a new CONTROL_QIDONG or the handle to
%      the existing singleton*.
%
%      CONTROL_QIDONG('Property','Value',...) creates a new CONTROL_QIDONG using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to Control_qidong_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      CONTROL_QIDONG('CALLBACK') and CONTROL_QIDONG('CALLBACK',hObject,...) call the
%      local function named CALLBACK in CONTROL_QIDONG.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Control_qidong

% Last Modified by GUIDE v2.5 15-Dec-2015 15:27:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Control_qidong_OpeningFcn, ...
                   'gui_OutputFcn',  @Control_qidong_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before Control_qidong is made visible.
function Control_qidong_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)
% Choose default command line output for Control_qidong
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);



% UIWAIT makes Control_qidong wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Control_qidong_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_beta_vec_Callback(hObject, eventdata, handles)
% hObject    handle to edit_beta_vec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_beta_vec as text
%        str2double(get(hObject,'String')) returns contents of edit_beta_vec as a double


% --- Executes during object creation, after setting all properties.
function edit_beta_vec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_beta_vec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Ma_vec_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Ma_vec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Ma_vec as text
%        str2double(get(hObject,'String')) returns contents of edit_Ma_vec as a double


% --- Executes during object creation, after setting all properties.
function edit_Ma_vec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Ma_vec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dz_vec_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dz_vec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dz_vec as text
%        str2double(get(hObject,'String')) returns contents of edit_dz_vec as a double


% --- Executes during object creation, after setting all properties.
function edit_dz_vec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dz_vec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dy_vec_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dy_vec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dy_vec as text
%        str2double(get(hObject,'String')) returns contents of edit_dy_vec as a double


% --- Executes during object creation, after setting all properties.
function edit_dy_vec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dy_vec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dx_vec_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dx_vec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dx_vec as text
%        str2double(get(hObject,'String')) returns contents of edit_dx_vec as a double


% --- Executes during object creation, after setting all properties.
function edit_dx_vec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dx_vec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_alpha_vec_Callback(hObject, eventdata, handles)
% hObject    handle to edit_alpha_vec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_alpha_vec as text
%        str2double(get(hObject,'String')) returns contents of edit_alpha_vec as a double


% --- Executes during object creation, after setting all properties.
function edit_alpha_vec_CreateFcn(hObject, eventdata, handles)

% hObject    handle to edit_alpha_vec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function text_alpha_nod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_alpha_nod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text_beta_nod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_beta_nod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text_Ma_nod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_Ma_nod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text_dz_nod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_dz_nod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text_dy_nod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_dy_nod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text_dx_nod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_dx_nod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton_qidong_ok.
function pushbutton_qidong_ok_Callback(hObject, eventdata, handles)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cc=get(handles.edit_dz_qidong,'string');
cc=['./air_data/',cc];
C=load(cc);
bb=get(handles.edit_dy_qidong,'string');
bb=['./air_data/',bb];
B=load(bb);
aa=get(handles.edit_dx_qidong,'string');
aa=['./air_data/',aa];
A=load(aa);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
alpha_vec=str2num(get(handles.edit_alpha_vec,'String'));
num_alpha=str2num(get(handles.text_alpha_nod,'String'));

Ma_vec=str2num(get(handles.edit_Ma_vec,'String'));
num_Ma=str2num(get(handles.text_Ma_nod,'String'));

beta_vec=str2num(get(handles.edit_beta_vec,'String'));
num_beta=str2num(get(handles.text_beta_nod,'String'));

dz_vec=str2num(get(handles.edit_dz_vec,'String'));
num_dz=str2num(get(handles.text_dz_nod,'String'));

dy_vec=str2num(get(handles.edit_dy_vec,'String'));
num_dy=str2num(get(handles.text_dy_nod,'String'));

dx_vec=str2num(get(handles.edit_dx_vec,'String'));
num_dx=str2num(get(handles.text_dx_nod,'String'));

zhixin_lapian=str2num(get(handles.text_zhixin_lapian,'string'))/100/1.779;

for i01=1:num_dx
		for i02=1:num_beta
			for i03=1:num_Ma
				for i04=1:num_alpha	
                ca_dx(i01,i02,i03,i04)=A((i01-1)*num_beta*num_Ma*num_alpha+(i02-1)*num_Ma*num_alpha+(i03-1)*num_alpha+i04,1);
                cn_dx(i01,i02,i03,i04)=A((i01-1)*num_beta*num_Ma*num_alpha+(i02-1)*num_Ma*num_alpha+(i03-1)*num_alpha+i04,2);
                cz_dx(i01,i02,i03,i04)=A((i01-1)*num_beta*num_Ma*num_alpha+(i02-1)*num_Ma*num_alpha+(i03-1)*num_alpha+i04,3);
                mx_dx(i01,i02,i03,i04)=A((i01-1)*num_beta*num_Ma*num_alpha+(i02-1)*num_Ma*num_alpha+(i03-1)*num_alpha+i04,4);
                my_dx(i01,i02,i03,i04)=A((i01-1)*num_beta*num_Ma*num_alpha+(i02-1)*num_Ma*num_alpha+(i03-1)*num_alpha+i04,5)+cz_dx(i01,i02,i03,i04)*zhixin_lapian;
                mz_dx(i01,i02,i03,i04)=A((i01-1)*num_beta*num_Ma*num_alpha+(i02-1)*num_Ma*num_alpha+(i03-1)*num_alpha+i04,6)-cn_dx(i01,i02,i03,i04)*zhixin_lapian;
                end
            end
        end
    end

for i11=1:num_dy
		for i12=1:num_beta
			for i13=1:num_Ma
				for i14=1:num_alpha	
                ca_dy(i11,i12,i13,i14)=B((i11-1)*num_beta*num_Ma*num_alpha+(i12-1)*num_Ma*num_alpha+(i13-1)*num_alpha+i14,1);
                cn_dy(i11,i12,i13,i14)=B((i11-1)*num_beta*num_Ma*num_alpha+(i12-1)*num_Ma*num_alpha+(i13-1)*num_alpha+i14,2);
                cz_dy(i11,i12,i13,i14)=B((i11-1)*num_beta*num_Ma*num_alpha+(i12-1)*num_Ma*num_alpha+(i13-1)*num_alpha+i14,3);
                mx_dy(i11,i12,i13,i14)=B((i11-1)*num_beta*num_Ma*num_alpha+(i12-1)*num_Ma*num_alpha+(i13-1)*num_alpha+i14,4);
                my_dy(i11,i12,i13,i14)=B((i11-1)*num_beta*num_Ma*num_alpha+(i12-1)*num_Ma*num_alpha+(i13-1)*num_alpha+i14,5)+cz_dy(i11,i12,i13,i14)*zhixin_lapian;
                mz_dy(i11,i12,i13,i14)=B((i11-1)*num_beta*num_Ma*num_alpha+(i12-1)*num_Ma*num_alpha+(i13-1)*num_alpha+i14,6)-cn_dy(i11,i12,i13,i14)*zhixin_lapian;
                end
            end
        end
    end

for i21=1:num_dz
		for i22=1:num_beta
			for i23=1:num_Ma
				for i24=1:num_alpha	
                ca_dz(i21,i22,i23,i24)=C((i21-1)*num_beta*num_Ma*num_alpha+(i22-1)*num_Ma*num_alpha+(i23-1)*num_alpha+i24,1);
                cn_dz(i21,i22,i23,i24)=C((i21-1)*num_beta*num_Ma*num_alpha+(i22-1)*num_Ma*num_alpha+(i23-1)*num_alpha+i24,2);
                cz_dz(i21,i22,i23,i24)=C((i21-1)*num_beta*num_Ma*num_alpha+(i22-1)*num_Ma*num_alpha+(i23-1)*num_alpha+i24,3);
                mx_dz(i21,i22,i23,i24)=C((i21-1)*num_beta*num_Ma*num_alpha+(i22-1)*num_Ma*num_alpha+(i23-1)*num_alpha+i24,4);
                my_dz(i21,i22,i23,i24)=C((i21-1)*num_beta*num_Ma*num_alpha+(i22-1)*num_Ma*num_alpha+(i23-1)*num_alpha+i24,5)+cz_dz(i21,i22,i23,i24)*zhixin_lapian;
                mz_dz(i21,i22,i23,i24)=C((i21-1)*num_beta*num_Ma*num_alpha+(i22-1)*num_Ma*num_alpha+(i23-1)*num_alpha+i24,6)-cn_dz(i21,i22,i23,i24)*zhixin_lapian;
                end
            end
        end
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
assignin('base','ca_dz',ca_dz);
assignin('base','cn_dz',cn_dz);
assignin('base','cz_dz',cz_dz);

assignin('base','mx_dz',mx_dz);
assignin('base','my_dz',my_dz);
assignin('base','mz_dz',mz_dz);

assignin('base','ca_dy',ca_dy);
assignin('base','cn_dy',cn_dy);
assignin('base','cz_dy',cz_dy);

assignin('base','mx_dy',mx_dy);
assignin('base','my_dy',my_dy);
assignin('base','mz_dy',mz_dy);

assignin('base','ca_dx',ca_dx);
assignin('base','cn_dx',cn_dx);
assignin('base','cz_dx',cz_dx);

assignin('base','mx_dx',mx_dx);
assignin('base','my_dx',my_dx);
assignin('base','mz_dx',mz_dx);

assignin('base','dz_vec',dz_vec);
assignin('base','dy_vec',dy_vec);
assignin('base','dx_vec',dx_vec);

save('air_Data.mat','num_Ma','num_alpha','num_beta','num_dx','num_dy','num_dz','alpha_vec','Ma_vec','beta_vec','dz_vec','dy_vec','dx_vec','ca_dz','cn_dz','cz_dz','mx_dz','my_dz','mz_dz','ca_dy','cn_dy','cz_dy','mx_dy','my_dy','mz_dy','ca_dx','cn_dx','cz_dx','mx_dx','my_dx','mz_dx');
close('Control_qidong');
% hObject    handle to pushbutton_qidong_ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press over edit_alpha_vec with no controls selected.
function edit_alpha_vec_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_alpha_vec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_basic.
function pushbutton_basic_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_basic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit_qidong_basic_Callback(hObject, eventdata, handles)
% hObject    handle to edit_qidong_basic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_qidong_basic as text
%        str2double(get(hObject,'String')) returns contents of edit_qidong_basic as a double


% --- Executes during object creation, after setting all properties.
function edit_qidong_basic_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_qidong_basic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dz_qidong_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dz_qidong (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dz_qidong as text
%        str2double(get(hObject,'String')) returns contents of edit_dz_qidong as a double


% --- Executes during object creation, after setting all properties.
function edit_dz_qidong_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dz_qidong (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_dz_qidong.
function pushbutton_dz_qidong_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_dz_qidong (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dz_file=uigetfile;
set(handles.edit_dz_qidong,'string',dz_file);

function edit_dy_qidong_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dy_qidong (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dy_qidong as text
%        str2double(get(hObject,'String')) returns contents of edit_dy_qidong as a double


% --- Executes during object creation, after setting all properties.
function edit_dy_qidong_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dy_qidong (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_dy_qidong.
function pushbutton_dy_qidong_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_dy_qidong (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dy_file=uigetfile;
set(handles.edit_dy_qidong,'string',dy_file);

function edit_dx_qidong_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dx_qidong (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dx_qidong as text
%        str2double(get(hObject,'String')) returns contents of edit_dx_qidong as a double


% --- Executes during object creation, after setting all properties.
function edit_dx_qidong_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dx_qidong (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_dx_qidong.
function pushbutton_dx_qidong_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_dx_qidong (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dx_file=uigetfile;
set(handles.edit_dx_qidong,'string',dx_file);


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% 攻角
a=str2num(get(handles.edit_alpha_vec,'string'));
assignin('base','alpha_vec',a);
assignin('base','num_alpha',max(size(a)));
set(handles.text_alpha_nod,'string',max(size(a)));
% 侧滑
a=str2num(get(handles.edit_beta_vec,'String'));
assignin('base','beta_vec',a);
assignin('base','num_beta',max(size(a)));
set(handles.text_beta_nod,'string',max(size(a)));
% 马赫数
a=str2num(get(handles.edit_Ma_vec,'String'));
assignin('base','Ma_vec',a);
assignin('base','num_Ma',max(size(a)));
set(handles.text_Ma_nod,'string',max(size(a)));
% dz
a=str2num(get(handles.edit_dz_vec,'String'));
assignin('base','dz_vec',a);
assignin('base','num_dz',max(size(a)));
set(handles.text_dz_nod,'string',max(size(a)));
% dy
a=str2num(get(handles.edit_dy_vec,'String'));
assignin('base','dy_vec',a);
assignin('base','num_dy',max(size(a)));
set(handles.text_dy_nod,'string',max(size(a)));
% dx
a=str2num(get(handles.edit_dx_vec,'String'));
assignin('base','dx_vec',a);
assignin('base','num_dx',max(size(a)));
set(handles.text_dx_nod,'string',max(size(a)));
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in radiobutton_flag.
function radiobutton_flag_Callback(hObject, eventdata, handles)
flag=get(handles.radiobutton_flag,'value');
if flag==1
    load('./气动数据初步处理/para.mat');
    set(handles.edit_alpha_vec,'string',num2str(alpha_vec));
    set(handles.edit_Ma_vec,'string',num2str(Ma_vec));
    set(handles.edit_beta_vec,'string',num2str(beta_vec));
    set(handles.edit_dz_vec,'string',num2str(dz_vec));
    set(handles.edit_dy_vec,'string',num2str(dy_vec));
    set(handles.edit_dx_vec,'string',num2str(dx_vec));

    set(handles.edit_alpha_vec,'Enable','off');
    set(handles.edit_Ma_vec,'Enable','off');
    set(handles.edit_beta_vec,'Enable','off');
    set(handles.edit_dz_vec,'Enable','off');
    set(handles.edit_dy_vec,'Enable','off');
    set(handles.edit_dx_vec,'Enable','off');
else
    set(handles.edit_alpha_vec,'Enable','on');
    set(handles.edit_Ma_vec,'Enable','on');
    set(handles.edit_beta_vec,'Enable','on');
    set(handles.edit_dz_vec,'Enable','on');
    set(handles.edit_dy_vec,'Enable','on');
    set(handles.edit_dx_vec,'Enable','on');
end

% hObject    handle to radiobutton_flag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_flag


