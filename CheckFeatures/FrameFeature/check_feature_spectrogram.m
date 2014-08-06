

function check_feature_spectrogram (audio_file, feature_number)

% audio_file:
% class 1: speech (voiced)
% - 'speech_voiced'
% - 'speech_indoor_meeting'
% - 'speech_phonecall'
% - 'speech_indoor_restaurant'
% - 'speech_indoor_hallway'
% - 'speech_outdoor_standing'
% - 'speech_outdoor_walking'
% - 'speech_outdoor_bus'
% - 'speech_radio'
% class 2: speech (unvoiced)
% - speech_unvoiced
% class 3: Ambient
% - 'silent'
% - 'bus'
% - 'walk'
% - 'cafe'
% - 'restaurant'
% - 'party'
% class 4: Music
% - 'classical'
% - 'pop'
% class 5: TV
% - 'tv'

% feature_number:
% 1 - Non-Initial Auto-correlation Peak
% 2 - Number of Auto-correlation Peaks
% 3 - Relative Spectral Entropy
% 4 - Low-High Energy Ratio
% 5 - Spectral Entropy
% 6 - Normalized Energy
% 7 - Total Energy
% 8 - ZCR
% 9 - MCR
    

    warning off
    
    % import library 
    addpath('./lib/voicing/')
    addpath('./lib/HMM/')
    
    load global_parameters.mat;   
    
    % set up dataset path
    dataset_path = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected\';
    label_path = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected_labels\';

    % load raw audio data
    file_name = strcat(dataset_path, audio_file, '.wav');
    raw_audio_data = wavread(file_name);
    
    % calculate frame-level audio features
    features = audio_feature_extraction(raw_audio_data, framesize, framestep, noise_level, num_of_framestep_for_RSE);
        
    % load true labels
	label_name = strcat(label_path, audio_file, '_final_label_array.txt');
	final_label_array = csvread(label_name);
    final_label_array = final_label_array(1:size(features,1),:);     
    
    % only look at a subset of the audio data
    starting_framestep = 0; 
    total_num_of_framestep = floor(length(raw_audio_data)/framestep) - starting_framestep;
    num_of_framestep_in_one_window = 500;
    total_num_of_window = floor(total_num_of_framestep/num_of_framestep_in_one_window);
    
    window_index = 7;
    start_index = (starting_framestep + (window_index-1)*num_of_framestep_in_one_window) * framestep + 1;
    end_index = (starting_framestep + window_index*num_of_framestep_in_one_window) * framestep;
    data_in_window = raw_audio_data(start_index : end_index);
    start_index_for_frame = (starting_framestep + (window_index-1)*num_of_framestep_in_one_window) + 1;
    end_index_for_frame = (starting_framestep + window_index*num_of_framestep_in_one_window);
    
    % plot
    figure;
    subplot(211)
    specgram(data_in_window, framesize, framestep);
    switch(feature_number)
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
        case 4
            hold on
            plot(features(start_index_for_frame:end_index_for_frame,4)*10);    
            hold off
            xlabel('Low-High Energy Ratio');
            axis tight   
        case 5
            hold on
            plot(features(start_index_for_frame:end_index_for_frame,5)*10);    
            hold off
            xlabel('Spectral Entropy');
            axis tight   
        case 6
            hold on
            plot(features(start_index_for_frame:end_index_for_frame,6)*10);    
            hold off
            xlabel('Normalized Energy');
            axis tight       
        case 7
            hold on
            plot(features(start_index_for_frame:end_index_for_frame,7)/40);    
            hold off
            xlabel('Total Energy');
            axis tight    
        case 8
            hold on
            plot(features(start_index_for_frame:end_index_for_frame,8)*120);    
            hold off
            xlabel('ZCR');
            axis tight      
        case 9
            hold on
            plot(features(start_index_for_frame:end_index_for_frame,8)*120);    
            hold off
            xlabel('MCR');
            axis tight          
        otherwise
            fprintf('Unexpected feature type.\n');
    end
    subplot(212)
    specgram(data_in_window, framesize, framestep);
    hold on
    plot(final_label_array(start_index_for_frame:end_index_for_frame)*30,'k');
    hold off
    xlabel('True Labels');
    axis tight    
    
    % put a single title for all subplots
    ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
    text(0.5, 1, [audio_file, ': Feature: ' num2str(feature_number)], 'HorizontalAlignment','center', 'VerticalAlignment','top');

    % save the curve
    saveas(gcf, [audio_file '_feature_' num2str(feature_number)], 'jpg');   


    


