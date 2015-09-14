function [s] = normalization( s, m )
%NARMALIZATION Summary of this function goes here
%   A spektrumok különbözõ fajta normalizálását lehetõvé tevõ fg.
%   s:spektrum adatsora
%   m: normalizálás különbözõ módjai
%       1: A spektrum alatti terület 1


    if m==1 
        p=s;
        s=s./sum(p);
    end

    %sum(s)
end

