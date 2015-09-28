function varargout = Crop_GUI(varargin)
% CROP_GUI MATLAB code for Crop_GUI.fig
%      CROP_GUI, by itself, creates a new CROP_GUI or raises the existing
%      singleton*.
%
%      H = CROP_GUI returns the handle to a new CROP_GUI or the handle to
%      the existing singleton*.
%
%      CROP_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CROP_GUI.M with the given input arguments.
%
%      CROP_GUI('Property','Value',...) creates a new CROP_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Crop_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Crop_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Crop_GUI

% Last Modified by GUIDE v2.5 28-Sep-2015 18:53:51

% Begin initialization code - DO NOT EDIT




gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Crop_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Crop_GUI_OutputFcn, ...
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


% --- Executes just before Crop_GUI is made visible.
function Crop_GUI_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Crop_GUI (see VARARGIN)
 
% Choose default command line output for Crop_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Crop_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Crop_GUI_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ButtonAdd.
function ButtonAdd_Callback(~, ~, handles)
% hObject    handle to ButtonAdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 结构体img_inf = struct('SrcDir', 'DstDir',
% 'CropHeight','CropWidth','CropWidthFirstPointCoordinate'
% 'CropHeightFirstPointCoordinate')

img_inf = getappdata(handles.CropInfoBox, 'ImgData');
inDir = get(handles.editInput, 'string');
outDir = get(handles.editOutput,  'string');
prefix = get(handles.Prefix,  'string');
suffix = get(handles.Suffix,  'string');
filename = get(handles.Filename,  'string');
cooX = get(handles.editX, 'string');
cooY = get(handles.editY, 'string');
width = get(handles.editW, 'string');
Height = get(handles.editH, 'string');
Z1 = get(handles.editZ1, 'string');
Z2 = get(handles.editZ2, 'string');
if isempty(inDir)|| ...
        isempty(outDir)|| ...
        isempty(cooX)|| ...
        isempty(cooY)|| ...
        isempty(width)|| ...
        isempty(Height )|| ...
        isempty(Z1 )|| ...
        isempty(Z2)
    msgbox('请输入路径、坐标以及裁剪区域信息');
else
    
    list_tmp1 = get(handles.CropInfoBox, 'string');
    appendinfo = get(handles.edit13, 'string');
    [n, ~] = size(list_tmp1);
    img_inf(n+1).SrcDir = inDir;
    img_inf(n+1).DstDir = outDir;
    img_inf(n+1).prefix = prefix;
    img_inf(n+1).suffix = suffix;
    img_inf(n+1).filename = filename;
    img_inf(n+1).CropWidthFirstPointCoordinate = str2num(cooX);
    img_inf(n+1).CropHeightFirstPointCoordinate = str2num(cooY);
    img_inf(n+1).CropWidth = str2num(width);
    img_inf(n+1).CropHeight = str2num(Height);
    img_inf(n+1).Zstart = str2num(Z1);
    img_inf(n+1).Zend = str2num(Z2);
    img_inf(n+1).init = n + 1;

    list_tmp2 = strcat('[', num2str(n+1), '] ', ...
        prefix, 'XXXXX', suffix, ...
        ' CropCoordinate X：', ...
        num2str(img_inf(n+1).CropWidthFirstPointCoordinate), ' Y：', ...
        num2str(img_inf(n+1).CropHeightFirstPointCoordinate), ' CropWidth：', ...
        num2str(img_inf(n+1).CropWidth),  ' CropHeight：', ...
        num2str(img_inf(n+1).CropHeight), ' ZRange：', ...
        num2str(img_inf(n+1).Zstart), ' - ' , ...
        num2str(img_inf(n+1).Zend), ' 备注信息：', ...
        appendinfo);
    
    list_cat(1:n) = list_tmp1;
    list_cat{n+1} = list_tmp2;
    set(handles.CropInfoBox, 'string', list_cat);
    
    set(handles.editInput, 'string', '');
    set(handles.editOutput, 'string', '');
    set(handles.Filename, 'string', '');
    set(handles.editX, 'string', '');
    set(handles.editY, 'string', '');
    set(handles.editW, 'string', '');
    set(handles.editH, 'string', '');
    set(handles.editZ1, 'string', '');
    set(handles.editZ2, 'string', '');
    set(handles.edit13, 'string', '');
end
setappdata(handles.CropInfoBox, 'ImgData', img_inf);



% --- Executes during object creation, after setting all properties.
function editX_CreateFcn(hObject, ~, ~)
% hObject    handle to editX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ButtonRun.
function ButtonRun_Callback(~, ~, handles)
% hObject    handle to ButtonRun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img_inf = getappdata(handles.CropInfoBox, 'ImgData');
[~, col] = size(img_inf);
for i = 1 : col
    Crop_img(img_inf(col));
end
Outprint = get(handles.CropInfoBox, 'string');
file = fopen('CropInfo.txt', 'at');
fprintf(file, '%s \n', date);
[n, ~] = size(Outprint);
for i = 1 : n
    fprintf(file, '%s \n', Outprint{n,1});
