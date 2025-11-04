function varargout = Control_pingtai(varargin)
% CONTROL_PINGTAI M-file for Control_pingtai.fig
%      CONTROL_PINGTAI, by itself, creates a new CONTROL_PINGTAI or raises the existing
%      singleton*.
%
%      H = CONTROL_PINGTAI returns the handle to a new CONTROL_PINGTAI or the handle to
%      the existing singleton*.
%
%      CONTROL_PINGTAI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONTROL_PINGTAI.M with the given input arguments.
%
%      CONTROL_PINGTAI('Property','Value',...) creates a new CONTROL_PINGTAI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Control_pingtai_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Control_pingtai_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Control_pingtai

% Last Modified by GUIDE v2.5 26-Oct-2015 10:38:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Control_pingtai_OpeningFcn, ...
                   'gui_OutputFcn',  @Control_pingtai_OutputFcn, ...
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


% --- Executes just before Control_pingtai is made visible.
function Control_pingtai_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Control_pingtai (see VARARGIN)

% Choose default command line output for Control_pingtai
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Control_pingtai wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Control_pingtai_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_login.
function pushbutton_login_Callback(hObject, eventdata, handles)
pin=get(handles.edit_PIN,'string');
num=max(size(pin));
if num==0
set(handles.text_pin_err,'string',' ‰»Î¥ÌŒÛpin');
else
if pin=='123'
Control_main;
close('Control_pingtai')
else
set(handles.text_pin_err,'string',' ‰»Î¥ÌŒÛpin');
end
end
% hObject    handle to pushbutton_login (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit_PIN_Callback(hObject, eventdata, handles)

% hObject    handle to edit_PIN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_PIN as text
%        str2double(get(hObject,'String')) returns contents of edit_PIN as a double


% --- Executes during object creation, after setting all properties.
function edit_PIN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_PIN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


