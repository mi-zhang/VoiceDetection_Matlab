

function features = compute_features_nonspeech (audio_file)
       

    % set up dataset path
    dataset_path = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected\';  

    % load raw audio data
    file_name = strcat(dataset_path, audio_file, '.wav');
    raw_audio_data = wavread(file_name);
       
    % load global parameters
    load global_parameters.mat;
    
    % get frame-level feature values
    features = audio_feature_extraction(raw_audio_data, framesize, framestep, noise_level, num_of_framestep_for_RSE);



        

    
    
    

    




