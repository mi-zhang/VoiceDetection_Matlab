


%load all the wav files from wav audio files
% data_dir = '../raw_audio_data/labeledData_selected/';
data_dir = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected\';

file_list = dir([data_dir '*.wav']);


for i = 1:length(file_list)
    
    %
    file_name = [data_dir file_list(i).name];
    
    
    %
    fprintf('%s\n',file_name);
    wav_data = wavread(file_name,'native');
    csvwrite([file_name(1:end-4) '_android.csv'],wav_data);
    
    
end