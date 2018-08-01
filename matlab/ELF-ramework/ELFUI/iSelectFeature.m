function varargout = iSelectFeature(varargin)
% ISELECTFEATURE MATLAB code for iSelectFeature.fig
%      ISELECTFEATURE, by itself, creates a new ISELECTFEATURE or raises the existing
%      singleton*.
%
%      H = ISELECTFEATURE returns the handle to a new ISELECTFEATURE or the handle to
%      the existing singleton*.
%
%      ISELECTFEATURE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ISELECTFEATURE.M with the given input arguments.
%
%      ISELECTFEATURE('Property','Value',...) creates a new ISELECTFEATURE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before iSelectFeature_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to iSelectFeature_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help iSelectFeature

% Last Modified by GUIDE v2.5 05-Jun-2015 16:31:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @iSelectFeature_OpeningFcn, ...
                   'gui_OutputFcn',  @iSelectFeature_OutputFcn, ...
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
global feature;


% --- Executes just before iSelectFeature is made visible.
function iSelectFeature_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to iSelectFeature (see VARARGIN)

% Choose default command line output for iSelectFeature
handles.output = hObject;
global feature;
feature = varargin{1};
% Update handles structure
guidata(hObject, handles);
initialize_gui(hObject, handles, false);

% UIWAIT makes iSelectFeature wait for user response (see UIRESUME)
% uiwait(handles.figure1);
uiwait(handles.figure1);

function initialize_gui(fig_handle, handles, isreset)
% If the metricdata field is present and the reset flag is false, it means
% we are we are just re-initializing a GUI by calling it from the cmd line
% while it is up. So, bail out as we dont want to reset the data.
%if ~isreset
 %   return;
%end
global feature;
global iExit;

iExit = 0;

handles.output = handles;
handles.HasBeenSelectedL1 = 0;
handles.HasBeenSelectedL2 = 0;

VarNames = feature;
%VarNames = evalin ('caller', 'feature');
%Drop the outcome name

set(handles.choosefeature_listbox1, 'String', VarNames);

%Inizialize variable contain a cell array of the categorical variables
handles.CatVarSelectedStr={};
guidata(fig_handle, handles)
set(handles.selectedfeature_listbox, 'String', handles.CatVarSelectedStr);

% Update handles structure
guidata(handles.figure1, handles);


% --- Outputs from this function are returned to the command line.
function varargout = iSelectFeature_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
varargout{2} = handles.CatVarSelectedStr;
close(gcf);

% --- Executes on selection change in choosefeature_listbox1.
function choosefeature_listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to choosefeature_listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns choosefeature_listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from choosefeature_listbox1
index_selected = get(hObject,'Value');

%Return a list of variable in string cell array string
list = get(hObject,'String');

%Almost a variable has been selected
handles.HasBeenSelectedL1=1;

%Return a cell array of variable selected
item_selected = list{index_selected};
%Gui data
handles.VarSelectedStr = list{index_selected};

%assignin('base', 'selected', index_selected);
%assignin('base', 'VarSelectedStr', item_selected);

guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function choosefeature_listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to choosefeature_listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in addFeature.
function addFeature_Callback(hObject, eventdata, handles)
% hObject    handle to addFeature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CatSelected;

if handles.HasBeenSelectedL1 == 1
    
    %Aggiungere al cell array
    %Find the string with that name if present in CatVarNames
    %If it isn't an empty matrix add the string
    if isempty(find (strcmp(handles.CatVarSelectedStr, handles.VarSelectedStr))) 
        yposition = length(handles.CatVarSelectedStr)+1;
        handles.CatVarSelectedStr (yposition,1) = cellstr(handles.VarSelectedStr);
    end

    set(handles.selectedfeature_listbox, 'String', handles.CatVarSelectedStr, 'Value', 1);
    %Pass the list at the program

    CatSelected = handles.CatVarSelectedStr;

else
    warndlg('Select a Variable on the left first!', 'Tree Classificatory Algorithm')
end

guidata(hObject, handles);


% --- Executes on button press in removeFeature.
function removeFeature_Callback(hObject, eventdata, handles)
% hObject    handle to removeFeature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CatSelected;

if handles.HasBeenSelectedL2 == 1
    index_selected = get(handles.selectedfeature_listbox, 'Value');

    %Return a list of variable in string cell array string
    list = get(handles.selectedfeature_listbox, 'String');

    %Return a cell array of variable selected
    item_selected = list{index_selected};

    %Delete this variable from the list.
    position = find(strcmp(handles.CatVarSelectedStr, item_selected));
    handles.CatVarSelectedStr (position) = [];
    %CatVarSelectedStr have the list of the variables.
    set(handles.selectedfeature_listbox, 'String', handles.CatVarSelectedStr, 'Value', 1);
    guidata(hObject, handles);
    %Pass the list at the program
    CatSelected = handles.CatVarSelectedStr;
    %assignin('caller', 'CatSelected', handles.CatVarSelectedStr);
else
    warndlg('Select a Variable on the right first!', 'Tree Classificatory Algorithm')
end
guidata(hObject, handles);


% --- Executes on selection change in selectedfeature_listbox.
function selectedfeature_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to selectedfeature_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns selectedfeature_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from selectedfeature_listbox
handles.HasBeenSelectedL2=1;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function selectedfeature_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selectedfeature_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in continue_algo_btn.
function continue_algo_btn_Callback(hObject, eventdata, handles)
% hObject    handle to continue_algo_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume(gcf);


% --- Executes on button press in SelectAllBtn.
function SelectAllBtn_Callback(hObject, eventdata, handles)
% hObject    handle to SelectAllBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Return a list of variable in string cell array string

list = get(handles.choosefeature_listbox1,'String');
%Return a cell array of variable selected
handles.CatVarSelectedStr  = list;
%CatVarSelectedStr have the list of the variables.
set(handles.selectedfeature_listbox, 'String', list, 'Value', 1);
guidata(hObject, handles);
%Pass the list at the program
CatSelected = handles.CatVarSelectedStr;
