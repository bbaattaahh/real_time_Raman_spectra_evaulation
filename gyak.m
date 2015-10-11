function varargout = gyak(varargin)
%FELADAT: Referencia k�tegek beolvas�sa �s elment�se a megfelel� mapp�ba.
%         Ez a script a kliens_main.m script kiszolg�l�s�ra k�sz�lt. 


% Edit the above text to modify the response to help gyak

% Last Modified by GUIDE v2.5 02-Mar-2014 14:53:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gyak_OpeningFcn, ...
                   'gui_OutputFcn',  @gyak_OutputFcn, ...
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


% --- Executes just before gyak is made visible.
function gyak_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gyak (see VARARGIN)
% Choose default command line output for gyak
handles.output = hObject;
handles.filename ='';
handles.pathname='';
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gyak wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gyak_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
%varargout{1} = 10;



% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)


[handles.filename, handles.pathname, filterindex] = uigetfile( ...
       {'*.txt','txt-files (*.txt)'; ...
        '*.mdl','Models (*.mdl)'; ...
        '*.*',  'All Files (*.*)'}, ...
        'Pick a file', ...
        'MultiSelect', 'on');

 set(handles.text1,'string',handles.filename)
guidata(hObject,handles);
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in savebutton.
function savebutton_Callback(hObject, eventdata, handles)

    remain=handles.filename;
    b=handles.pathname;
    savefilename='';
    
    
    token='';
    A=[];
    fn=[];                                %file neveket itt gy�jt�m �ssze egy fileba
    
    while isempty(token)                  %Sz�tszedi a filename v�ltoz�t, mert az egy hossz� string
       [token, remain] = strtok(remain);  %A tokenel�s cell t�pus� v�ltoz�kat csin�l az�rt kell vele kicsit baszakodni
    end
    
    if class(token)=='char'
            fn=[fn,token];
            fn=[fn,' '];
            A=[A,importdata(strcat(b,token))];           %Cell-t �gy lehet sztring� alak�tani
    else    
        for k=1:length(token)                 %A tokenel�s cell t�pus� v�ltoz�kat csin�l az�rt kell vele kicsit baszakodni
            fn=[fn,token{k}];
            fn=[fn,' '];
            A=[A,importdata(strcat(b,token{k}))];           %Cell-t �gy lehet sztring� alak�tani
        end    
    end
    
    %A
    %fn
    
    savefilename=mfilename('fullpath');
    c=strfind(savefilename,'\');

    savefilename=savefilename(1:c(length(c)));                      %lev�gja az m file nev�t az el�r�si �tb�l
    savefilename=strcat(savefilename,'REFERENCE COLLECTIONS\');      %hozz� adja a referencia mappa el�r�si �tvonal�t
    savefilename=strcat(savefilename,get(handles.edit1,'String'));  %hozz� adja a referencia file nev�t a text boxb�l
    savefilename=strcat(savefilename,'.rc');
    
    %class(savefilename{1})
    
   
    
    
    fileID = fopen(savefilename{1},'w');
      fprintf(fileID,'%d\r\n', length(A(:,1)));
      fprintf(fileID,'%d\r\n', length(A(1,:)));
      fprintf(fileID,'%s\r\n', fn);
      fprintf(fileID,'%f\r\n', A);
    fclose(fileID);
    
    close(gyak);
% hObject    handle to savebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Cancelbutton.
function Cancelbutton_Callback(hObject, eventdata, handles)

 close(gyak);
% hObject    handle to Cancelbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
