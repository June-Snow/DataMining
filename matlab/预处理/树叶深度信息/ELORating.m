function varargout = ELORating(varargin)

% Edit the above text to modify the response to help ELORating

% Last Modified by GUIDE v2.5 19-Nov-2016 21:33:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ELORating_OpeningFcn, ...
                   'gui_OutputFcn',  @ELORating_OutputFcn, ...
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

global iniInfo;

end

% --- Executes just before ELORating is made visible.
function ELORating_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for ELORating
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ELORating wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = ELORating_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global iniInfo;

RA = iniInfo.strData(iniInfo.pos(1, 1));
RB = iniInfo.strData(iniInfo.pos(2, 1));
SA = 1;
SB = 0;
K = iniInfo.K;
[newRA, newRB] = ELORatingSystem(RA, RB, SA, SB, K);
iniInfo.strData(iniInfo.pos(1, 1)) = newRA;
iniInfo.strData(iniInfo.pos(2, 1)) = newRB;

[curPos, pos] = FindCompareNum();
iniInfo.pos = [curPos; pos];
path = strcat(iniInfo.path, cell2mat(iniInfo.strName(curPos)));
img = imread(path);
axes(handles.axes1);
imshow(img);
path = strcat(iniInfo.path, cell2mat(iniInfo.strName(pos)));
img = imread(path);
axes(handles.axes2);
imshow(img);

end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
global iniInfo;

RA = iniInfo.strData(iniInfo.pos(1, 1));
RB = iniInfo.strData(iniInfo.pos(2, 1));
SA = 0.5;
SB = 0.5;
K = iniInfo.K;
[newRA, newRB] = ELORatingSystem(RA, RB, SA, SB, K);
iniInfo.strData(iniInfo.pos(1, 1)) = newRA;
iniInfo.strData(iniInfo.pos(2, 1)) = newRB;

[curPos, pos] = FindCompareNum();
iniInfo.pos = [curPos; pos];
path = strcat(iniInfo.path, cell2mat(iniInfo.strName(curPos)));
img = imread(path);
axes(handles.axes1);
imshow(img);
path = strcat(iniInfo.path, cell2mat(iniInfo.strName(pos)));
img = imread(path);
axes(handles.axes2);
imshow(img);
end

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
global iniInfo;

RA = iniInfo.strData(iniInfo.pos(1, 1));
RB = iniInfo.strData(iniInfo.pos(2, 1));
SA = 0;
SB = 1;
K = iniInfo.K;
[newRA, newRB] = ELORatingSystem(RA, RB, SA, SB, K);
iniInfo.strData(iniInfo.pos(1, 1)) = newRA;
iniInfo.strData(iniInfo.pos(2, 1)) = newRB;

[curPos, pos] = FindCompareNum();
iniInfo.pos = [curPos; pos];
path = strcat(iniInfo.path, cell2mat(iniInfo.strName(curPos)));
img = imread(path);
axes(handles.axes1);
imshow(img);
path = strcat(iniInfo.path, cell2mat(iniInfo.strName(pos)));
img = imread(path);
axes(handles.axes2);
imshow(img);

end

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
global iniInfo;

[~, path, ~] = uigetfile('*.jpg');
%% ��ʼ������
flag = 0;
for i = 20 : -1 : 1
    excelPath = strcat(path, '�ڵ�����', num2str(i), '.xls');
    if exist(excelPath, 'file')
        [strData, strName] = xlsread(excelPath);
        flag = 1;
        break;
    end
end

if flag == 0
    img_path_list = dir([path,'*.bmp']);
    if isempty(img_path_list);
        error('�趨���ļ�����û���κ���Ƶ�������¼��...')
    end
    len = length(img_path_list);
    
    strName = cell(len, 1);
    strData = zeros(len, 1); 
    for i=1 : len
        file_path = strcat(path, img_path_list(i).name);
        [~, name, ext] = fileparts(file_path);
        if exist(file_path, 'file')
            strName{i, 1} = strcat(name, ext);
            strData(i, 1) = 1600;
        end
    end
end

len = length(strData(:, 1));
if len >= 2400
    k = 16;
elseif 2100 < len && len < 2400
    k = 24;
    
else
    k = 32;
end

strIndex = zeros(len, 1);
[strData, index] = sortrows(strData);
strName = strName(index, 1);

iniInfo.path = path;
iniInfo.strName = strName;
iniInfo.strData = strData;
iniInfo.strIndex = strIndex;
iniInfo.pos = [0; 0];
iniInfo.K = k;

%% չ��ͼƬ
[curPos, pos] = FindCompareNum();
iniInfo.pos = [curPos; pos];

path = strcat(iniInfo.path, cell2mat(iniInfo.strName(curPos)));
img = imread(path);
axes(handles.axes1);
imshow(img);
path = strcat(iniInfo.path, cell2mat(iniInfo.strName(pos)));
img = imread(path);
axes(handles.axes2);
imshow(img);

end


function [curPos, pos] = FindCompareNum()
%% ѡ��Ƚ�ͼƬ
global iniInfo;
len = length(iniInfo.strName(:, 1));
num = sum(iniInfo.strIndex == 0);

if num == 0 
    for i = 1 : 20
        excelPath = strcat(iniInfo.path, '�ڵ�����', num2str(i), '.xls');
        if ~exist(excelPath, 'file')            
            data = cell(len, 2);
            data(:, 1) = iniInfo.strName(:, 1);
            data(:, 2) = num2cell(iniInfo.strData(:, 1));
            xlswrite(excelPath, data);
            h = dialog('name', '��ʾ', 'position', [200,200,200,70]);
            uicontrol('parent',h,'style','text','string','һ�ֽ�����','position',[50 40 120 20],'fontsize',12);
            uicontrol('parent',h,'style','pushbutton','position',...
                [80 10 50 20],'string','ȷ��','callback','delete(gcbf)');
            return;
        end
    end
end

[curPos, pos] = SelectComparePos();
end

function [curPos, pos] = SelectComparePos()
%% ѡ��Ƚ�ͼƬ
global iniInfo;

%ѡ��û�б�ѡ�е�ͼƬ
len = length(iniInfo.strName(:, 1));
curPos = ceil(rand(1)*len);
while iniInfo.strIndex(curPos, 1) == 1
    curPos = ceil(rand(1)*len);        
end
iniInfo.strIndex(curPos, 1) = 1;
RA = iniInfo.strData(curPos, 1);

randPos = [];
i = 1;
tage = 0.5;
while  i <= len
    RB = iniInfo.strData(i, 1);
    EA = 1/(1+10.^((RA - RB)/400));
    if abs(EA-0.5) < tage && curPos ~= i
        tage = abs(EA-0.5);
        randPos = [];
        randPos = [randPos, i];
    elseif abs(EA-0.5) == tage && curPos ~= i
        randPos = [randPos, i];
    end
    i = i + 1;
end


if isempty(randPos)
    [r, ~] = find(iniInfo.strIndex(:, 1) == 0);
    pos = curPos;
    if ~isempty(r)
        pos = r(1);
    end
else
    len = length(randPos);
    pos = ceil(rand(1)*len);
    pos = randPos(pos);
end

end


function [newRA, newRB] = ELORatingSystem(RA, RB, SA, SB, K)
%% ����ELO���޷�
%RA,RB���쳣�ȼ���,EA���Ա�����ƵA����ǵ�����
EA = 1/(1+10.^((RA - RB)/400));
%EB���Ա�����ƵA����ǵ�����
EB = 1 - EA;
%SA����ʾ�������
newRA = RA + K*(SA - EA);
newRB = RB + K*(SB - EB);
end
