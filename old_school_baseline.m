function [ bl ] = old_school_baseline( s , bl_points)
%   DESCRIPTION:Régi típusó "Labszpekes" alapvonal korrekciók
%               végrehajtásához, írodott ez az ALAPVONALAT visszaadó függvény.
%               A felhasználó megad egy jelsorozaot, OSZLOPVEKTOROSAN valamint egy 0 és 1-esekbõl álló hasonló hosszságú
%               OSZLOPVEKTORT. Ahol az oszlopvektorban 1-es van az eredeti jelsorozat azon pontjai között interpolál.Így egy alapvonalat ad vissza
%
%   Detailed explanation goes here
%
%   INPUTS: s:signal
%           bl_points:
%
%   OUTPUTS:bl:alapvonal OSZLOPVEKTORA
%

%    hold on;
%    plot(s);
%    ss=s;
    
    s=s+10000;
    s=s.*bl_points;
    X=1:length(s);
    X=rot90(fliplr(X));
    
    [A]=find(bl_points);
    y=zeros(length(A),1);
    
    
    for i=1:length(A)
        y(i)=s(A(i));
    end
    
    
    bl = interp1(A,y,X);
    bl=bl-10000;
    
%    plot(bl);
%    plot(ss-bl,'-r');
%    hold off;
%    shg;
    
end

