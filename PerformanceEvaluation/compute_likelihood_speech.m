

function [nonvoiced_likelihood_for_voiced_frames voiced_likelihood_for_voiced_frames] = compute_likelihood_speech (audio_file)
       

    % set up dataset path
    dataset_path = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected\';
    label_path = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected_labels\';    

    % load raw audio data
    file_name = strcat(dataset_path, audio_file, '.wav');
    raw_audio_data = wavread(file_name);
       
    % load global parameters
    load global_parameters.mat;
    
    % get inference results and feature values
    results = infer(raw_audio_data, sampling_rate, framesize, framestep, noise_level, num_of_framestep_for_RSE);
    inference_result = results(:, 1) - 1; % 0 - unvoiced; 1 - voiced     
    nonvoiced_likelihood = results(:, 2);
    voiced_likelihood = results(:, 3);
    
    % load true labels
    label_name = strcat(label_path, audio_file, '_final_label_array.txt');
    final_label_array = csvread(label_name);
    % Fix the BUG: 
    % The number of framesteps of final_label_array is equal to the number of
    % framesteps of inference_result.
    % So I just remove the last framestep of final_label_array
    final_label_array = final_label_array(1:length(inference_result),:);
    
    % only look at the voiced likelihood of voiced frames
    voiced_likelihood_for_voiced_frames = [];
    nonvoiced_likelihood_for_voiced_frames = [];
    for i = 1:length(final_label_array)
        if (final_label_array(i) == 1)  
            nonvoiced_likelihood_for_voiced_frames = [nonvoiced_likelihood_for_voiced_frames; nonvoiced_likelihood(i)];
            voiced_likelihood_for_voiced_frames = [voiced_likelihood_for_voiced_frames; voiced_likelihood(i)];    
        end    
    end
       
    nonvoiced_likelihood_for_voiced_frames = log10(nonvoiced_likelihood_for_voiced_frames);
    voiced_likelihood_for_voiced_frames = log10(voiced_likelihood_for_voiced_frames);

    
        

    
    
    

    




