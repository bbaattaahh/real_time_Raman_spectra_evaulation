function [ki] = VBLong_32bit_to_ML_int32_64bit_socket( x )
%VBLONG_32BIT_TO_ML_INT32_64BIT_SOCKET Summary of this function goes here
%   Detailed explanation goes here
 ki=0+bitshift(bitshift(x,32),-56);
 ki=ki+bitshift(bitshift(bitshift(bitshift(x,-16),16),40),-48);
 ki=ki+bitshift(bitshift(bitshift(bitshift(x,-8),8),48),-40);
 ki=ki+bitshift(bitshift(bitshift(bitshift(x,-0),0),56),-32);
 ki=bitshift(ki,-8);
end

