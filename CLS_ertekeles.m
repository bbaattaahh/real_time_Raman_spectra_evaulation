function [ conc , err] = CLS_ertekeles(ref, akt )   %conc koncentráció értékek; ref: referencia spektrum mátrixa; akt: aktuális spektrum
   conc=ref\akt;
   err=sum((ref*conc-akt).^2);
end