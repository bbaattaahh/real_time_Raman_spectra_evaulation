function [ s ] = Convert_concentration_results_to_str( e )
%SEND_CONCENTRATION_RESULTS Summary of this function goes here
%   Detailed explanation goes here
%   
%   VARIABLES:  s:kreaált üzenet a szervernek;
%               e:eredmények vektora;
%   
%   Leírás: -A kiszámított koncentráció értékeket alakítja küldhetõ string
%           formára.
%           -az üzenet általános alakja: adat kódja (2)@adat db
%           száma@adat1@adat2...
%           -az utolsó adat után nincs @ karakter (if)
%           -a kijött eredmények itt vannak megszorozva 100-al, hogy %
%           legyen



        s='2@';
        s=strcat(s,num2str(length(e)));
        s=strcat(s,'@');
        
        for ii=1:length(e)
           s=strcat(s,num2str(e(ii)));
           if ii~=length(e)
               s=strcat(s,'@');
           end    
        end

end

