function varargout = Choose_zhidao(varargin)
% CHOOSE_ZHIDAO M-file for Choose_zhidao.fig
%      CHOOSE_ZHIDAO, by itself, creates a new CHOOSE_ZHIDAO or raises the existing
%      singleton*.
%
%      H = CHOOSE_ZHIDAO returns the handle to a new CHOOSE_ZHIDAO or the handle to
%      the existing singleton*.
%
%      CHOOSE_ZHIDAO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CHOOSE_ZHIDAO.M with the given input arguments.
%
%      CHOOSE_ZHIDAO('Property','Value',...) creates a new CHOOSE_ZHIDAO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Choose_zhidao_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Choose_zhidao_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Choose_zhidao

% Last Modified by GUIDE v2.5 30-Oct-2015 09:05:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Choose_zhidao_OpeningFcn, ...
                   'gui_OutputFcn',  @Choose_zhidao_OutputFcn, ...
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


% --- Executes just before Choose_zhidao is made visible.
function Choose_zhidao_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Choose_zhidao (see VARARGIN)

% Choose default command line output for Choose_zhidao
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Choose_zhidao wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Choose_zhidao_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbo_choose_zhidao.
function listbo_choose_zhidao_Callback(hObject, eventdata, handles)
% hObject    handle to listbo_choose_zhidao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbo_choose_zhidao contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbo_choose_zhidao


% --- Executes during object creation, after setting all properties.
function listbo_choose_zhidao_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbo_choose_zhidao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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


% --- Executes on selection change in popupmenu_choose_zhidao.
function popupmenu_choose_zhidao_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_choose_zhidao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu_choose_zhidao contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_choose_zhidao


% --- Executes during object creation, after setting all properties.
function popupmenu_choose_zhidao_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_choose_zhidao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu.
function popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu


% --- Executes during object creation, after setting all properties.
function popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_ok.
function pushbutton_ok_Callback(hObject, eventdata, handles)
flag=get(handles.popupmenu,'Value');
if flag==1%比例导引
    open('ratio.m');
end
if flag==2%落角约束比例导引
    open('ratio.m');
end
if flag==3%固定弹道倾角
    open('ratio.m');
end
assignin('base','zhidao_flag',flag);
close(Choose_zhidao)
% hObject    handle to pushbutton_ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


