
% Manually label the speech frames.
% @author: Mi Zhang

clc;
    
% set up dataset path
dataset_path = 'D:\Work\Projects\VoiceDetection\Datasets\new_dataset\';
audio_file = 'walk_t3';

% load raw audio data
file_name = strcat(dataset_path, audio_file, '.wav');
raw_audio_data = wavread(file_name);

% set up global parameters
sampling_rate = 8192;
framesize = 256;
framestep = 128;
% starting_framestep = 500; % NOTE: relative spectrual entropy needs to wait for 500 framesteps to be ready to compute.
starting_framestep = 0; 

% set up data structures
total_num_of_framesteps = floor(length(raw_audio_data)/framestep) - starting_framestep;
num_of_framesteps_in_one_window = 200;
total_num_of_windows = ceil(total_num_of_framesteps/num_of_framesteps_in_one_window);
labels = [];
final_label_array = zeros(total_num_of_framesteps, 1);

% lets do the labeling work window by window!
fprintf('Total Number of Windows to Label: %d\n', total_num_of_windows);
for window_index = 1:1:total_num_of_windows

    fprintf('Current Window: %d\n', window_index);
     
    start_index = (starting_framestep + (window_index-1)*num_of_framesteps_in_one_window) * framestep + 1;
    if window_index == total_num_of_windows
        end_index = total_num_of_framesteps * framestep;
    else
        end_index = (starting_framestep + window_index*num_of_framesteps_in_one_window) * framestep;
    end
	
    data_in_window = raw_audio_data(start_index : end_index);
    specgram(data_in_window, framesize, framestep);
    labels_this_window = label_speech_features('signal', data_in_window, 'framesize', framesize, 'framestep', framestep, 'samplingrate', sampling_rate, 'segheight', 50);
    labels_this_window_shift = labels_this_window + (window_index-1)*num_of_framesteps_in_one_window;
    labels = [labels; labels_this_window_shift];
    
    % save spectrograms
    %saveas(gcf, [audio_file '_snapshot' num2str(window_index)], 'jpg')
    
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

% save labels in both .txt and .mat formats
dlmwrite(strcat(audio_file, '_final_label_array.txt'), final_label_array);
save (strcat(audio_file, '_labels.mat'), 'labels');
save (strcat(audio_file, '_final_label_array.mat'), 'final_label_array'); 

fprintf('I am done!\n');






