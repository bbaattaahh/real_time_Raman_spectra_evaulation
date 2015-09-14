function [ s ] = references_spectras_preparation( s, b, n , OSb, OSbp)
%REFERENCES_SPECTRAS_PREPARATION Summary of this function goes here
%   s:spektrum adatsora
%   b: kell e baseline flag
%   n: kell e normalizálni flag
%   OSb:kell e old school alapvonal korrigálni
%   OSbp:old school alapvonal korrigáláshoz kellõ pontok

    for ii=1:length(s(1,:))
        %Bejövõ spektrum alapvonal korrekciója
        if b
           A=asysm(s(:,ii),1000,0.001,2);
           s(:,ii)=s(:,ii)-A;
        end    
        
        if OSb
           A=old_school_baseline(s(:,ii),OSbp);
           s(:,ii)=s(:,ii)-A;
        end   
        
        
        %Bejövõ spektrum normalizálása, görbe alatti terület 1
        if n
           s(:,ii)=normalization(s(:,ii),1); 
        end
        
 
    end   
end

