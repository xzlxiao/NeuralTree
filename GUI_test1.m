function varargout = GUI_test1(varargin)
% GUI_TEST1 MATLAB code for GUI_test1.fig
%      GUI_TEST1, by itself, creates a new GUI_TEST1 or raises the existing
%      singleton*.
%
%      H = GUI_TEST1 returns the handle to a new GUI_TEST1 or the handle to
%      the existing singleton*.
%
%      GUI_TEST1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_TEST1.M with the given input arguments.
%
%      GUI_TEST1('Property','Value',...) creates a new GUI_TEST1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_test1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_test1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_test1

% Last Modified by GUIDE v2.5 27-Sep-2015 21:10:29

% Begin initialization code - DO NOT EDIT
global img_inf;
img_inf = struct('SrcDir','', ...
    'DstDir','', ...
    'prefix', '', ...
    'suffix', '', ...
    'CropWidthFirstPointCoordinate', 0, ...
    'CropHeightFirstPointCoordinate',0, ...
    'CropWidth', 0, ...
    'CropHeight',0, ...
    'Zstart', 0, ...
    'Zend', 0);

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_test1_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_test1_OutputFcn, ...
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


% --- Executes just before GUI_test1 is made visible.
function GUI_test1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_test1 (see VARARGIN)
 
% Choose default command line output for GUI_test1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_test1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_test1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ButtonAdd.
function ButtonAdd_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonAdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 结构体img_inf = struct('SrcDir', 'DstDir',
% 'CropHeight','CropWidth','CropWidthFirstPointCoordinate'
% 'CropHeightFirstPointCoordinate')
global img_inf;
inDir = get(handles.editInput, 'string');
outDir = get(handles.editOutput,  'string');
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
    [n, ~] = size(list_tmp1);
    img_inf(n+1) = struct('SrcDir',inDir, ...
        'DstDir',outDir, ...
        'prefix', '', ...
        'suffix', '', ...
        'CropWidthFirstPointCoordinate', str2num(cooX), ...
        'CropHeightFirstPointCoordinate',str2num(cooY), ...
        'CropWidth', str2num(width), ...
        'CropHeight',str2num(Height), ...
        'Zstart', str2num(Z1), ...
        'Zend', str2num(Z2));

    list_tmp2 = strcat('[', num2str(n+1), '] 图片裁剪坐标 X：', ...
        num2str(img_inf(n+1).CropWidthFirstPointCoordinate), ' Y：', ...
        num2str(img_inf(n+1).CropHeightFirstPointCoordinate), ' 裁剪宽度：', ...
        num2str(img_inf(n+1).CropWidth),  ' 裁剪高度：', ...
        num2str(img_inf(n+1).CropHeight), ' 图层序号：', ...
        num2str(img_inf(n+1).Zstart), ' - ' , ...
        num2str(img_inf(n+1).Zend));
    
    list_cat(1:n) = list_tmp1;
    list_cat{n+1} = list_tmp2;
    set(handles.CropInfoBox, 'string', list_cat);
    
    set(handles.editInput, 'string', '');
    set(handles.editOutput, 'string', '');
    set(handles.editX, 'string', '');
    set(handles.editY, 'string', '');
    set(handles.editW, 'string', '');
    set(handles.editH, 'string', '');
    set(handles.editZ1, 'string', '');
    set(handles.editZ2, 'string', '');
end


function editX_Callback(hObject, eventdata, handles)
% hObject    handle to editX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editX as text
%        str2double(get(hObject,'String')) returns contents of editX as a double


% --- Executes during object creation, after setting all properties.
function editX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ButtonRun.
function ButtonRun_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonRun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.suffixN, 'Value')
    set(handles.editX, 'string', '1');
elseif get(handles.suffixY, 'Value')
    set(handles.editX, 'string', '2');
end



function editY_Callback(hObject, eventdata, handles)
% hObject    handle to editY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editY as text
%        str2double(get(hObject,'String')) returns contents of editY as a double


% --- Executes during object creation, after setting all properties.
function editY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editW_Callback(hObject, eventdata, handles)
% hObject    handle to editW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editW as text
%        str2double(get(hObject,'String')) returns contents of editW as a double


% --- Executes during object creation, after setting all properties.
function editW_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editH_Callback(hObject, eventdata, handles)
% hObject    handle to editH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editH as text
%        str2double(get(hObject,'String')) returns contents of editH as a double


% --- Executes during object creation, after setting all properties.
function editH_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in CropInfoBox.
function CropInfoBox_Callback(hObject, eventdata, handles)
% hObject    handle to CropInfoBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns CropInfoBox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from CropInfoBox



% --- Executes during object creation, after setting all properties.
function CropInfoBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CropInfoBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_5_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over ButtonAdd.



