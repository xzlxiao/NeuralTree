function varargout = Crop_GUI(varargin)
%   软件功能：图片裁剪
%   软件说明：GUI设计，输入参数为图片输入路径（输入路径选择任意需要裁剪的图片文件，将自动获取路径和文件名信息
%   、图片输出路径、文件名前缀、文件名后缀（图片数字需要后，“.JPG”之前的部分），
%   图片裁剪区域左上角坐标X、Y，裁剪的宽度和高度：W、H，这四个参数由imageJ获取，
%   需裁剪图片的起始序号和终止序号，备注信息
%   填写裁剪区域所在脑区，如海马CA1区。
%   参数填写完毕后，点击添加，会在列表框生成一条裁剪信息，
%   点击运行按钮会根据添加的裁剪信息进行图片裁剪
%   setappdata(handles.CropInfoBox, 'ImgData', img_inf);
%   图片裁剪信息以结构体数组img_inf(n)的形式，用setappdata函数储存于CropInfoBox控件句柄的'ImgData'属性中
%   投影需要根据图片背景选择黑色或浅色，用以决定是min投影还是max投影，该功能会在原图片路径下生成prj文件夹，
%   用以储存生成的结果
%   Created by 肖镇龙.
%   Copyright (c) 2015年 肖镇龙. All rights reserved.

% Edit the above text to modify the response to help Crop_GUI

% Last Modified by GUIDE v2.5 04-Oct-2015 18:47:30

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
    msgbox('请输入输出路径、坐标以及裁剪区域信息');
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
    
    if n == 0
        list_cat{1} = list_tmp2;
    else
        list_cat(1:n) = list_tmp1;
        list_cat{n+1} = list_tmp2;
    end
    set(handles.CropInfoBox, 'string', list_cat);
        
    set(handles.editX, 'string', '');
    set(handles.editY, 'string', '');
    set(handles.editW, 'string', '');
    set(handles.editH, 'string', '');
    set(handles.editZ1, 'string', '');
    set(handles.editZ2, 'string', '');
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
waitbar_crop = waitbar(0, '图片裁剪中');
steps = col;
for i = 1 : col
    Crop_img(img_inf(i));
    waitbar(i/steps, waitbar_crop, strcat('总进度：图片序列',num2str(i)));
end
close(waitbar_crop);
Outprint = get(handles.CropInfoBox, 'string');
file1 = fopen('CropInfo.txt', 'at');
fprintf(file1, '%s \n', date);
[n, ~] = size(Outprint);
filename_info = 'info.txt';
for i = 1 : n
    fprintf(file1, '%s \n', Outprint{i,1});
end
fclose(file1);
for i = 1 : n
    SavDir = strcat(img_inf(i).DstDir, filename_info);
    file2 = fopen(SavDir, 'at');
    fprintf(file2, '%s \n', date);
    fprintf(file2, '%s \n', Outprint{i,1});
    fclose(file2);
end




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
[n2,~] = size(list_info);
for i = 1 : n2
    list_info{i}(2) = num2str(i);
    img_inf(i).init = num2str(i);
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


% --- Executes on button press in buttonInfo.
function buttonInfo_Callback(hObject, eventdata, handles)
% hObject    handle to buttonInfo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('图片裁剪GUI设计说明.txt');


