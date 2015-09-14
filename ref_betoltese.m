%majd lehet h megérné beépíteni egy hsz ellenörzõ funkct valahova....

function [ ref_nev, hsz, int ] = ref_betoltese(opened_file )   %ref_nev referenciák nevei
%REF_BETOLTESE Summary of this function goes here
%   Detailed explanation goes here
    fileID = fopen(opened_file,'r');
        s=str2double(fgetl(fileID));      %sorok száma
        o=str2double(fgetl(fileID));      %oszlopok száma
        fn=fgetl(fileID);              %változó nevek
    


        hsz=zeros(s,1);
        int=zeros(s,(o/2));
        
        
        %itt szedi ki a hullámszám értékeket
        
        for ii=1:s                      
            hsz(ii)=str2double(fgetl(fileID));
        end
    
        
        
        %itt szedi ki az intenzitás értékeket, a feles hullámszámokat
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
        
        
        %itt tördeli el a file neveket, és leszedi rõluk a kiterjesztést
        
        remain=fn;
        
        for k = 1:o/2
            [token, remain] = strtok(remain);
            a{k}=token;
        end
        
        
    fclose(fileID);
    

    ref_nev=a;

end

