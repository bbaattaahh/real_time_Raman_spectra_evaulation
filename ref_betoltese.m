%majd lehet h meg�rn� be�p�teni egy hsz ellen�rz� funkct valahova....

function [ ref_nev, hsz, int ] = ref_betoltese(opened_file )   %ref_nev referenci�k nevei
%REF_BETOLTESE Summary of this function goes here
%   Detailed explanation goes here
    fileID = fopen(opened_file,'r');
        s=str2double(fgetl(fileID));      %sorok sz�ma
        o=str2double(fgetl(fileID));      %oszlopok sz�ma
        fn=fgetl(fileID);              %v�ltoz� nevek
    


        hsz=zeros(s,1);
        int=zeros(s,(o/2));
        
        
        %itt szedi ki a hull�msz�m �rt�keket
        
        for ii=1:s                      
            hsz(ii)=str2double(fgetl(fileID));
        end
    
        
        
        %itt szedi ki az intenzit�s �rt�keket, a feles hull�msz�mokat
        %eldobja
        
        for jj=2:o
            for ii=1:s
                if mod(jj,2)==0 
                    int(ii,jj/2)=str2double(fgetl(fileID));
                else
                    fgetl(fileID);
                end    
            end
        end
        
        
        %itt t�rdeli el a file neveket, �s leszedi r�luk a kiterjeszt�st
        
        remain=fn;
        
        for k = 1:o/2
            [token, remain] = strtok(remain);
            a{k}=token;
        end
        
        
    fclose(fileID);
    

    ref_nev=a;

end

