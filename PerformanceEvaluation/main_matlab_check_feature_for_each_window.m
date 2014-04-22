

function main_matlab_check_feature_for_each_window (audio_file, feature_select)


    clc;

    % set up dataset path
    dataset_path = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected\';
    label_path = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected_labels\';

    % load raw audio data
    file_name = strcat(dataset_path, audio_file, '.wav');
    raw_audio_data = wavread(file_name);

   % load global parameters
    load global_parameters.mat;
%     % set up parameters
%     sampling_rate = 8192;
%     framesize = 256;
%     framestep = 128;
%     num_of_framestep_for_RSE = 300; % number of framesteps for calculating Relative Spectral Entropy (RSE)
%     noise_level = 0.02; % white noise level: 0.01 represents 1%.

    % starting_framestep = 500; % relative spectrual entropy needs to wait for 500 framesteps to be ready to compute.
    starting_framestep = 0; % relative spectrual entropy needs to wait for 500 framesteps to be ready to compute.
    total_num_of_framestep = floor(length(raw_audio_data)/framestep) - starting_framestep;
    num_of_framestep_in_one_window = 200;
    total_num_of_window = floor(total_num_of_framestep/num_of_framestep_in_one_window);
    labels = [];
    final_label_array = zeros(total_num_of_framestep, 1);

    % get inference results and feature values
    results = infer(raw_audio_data, sampling_rate, framesize, framestep, noise_level, num_of_framestep_for_RSE);
    inference_result = results(:, 1) - 1; % 0 - unvoiced; 1 - voiced
    features = results(:, 4:11);

    % load true labels
    label_name = strcat(label_path, audio_file, '_final_label_array.txt');
    final_label_array = csvread(label_name);
    % Fix the BUG: 
    % The number of framesteps of final_label_array is equal to the number of
    % framesteps of inference_result.
    % So I just remove the last framestep of final_label_array
    final_label_array = final_label_array(1:length(inference_result),:);

    for window_index = 1:1:total_num_of_window

        start_index = (starting_framestep + (window_index-1)*num_of_framestep_in_one_window) * framestep + 1;
        end_index = (starting_framestep + window_index*num_of_framestep_in_one_window) * framestep;
        data_in_window = raw_audio_data(start_index : end_index);
        specgram(data_in_window, framesize, framestep);

        start_index_for_frame = (starting_framestep + (window_index-1)*num_of_framestep_in_one_window) + 1;
        end_index_for_frame = (starting_framestep + window_index*num_of_framestep_in_one_window);

        % visualization
        figure;
        subplot(311)
        specgram(data_in_window, framesize, framestep);
        switch(feature_select)
            case 1
                hold on
                plot(features(start_index_for_frame:end_index_for_frame,1)*60);
                hold off
                xlabel('Non-Initial Auto-correlation Peak');
                axis tight            
            case 2
                hold on
                plot(features(start_index_for_frame:end_index_for_frame,2));
                hold off
                xlabel('Number of Auto-correlation Peaks');
                axis tight        
            case 3
                hold on
                plot(features(start_index_for_frame:end_index_for_frame,3)*60);    
                hold off
                xlabel('Relative Spectral Entropy');
                axis tight   
            case 7
                hold on
                plot(features(start_index_for_frame:end_index_for_frame,7));    
                hold off
                xlabel('LF / HF');
                axis tight    
            case 8
                hold on
                plot(features(start_index_for_frame:end_index_for_frame,8)*120);    
                hold off
                xlabel('ZCR');
                axis tight      
            otherwise
                fprintf('Unexpected feature type.\n');
        end
        subplot(312)
        specgram(data_in_window, framesize, framestep);
        hold on
        plot(inference_result(start_index_for_frame:end_index_for_frame)*30,'b');
        hold off
        xlabel('Inference Result');
        axis tight
        subplot(313)
        specgram(data_in_window, framesize, framestep);
        hold on
        plot(final_label_array(start_index_for_frame:end_index_for_frame)*30,'k');
        hold off
        xlabel('True Labels');
        axis tight
        % put a single title for all subplots
        ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
        text(0.5, 1, [audio_file, ': noise level equals to ', num2str(noise_level), ', number of framesteps equals to ', num2str(num_of_framestep_for_RSE)], 'HorizontalAlignment','center', 'VerticalAlignment','top');
        
        % save the curve
        saveas(gcf, [audio_file '_feature_' num2str(feature_select) '_window_' num2str(window_index)], 'jpg');   

    end


    




