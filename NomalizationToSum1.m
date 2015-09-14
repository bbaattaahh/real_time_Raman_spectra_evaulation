function [ v ] = NomalizationToSum1( v )
%NOMALIZATIONTO100PERCENT Summary of this function goes here
%   DESCRIPTION:
%       A megkapott vektorból kiszûri a negatív értékeket, majd az egészet 1-re normálja
%
%   VARIABLES
%       INPUT:  v   vector
%       OUTPUT: v  1 összegûre normált vektor

    
    for ii=1:length(v)
        if v(ii)<0
           v(ii)=0;
        end   
    end
        
    if (sum(v)~=0)              %Azért kell check-olni, hoyg moving-nál ne haljon el a 0 osztónál
        v=v./sum(v);
    end
end

