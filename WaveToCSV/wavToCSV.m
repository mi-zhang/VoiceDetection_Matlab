
% wavToCSV.m translates .wav file into .csv file.
% NOTE: .wav is the original sound file. .csv is the file will be imported
% into the mobile phone to calculate the features.
% @author: Mi Zhang

file_name = 'walk_t3.wav';
fprintf('%s\n',file_name);
wav_data = wavread(file_name, 'native');
csvwrite([file_name(1:end-4) '_android.csv'], wav_data);
    
disp('I am done');
