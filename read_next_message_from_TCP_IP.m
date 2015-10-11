function [message_id, message] = read_next_message_from_TCP_IP(opened_tcpip)
    % Megkapja a nyitott portot, milyen módban van 
    if  strcmp(opened_tcpip.RemoteHost, 'localhost')
        
        message_id = fread(opened_tcpip, 4);
        message_id = char(rot90(message_id));

        message_len = fread(opened_tcpip, 16);
        message_len = str2double(char(rot90(message_len)));

        message = fread(opened_tcpip, message_len);
        message = char(rot90(message));
        % TODO Here there will be a function which decode the message by
        % id... Now it is enought because the same kind of messege is the
        % intansity and wavenumber data
        message = str2num(message);
        message = rot90(message, -1);
        
    else
        
        rawData = fread(opened_tcpip,2,'int32');  
        rawData=VBLong_32bit_to_ML_int32_64bit_socket(rawData);
        x=0;


        switch rawData(1)
            case 1
                x=fread(opened_tcpip,rawData(2),'int32');
                x=VBLong_32bit_to_ML_int32_64bit_socket(x);
            otherwise
                msgbox('Ismeretlen adat azonosító érkezett a socketen');
        end
        
        message_id = 1;
        message = x;
    end
    
end