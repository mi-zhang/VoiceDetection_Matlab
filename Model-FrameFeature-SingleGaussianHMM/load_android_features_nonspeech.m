

function features = load_android_features_nonspeech (audio_file)

       
    % set up dataset path
    dataset_path = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected\';    

    % load feature data
    file_name = strcat(dataset_path, audio_file, '.FeatAndInference');
    feature_inference_data = csvread(file_name);   
    features = feature_inference_data(:, [4,3,5]);
     
