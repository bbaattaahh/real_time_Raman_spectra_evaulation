function [ v ] = NomalizationToSum1( v )
%NOMALIZATIONTO100PERCENT Summary of this function goes here
%   DESCRIPTION:
%       A megkapott vektorb�l kisz�ri a negat�v �rt�keket, majd az eg�szet 1-re norm�lja
%
%   VARIABLES
%       INPUT:  v   vector
%       OUTPUT: v  1 �sszeg�re norm�lt vektor

    
    for ii=1:length(v)
        if v(ii)<0
           v(ii)=0;
        end   
    end
        
    if (sum(v)~=0)              %Az�rt kell check-olni, hoyg moving-n�l ne haljon el a 0 oszt�n�l
        v=v./sum(v);
    end
end