end
fclose(file);



% --- Executes during object creation, after setting all properties.
function editY_CreateFcn(hObject, ~, ~)
% hObject    handle to editY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function editW_CreateFcn(hObject, ~, ~)
% hObject    handle to editW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function editH_CreateFcn(hObject, ~, ~)
% hObject    handle to editH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function CropInfoBox_CreateFcn(hObject, ~, handles)
% hObject    handle to CropInfoBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
img_inf(1).init = 1;
setappdata(hObject, 'imgData', img_inf);


% --- Executes during object creation, after setting all properties.
function editInput_CreateFcn(hObject, ~, ~)
% hObject    handle to editInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function editOutput_CreateFcn(hObject, ~, ~)
% hObject    handle to editOutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ButtonInput.
function ButtonInput_Callback(~, ~, handles)
% hObject    handle to ButtonInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, indir] = uigetfile({'*.jpg'},'选择需要裁剪的第一张图片');
if indir ~= 0
    set(handles.editInput, 'string', indir);
    set(handles.Filename, 'string', filename);
end

% --- Executes on button press in ButtonOutput.
function ButtonOutput_Callback(~, ~, handles)
% hObject    handle to ButtonOutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
outdir = uigetdir({},'选择文件夹');
if outdir ~= 0
    outdir = strcat(outdir,'\');
    set(handles.editOutput, 'string', outdir);
end





% --- Executes on button press in ButtonDel.
function ButtonDel_Callback(~, ~, handles)
% hObject    handle to ButtonDel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
list_info = get(handles.CropInfoBox, 'string');
[n,~] = size(list_info);
CurPt = get(handles.CropInfoBox, 'Value');
img_inf = getappdata(handles.CropInfoBox, 'ImgData');
% 列表框当前选中项
if CurPt == 1
    list_info = list_info(2:n);
    img_inf = img_inf(2:n);
elseif CurPt == n
    set(handles.CropInfoBox, 'Value', n-1);
    list_info = list_info(1:(n-1));
    img_inf = img_inf(1:(n-1));
else
    list_tmp(1:CurPt-1) = list_info(1:CurPt-1);
    list_tmp(CurPt:(n-1)) = list_info((CurPt+1):n);
    list_info = list_tmp;
    img_tmp(1:CurPt-1) = img_inf(1:CurPt-1);
    img_tmp(CurPt:(n-1)) = img_inf((CurPt+1):n);
    img_inf = img_tmp; 
end
set(handles.CropInfoBox, 'string', list_info);
setappdata(handles.CropInfoBox, 'ImgData', img_inf);

% --- Executes during object creation, after setting all properties.
function editZ1_CreateFcn(hObject, ~, ~)
% hObject    handle to editZ1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function editZ2_CreateFcn(hObject, ~, ~)
% hObject    handle to editZ2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Filename_CreateFcn(hObject, ~, ~)
% hObject    handle to Filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Prefix_CreateFcn(hObject, ~, ~)
% hObject    handle to Prefix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Suffix_CreateFcn(hObject, ~, ~)
% hObject    handle to Suffix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editInput_Callback(~, ~, ~)
% hObject    handle to editInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editInput as text
%        str2double(get(hObject,'String')) returns contents of editInput as a double



function editOutput_Callback(~, ~, ~)
% hObject    handle to editOutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOutput as text
%        str2double(get(hObject,'String')) returns contents of editOutput as a double



function Filename_Callback(~, ~, ~)
% hObject    handle to Filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Filename as text
%        str2double(get(hObject,'String')) returns contents of Filename as a double



function Prefix_Callback(~, eventdata, handles)
% hObject    handle to Prefix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Prefix as text
%        str2double(get(hObject,'String')) returns contents of Prefix as a double



function Suffix_Callback(~, ~, ~)
% hObject    handle to Suffix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Suffix as text
%        str2double(get(hObject,'String')) returns contents of Suffix as a double



function editX_Callback(~, ~, ~)
% hObject    handle to editX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editX as text
%        str2double(get(hObject,'String')) returns contents of editX as a double



function editY_Callback(~, ~, ~)
% hObject    handle to editY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editY as text
%        str2double(get(hObject,'String')) returns contents of editY as a double



function editW_Callback(~, ~, ~)
% hObject    handle to editW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editW as text
%        str2double(get(hObject,'String')) returns contents of editW as a double



function editH_Callback(~, ~, ~)
% hObject    handle to editH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editH as text
%        str2double(get(hObject,'String')) returns contents of editH as a double



function editZ1_Callback(hObject, eventdata, handles)
% hObject    handle to editZ1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editZ1 as text
%        str2double(get(hObject,'String')) returns contents of editZ1 as a double



function editZ2_Callback(~, ~, ~)
% hObject    handle to editZ2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editZ2 as text
%        str2double(get(hObject,'String')) returns contents of editZ2 as a double


% --- Executes on selection change in CropInfoBox.
function CropInfoBox_Callback(~, ~, ~)
% hObject    handle to CropInfoBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns CropInfoBox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from CropInfoBox


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over ButtonAdd.



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
