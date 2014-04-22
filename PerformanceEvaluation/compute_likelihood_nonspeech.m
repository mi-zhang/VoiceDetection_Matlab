

function [nonvoiced_likelihood voiced_likelihood] = compute_likelihood_nonspeech (audio_file)
       

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

    nonvoiced_likelihood = log10(nonvoiced_likelihood);
    voiced_likelihood = log10(voiced_likelihood);
    
        

    
    
    

    




