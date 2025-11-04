function varargout = trf(varargin)
%TRF M-file for trf.fig
%      TRF, by itself, creates a new TRF or raises the existing
%      singleton*.
%
%      H = TRF returns the handle to a new TRF or the handle to
%      the existing singleton*.
%
%      TRF('Property','Value',...) creates a new TRF using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to trf_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      TRF('CALLBACK') and TRF('CALLBACK',hObject,...) call the
%      local function named CALLBACK in TRF.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help trf

% Last Modified by GUIDE v2.5 21-Dec-2015 18:01:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @trf_OpeningFcn, ...
                   'gui_OutputFcn',  @trf_OutputFcn, ...
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


% --- Executes just before trf is made visible.
function trf_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for trf
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
load zongxiang.mat;
load hengce.mat;
evalin('base','load zongxiang.mat;');
evalin('base','load hengce.mat;');
set(handles.a11,'string',num2str(a11));
set(handles.a12,'string',num2str(a12));
set(handles.a13,'string',num2str(a13));
set(handles.a14,'string',num2str(a14));
set(handles.a15,'string',num2str(a15));
set(handles.a16,'string',num2str(a16));

set(handles.a21,'string',num2str(a21));
set(handles.a22,'string',num2str(a22));
set(handles.a23,'string',num2str(a23));
set(handles.a24,'string',num2str(a24));
set(handles.a25,'string',num2str(a25));
set(handles.a26,'string',num2str(a26));

set(handles.a31,'string',num2str(a31));
set(handles.a32,'string',num2str(a32));
set(handles.a33,'string',num2str(a33));
set(handles.a34,'string',num2str(a34));
set(handles.a35,'string',num2str(a35));
set(handles.a36,'string',num2str(a36));

set(handles.km,'string',num2str(km));
set(handles.tm,'string',num2str(tm));
set(handles.ztm,'string',num2str(ztam));
set(handles.t1,'string',num2str(t1));
set(handles.w_fix,'string',[num2str(1/tm/2/3.14),'hz']);

set(handles.b11,'string',num2str(b11));
set(handles.b12,'string',num2str(b12));
set(handles.b13,'string',num2str(b13));
set(handles.b14,'string',num2str(b14));
set(handles.b15,'string',num2str(b15));
set(handles.b16,'string',num2str(b16));
set(handles.b17,'string',num2str(b17));
set(handles.b18,'string',num2str(b18));

set(handles.b21,'string',num2str(b21));
set(handles.b22,'string',num2str(b22));
set(handles.b23,'string',num2str(b23));
set(handles.b24,'string',num2str(b24));
set(handles.b25,'string',num2str(b25));
set(handles.b26,'string',num2str(b26));
set(handles.b27,'string',num2str(b27));
set(handles.b28,'string',num2str(b28));

set(handles.b31,'string',num2str(b31));
set(handles.b32,'string',num2str(b32));
set(handles.b33,'string',num2str(b33));
set(handles.b34,'string',num2str(b34));
set(handles.b35,'string',num2str(b35));
set(handles.b36,'string',num2str(b36));
set(handles.b37,'string',num2str(b37));
set(handles.b38,'string',num2str(b38));

set(handles.km_h,'string',num2str(km_h));
set(handles.tm_h,'string',num2str(tm_h));
set(handles.ztm_h,'string',num2str(zeta_h));
set(handles.t1_h,'string',num2str(t1_h));

set(handles.text_b17,'string',num2str(b17));
set(handles.text_b11,'string',num2str(b11));

set(handles.text_km,'string',num2str(km));
set(handles.text_t1,'string',num2str(t1));
set(handles.text_tm2,'string',num2str(tm*tm));
set(handles.text_2tmztm,'string',num2str(2*tm*ztam));
set(handles.text_kmt1,'string',num2str(km*t1));
set(handles.text_kmvg,'string',num2str(km*v));

