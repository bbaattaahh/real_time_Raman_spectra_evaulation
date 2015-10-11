%TODO : Spike filtering ahve to handled here
% if (spike_filt_flag1)
%     [x,caughtSpikeFlag]=spike_filter1(x,despersion);
%     if (caughtSpikeFlag)
%         addOne(handles.numberOfDetectedSpikes);
%         WriteLog();
%     end    
% end
% 
% if (spike_filt_flag2) 
%     [blank,specrtaHistorySpikeFilter]=SpectraFlowHandler(x,2,specrtaHistorySpikeFilter);
%     [x,caughtSpikeFlag]=spike_filter2(specrtaHistorySpikeFilter,despersion);
%     if (caughtSpikeFlag)
%         addOne(handles.numberOfDetectedSpikes);
%         WriteLog();
%     end    
% end


function [s] = incoming_spectra_preparation( s, b, n, OSb, OSbp )
%   s:spektrum adatsora
%   b: kell e baseline flag
%   n: kell e normaliz�lni fleg
%   OSb:kell e old school alapvonal korrig�lni flag
%   OSbp:old school alapvonal korrig�l�shoz kell� pontok


        %Bej�v� spektrum alapvonal korrekci�ja
        if b
           A=asysm(s,1000,0.001,2);
           s=s-A;
        end    
        
        if OSb
           A=old_school_baseline(s,OSbp);
           s=s-A;
        end          
        
        %Bej�v� spektrum normaliz�l�sa, g�rbe alatti ter�let 1
        if n
           s=normalization(s,1); 
        end    
end        