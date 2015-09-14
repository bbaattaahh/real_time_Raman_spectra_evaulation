function WriteLog()
persistent FID

% Open the file
    FID = fopen('LogFile.txt', 'a+');
    if FID < 0
     error('Cannot open file');
    end
    log=strcat('Spike-ot detektáltam: ',mat2str(clock));
    fprintf(FID, '%s\n',  log);

    fclose(FID);
end