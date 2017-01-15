function varargout = Calibrate(varargin)
% CALIBRATION MATLAB code for Calibration.fig
%      CALIBRATION, by itself, creates a new CALIBRATION or raises the existing
%      singleton*.
%
%      H = CALIBRATION returns the handle to a new CALIBRATION or the handle to
%      the existing singleton*.
%
%      CALIBRATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CALIBRATION.M with the given input arguments.
%
%      CALIBRATION('Property','Value',...) creates a new CALIBRATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Calibrate_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Calibrate_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Calibration

% Last Modified by GUIDE v2.5 14-Jan-2017 06:29:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Calibrate_OpeningFcn, ...
                   'gui_OutputFcn',  @Calibrate_OutputFcn, ...
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


% --- Executes just before Calibration is made visible.
function Calibrate_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Calibration (see VARARGIN)

% Choose default command line output for Calibration
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Calibration wait for user response (see UIRESUME)
% uiwait(handles.figure1);
set(handles.GR,'String','208');
set(handles.GG,'String','148');
set(handles.GB,'String','87');
set(handles.SR,'String','152');
set(handles.SG,'String','131');
set(handles.SB,'String','113');
set(handles.CR,'String','194');
set(handles.CG,'String','124');
set(handles.CB,'String','94');
set(handles.SF,'String','0.0705');

% --- Outputs from this function are returned to the command line.
function varargout = Calibrate_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in OK.
function OK_Callback(~, ~, handles)
% hObject    handle to OK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SF;
global C_ref;
SF = str2double(get(handles.SF,'String'));
C_ref = [str2double(get(handles.GR,'String')),str2double(get(handles.GG,'String')),str2double(get(handles.GB,'String'));
    str2double(get(handles.SR,'String')),str2double(get(handles.SG,'String')),str2double(get(handles.SB,'String'));
    str2double(get(handles.CR,'String')),str2double(get(handles.CG,'String')),str2double(get(handles.CB,'String'))];
close;

% --- Executes on button press in Cancel.
function Cancel_Callback(~, ~, ~)
% hObject    handle to Cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;
