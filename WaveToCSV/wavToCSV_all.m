

% wavToCSV_all.m translates all .wav files in the directory into .csv files.
% NOTE: .wav is the original sound file. .csv is the file will be imported
% into the mobile phone to calculate the features.
% @author: Mi Zhang

data_dir = 'D:\Work\Projects\VoiceDetection\Datasets\Datasets_Nexus5\';
file_list = dir([data_dir '*.wav']);

for i = 1:length(file_list)
    
    file_name = [data_dir file_list(i).name];      
    fprintf('%s\n',file_name);
    wav_data = wavread(file_name,'native');
    csvwrite([file_name(1:end-4) '_android.csv'],wav_data);    
    
end

disp('I am done');
