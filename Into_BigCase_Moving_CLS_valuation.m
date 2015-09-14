function [ conc, err ] = Into_BigCase_Moving_CLS_valuation( s, ref, window, baseline_flag, normalization_fleg, spike_filtering_flag )
%Feladat: A Ramanbõl jövö rövid felvételi idejû spektrumokból eldönti, hogy
%       mennyit kell összeadni ahhoz, hogy CLSsel jól kiértéklehetõ
%       adatokat kapjon. Ezt õgy teszi meg, hogy a mátrix utolsó oszlopátol
%       vissza fele össze adogatja a spektrumokat, CLS-t számol, illetve a
%       CLS-nek a hibáját. A vissza fele szummázgatást addig ismételi amígy 
%       egy megadott relatív hibánál kisebb értéket nem tapasztal.


%Változók:  s:az eddig beérkezett spektrumok mátrixa
%           ref:referencia spektrumok mátrixa
%           conc:megállapított CLS koncentráció értékek
%           rel_err:megállípított relatív hiba
%           us: ~used_spectras hány spektrumot értékelt ki ahhoz, hogy jó legyen a CLS            
%           c1,c2:
%           e1,e2:
%           rel_c,rel_e:Relativ Error Local concentration/error

%           WARNING:Ha csak 1db oszlop van a azaz 1db spektrum van még csak
%           beérkezve akkor bekakál!!!

    b=zeros(length(s(:,1)),1);
    
    ref=references_spectras_preparation(ref,baseline_flag,normalization_fleg);
   
    for ii=length(s(1,:)):-1:length(s(1,:))-window+1
        b=b+s(:,ii);
    end    

    b=incoming_spectra_preparation( b, baseline_flag, normalization_fleg);
    if spike_filtering_flag
        b=spike_filter(b);
    end    
    [conc,err]=CLS_ertekeles(ref,b);

    

    %figure(98);
    %plot(CONC);
    %figure(66);
    %plot(gradient(CONC));
end

