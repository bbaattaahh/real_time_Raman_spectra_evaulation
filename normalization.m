function [s] = normalization( s, m )
%NARMALIZATION Summary of this function goes here
%   A spektrumok k�l�nb�z� fajta normaliz�l�s�t lehet�v� tev� fg.
%   s:spektrum adatsora
%   m: normaliz�l�s k�l�nb�z� m�djai
%       1: A spektrum alatti ter�let 1


    if m==1 
        p=s;
        s=s./sum(p);
    end

    %sum(s)
end

