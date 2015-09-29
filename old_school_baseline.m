function [ bl ] = old_school_baseline( s , bl_points)
%   DESCRIPTION:R�gi t�pus� "Labszpekes" alapvonal korrekci�k
%               v�grehajt�s�hoz, �rodott ez az ALAPVONALAT visszaad� f�ggv�ny.
%               A felhaszn�l� megad egy jelsorozaot, OSZLOPVEKTOROSAN valamint egy 0 �s 1-esekb�l �ll� hasonl� hosszs�g�
%               OSZLOPVEKTORT. Ahol az oszlopvektorban 1-es van az eredeti jelsorozat azon pontjai k�z�tt interpol�l.�gy egy alapvonalat ad vissza
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

