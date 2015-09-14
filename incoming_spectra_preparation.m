function [s] = incoming_spectra_preparation( s, b, n, OSb, OSbp )
%   s:spektrum adatsora
%   b: kell e baseline flag
%   n: kell e normalizálni fleg
%   OSb:kell e old school alapvonal korrigálni flag
%   OSbp:old school alapvonal korrigáláshoz kellõ pontok


        %Bejövõ spektrum alapvonal korrekciója
        if b
           A=asysm(s,1000,0.001,2);
           s=s-A;
        end    
        
        if OSb
           A=old_school_baseline(s,OSbp);
           s=s-A;
        end          
        
        %Bejövõ spektrum normalizálása, görbe alatti terület 1
        if n
           s=normalization(s,1); 
        end    
end        