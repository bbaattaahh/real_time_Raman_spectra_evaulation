function [ conc, err ] = Into_BigCase_Moving_CLS_valuation( s, ref, window, baseline_flag, normalization_fleg, spike_filtering_flag )
%Feladat: A Ramanb�l j�v� r�vid felv�teli idej� spektrumokb�l eld�nti, hogy
%       mennyit kell �sszeadni ahhoz, hogy CLSsel j�l ki�rt�klehet�
%       adatokat kapjon. Ezt �gy teszi meg, hogy a m�trix utols� oszlop�tol
%       vissza fele �ssze adogatja a spektrumokat, CLS-t sz�mol, illetve a
%       CLS-nek a hib�j�t. A vissza fele szumm�zgat�st addig ism�teli am�gy 
%       egy megadott relat�v hib�n�l kisebb �rt�ket nem tapasztal.


%V�ltoz�k:  s:az eddig be�rkezett spektrumok m�trixa
%           ref:referencia spektrumok m�trixa
%           conc:meg�llap�tott CLS koncentr�ci� �rt�kek
%           rel_err:meg�ll�p�tott relat�v hiba
%           us: ~used_spectras h�ny spektrumot �rt�kelt ki ahhoz, hogy j� legyen a CLS            
%           c1,c2:
%           e1,e2:
%           rel_c,rel_e:Relativ Error Local concentration/error

%           WARNING:Ha csak 1db oszlop van a azaz 1db spektrum van m�g csak
%           be�rkezve akkor bekak�l!!!

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

