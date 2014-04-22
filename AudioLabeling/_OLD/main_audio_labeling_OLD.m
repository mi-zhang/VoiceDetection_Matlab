% clear;
% clear all;
clc;

% set up dataset path
dataset_path = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected\';
audio_file = 'cafe_t5';
% 1. silence
% audio_file = 'silent_t1';
% 2. speech
% audio_file = 'speech_t3';
% 3. classical music
% audio_file = 'classical_t3';
% 4. tv 
% audio_file = 'tv_t6';
% 5. pop music
% audio_file = 'pop_t6';
% 6. ambient sound
% audio_file = 'ambient_t6';
% 7. radio
% audio_file = 'radio_t1';
% 8. body sound
% audio_file = 'bodysound_t7';

% load raw audio data
file_name = strcat(dataset_path, audio_file, '.wav');
raw_audio_data = wavread(file_name);

% set up parameters
sampling_rate = 8192;
framesize = 256;
framestep = 128;
% starting_framestep = 500; % relative spectrual entropy needs to wait for 500 framesteps to be ready to compute.
starting_framestep = 0; % relative spectrual entropy needs to wait for 500 framesteps to be ready to compute.
total_num_of_framestep = floor(length(raw_audio_data)/framestep) - starting_framestep;
num_of_framestep_in_one_window = 200;
total_num_of_window = floor(total_num_of_framestep/num_of_framestep_in_one_window);
labels = [];
final_label_array = zeros(total_num_of_framestep, 1);

% lets do the labeling work window by window!
for window_index = 1:1:total_num_of_window

    fprintf('Current Window: %d\n', window_index);
     
    start_index = (starting_framestep + (window_index-1)*num_of_framestep_in_one_window) * framestep + 1;
    end_index = (starting_framestep + window_index*num_of_framestep_in_one_window) * framestep;
    data_in_window = raw_audio_data(start_index : end_index);
    specgram(data_in_window, framesize, framestep);
    labels_this_window = label_speech_features('signal', data_in_window, 'framesize', framesize, 'framestep', framestep, 'samplingrate', sampling_rate, 'segheight', 50);
    labels_this_window_shift = labels_this_window + (window_index-1)*num_of_framestep_in_one_window;
    labels = [labels; labels_this_window_shift];
    saveas(gcf, [audio_file '_snapshot' num2str(window_index)], 'jpg')
    % saveas(gcf, ['figure_' num2str(window_index)], 'fig')
    % movefile('audio.wav',['audio_' num2str(window_index) '.wav'])
    
    % save labels
    dlmwrite(strcat(audio_file, '_labels.txt'), labels_this_window_shift, '-append', 'delimiter',' ');
       
end

% fill in the final_label_array with true labels: 0 - unvoiced; 1 - voiced.
if (isempty(labels) == true)
    fprintf('There is no voiced region labeled.');
else
    for row_index = 1:1:size(labels,1)

        start_frame_number = labels(row_index, 1);
        end_frame_number = labels(row_index, 2);

        for final_label_array_index = start_frame_number:1:end_frame_number
            final_label_array(final_label_array_index,1) = 1;
        end

    end
end

% save labels
dlmwrite(strcat(audio_file, '_final_label_array.txt'), final_label_array);
save (strcat(audio_file, '_labels.mat'), 'labels');
save (strcat(audio_file, '_final_label_array.mat'), 'final_label_array'); 

fprintf('I am done!\n');






