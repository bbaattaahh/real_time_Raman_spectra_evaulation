function [ cs, sh ] = SpectraFlowHandler( s, w, sh )
%SPECTRAFLOWHANDLER Summary of this function goes here
%   DESCRIPTION:
%
%
%   INPUT:  s:spectra
%           w:size of the window
%           sh:spectra history
%
%   OUTPUT: cs:comolulated spectra
%           sh:spectra history
% 

    sh=[s,sh];

    if (size(sh,2)<w)
        cs=sum(sh, 2)/size(sh,2);
    elseif (size(sh,2)==w)
        cs=sum(sh, 2)/w;
    else    
        s_in_w = sh(: , 1:w);
        cs=sum(s_in_w,2)/w;
    end
    
    
end

