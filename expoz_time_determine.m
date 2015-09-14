function [ CONC, ERR ] = expoz_time_determine( S, REF, max_window )
%EXPOY_TIME_DETERMINE Summary of this function goes here


%FELADAT:




%V�LTOZ�K:  S:r�vid idej� spektrumok m�trixa
%           REF:referencia spektrumok
%           max_window:legn�gzobb id�ablak amire n�zz�k
%           CONC:sy�m�tott koncentr�ci�k az egyes komponensekre. 3D matrix
%           ERR:sz�m�tott errorok m�trixa ay egyes esetekben
%           A: seg�d v�ltoy� ebben vannak t�rolva az �ppen aktu�lis �sszeszumm�zott �rt�kek  


%PREALLOK�CI�K
    CONC=zeros(length(S(1,:)),max_window,length(REF(1,:)));
    ERR=zeros(length(S(1,:)),max_window);
    
    
%REFERENCIA SPEKTRUMOK EL�K�SZ�T�SE
    REF=references_spectras_preparation( REF, 1, 1);

    
    for i1=max_window:-1:1              %ez a szint a windiw nagzs�gokon megy v�gig
        for i2=length(S(1,:)):-1:i1     %Ez a szint az id�n megy v�gig azaz ay S oszlopain
            A=zeros(length(REF(:,1)),1);
            for i3=i2:-1:i2-i1+1          %Ez a sor szumm�zza �ssza a sz�ks�ges oszlopokat
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

