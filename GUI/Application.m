function varargout = Application(varargin)
% Application MATLAB code for Application.fig
%      Application, by itself, creates a new Application or raises the existing
%      singleton*.
%
%      H = Application returns the handle to a new Application or the handle to
%      the existing singleton*.
%
%      Application('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Application.M with the given input arguments.
%
%      Application('Property','Value',...) creates a new Application or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Application_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Application_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Application

% Last Modified by GUIDE v2.5 14-Jan-2017 02:08:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Application_OpeningFcn, ...
                   'gui_OutputFcn',  @Application_OutputFcn, ...
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


% --- Executes just before Application is made visible.
function Application_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Application (see VARARGIN)

% Choose default command line output for Application
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Application wait for user response (see UIRESUME)
% uiwait(handles.figure1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize variables and GUI items 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global myImage;
global SF;
global C_ref;
myImage = [];
SF = 0.0705;
C_ref = [208,148,87;152,131,113;194,124,94];
set(handles.cent1,'String','0');
set(handles.cent2,'String','0');
set(handles.cent5,'String','0');
set(handles.cent10,'String','0');
set(handles.cent20,'String','0');
set(handles.cent50,'String','0');
set(handles.euro1,'String','0');
set(handles.euro2,'String','0');
set(handles.totalValue,'String','0');
set(handles.axes1,'YTick',[]);
set(handles.axes1,'XTick',[]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Outputs from this function are returned to the command line.
function varargout = Application_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in loadImageButton.
function loadImageButton_Callback(~, ~, handles)
% hObject    handle to loadImageButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load image after clicking button 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[FileName,PathName] = uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
          '*.*','All Files' },'Select image files only!');
global myImage;
myImage = imread(fullfile(PathName,FileName));
axes(handles.axes1);
imshow(myImage);

set(handles.cent1,'String','0');
set(handles.cent2,'String','0');
set(handles.cent5,'String','0');
set(handles.cent10,'String','0');
set(handles.cent20,'String','0');
set(handles.cent50,'String','0');
set(handles.euro1,'String','0');
set(handles.euro2,'String','0');
set(handles.totalValue,'String','0');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in calculateButton.
function calculateButton_Callback(~, ~, handles)
% hObject    handle to calculateButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do processing calculation in loaded image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global myImage;
global SF;
global C_ref;
if(~isempty(myImage))
    % Preprocessing and Segmentation
    img = preprocessing(myImage);
    mask = segmentation_3(img);
    % Recognition
    [value_total, centroids, values] = recognition_2(mask, img, SF, C_ref);
    axes(handles.axes1);
    imshow(myImage);
    hold on;
    for i = 1:size(values,1)
        text(centroids(i,1),centroids(i,2),num2str(values(i)),'Color','red','FontSize',14, 'FontWeight', 'bold', 'HorizontalAlignment', 'center')
    end
    hold off;
    
    count = 0;
    for i = 1:size(values,1)
        if values(i) == 0.01
            count = count + 1;
        end
    end
    set(handles.cent1,'String',num2str(count));
    count = 0;
    for i = 1:size(values,1)
        if values(i) == 0.02
            count = count + 1;
        end
    end
    set(handles.cent2,'String',num2str(count));
    count = 0;
    for i = 1:size(values,1)
        if values(i) == 0.05
            count = count + 1;
        end
    end
    set(handles.cent5,'String',num2str(count));
    count = 0;
    for i = 1:size(values,1)
        if values(i) == 0.10
            count = count + 1;
        end
    end
    set(handles.cent10,'String',num2str(count));
    count = 0;
    for i = 1:size(values,1)
        if values(i) == 0.20
            count = count + 1;
        end
    end
    set(handles.cent20,'String',num2str(count));
    count = 0;
    for i = 1:size(values,1)
        if values(i) == 0.50
            count = count + 1;
        end
    end
    set(handles.cent50,'String',num2str(count));
    count = 0;
    for i = 1:size(values,1)
        if values(i) == 1.00
            count = count + 1;
        end
    end
    set(handles.euro1,'String',num2str(count));
    count = 0;
    for i = 1:size(values,1)
        if values(i) == 2.00
            count = count + 1;
        end
    end
    set(handles.euro2,'String',num2str(count));
    set(handles.totalValue,'String',num2str(value_total));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in calibrateButton.
function calibrateButton_Callback(~, ~, ~)
% hObject    handle to calibrateButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Calibrate;
% --- Executes on button press in exitButton.

function exitButton_Callback(~, ~, ~)
% hObject    handle to exitButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;
