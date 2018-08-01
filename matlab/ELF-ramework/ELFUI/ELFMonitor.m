function varargout = ELFMonitor(varargin)
% MONITOR MATLAB code for monitor.fig
%      MONITOR, by itself, creates a new MONITOR or raises the existing
%      singleton*.
%
%      H = MONITOR returns the handle to a new MONITOR or the handle to
%      the existing singleton*.
%
%      MONITOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MONITOR.M with the given input arguments.
%
%      MONITOR('Property','Value',...) creates a new MONITOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before monitor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to monitor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help monitor

% Last Modified by GUIDE v2.5 26-Mar-2015 21:43:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @monitor_OpeningFcn, ...
                   'gui_OutputFcn',  @monitor_OutputFcn, ...
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


% --- Executes just before monitor is made visible.
function monitor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to monitor (see VARARGIN)

% Choose default command line output for monitor
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes monitor wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = monitor_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
% varargout{1} = handles.output;
varargout{1} = handles;