% --- Executes on button press in Test_But.
function Test_But_Callback(hObject, eventdata, handles)
% hObject    handle to Test_But (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CoordinateGet;


% --- Executes on button press in buttonInvert.
function buttonInvert_Callback(hObject, eventdata, handles)
% hObject    handle to buttonInvert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img_invert;
            


% --- Executes on button press in buttonRun2.
function buttonRun2_Callback(hObject, eventdata, handles)
% hObject    handle to buttonRun2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img_inf = getappdata(handles.CropInfoBox, 'ImgData');
[~, col] = size(img_inf);
for i = 1 : col
    CropIn_img(img_inf(i));
end
Outprint = get(handles.CropInfoBox, 'string');
file1 = fopen('CropInfo.txt', 'at');
fprintf(file1, '%s \n', date);
[n, ~] = size(Outprint);
filename_info = 'info.txt';
for i = 1 : n
    fprintf(file1, '%s \n', Outprint{i,1});
end
fclose(file1);
for i = 1 : n
    SavDir = strcat(img_inf(i).DstDir, filename_info);
    file2 = fopen(SavDir, 'at');
    fprintf(file2, '%s \n', date);
    fprintf(file2, '%s \n', Outprint{i,1});
    fclose(file2);
end


% --- Executes on button press in ButtonPrj.
function ButtonPrj_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonPrj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile({'*.jpg', 'JPG文件';'*.tif', 'TIF文件'}, '选取图片', 'MultiSelect', 'on');
prj_property = -1;
if pathname ~= 0
    prj_ptmp = questdlg('请确定投影图片背景颜色，已决定正确地投影参数', ...
        '投影参数选择', '黑色', '浅色', '取消', '黑色');
    switch prj_ptmp
        case '黑色'
            prj_property = 1;
        case '浅色'
            prj_property = 0;
        case '取消'
            prj_property = -1;
    end
end
if prj_property ~= -1
    %   判断叠加的图片数量
    stack_num = 100;
    %   设置投影图储存地址
    save_path = strcat(pathname, 'prj/');
    CreateFolder(save_path);
    %   设置图片读取的路径信息
    [~, up_lim] = size(filename);
    filedir = cell(1, up_lim);
    for i = 1 : up_lim
        filedir{1, i} = strcat(pathname, filename{1, i});
    end
    fix_lim = fix(up_lim/stack_num);
    rem_lim = rem(up_lim, stack_num);
    %   按顺序读取图片
    if rem_lim > 0
        waitbar_1 = waitbar(0, '进度');
        steps = up_lim;
        for i = 0 : (fix_lim - 1)
            img_first = imread(filedir{(i*stack_num) + 1});
            for j = 1 : stack_num
                img_next = imread(filedir{(i * stack_num) + j});
                img_first = img_prj(img_first, img_next, prj_property);
                waitbar(((i * stack_num) + j)/steps,waitbar_1,num2str((i * stack_num) + j));
            end
            [filename2, ~] = strtok(filename{(i*stack_num) + 1}, '.');
            ImgInvert = img_invert(img_first);
            imwrite(ImgInvert, strcat(save_path, 'INVERT' , filename2, 'stack.tif'));
            imwrite(img_first, strcat(save_path, filename2, 'stack.tif'));
        end
        img_first = imread(filedir{(fix_lim*stack_num) + 1});
        for i = 1 : rem_lim
            img_next = imread(filedir{(fix_lim*stack_num) + i});
            img_first = img_prj(img_first, img_next, prj_property);
            waitbar(((fix_lim*stack_num) + i)/steps, waitbar_1, num2str((fix_lim*stack_num) + i));
        end
        [filename2, ~] = strtok(filename{(fix_lim*stack_num) + 1}, '.');
        ImgInvert = img_invert(img_first);
        imwrite(ImgInvert, strcat(save_path, 'INVERT' , filename2, 'stack.tif'));
        imwrite(img_first, strcat(save_path, filename2, 'stack.tif'));
        close(waitbar_1);
    else
        waitbar_2 = waitbar(0, '进度');
        steps = up_lim;
        for i = 0 : (fix_lim - 1)
            img_first = imread(filedir{(i*stack_num) + 1});
            for j = 1 : stack_num
                img_next = imread(filedir{(i * stack_num) + j});
                img_first = img_prj(img_first, img_next, prj_property);
                waitbar(((i * stack_num) + j)/steps, waitbar_2, num2str((i * stack_num) + j));
            end
            [filename2, ~] = strtok(filename{(i*stack_num) + 1}, '.');
            ImgInvert = img_invert(img_first);
            imwrite(ImgInvert, strcat(save_path, 'INVERT' , filename2, 'stack.tif'));
            imwrite(img_first, strcat(save_path, filename2, 'stack.tif'));
        end
        close(waitbar_2);
    end
end
