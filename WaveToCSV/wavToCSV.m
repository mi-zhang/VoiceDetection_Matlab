

file_name = '1398719349_358239057380463.wav';
fprintf('%s\n',file_name);
wav_data = wavread(file_name, 'native');
csvwrite([file_name(1:end-4) '_android.csv'], wav_data);
    
disp('I am done');
