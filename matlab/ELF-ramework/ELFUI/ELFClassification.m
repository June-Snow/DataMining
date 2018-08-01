function varargout = ELFClassification(varargin)
%% ELFCLASSIFICATION MATLAB code for ELFClassification.fig
%      ELFCLASSIFICATION, by itself, creates a new ELFCLASSIFICATION or raises the existing
%      singleton*.
%
%      H = ELFCLASSIFICATION returns the handle to a new ELFCLASSIFICATION or the handle to
%      the existing singleton*.
%
%      ELFCLASSIFICATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ELFCLASSIFICATION.M with the given input arguments.
%
%      ELFCLASSIFICATION('Property','Value',...) creates a new ELFCLASSIFICATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ELFClassification_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ELFClassification_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ELFClassification

% Last Modified by GUIDE v2.5 03-Nov-2016 18:01:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ELFClassification_OpeningFcn, ...
                   'gui_OutputFcn',  @ELFClassification_OutputFcn, ...
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
% Declare global variables
global color1; % TO DELETE
global color2; % TO DELETE
global rawImdb; % TO DELETE
global iniInfo; % TO DELETE
global nowSelected;
global DEBUG;
global configPath;
global trainType;

% --- Executes just before ELFClassification is made visible.
function ELFClassification_OpeningFcn(hObject, eventdata, handles, varargin)
%% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ELFClassification (see VARARGIN)

% Choose default command line output for ELFClassification
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ELFClassification wait for user response (see UIRESUME)
% uiwait(handles.figure1);
set(handles.axeShowData,'visible','off')
set(handles.processBar,'visible','off')
global color1
global color2
color1 = [0.3569,0.502,0.6588];
color2 = [0.55,0.66,0.77];


% --- Outputs from this function are returned to the command line.
function varargout = ELFClassification_OutputFcn(hObject, eventdata, handles) 
%%
varargout{1} = handles.output;


% --- Executes on selection change in dataList.
function dataList_Callback(hObject, eventdata, handles)
%%
str=get(hObject,'string');
value=get(hObject,'value');


% --- Executes during object creation, after setting all properties.
function dataList_CreateFcn(hObject, eventdata, handles)
%%
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
str = 'name|sex|yearold|ID|company';
strcell = {'one', 'two'};
set(handles.dataList,'String',str);
set(handles.dataList,'String', strcell);


% --- Executes on button press in loadConfig.
function loadConfig_Callback(hObject, eventdata, handles)
%% 数据初始化
global rawImdb;
global iniInfo;
global configPath;
global trainType;
mode  = 'train';
[name, path, filterindex] = uigetfile('*.ini');

num1 = get(handles.togglebutton1, 'value');
num2 = get(handles.togglebutton2, 'value');
num3 = get(handles.togglebutton3, 'value');

if num1 == 1, trainType = 1;end
if num2 == 1, trainType = 2;end
if num3 == 1, trainType = 3;end

if name~=0
    configPath = fullfile(path, name); 
    oriIniStruct = olIni2struct(configPath);
    
    [confirmFigure, iniStruct] = ELFConfirm(oriIniStruct);
    waitfor(confirmFigure);
    if iDetectConfigChange(oriIniStruct, iniStruct)
        olStruct2ini(configPath, iniStruct)
    end
    
    iniInfo = iIni2info(iniStruct);
    iInitialize(iniInfo); 
    rawImdb = ELFMakeData(iniInfo, trainType);
    [colName, tableData] = iUiDataInfo(rawImdb.rawDataDir, rawImdb.relPath);
    set(handles.dataTable, 'ColumnName', colName, 'data', tableData);
    set(handles.LogOutput, 'String', configPath);    
end


% --- Executes on button press in run.
function run_Callback(hObject, eventdata, handles)
%% Train Button
global rawImdb;
global iniInfo;
global DEBUG;
global configPath;
global trainType;

mode = 'train';
if isempty(iniInfo)
    msgbox('Load config file first.');
    return ;
end
if length(iniInfo.targetfolder) < 2 && trainType == 1
    msgbox('At least two classes is needed for train');
    return ;
end
iniInfo = validateConfig(configPath, iniInfo);
% hmonitor = ELFMonitor();
% SHandle.monitorwdw = hmonitor;
SHandle.entrywdw = handles;

dim = iQueryFeatDim(iniInfo.train.method); 

if dim == 1
    featnames = iExtract1DFeature();
end

if dim == 2
    featnames = iExtract2DFeature(trainType);
end

[selFeatFig, featName]= iSelectFeature(featnames);
waitfor(selFeatFig);

DEBUG = iniInfo.program.debug;
ELFPipeLineTrain(rawImdb, featName, iniInfo, dim, mode, trainType);


% --- Executes on button press in predict.
function predict_Callback(hObject, eventdata, handles)
%% Predict Button
global configPath;
global rawImdb;
global iniInfo;
global DEBUG;
global trainType;