set(handles.text_km_h,'string',num2str(km_h));
set(handles.text_t1_h,'string',num2str(t1_h));
set(handles.text_tm_h2,'string',num2str(tm_h*tm_h));
set(handles.text_2tm_hztm_h,'string',num2str(2*tm_h*zeta_h));
set(handles.text_km_ht1_h,'string',num2str(km_h*t1_h));
set(handles.text_km_hvg,'string',num2str(km_h*v));
if -b24-b22*b34>=0
    set(handles.text_tm2,'string',num2str(tm*tm));
end
if -b24-b22*b34<0
    set(handles.text_tm2,'string',num2str(-tm*tm));
end
if -a24-a22*a34>=0
    set(handles.text_tm_h2,'string',num2str(tm_h*tm_h));
end
if -a24-a22*a34<0
    set(handles.text_tm_h2,'string',num2str(-tm_h*tm_h));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% UIWAIT makes trf wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = trf_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function a11_Callback(hObject, eventdata, handles)
% hObject    handle to a11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a11 as text
%        str2double(get(hObject,'String')) returns contents of a11 as a double


% --- Executes during object creation, after setting all properties.
function a11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a12_Callback(hObject, eventdata, handles)
% hObject    handle to a12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a12 as text
%        str2double(get(hObject,'String')) returns contents of a12 as a double


% --- Executes during object creation, after setting all properties.
function a12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a13_Callback(hObject, eventdata, handles)
% hObject    handle to a13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a13 as text
%        str2double(get(hObject,'String')) returns contents of a13 as a double


% --- Executes during object creation, after setting all properties.
function a13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a14_Callback(hObject, eventdata, handles)
% hObject    handle to a14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a14 as text
%        str2double(get(hObject,'String')) returns contents of a14 as a double


% --- Executes during object creation, after setting all properties.
function a14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a15_Callback(hObject, eventdata, handles)
% hObject    handle to a15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a15 as text
%        str2double(get(hObject,'String')) returns contents of a15 as a double


% --- Executes during object creation, after setting all properties.
function a15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a16_Callback(hObject, eventdata, handles)
% hObject    handle to a16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a16 as text
%        str2double(get(hObject,'String')) returns contents of a16 as a double


% --- Executes during object creation, after setting all properties.
function a16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a21_Callback(hObject, eventdata, handles)
% hObject    handle to a21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a21 as text
%        str2double(get(hObject,'String')) returns contents of a21 as a double


% --- Executes during object creation, after setting all properties.
function a21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a22_Callback(hObject, eventdata, handles)
% hObject    handle to a22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a22 as text
%        str2double(get(hObject,'String')) returns contents of a22 as a double


% --- Executes during object creation, after setting all properties.
function a22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a23_Callback(hObject, eventdata, handles)
% hObject    handle to a23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a23 as text
%        str2double(get(hObject,'String')) returns contents of a23 as a double


% --- Executes during object creation, after setting all properties.
function a23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a24_Callback(hObject, eventdata, handles)
% hObject    handle to a24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a24 as text
%        str2double(get(hObject,'String')) returns contents of a24 as a double


% --- Executes during object creation, after setting all properties.
function a24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a25_Callback(hObject, eventdata, handles)
% hObject    handle to a25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a25 as text
%        str2double(get(hObject,'String')) returns contents of a25 as a double


% --- Executes during object creation, after setting all properties.
function a25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a26_Callback(hObject, eventdata, handles)
% hObject    handle to a26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a26 as text
%        str2double(get(hObject,'String')) returns contents of a26 as a double


% --- Executes during object creation, after setting all properties.
function a26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a31_Callback(hObject, eventdata, handles)
% hObject    handle to a31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a31 as text
%        str2double(get(hObject,'String')) returns contents of a31 as a double


% --- Executes during object creation, after setting all properties.
function a31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a32_Callback(hObject, eventdata, handles)
% hObject    handle to a32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a32 as text
%        str2double(get(hObject,'String')) returns contents of a32 as a double


% --- Executes during object creation, after setting all properties.
function a32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a33_Callback(hObject, eventdata, handles)
% hObject    handle to a33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a33 as text
%        str2double(get(hObject,'String')) returns contents of a33 as a double


% --- Executes during object creation, after setting all properties.
function a33_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a34_Callback(hObject, eventdata, handles)
% hObject    handle to a34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a34 as text
%        str2double(get(hObject,'String')) returns contents of a34 as a double


