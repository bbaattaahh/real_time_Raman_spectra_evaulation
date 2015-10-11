function [] = send_all_spectradata_to_TCP_IP(opened_tcpip, path_of_simulation_folder)

    if nargin == 1
        path_of_simulation_folder = 'H_13';
    end
    
    names = dir(path_of_simulation_folder);

    
    function [message_serverside] = make_message(message_id, message)
        message_serverside = num2str(rot90(message));
        message_len_serverside = num2str(length(message_serverside));

        message_len = strcat('0000000000000000', message_len_serverside);
        message_len = message_len((length(message_len)-16+1) : length(message_len));

        message_serverside = strcat(message_id, message_len, message_serverside);

    end    


    for i = 3 : length(names)
         act_spectra_data = importdata(strcat('H_13\', names(i).name));
         wavenumber_values = act_spectra_data(:, 1);
         intensity_values = act_spectra_data(:, 2);
         
         wavenumber_message = make_message('WAVE', wavenumber_values);   
         intensity_message = make_message('INTE', intensity_values);   
         
         fwrite(opened_tcpip, wavenumber_message);
         fwrite(opened_tcpip, intensity_message);
    end

    
    end_message = 'ENDE0000000000000003end';
    fwrite(opened_tcpip, end_message);
    
end


