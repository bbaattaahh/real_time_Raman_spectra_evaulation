%Start a TCP/IP echo server and create a TCPIP object.

echotcpip('on',4012)
t = tcpip('localhost',4012);

t.OutputBufferSize = 2000000;
t.InputBufferSize = 2000000;

%Connect the TCPIP object to the host.

fopen(t)

%SERVER SIDE
message_id_serverside = 'SPEC'
message_serverside = 'kokain'
message_len_serverside = num2str(length(message_serverside))

message_len = strcat('0000000000000000', message_len_serverside)
message_len = message_len((length(message_len)-16+1) : length(message_len));


message_serverside = strcat(message_id_serverside, message_len, message_serverside);


fwrite(t,message_serverside);

% CLIENS SIDE
message_id = fread(t, 4);
message_id = rot90(message_id);

message_len = fread(t, 16);
message_len = str2double(char(rot90(message_len)));

message = fread(t, message_len);

message = char(rot90(message))

%Disconnect the TCPIP object from the host and stop the echo server.

fclose(t)
echotcpip('off')