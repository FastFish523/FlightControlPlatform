function varargout = Control_main(varargin)
%CONTROL_MAIN M-file for Control_main.fig
%      CONTROL_MAIN, by itself, creates a new CONTROL_MAIN or raises the existing
%      singleton*.
%
%      H = CONTROL_MAIN returns the handle to a new CONTROL_MAIN or the handle to
%      the existing singleton*.
%
%      CONTROL_MAIN('Property','Value',...) creates a new CONTROL_MAIN using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to Control_main_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      CONTROL_MAIN('CALLBACK') and CONTROL_MAIN('CALLBACK',hObject,...) call the
%      local function named CALLBACK in CONTROL_MAIN.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Control_main

% Last Modified by GUIDE v2.5 11-Jan-2016 08:03:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Control_main_OpeningFcn, ...
                   'gui_OutputFcn',  @Control_main_OutputFcn, ...
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


% --- Executes just before Control_main is made visible.
function Control_main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for Control_main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Control_main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Control_main_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_air_para.
function pushbutton_air_para_Callback(hObject, eventdata, handles)
Control_qidong;
% hObject    handle to pushbutton_air_para (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_air_analyse.
function pushbutton_air_analyse_Callback(hObject, eventdata, handles)
air_analyse;
% hObject    handle to pushbutton_air_analyse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_dandao_sim.
function pushbutton_dandao_sim_Callback(hObject, eventdata, handles)
sim_3dof;
% hObject    handle to pushbutton_dandao_sim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_zikong_design.
function pushbutton_zikong_design_Callback(hObject, eventdata, handles)
zikong_design;
% hObject    handle to pushbutton_zikong_design (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_zikong_sim.
function pushbutton_zikong_sim_Callback(hObject, eventdata, handles)
! .\vc6sim\vc6sim\vc6sim.dsw
% hObject    handle to pushbutton_zikong_sim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in zikong_gunzhuan.
function zikong_gunzhuan_Callback(hObject, eventdata, handles)
gz_design
% hObject    handle to zikong_gunzhuan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pianhang_zikong.
function pianhang_zikong_Callback(hObject, eventdata, handles)
ph_design;
% hObject    handle to pianhang_zikong (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
zikong_cu_design;
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
gz_cu_design;
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
ph_cu_design;
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_plot.
function pushbutton_plot_Callback(hObject, eventdata, handles)
trajnew;
Control_main;
% hObject    handle to pushbutton_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


