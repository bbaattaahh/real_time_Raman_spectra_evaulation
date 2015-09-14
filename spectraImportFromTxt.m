function [ spectraData , waveNums] = spectraImportFromTxt()

% This function was created by Henrik Bata, because he had enough from hard
% data exporting from txt spectra files. //2015.03.24.
%
%Useage: when you run it a select window pick up. You can choose the your
%        spetras in this window (multiple choose) and this file will process it.
%        The function remove the wavenumers, and organize your selected spetras 
%        into one output matrix (spectraData). One cloumn one spectra.
%        The funcion organize your spectras by its creation date, the oldest be on the first cloumn   
%
%
%This program has written for spetras which are from Labspes and seved in
%txt extension
%
%INPUTS: No any input
%
%OUTPUT:    spectraData: your selected spectras
%           waveNums: the wavenumbers of the oldest spectra which was
%                     selected
%
%

    [filename, pathname, filterindex] = uigetfile( ...
    {  '*.txt','text files (*.txt)'; ...
       '*.slx;*.mdl','Models (*.slx, *.mdl)'; ...
       '*.*',  'All Files (*.*)'}, ...
       'Pick a file', ...
       'MultiSelect', 'on');


    h = waitbar(0,'Please wait...');
    
    
    dataAboutFiles={};
    date1970s=[];
    spectraData=[];

    %ezt le kell kezelniclass(filename(1))

    for i=1:length(filename)
        dataAboutFiles{i}=dir(cell2str(strcat(pathname,filename(i))));       
        date1970s(i)=dataAboutFiles{i}.datenum;
    end   


    
    steps = length(filename);
    
    
    for i=1:length(filename)

        [actMin, actInd] = min(date1970s);
        date1970s(actInd)=Inf;
        actFileName=dataAboutFiles{actInd}.name;
        actSpectra=importdata(strcat(pathname,actFileName));
            if (i==1)
                waveNums=actSpectra(:,1);
            end
        actSpectra(:,1)=[];
        spectraData=[spectraData,actSpectra];
        waitbar(i / steps);
    end 
    
    close(h)

end