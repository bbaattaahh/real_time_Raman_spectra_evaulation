function varargout = main_kliens(varargin)
% MAIN MATLAB code for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 25-Oct-2015 18:00:09

% Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @main_OpeningFcn, ...
                       'gui_OutputFcn',  @main_OutputFcn, ...
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
end

% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
    handles.output = hObject;


%Saját változók gyüjteménye
    handles.MOR=[];   %Mátrix Of References 
    handles.MOWN=[];  %Matric Of WaveNumbers
    handles.NOR='';   %Names Of References
    handles.MOIS=[];  %Matric Of Income Spertras  (idõrendi sorendben. Az elsõ a legrégebbi)    

    handles.tcpipClient= tcpip('152.66.62.157',12346,'NetworkRole','Client');
    
    handles.CD=[];    %Counted Data ebben vannak eltárolva a táblázatban megjelenítendõ értékek illetve referencia nevek

    handles.OS_baseline_points=[];
    
    %handles.actPLSMoldel;
    
    %Kutya
    imshow('xVyoSl.jpg');
    
    %induláskor beállítja a list box értékeit
    LoadAListBoxFromARelativFolder('REFERENCE COLLECTIONS',handles.listbox1);   
    LoadAListBoxFromARelativFolder('PLS_MODEL_COLLECTION',handles.listbox_of_PLS_models);
    
    guidata(hObject, handles);

end

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
    varargout{1} = handles.output;
end

% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end



% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    gyak
    waitfor(gyak);
    
    %frissíteni kell a list box értékeit    
    LoadAListBoxFromARelativFolder('REFERENCE COLLECTIONS',handles.listbox1);
 
    % Update handles structure
    guidata(hObject, handles);
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)


% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end

