%Valószínûleg fos, de nem is kell ehhez a projekthez

function [ki] = VBLong_32bit_to_ML_int32_64bit_socket2( x )
%VBLONG_32BIT_TO_ML_INT32_64BIT_SOCKET Summary of this function goes here
%   Detailed explanation goes here
    ki=0;
    for ii=1:8
       b = bitget(x,ii)
       if b==1 
           ki=setbit(ki,ii+24)
       end    
    end
    
    
    for ii=9:16
       b = bitget(x,ii)
       if b==1 
           ki=setbit(ki,ii+16-8)
       end    
    end    
    

    for ii=17:24
        b = bitget(x,ii)
        if b==1 
            ki=setbit(ki,ii+8-16)
        end    
    end    

    for ii=25:32
       b = bitget(x,ii)
       if b==1 
           ki=setbit(ki,ii+16-24)
       end    
    end    

    
   
end


