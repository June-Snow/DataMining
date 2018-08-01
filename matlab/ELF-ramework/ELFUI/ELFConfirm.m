function varargout = ELFConfirm(varargin)
% ELFCONFIRM MATLAB code for ELFConfirm.fig
%      ELFCONFIRM, by itself, creates a new ELFCONFIRM or raises the existing
%      singleton*.
%
%      H = ELFCONFIRM returns the handle to a new ELFCONFIRM or the handle to
%      the existing singleton*.
%
%      ELFCONFIRM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ELFCONFIRM.M with the given input arguments.
%
%      ELFCONFIRM('Property','Value',...) creates a new ELFCONFIRM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ELFConfirm_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ELFConfirm_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ELFConfirm

% Last Modified by GUIDE v2.5 08-Jun-2015 21:56:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ELFConfirm_OpeningFcn, ...
                   'gui_OutputFcn',  @ELFConfirm_OutputFcn, ...
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
global ELFConfirm_confirmIniInfo; % long name in case replicate.
global ELFConfirm_orignInfo;

% --- Executes just before ELFConfirm is made visible.
function ELFConfirm_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ELFConfirm (see VARARGIN)

% Choose default command line output for ELFConfirm
%%
global ELFConfirm_orignInfo;
global ELFConfirm_confirmIniInfo;
ELFConfirm_orignInfo = varargin{1};
ELFConfirm_confirmIniInfo =  ELFConfirm_orignInfo;
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ELFConfirm wait for user response (see UIRESUME)

fillInfo(ELFConfirm_confirmIniInfo, handles)

uiwait(gcf); 


function fillInfo(ELFConfirm_confirmIniInfo, handles)
% Data
%%
set(handles.edit_rawdatadir, 'string', ELFConfirm_confirmIniInfo.data.rawdatadir);
set(handles.edit_rawdataext, 'string', ELFConfirm_confirmIniInfo.data.rawdataext);
set(handles.edit_targetfolder, 'string', ELFConfirm_confirmIniInfo.data.targetfolder);

% Program
if ELFConfirm_confirmIniInfo.program.debug == 0 
    debug = 0;
else
    debug = 1;
end
set(handles.radiobutton_debug, 'value', debug);

% Train
set(handles.popupmenu_method, 'string', olStr2cell(ELFConfirm_confirmIniInfo.train.methodcandidate));
set(handles.edit_numepoch, 'string', ELFConfirm_confirmIniInfo.train.numepoch);
mc = olStr2cell(ELFConfirm_confirmIniInfo.data.modecandidate);
mod_ind = arrayfun(@(x) strcmp(x, ELFConfirm_confirmIniInfo.data.mode), mc);
set(handles.popupReadData, 'string', [mc{mod_ind}, mc(~mod_ind)]); 


% --- Outputs from this function are returned to the command line.
function varargout = ELFConfirm_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
%%
varargout{1} = handles.output;
global ELFConfirm_confirmIniInfo;
varargout{2} = ELFConfirm_confirmIniInfo;
close(gcf);


% --- Executes on button press in pushbutton_reset.
function pushbutton_reset_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ELFConfirm_orignInfo;
global ELFConfirm_confirmIniInfo;
ELFConfirm_confirmIniInfo =  ELFConfirm_orignInfo;
fillInfo(ELFConfirm_orignInfo, handles);


% --- Executes on button press in pushbutton_ok.
function pushbutton_ok_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%
uiresume(gcf);

% --- Executes on selection change in popupmenu_method.
function popupmenu_method_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_method
global ELFConfirm_confirmIniInfo;
contents = cellstr(get(hObject,'String'));
ELFConfirm_confirmIniInfo.train.method = contents{get(hObject,'Value')};



% --- Executes during object creation, after setting all properties.
function popupmenu_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
%%
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in popupReadData.
function popupReadData_Callback(hObject, eventdata, handles)
% hObject    handle to popupReadData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns popupReadData contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupReadData
global ELFConfirm_confirmIniInfo;
contents = cellstr(get(hObject,'String'));
ELFConfirm_confirmIniInfo.data.mode = contents{get(hObject,'Value')};


% --- Executes during object creation, after setting all properties.
function popupReadData_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupReadData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton_debug.
function radiobutton_debug_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_debug (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_debug
%%
global ELFConfirm_confirmIniInfo;
ELFConfirm_confirmIniInfo.program.debug = get(handles.radiobutton_debug,'Value');


function edit_rawdatadir_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rawdatadir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rawdatadir as text
%        str2double(get(hObject,'String')) returns contents of edit_rawdatadir as a double
%%
global ELFConfirm_confirmIniInfo;
ELFConfirm_confirmIniInfo.data.rawdatadir = get(handles.edit_rawdatadir,'String');


% --- Executes during object creation, after setting all properties.
function edit_rawdatadir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rawdatadir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
%%
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_rawdataext_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rawdataext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rawdataext as text
%        str2double(get(hObject,'String')) returns contents of edit_rawdataext as a double
%%
global ELFConfirm_confirmIniInfo;
ELFConfirm_confirmIniInfo.data.rawdataext = get(handles.edit_rawdataext, 'String');

% --- Executes during object creation, after setting all properties.
function edit_rawdataext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rawdataext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
%%
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_tempdir_Callback(hObject, eventdata, handles)
% hObject    handle to edit_tempdir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_tempdir as text
%        str2double(get(hObject,'String')) returns contents of edit_tempdir as a double
%%
global ELFConfirm_confirmIniInfo;
ELFConfirm_confirmIniInfo.data.tempdir = get(handles.edit_tempdir, 'String');


% --- Executes during object creation, after setting all properties.
function edit_tempdir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_tempdir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
%%
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_targetfolder_Callback(hObject, eventdata, handles)
% hObject    handle to edit_targetfolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_targetfolder as text
%        str2double(get(hObject,'String')) returns contents of edit_targetfolder as a double
%%
global ELFConfirm_confirmIniInfo;
ELFConfirm_confirmIniInfo.data.targetfolder = get(handles.edit_targetfolder, 'String');


% --- Executes during object creation, after setting all properties.
function edit_targetfolder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_targetfolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
%%
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor')) 
    set(hObject,'BackgroundColor','white');
end



function edit_numepoch_Callback(hObject, eventdata, handles)
% hObject    handle to edit_numepoch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_numepoch as text
%        str2double(get(hObject,'String')) returns contents of edit_numepoch as a double
%%
global ELFConfirm_confirmIniInfo;
ELFConfirm_confirmIniInfo.train.numepoch= get(handles.edit_numepoch, 'String');


% --- Executes during object creation, after setting all properties.
function edit_numepoch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_numepoch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
%%
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_note_Callback(hObject, eventdata, handles)
% hObject    handle to edit_note (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_note as text
%        str2double(get(hObject,'String')) returns contents of edit_note as a double
global ELFConfirm_confirmIniInfo;
ELFConfirm_confirmIniInfo.program.note = get(handles.edit_numepoch, 'String');


% --- Executes during object creation, after setting all properties.
function edit_note_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_note (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_expdir_Callback(hObject, eventdata, handles)
% hObject    handle to edit_expdir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_expdir as text
%        str2double(get(hObject,'String')) returns contents of edit_expdir as a double
global ELFConfirm_confirmIniInfo;
ELFConfirm_confirmIniInfo.program.expdir= get(handles.edit_expdir, 'String');


% --- Executes during object creation, after setting all properties.
function edit_expdir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_expdir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

