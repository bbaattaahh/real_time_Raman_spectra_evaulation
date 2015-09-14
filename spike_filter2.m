function [ filteredSpectra, flag ] = spike_filter2( s, szoras )
%SPIKE_FILTER Summary of this function goes here
%   Detailed explanation goes here
%
%   PROGRAM LEÍRÁS: 
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
        title('Az elsõ rögzatett spektrum !!!Ha spikot tapasztal benne akkor kezdje elõrõl a spektrumok valós idejû értékelését!!!');
    end
    
    filteredSpectra=s(:,1);
end