function editInput_Callback(hObject, eventdata, handles)
% hObject    handle to editInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editInput as text
%        str2double(get(hObject,'String')) returns contents of editInput as a double


% --- Executes during object creation, after setting all properties.
function editInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editOutput_Callback(hObject, eventdata, handles)
% hObject    handle to editOutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOutput as text
%        str2double(get(hObject,'String')) returns contents of editOutput as a double


% --- Executes during object creation, after setting all properties.
function editOutput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ButtonInput.
function ButtonInput_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, indir] = uigetfile({'*.jpg'},'选择需要裁剪的第一张图片');
if indir ~= 0
    set(handles.editInput, 'string', indir);
    set(handles.Filename, 'string', filename);
end

% --- Executes on button press in ButtonOutput.
function ButtonOutput_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonOutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
outdir = uigetdir({},'选择文件夹');
if outdir ~= 0
    outdir = strcat(outdir,'\');
    set(handles.editOutput, 'string', outdir);
end





% --- Executes on button press in ButtonDel.
function ButtonDel_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonDel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img_inf;
list_info = get(handles.CropInfoBox, 'string');
[n,~] = size(list_info);
CurPt = get(handles.CropInfoBox, 'Value');
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



function editZ1_Callback(hObject, eventdata, handles)
% hObject    handle to editZ1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editZ1 as text
%        str2double(get(hObject,'String')) returns contents of editZ1 as a double


% --- Executes during object creation, after setting all properties.
function editZ1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editZ1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editZ2_Callback(hObject, eventdata, handles)
% hObject    handle to editZ2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editZ2 as text
%        str2double(get(hObject,'String')) returns contents of editZ2 as a double


% --- Executes during object creation, after setting all properties.
function editZ2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editZ2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in buttonTest.
function buttonTest_Callback(hObject, eventdata, handles)
% hObject    handle to buttonTest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% te = get(handles.CropInfoBox, 'string');
% n = get(handles.CropInfoBox, 'Value');
% set(handles.textTest, 'string', te(n));

global img_inf;
inDir = get(handles.editInput, 'string');
outDir = get(handles.editOutput,  'string');
prefix = get(handles.Prefix,  'string');
suffix = get(handles.Suffix,  'string');
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
    [n, ~] = size(list_tmp1);
    img_inf(n+1) = struct('SrcDir',inDir, ...
        'DstDir',outDir, ...
        'prefix', Prefix, ...
        'suffix', suffix, ...
        'CropWidthFirstPointCoordinate', str2num(cooX), ...
        'CropHeightFirstPointCoordinate',str2num(cooY), ...
        'CropWidth', str2num(width), ...
        'CropHeight',str2num(Height), ...
        'Zstart', str2num(Z1), ...
        'Zend', str2num(Z2));

    list_tmp2 = strcat('[', num2str(n+1), '] ', ...
        Prefix, 'XXXXX', Suffix, ...
        '图片裁剪坐标 X：', ...
        num2str(img_inf(n+1).CropWidthFirstPointCoordinate), ' Y：', ...
        num2str(img_inf(n+1).CropHeightFirstPointCoordinate), ' 裁剪宽度：', ...
        num2str(img_inf(n+1).CropWidth),  ' 裁剪高度：', ...
        num2str(img_inf(n+1).CropHeight), ' 图层序号：', ...
        num2str(img_inf(n+1).Zstart), ' - ' , ...
        num2str(img_inf(n+1).Zend));
    
    list_cat(1:n) = list_tmp1;
    list_cat{n+1} = list_tmp2;
    set(handles.CropInfoBox, 'string', list_cat);
    
    set(handles.editInput, 'string', '');
    set(handles.editOutput, 'string', '');
    set(handles.Filename, 'string', '');
    set(handles.Prefix, 'string', '');
    set(handles.Suffix, 'string', '');
    set(handles.editX, 'string', '');
    set(handles.editY, 'string', '');
    set(handles.editW, 'string', '');
    set(handles.editH, 'string', '');
    set(handles.editZ1, 'string', '');
    set(handles.editZ2, 'string', '');
end



function Filename_Callback(hObject, eventdata, handles)
% hObject    handle to Filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Filename as text
%        str2double(get(hObject,'String')) returns contents of Filename as a double


% --- Executes during object creation, after setting all properties.
function Filename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Prefix_Callback(hObject, eventdata, handles)
% hObject    handle to Prefix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Prefix as text
%        str2double(get(hObject,'String')) returns contents of Prefix as a double


% --- Executes during object creation, after setting all properties.
function Prefix_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Prefix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Suffix_Callback(hObject, eventdata, handles)
% hObject    handle to Suffix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Suffix as text
%        str2double(get(hObject,'String')) returns contents of Suffix as a double


% --- Executes during object creation, after setting all properties.
function Suffix_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Suffix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
