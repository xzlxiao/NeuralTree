function varargout = CoordinateGet(varargin)
% COORDINATEGET MATLAB code for CoordinateGet.fig
%      COORDINATEGET, by itself, creates a new COORDINATEGET or raises the existing
%      singleton*.
%
%      H = COORDINATEGET returns the handle to a new COORDINATEGET or the handle to
%      the existing singleton*.
%
%      COORDINATEGET('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COORDINATEGET.M with the given input arguments.
%
%      COORDINATEGET('Property','Value',...) creates a new COORDINATEGET or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CoordinateGet_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CoordinateGet_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CoordinateGet

% Last Modified by GUIDE v2.5 13-Oct-2015 01:32:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CoordinateGet_OpeningFcn, ...
                   'gui_OutputFcn',  @CoordinateGet_OutputFcn, ...
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


% --- Executes just before CoordinateGet is made visible.
function CoordinateGet_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CoordinateGet (see VARARGIN)

% Choose default command line output for CoordinateGet
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CoordinateGet wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CoordinateGet_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a = get(hObject, 'Value')
if a >= 0 && a <= 1
    axes(handles.axes1);
    b = imread('C:\Users\xzlxiao\Desktop\²Ã¼ô²âÊÔ\ÊäÈë\1\MBA-GI13443_06201_Crop.jpg');
    imshow(b);
elseif a > 1 && a <= 2
    axes(handles.axes1);
    b = imread('C:\Users\xzlxiao\Desktop\²Ã¼ô²âÊÔ\ÊäÈë\1\MBA-GI13443_06202_Crop.jpg');
    imshow(b);
end

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushTest.
function pushTest_Callback(hObject, eventdata, handles)
% hObject    handle to pushTest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
a = imread('C:\Users\xzlxiao\Desktop\²Ã¼ô²âÊÔ\ÊäÈë\1\MBA-GI13443_06201_Crop.jpg');
imshow(a);



% --- Executes on button press in pushTest2.
function pushTest2_Callback(hObject, eventdata, handles)
% hObject    handle to pushTest2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
b = imread('C:\Users\xzlxiao\Desktop\²Ã¼ô²âÊÔ\ÊäÈë\1\MBA-GI13443_06202_Crop.jpg');
imshow(b);



% --- Executes on button press in pushTest3.
function pushTest3_Callback(hObject, eventdata, handles)
% hObject    handle to pushTest3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
c = imrect;
a = getPosition(c)
