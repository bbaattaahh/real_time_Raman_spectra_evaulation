function [alapvonalkorr_spektrumok, z]= asysm_adatmatrixra(spektrumok, lambda, p, d)

alapvonalkorr_spektrumok=zeros(size(spektrumok));
d1 = size(spektrumok,1);
d2 = size(spektrumok,2);

for sor=1:d1
    y0 = spektrumok(sor,:)';
    z = asysm(y0, lambda, p, d);
    y = y0 - z;
    alapvonalkorr_spektrumok (sor,1:d2)= y';
end;

end