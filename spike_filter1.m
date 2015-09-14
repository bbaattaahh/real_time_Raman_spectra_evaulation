function [ s, flag ] = spike_filter1( s, szoras )
%SPIKE_FILTER Summary of this function goes here
%   Detailed explanation goes here
%
%   PROGRAM LEÍRÁS: Egy bejövõ spektrumból kikeresi a spike-okat, azokat
%                   leradítozza. 
%                   1. eset:Ha nem az esõ hullámhosszon jön a spike
%                           akkor a detektált spike-ot a az elúzú hullámhossz intenzitásértékével helyettesíti.
%                   2. eset:Ha az elsõ hullámszám is már az akkor megkeresi
%                           az elõs olyan intenzitást ami nem az és vissza felé
%                           mindegyik érték megkapja azt az értéket
%
%
%   INPUT:  s:spektrum
%           szórás:megadja hogy hény szórásnyi távolságban fogadja el a nuemrikus 
%           
%
%   OUTPUT: s:spektrum spiktalanítva
%           flag:volt-e spike detektálás
%
%   INNER VARIABLES    x:numerikus deriváltja a s-nek    
%                       

    if nargin==1 
        szoras=6;
    end    

    flag=false;
    x=diff(s);
    limit=mean(x)+szoras*std(x);    
    f=0;
    
    %Ha az elsõ mért hullámhosszaon jelentkezne a spike
    while (abs(x(f+1))>limit)
        f=f+1;
        flag=true;
    end    
    
    
    for ii=1:f
        s(ii)=s(f+1);
    end    
    
    
    for ii=1:length(x)-1
        if (abs(x(ii))>limit)
            s(ii+1)=s(ii);
            x=diff(s);
            flag=true;
        end    
    end    
end