% --- Executes during object creation, after setting all properties.
function a34_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a35_Callback(hObject, eventdata, handles)
% hObject    handle to a35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a35 as text
%        str2double(get(hObject,'String')) returns contents of a35 as a double


% --- Executes during object creation, after setting all properties.
function a35_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a36_Callback(hObject, eventdata, handles)
% hObject    handle to a36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a36 as text
%        str2double(get(hObject,'String')) returns contents of a36 as a double


% --- Executes during object creation, after setting all properties.
function a36_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function km_Callback(hObject, eventdata, handles)
% hObject    handle to km (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of km as text
%        str2double(get(hObject,'String')) returns contents of km as a double


% --- Executes during object creation, after setting all properties.
function km_CreateFcn(hObject, eventdata, handles)
% hObject    handle to km (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tm_Callback(hObject, eventdata, handles)
% hObject    handle to tm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tm as text
%        str2double(get(hObject,'String')) returns contents of tm as a double


% --- Executes during object creation, after setting all properties.
function tm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ztm_Callback(hObject, eventdata, handles)
% hObject    handle to ztm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ztm as text
%        str2double(get(hObject,'String')) returns contents of ztm as a double


% --- Executes during object creation, after setting all properties.
function ztm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ztm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function t1_Callback(hObject, eventdata, handles)
% hObject    handle to t1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t1 as text
%        str2double(get(hObject,'String')) returns contents of t1 as a double


% --- Executes during object creation, after setting all properties.
function t1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function w_fix_Callback(hObject, eventdata, handles)
% hObject    handle to w_fix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of w_fix as text
%        str2double(get(hObject,'String')) returns contents of w_fix as a double


% --- Executes during object creation, after setting all properties.
function w_fix_CreateFcn(hObject, eventdata, handles)
% hObject    handle to w_fix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b11_Callback(hObject, eventdata, handles)
% hObject    handle to b11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b11 as text
%        str2double(get(hObject,'String')) returns contents of b11 as a double


% --- Executes during object creation, after setting all properties.
function b11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b12_Callback(hObject, eventdata, handles)
% hObject    handle to b12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b12 as text
%        str2double(get(hObject,'String')) returns contents of b12 as a double


% --- Executes during object creation, after setting all properties.
function b12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b13_Callback(hObject, eventdata, handles)
% hObject    handle to b13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b13 as text
%        str2double(get(hObject,'String')) returns contents of b13 as a double


% --- Executes during object creation, after setting all properties.
function b13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b14_Callback(hObject, eventdata, handles)
% hObject    handle to b14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b14 as text
%        str2double(get(hObject,'String')) returns contents of b14 as a double


% --- Executes during object creation, after setting all properties.
function b14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b15_Callback(hObject, eventdata, handles)
% hObject    handle to b15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b15 as text
%        str2double(get(hObject,'String')) returns contents of b15 as a double


% --- Executes during object creation, after setting all properties.
function b15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b16_Callback(hObject, eventdata, handles)
% hObject    handle to b16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b16 as text
%        str2double(get(hObject,'String')) returns contents of b16 as a double


% --- Executes during object creation, after setting all properties.
function b16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b21_Callback(hObject, eventdata, handles)
% hObject    handle to b21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b21 as text
%        str2double(get(hObject,'String')) returns contents of b21 as a double


% --- Executes during object creation, after setting all properties.
function b21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b22_Callback(hObject, eventdata, handles)
% hObject    handle to b22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b22 as text
%        str2double(get(hObject,'String')) returns contents of b22 as a double


% --- Executes during object creation, after setting all properties.
function b22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b23_Callback(hObject, eventdata, handles)
% hObject    handle to b23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b23 as text
%        str2double(get(hObject,'String')) returns contents of b23 as a double


% --- Executes during object creation, after setting all properties.
function b23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b24_Callback(hObject, eventdata, handles)
% hObject    handle to b24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b24 as text
%        str2double(get(hObject,'String')) returns contents of b24 as a double


% --- Executes during object creation, after setting all properties.
function b24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b25_Callback(hObject, eventdata, handles)
% hObject    handle to b25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b25 as text
%        str2double(get(hObject,'String')) returns contents of b25 as a double


% --- Executes during object creation, after setting all properties.
function b25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b26_Callback(hObject, eventdata, handles)
% hObject    handle to b26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b26 as text
%        str2double(get(hObject,'String')) returns contents of b26 as a double


% --- Executes during object creation, after setting all properties.
function b26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b31_Callback(hObject, eventdata, handles)
% hObject    handle to b31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b31 as text
%        str2double(get(hObject,'String')) returns contents of b31 as a double


% --- Executes during object creation, after setting all properties.
function b31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b32_Callback(hObject, eventdata, handles)
% hObject    handle to b32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b32 as text
%        str2double(get(hObject,'String')) returns contents of b32 as a double


% --- Executes during object creation, after setting all properties.
function b32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b33_Callback(hObject, eventdata, handles)
% hObject    handle to b33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b33 as text
%        str2double(get(hObject,'String')) returns contents of b33 as a double


% --- Executes during object creation, after setting all properties.
function b33_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b34_Callback(hObject, eventdata, handles)
% hObject    handle to b34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b34 as text
%        str2double(get(hObject,'String')) returns contents of b34 as a double


% --- Executes during object creation, after setting all properties.
function b34_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b35_Callback(hObject, eventdata, handles)
% hObject    handle to b35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b35 as text
%        str2double(get(hObject,'String')) returns contents of b35 as a double


% --- Executes during object creation, after setting all properties.
function b35_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b36_Callback(hObject, eventdata, handles)
% hObject    handle to b36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b36 as text
%        str2double(get(hObject,'String')) returns contents of b36 as a double


% --- Executes during object creation, after setting all properties.
function b36_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function km_h_Callback(hObject, eventdata, handles)
% hObject    handle to km_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of km_h as text
%        str2double(get(hObject,'String')) returns contents of km_h as a double


% --- Executes during object creation, after setting all properties.
function km_h_CreateFcn(hObject, eventdata, handles)
% hObject    handle to km_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tm_h_Callback(hObject, eventdata, handles)
% hObject    handle to tm_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tm_h as text
%        str2double(get(hObject,'String')) returns contents of tm_h as a double


% --- Executes during object creation, after setting all properties.
function tm_h_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tm_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ztm_h_Callback(hObject, eventdata, handles)
% hObject    handle to ztm_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ztm_h as text
%        str2double(get(hObject,'String')) returns contents of ztm_h as a double


% --- Executes during object creation, after setting all properties.
function ztm_h_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ztm_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function t1_h_Callback(hObject, eventdata, handles)
% hObject    handle to t1_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t1_h as text
%        str2double(get(hObject,'String')) returns contents of t1_h as a double


% --- Executes during object creation, after setting all properties.
function t1_h_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t1_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b17_Callback(hObject, eventdata, handles)
% hObject    handle to b17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b17 as text
%        str2double(get(hObject,'String')) returns contents of b17 as a double


% --- Executes during object creation, after setting all properties.
function b17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b27_Callback(hObject, eventdata, handles)
% hObject    handle to b27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b27 as text
%        str2double(get(hObject,'String')) returns contents of b27 as a double


% --- Executes during object creation, after setting all properties.
function b27_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b37_Callback(hObject, eventdata, handles)
% hObject    handle to b37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b37 as text
%        str2double(get(hObject,'String')) returns contents of b37 as a double


% --- Executes during object creation, after setting all properties.
function b37_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b18_Callback(hObject, eventdata, handles)
% hObject    handle to b18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b18 as text
%        str2double(get(hObject,'String')) returns contents of b18 as a double


% --- Executes during object creation, after setting all properties.
function b18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b28_Callback(hObject, eventdata, handles)
% hObject    handle to b28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b28 as text
%        str2double(get(hObject,'String')) returns contents of b28 as a double


% --- Executes during object creation, after setting all properties.
function b28_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b38_Callback(hObject, eventdata, handles)
% hObject    handle to b38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b38 as text
%        str2double(get(hObject,'String')) returns contents of b38 as a double


% --- Executes during object creation, after setting all properties.
function b38_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


