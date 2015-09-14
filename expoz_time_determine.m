function [ CONC, ERR ] = expoz_time_determine( S, REF, max_window )
%EXPOY_TIME_DETERMINE Summary of this function goes here


%FELADAT:




%VÁLTOZÓK:  S:rövid idejû spektrumok mátrixa
%           REF:referencia spektrumok
%           max_window:legnígzobb idõablak amire nézzük
%           CONC:syámított koncentrációk az egyes komponensekre. 3D matrix
%           ERR:számított errorok mátrixa ay egyes esetekben
%           A: segéd váltoyó ebben vannak tárolva az éppen aktuális összeszummázott értékek  


%PREALLOKÁCIÓK
    CONC=zeros(length(S(1,:)),max_window,length(REF(1,:)));
    ERR=zeros(length(S(1,:)),max_window);
    
    
%REFERENCIA SPEKTRUMOK ELÕKÉSZÍTÉSE
    REF=references_spectras_preparation( REF, 1, 1);

    
    for i1=max_window:-1:1              %ez a szint a windiw nagzságokon megy végig
        for i2=length(S(1,:)):-1:i1     %Ez a szint az idõn megy végig azaz ay S oszlopain
            A=zeros(length(REF(:,1)),1);
            for i3=i2:-1:i2-i1+1          %Ez a sor szummázza össza a szükséges oszlopokat
                A=A+S(:,i3);
            end 
            A=incoming_spectra_preparation( A, 1, 1 );
            [CONC(i2,i1,:),ERR(i2,i1)]=CLS_ertekeles(REF,A);
            for i4=1:length(CONC(1,1,:))
                if CONC(i2,i1,i4)<0
                    CONC(i2,i1,i4)=0;
                end    
            end
            b=sum(CONC(i2,i1,:));
            for i5=1:length(CONC(1,1,:))
                CONC(i2,i1,i5)=CONC(i2,i1,i5)/b;
            end    
        end    
    end    
    
    plot(ERR(:,1));

end

