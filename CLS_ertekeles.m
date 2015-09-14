function [ conc , err] = CLS_ertekeles(ref, akt )   %conc koncentr�ci� �rt�kek; ref: referencia spektrum m�trixa; akt: aktu�lis spektrum
   conc=ref\akt;
   err=sum((ref*conc-akt).^2);
end