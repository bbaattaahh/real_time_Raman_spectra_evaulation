function [ filteredSpectra, flag ] = spike_filter2( s, szoras )
%SPIKE_FILTER Summary of this function goes here
%   Detailed explanation goes here
%
%   PROGRAM LE�R�S: 
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
        szoras=3;
    end
    
    
    if (size(s,2)==2)
        d=s(:,1)-s(:,2);
        plot(d);
        shg;
        flag=false;
        limit=mean(d)+szoras*std(d);    


        for ii=1:length(s(:,1))
            if (abs(d(ii))>limit)
                s(ii,1)=s(ii,2);
                flag=true;
            end    
        end 
    else
        plot(s(:,1));
        title('Az els� r�gzatett spektrum !!!Ha spikot tapasztal benne akkor kezdje el�r�l a spektrumok val�s idej� �rt�kel�s�t!!!');
    end
    
    filteredSpectra=s(:,1);
end