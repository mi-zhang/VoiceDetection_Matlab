

function window_feature = compute_window_feature (audio_file, feature_number)
       

    % set up dataset path   
    dataset_path = 'D:\Work\Projects\VoiceDetection\Datasets\new_dataset\';   
    
    % load feature data
    file_name = strcat(dataset_path, audio_file, '_android_features.txt');
    data = csvread(file_name);           
       
    % set up global parameters
    % 1/8192 * 128 
%     windowsize = 320; % 5 seconds contains 320 frame-level features
%     windowsize = 192; % 3 seconds contains 192 frame-level features
    windowsize = 64; % 1 second contains 64 frame-level features
    windowstep = windowsize / 2; 
    
    % compute window-level feature values
    window_features = window_feature_extraction(data, windowsize, windowstep);
    
    % select the feature
    window_feature = window_features(:, feature_number);


        

    
    
    

    