[name, path, filterindex] = uigetfile('*.mat', 'Load a model');
modelPath = fullfile(path, name);
model = load(modelPath);
type = 'test';
if name == 0
    msgbox('Load a model first.');
    return ;
end

iniInfo = validateConfig(configPath, iniInfo);
DEBUG = iniInfo.program.debug;
ELFPipeLinePredict(rawImdb, iniInfo, model,type,  trainType);


function iniInfo = validateConfig(configPath, iniInfoOld)
%%
STAYSAME = 0;
iniInfoNew = iLoadIniInfo(configPath);
ret = iDetectConfigChange(iniInfoNew, iniInfoOld);
iShowDiff(iniInfoNew, iniInfoOld);
if ret == STAYSAME
    iniInfo = iniInfoOld;  
else% detect change in config
    userResponse = ELFConfirmConfig('Title','Confirm Config');
    switch userResponse
        case {'No'}
            iniInfo = iniInfoOld;
        case 'Yes'
            iniInfo = iniInfoNew;          
    end
end


% --- Executes when selected cell(s) is changed in dataTable.
function dataTable_CellSelectionCallback(hObject, eventdata, handles)
%%
global nowSelected;

data = get(handles.dataTable, 'Data');
selInd = eventdata.Indices;
if isempty(selInd)
    return
end
nowSelected = selInd(1);
dataPath = data{selInd(1), 2};
[name, path, ext] = fileparts(dataPath);
ext = olStdExt(ext);
img = olReadDataToImg(dataPath);
axes(handles.axeShowData);
imshow(img);
title(gca, dataPath,'Interpreter','none');
iCustomWaitbar(handles.processBar, 100, 500, 100);
 

% --- Executes when entered data in editable cell(s) in dataTable.
function dataTable_CellEditCallback(hObject, eventdata, handles)
%% hObject    handle to dataTable (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
p = imread('peppers.png');
figure(203);imshow(p);


% --------------------------------------------------------------------
function dataTable_ButtonDownFcn(hObject, eventdata, handles)
%% hObject    handle to dataTable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global nowSelected;
data = get(handles.dataTable, 'Data');
if isempty(nowSelected)
    return
end

dataPath = data{nowSelected, 2};
ext = olGetExtension(dataPath);

% rip leading . from ext
if ~isempty(findstr(ext,'.'))
    ext = strtok(ext,'.');
end

if olIsVideoFile(ext)
    implay(dataPath, 5);
end

if olIsImageFile(ext)
    imshow(dataPath);
end


function panelShowtab_ButtonDownFcn(hObject, eventdata, handles)
choice1(handles)

function txtShowData_ButtonDownFcn(hObject, eventdata, handles)
choice1(handles)

function panelStattab_ButtonDownFcn(hObject, eventdata, handles)
choice2(handles)

function txtShowStat_ButtonDownFcn(hObject, eventdata, handles)
choice2(handles)


function choice1(handles)
%%
global color1
global color2

set(handles.panelShowtab,'BackgroundColor',color1);
set(handles.panelShowtab,'BorderType','line');

set(handles.panelStattab,'BackgroundColor',color2);
set(handles.panelStattab,'BorderType','none');

set(handles.txtShowData,'BackgroundColor',color1);
set(handles.txtShowStat,'BackgroundColor',color2);

set(handles.panelShowData,'Visible','on');
set(handles.panelShowtabShadow,'Visible','on');
set(handles.statistics,'Visible','off');
set(handles.panelStattabShadow,'Visible','off');

function choice2(handles)
%%
global color1
global color2
set(handles.panelStattab,'BackgroundColor',color1);
set(handles.panelStattab,'BorderType','line');

set(handles.panelShowtab,'BackgroundColor',color2);
set(handles.panelShowtab,'BorderType','none');

set(handles.txtShowStat,'BackgroundColor',color1);
set(handles.txtShowData,'BackgroundColor',color2);

set(handles.panelShowData,'Visible','off');
set(handles.panelShowtabShadow,'Visible','off');
set(handles.statistics,'Visible','on');
set(handles.panelStattabShadow,'Visible','on');


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.togglebutton1, 'value', 1);
set(handles.togglebutton2, 'value', 0);
set(handles.togglebutton3, 'value', 0);
set(handles.run, 'Visible', 'on');
% Hint: get(hObject,'Value') returns toggle state of togglebutton1


% --- Executes on button press in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.togglebutton1, 'value', 0);
set(handles.togglebutton2, 'value', 1);
set(handles.togglebutton3, 'value', 0);
set(handles.run, 'Visible', 'on');

% Hint: get(hObject,'Value') returns toggle state of togglebutton2


% --- Executes on button press in togglebutton3.
function togglebutton3_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.togglebutton1, 'value', 0);
set(handles.togglebutton2, 'value', 0);
set(handles.togglebutton3, 'value', 1);
set(handles.run, 'Visible', 'off');
% Hint: get(hObject,'Value') returns toggle state of togglebutton3


