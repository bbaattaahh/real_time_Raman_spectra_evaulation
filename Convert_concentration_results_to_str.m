function [ s ] = Convert_concentration_results_to_str( e )
%SEND_CONCENTRATION_RESULTS Summary of this function goes here
%   Detailed explanation goes here
%   
%   VARIABLES:  s:krea�lt �zenet a szervernek;
%               e:eredm�nyek vektora;
%   
%   Le�r�s: -A kisz�m�tott koncentr�ci� �rt�keket alak�tja k�ldhet� string
%           form�ra.
%           -az �zenet �ltal�nos alakja: adat k�dja (2)@adat db
%           sz�ma@adat1@adat2...
%           -az utols� adat ut�n nincs @ karakter (if)
%           -a kij�tt eredm�nyek itt vannak megszorozva 100-al, hogy %
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

