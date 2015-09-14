function [ s, flag ] = spike_filter1( s, szoras )
%SPIKE_FILTER Summary of this function goes here
%   Detailed explanation goes here
%
%   PROGRAM LE�R�S: Egy bej�v� spektrumb�l kikeresi a spike-okat, azokat
%                   lerad�tozza. 
%                   1. eset:Ha nem az es� hull�mhosszon j�n a spike
%                           akkor a detekt�lt spike-ot a az el�z� hull�mhossz intenzit�s�rt�k�vel helyettes�ti.
%                   2. eset:Ha az els� hull�msz�m is m�r az akkor megkeresi
%                           az el�s olyan intenzit�st ami nem az �s vissza fel�
%                           mindegyik �rt�k megkapja azt az �rt�ket
%
%
%   INPUT:  s:spektrum
%           sz�r�s:megadja hogy h�ny sz�r�snyi t�vols�gban fogadja el a nuemrikus 
%           
%
%   OUTPUT: s:spektrum spiktalan�tva
%           flag:volt-e spike detekt�l�s
%
%   INNER VARIABLES    x:numerikus deriv�ltja a s-nek    
%                       

    if nargin==1 
        szoras=6;
    end    

    flag=false;
    x=diff(s);
    limit=mean(x)+szoras*std(x);    
    f=0;
    
    %Ha az els� m�rt hull�mhosszaon jelentkezne a spike
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