% --- Executes on button press in load_references_button.
function load_references_button_Callback(hObject, eventdata, handles)


    x=get(handles.listbox1,'Value');
    a=get(handles.listbox1,'String');
    %a(x,:)
    fn=pwd;                                      %dictionary name                
    fn=strcat(fn,'\REFERENCE COLLECTIONS\');     %hozzá adja a referencia mappa elérési útvonalát
    fn=strcat(fn,a(x,:));
    
    [handles.NOR,handles.MOWN,handles.MOR]=ref_betoltese(fn);
    
    set(handles.State_of_references,'String',a(x,:));
    
    %Itt tölti ki a kezdõ táblázatott értékekkel és kérdõjelekkel
    handles.CD=[];
    for ii=1:length(handles.NOR)
        handles.CD = [ handles.CD ; [handles.NOR{ii}, {'? %'}]];
    end
    
    set(handles.uitable1,'Data',handles.CD)
    
    
    %figure(1)
    %plot(handles.MOWN,handles.MOR);
    %title('Nyers referenciák');
    
    guidata(hObject, handles);

% hObject    handle to load_references_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end


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

end

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end

% --- Executes on button press in Connect_button.
function Connect_button_Callback(hObject, eventdata, handles)
% hObject    handle to Connect_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    IP=get(handles.edit1,'String'); 
    Port=str2double(get(handles.edit2,'String'));
    
    whos handles.tcpipClient
    
    handles.tcpipClient = tcpip(IP,Port,'NetworkRole','Client')
    set(handles.tcpipClient,'InputBufferSize',1000000);              %HENRIK ezeket lehet h paraméterezhetõvé kell tenni
    set(handles.tcpipClient,'OutputBufferSize',1000000);              %HENRIK ezeket lehet h paraméterezhetõvé kell tenni
    set(handles.tcpipClient,'Timeout',300);                       
    
    fopen(handles.tcpipClient);
    
    set(handles.text5,'String','CSATLAKOZOTT');
    set(handles.text5,'FontSize',12);
      

    guidata(hObject, handles);

end


% --- Executes on button press in disconnect_buttom.
function disconnect_buttom_Callback(hObject, eventdata, handles)
% hObject    handle to disconnect_buttom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    fclose(handles.tcpipClient);
    set(handles.text5,'String','LEVÁLASZTVA')
    guidata(hObject, handles);
end

% --- Executes on button press in Count_button.
function Count_button_Callback(hObject, eventdata, handles)
    
    %Henrik ganyolas it is only temporary solution
    if get(handles.checkbox_simulation, 'Value')
        sim_folder_path = get(handles.simulation_folder_path,'String');
        send_all_spectradata_to_TCP_IP(handles.tcpipClient, sim_folder_path)      
    end
    %Feladat

    %Adatok úgy jönnek h: azonosító(int32), hosszúság(int32), Ömlesztve azadat(int32 vagy char)

    %AZONOSÍTÓK
    %1:Spektrum intenzitások
    %2:Számított koncentráció eredmények
    %3:Hullámszám értékek (TERVEZETT)    

    %A KIÉRTÉKELÉS FELÉPÍTÁSE
    %   1.Elõkészülni a kiértékeléshez, olyan programsrészek, amiket 
    %        csak egyszer kell megcsinálni a spetrumok kiértékelése elõtt
    %        (Értékelés típusától fûgg)
    %   2.Beérkezõ adatok azonosítása, megfelelõ változóba való mentáse (Beérkezõ adat azonosítájól függ)
    %   3.Beérkezett adatok elõfeldolgozása (Értékelés típusûtól és beérkezõ adat azonosítájól IS függ)
    %   4.Értékelés (Értékelés típusûtól)
    %   5.Eredmények utólagos feldolgozása  (Értékelés típusûtól és beérkezõ adat azonosítájól IS függ)
    %   6.Eredmények kiküldáse (???)        (Beérkezõ adat azonosítójál
    %       függ. Ez nem biztos, hogy így van de most még elég 
    
    
    rawData = [-1,-1];
    bl_flag = get(handles.baseline_correction_checkbox,'Value');
    norm_flag = get(handles.normalization_checkbox,'Value');
    spike_filt_flag2 = get(handles.spike_filter_CB_twoSpetras,'Value');
    spike_filt_flag1 = get(handles.spikeFilterCB_onespetra,'Value');
    OS_bl_flag = get(handles.OS_baseline,'Value');
    window = str2double(get(handles.size_of_window_edit,'String'));
    sum_conc100=get(handles.sum_concentrations_checkbox,'Value');
    spectraHistoryMoving=[];
    specrtaHistorySpikeFilter=[];
    despersion=str2double(get(handles.despersionTextBox, 'String'));
    result_buffer = [];
    

    %   1.Elõkészülni a kiértékeléshez, olyan programsrészek, amiket 
    %        csak egyszer kell megcsinálni a spetrumok kiértékelése elõtt
    %        (Értékelés típusától fûgg)
    
    if get(handles.checkbox_simulation, 'Value')
    
        switch get(handles.popupmenu2,'Value')
            case 1
                preparated_references = references_spectras_preparation(handles.MOR,bl_flag,norm_flag,OS_bl_flag,handles.OS_baseline_points);
                ered=zeros(length(preparated_references(1,:)),1);
            case 2
                %PLS-hez nem kell semmi ilyesmi mivel a model tartalmazza
                %minden ilyesmit...
            otherwise
                msgbox('Ismeretlen értékelési mód lett kiválasztva!!négy!4!')
        end  

        id = 'start value';
        
        while not(strcmp(id, 'ENDE'))
         %-------------------------------------------------------------------------------------------------------
         %   2.Beérkezõ adatok azonosítása, megfelelõ változóba való mentáse (Beérkezõ adat azonosítájól függ)
            id = 'start value';

            while not (strcmp(id, 'INTE') || strcmp(id, 'ENDE'))
                [id, message] = read_next_message_from_TCP_IP(handles.tcpipClient);
            end

            if strcmp(id, 'ENDE')
                break;
            end    
            
            x = message;



         %-------------------------------------------------------------------------------------------------------        
         %   3.Beérkezett adatok elõfeldolgozása (Értékelés típusûtól és beérkezõ adat azonosítájól IS függ)


            switch id  %ADAT AZONOSÍTÓ szint
                case 'INTE'
                    % preprocessing function
                    [x,spectraHistoryMoving] = SpectraFlowHandler(x, window, spectraHistoryMoving); 
                    preProcessedSpectra = incoming_spectra_preparation(x,bl_flag,norm_flag, OS_bl_flag, handles.OS_baseline_points);                  
                otherwise
                    msgbox('Ismeretlen adat azonosító érkezett a socketen');
            end     

         %-------------------------------------------------------------------------------------------------------
         %   4.Értékelés (Értékelés típusûtól)     
         %TODO ez egy function kellene hogy legyen amit meg lehet hívni
         %egyben
            switch get(handles.popupmenu2,'Value')
                case 1
                    ered=CLS_ertekeles(preparated_references,preProcessedSpectra);
                case 2
                    temp1=pls(preProcessedSpectra,handles.actPLSModel);
                    ered=cell2mat(temp1.pred);
                    ered=rot90(ered,3); 
                otherwise
                    msgbox('Kaka van a levesben')
            end


        %-------------------------------------------------------------------------------------------------------
        %   5.Eredmények utólagos feldolgozása (Értékelés típusûtól és beérkezõ adat azonosítájól IS függ  


            if (sum_conc100) 
                ered=NomalizationToSum1(ered); 
            end

        %-------------------------------------------------------------------------------------------------------        
        %   6.Eredmények kiküldáse (???)        (Beérkezõ adat azonosítójál  függ)

            %eredmények kiíratása a kliensen
            figure(2);
            result_buffer = [result_buffer, ered];
            plot(rot90(result_buffer, -1));
            
            for ii=1:size(ered,1)
                handles.CD{ii,2}=num2str(ered(ii));
            end

            set(handles.uitable1,'Data',handles.CD);
            drawnow;


        end
       
    else
        %Original eavaulation process

        switch get(handles.popupmenu2,'Value')
            case 1
                preparated_references=references_spectras_preparation(handles.MOR,bl_flag,norm_flag,OS_bl_flag,handles.OS_baseline_points);
                ered=zeros(length(preparated_references(1,:)),1);
            case 2
                %PLS-hez nem kell semmi ilyesmi mivel a model tartalmazza
                %minden ilyesmit...
            otherwise
                msgbox('Ismeretlen értékelési mód lett kiválasztva!!négy!4!')
        end  


        while rawData(1)~=0 
         %-------------------------------------------------------------------------------------------------------
         %   2.Beérkezõ adatok azonosítása, megfelelõ változóba való mentáse (Beérkezõ adat azonosítájól függ)
            rawData = fread(handles.tcpipClient,2,'int32');  
            rawData=VBLong_32bit_to_ML_int32_64bit_socket(rawData);
            x=0;
    
    
            switch rawData(1)
                case 1
                    x=fread(handles.tcpipClient,rawData(2),'int32');
                    x=VBLong_32bit_to_ML_int32_64bit_socket(x);
                    handles.MOIS=[handles.MOIS,x];
                otherwise
                    msgbox('Ismeretlen adat azonosító érkezett a socketen');
            end



         %-------------------------------------------------------------------------------------------------------        
         %   3.Beérkezett adatok elõfeldolgozása (Értékelés típusûtól és beérkezõ adat azonosítájól IS függ)


            switch rawData(1)  %ADAT AZONOSÍTÓ szint
                case 1
                    if (spike_filt_flag1)
                        [x,caughtSpikeFlag]=spike_filter1(x,despersion);
                        if (caughtSpikeFlag)
                            addOne(handles.numberOfDetectedSpikes);
                            WriteLog();
                        end    
                    end

                    if (spike_filt_flag2) 
                        [blank,specrtaHistorySpikeFilter]=SpectraFlowHandler(x,2,specrtaHistorySpikeFilter);
                        [x,caughtSpikeFlag]=spike_filter2(specrtaHistorySpikeFilter,despersion);
                        if (caughtSpikeFlag)
                            addOne(handles.numberOfDetectedSpikes);
                            WriteLog();
                        end    
                    end
                    [x,spectraHistoryMoving]=SpectraFlowHandler(x,window,spectraHistoryMoving); 
                    switch get(handles.popupmenu2,'Value') %ÉRTÉKELÉS TIPUSA szint
                        case 1 
                                preProcessedSpectra=incoming_spectra_preparation(x,bl_flag,norm_flag, OS_bl_flag, handles.OS_baseline_points); 
                        case 2 
                                preProcessedSpectra=incoming_spectra_preparation(x,bl_flag,norm_flag, OS_bl_flag, handles.OS_baseline_points);
                                %Henrik: itt lehet h kell forgatni a spetrumot, hogy megtudja enni a PLS model
                                preProcessedSpectra=rot90(preProcessedSpectra,1);
                        otherwise
                            msgbox('Ismeretlen értékelési módot adott meg');

                    end
                otherwise
                    msgbox('Ismeretlen adat azonosító érkezett a socketen');
            end     

         %-------------------------------------------------------------------------------------------------------
         %   4.Értékelés (Értékelés típusûtól)     

            switch get(handles.popupmenu2,'Value')
                case 1
                    ered=CLS_ertekeles(preparated_references,preProcessedSpectra);
                case 2
                    temp1=pls(preProcessedSpectra,handles.actPLSModel);
                    ered=cell2mat(temp1.pred);
                    ered=rot90(ered,3); 
                otherwise
                    msgbox('Kaka van a levesben')
            end


        %-------------------------------------------------------------------------------------------------------
        %   5.Eredmények utólagos feldolgozása (Értékelés típusûtól és beérkezõ adat azonosítájól IS függ  

            switch rawData(1)  %ADAT AZONOSÍTÓ szint
                case 1
                    switch get(handles.popupmenu2,'Value') %ÉRTÉKELÉS TIPUSA szint
                        case 1
                            if (sum_conc100) ered=NomalizationToSum1(ered); end
                        case 2
                            if (sum_conc100) ered=NomalizationToSum1(ered); end
                        otherwise
                            msgbox('Ismeretlen értékelési mód lett kiválasztva!!négy!!4!');
                    end
                otherwise
                    msgbox('Ismeretlen adat azonosító érkezett a socketen');
            end    

        %-------------------------------------------------------------------------------------------------------        
        %   6.Eredmények kiküldáse (???)        (Beérkezõ adat azonosítójál  függ)

            switch rawData(1)  %ADAT AZONOSÍTÓ szint
                case 1
                    switch get(handles.popupmenu2,'Value') %ÉRTÉKELÉS TIPUSA szint
                        case 1
                            ered_str=Convert_concentration_results_to_str(ered);
                            fwrite(handles.tcpipClient, ered_str, 'char');                           
                        case 2
                            ered_str=Convert_concentration_results_to_str(ered);
                            fwrite(handles.tcpipClient, ered_str, 'char');   
                        otherwise
                            msgbox('Ismeretlen értékelési mód lett kiválasztva!!4!');
                    end
                otherwise
                    msgbox('Ismeretlen adat azonosító érkezett a socketen');
            end            




            %eredmények kiíratása a kliensen
            for ii=1:size(ered,1)
                handles.CD{ii,2}=num2str(ered(ii));
            end

            set(handles.uitable1,'Data',handles.CD);
            drawnow;
        end    
        
    end
        
        
    guidata(hObject, handles);
end    
    
   
    
% hObject    handle to Count_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in End_count.
function End_count_Callback(hObject, eventdata, handles)
% hObject    handle to End_count (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on Count_button and none of its con
% hObject    handle to Count_button (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
end

% --- Executes on button press in normalization_checkbox.
function normalization_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to normalization_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of normalization_checkbox
end

% --- Executes on button press in baseline_correction_checkbox.
function baseline_correction_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to baseline_correction_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    if get(handles.baseline_correction_checkbox,'Value')
         set(handles.base_line_points_panel,'Visible','off');
         set(handles.OS_baseline,'Value',0);
    end     
    
    guidata(hObject, handles); 

% Hint: get(hObject,'Value') returns toggle state of baseline_correction_checkbox
end

% --- Executes on button press itextn sum_concentrations_checkbox.
function sum_concentrations_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to sum_concentrations_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sum_concentrations_checkbox
end

% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    if get(handles.popupmenu2,'Value')==1    
        set(handles.PLS_panel,'Visible','off');
        set(handles.uipanel1,'Visible','on');
    elseif get(handles.popupmenu2,'Value')==2
        set(handles.PLS_panel,'Visible','on');
        set(handles.uipanel1,'Visible','off');
    else
    end    

    guidata(hObject, handles);



% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2
end

% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end


function size_of_window_edit_Callback(hObject, eventdata, handles)
% hObject    handle to size_of_window_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of size_of_window_edit as text
%        str2double(get(hObject,'String')) returns contents of size_of_window_edit as a double
end

% --- Executes during object creation, after setting all properties.
function size_of_window_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to size_of_window_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end

% --- Executes on button press in spike_filter_CB_twoSpetras.
function spike_filter_CB_twoSpetras_Callback(hObject, eventdata, handles)
    if get(handles.spike_filter_CB_twoSpetras,'Value')
        set(handles.caughtSpikePanel,'Visible','on');
        set(handles.spikeFilterCB_onespetra,'Value', false);
    else     
        if (get(handles.spike_filter_CB_twoSpetras,'Value') || get(handles.spikeFilterCB_onespetra,'Value'))
            set(handles.caughtSpikePanel,'Visible','on');
        else
            set(handles.caughtSpikePanel,'Visible','off');            
        end 
    end     
    
    guidata(hObject, handles); 

% hObject    handle to spike_filter_CB_twoSpetras (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of spike_filter_CB_twoSpetras
end

% --- Executes on button press in OC_baseline_load.
function OC_baseline_load_Callback(hObject, eventdata, handles)
% hObject    handle to OC_baseline_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%[filename, pathname, filterindex] = uigetfile( ...
%       {'*.txt','txt-files (*.txt)'; ...
%        '*.mdl','Models (*.mdl)'; ...
%        '*.*',  'All Files (*.*)'}, ...
%        'Pick a file', ...
%        'MultiSelect', 'on');

    [filename, pathname, filterindex] = uigetfile( ...
    {  '*.txt','Text dokumentum (*.txt)'; ...
       '*.*',  'All Files (*.*)'}, ...
       'Pick a file', ...
       'MultiSelect', 'off');

      msgbox(strcat(pathname,filename));    

      if exist('filename')
         handles.OS_baseline_points=importdata(strcat(pathname,filename));
         s=strcat('A(z) ',filename,' be van töltve!!!');
         set(handles.textbox_of_loaded_OS_baseline_points,'String', s);
      end
      
    guidata(hObject, handles);
 % Hint: get(hObject,'Value') returns toggle state of OC_baseline_load
end

% --- Executes on button press in OS_baseline.
function OS_baseline_Callback(hObject, eventdata, handles)
% hObject    handle to OS_baseline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    if get(handles.OS_baseline,'Value')
         set(handles.base_line_points_panel,'Visible','on');
         set(handles.baseline_correction_checkbox,'Value',0);
    else
         set(handles.base_line_points_panel,'Visible','off');
    end     
% Hint: get(hObject,'Value') returns toggle state of OS_baseline
    guidata(hObject, handles);
end

% --- Executes on button press in Load_PLS_model_pushbutton.
function Load_PLS_model_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Load_PLS_model_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


    x=get(handles.listbox_of_PLS_models,'Value');
    a=get(handles.listbox_of_PLS_models,'String');
    %a(x,:)
    fn=pwd;                                     %dictionary name                
    fn=strcat(fn,'\PLS_MODEL_COLLECTION\');     %hozzá adja a referencia mappa elérési útvonalát
    fn=strcat(fn,a(x,:));
    
    %Ez a rész kiszedi az emnetett mat filokból az azokba mentett PLS
    %modelt, úgy van megírva, hogy a mat filban !!CSAK!! a model
    %lehet!!négy!!44
    
    temp1=load(fn,'*'); 
    structFieldName=fieldnames(temp1);
    eval(sprintf('handles.actPLSModel=temp1.%s',structFieldName{1}));
    

    set(handles.which_PLS_model_is_loaded_textbox,'String',a(x,:));

    
    %Itt tölti ki a kezdõ táblázatott értékekkel és kérdõjelekkel   NINCS
    %KÉSZ!!!!!!!
    %******************    
    handles.CD=[];
    %for ii=1:length(handles.NOR)
    for ii=1:4
        handles.CD=[handles.CD ; ['komponens??', {'? %'}]];
    end
    
    set(handles.uitable1,'Data',handles.CD);
    
    
    guidata(hObject, handles);

end




% --- Executes on button press in add_PLS_model_button.
function add_PLS_model_button_Callback(hObject, eventdata, handles)
% hObject    handle to add_PLS_model_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    [filename, pathname] = uigetfile( ...
           {'*.mat'}, ...
            'Pick a file', ...
            'MultiSelect', 'off');
 
     sourcePath=strcat(pathname,filename);

     destinationPath=pwd;
     destinationPath=strcat(destinationPath,'\');
     destinationPath=strcat(destinationPath,'PLS_MODEL_COLLECTION\');
     destinationPath=strcat(destinationPath,filename);
 
     copyfile(sourcePath,destinationPath);

     LoadAListBoxFromARelativFolder('PLS_MODEL_COLLECTION',handles.listbox_of_PLS_models);

    guidata(hObject, handles);
end 
 
 




% --- Executes on button press in DeletePLSModelPushButton.
function DeletePLSModelPushButton_Callback(hObject, eventdata, handles)
% hObject    handle to DeletePLSModelPushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    actRow=get(handles.listbox_of_PLS_models,'Value');
    listOfFileNames=get(handles.listbox_of_PLS_models,'String');      
    filename=listOfFileNames(actRow,:)
    filename=strrep(filename,' ','');
    
    path=pwd;
    path=strcat(path,'\');
    path=strcat(path,'PLS_MODEL_COLLECTION\');
    path=strcat(path,filename);
    
    delete(path);
       
    LoadAListBoxFromARelativFolder('PLS_MODEL_COLLECTION', handles.listbox_of_PLS_models)

    guidata(hObject, handles);

end

% --- Executes on selection change in listbox_of_PLS_models.
function listbox_of_PLS_models_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_of_PLS_models (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_of_PLS_models contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_of_PLS_models
end

% --- Executes during object creation, after setting all properties.
function listbox_of_PLS_models_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_of_PLS_models (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

end



function LoadAListBoxFromARelativFolder(folderName, listBox)
    %Ha megadsz egy listBoxot a guide-ból és egy mappa relatv elérési
    %útvonalát a kliens_main-hez képest, akkor abból a mappából a függvény kilistázza a filok listáját... 
    
    path=pwd;
    path=strcat(path,'\');
    path=strcat(path,folderName);
    path=strcat(path,'\');
    
    a=ls(path);
    a(1,:)='';                                  
    a(1,:)='';
    
    set(listBox,'String',a);
    set(listBox,'Value',[]);
    set(listBox,'Max',2);

end


function addOne(textBox)
    szoveg=get(textBox,'String');
    szam=str2double(szoveg);
    szam=szam+1.0;
    szoveg=num2str(szam);
    set(textBox,'String',szoveg);
end


% --- Executes during object creation, after setting all properties.
function numberOfDetectedSpikes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numberOfDetectedSpikes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
end


% --- Executes on button press in spikeFilterCB_onespetra.
function spikeFilterCB_onespetra_Callback(hObject, eventdata, handles)
% hObject    handle to spikeFilterCB_onespetra (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    if (get(handles.spikeFilterCB_onespetra,'Value'))
        set(handles.spike_filter_CB_twoSpetras,'Value', false);
        set(handles.caughtSpikePanel,'Visible','on'); 
    else
        if (get(handles.spike_filter_CB_twoSpetras,'Value') || get(handles.spikeFilterCB_onespetra,'Value'));
            set(handles.caughtSpikePanel,'Visible','on');
        else
            set(handles.caughtSpikePanel,'Visible','off');            
        end         
    end    
    guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of spikeFilterCB_onespetra
end



function despersionTextBox_Callback(hObject, eventdata, handles)
% hObject    handle to despersionTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of despersionTextBox as text
%        str2double(get(hObject,'String')) returns contents of despersionTextBox as a double
end


% --- Executes during object creation, after setting all properties.
function despersionTextBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to despersionTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    beep
end


% --- Executes on button press in checkbox_simulation.
function checkbox_simulation_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_simulation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    if (get(handles.checkbox_simulation, 'Value'))
        set(handles.edit1,'String','localhost');
        set(handles.edit2,'String','4012');
        echotcpip('on',4012);
        set(handles.simulation_folder_path,'Enable','on');
        set(handles.simulation_browse,'Enable','on');
    else
        echotcpip('off')
        set(handles.simulation_folder_path,'Enable','off');
        set(handles.simulation_browse,'Enable','off');      
    end



    
    guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of checkbox_simulation
end


% --- Executes on button press in simulation_browse.
function simulation_browse_Callback(hObject, eventdata, handles)
% hObject    handle to simulation_browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    folder_name = uigetdir;
    set(handles.simulation_folder_path,'String',folder_name);
end
