

function features_for_voiced_frames = load_android_features_speech (audio_file)

       
    % set up dataset path
    dataset_path = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected\';    
    label_path = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected_labels\'; 
    
    % load feature data
    file_name = strcat(dataset_path, audio_file, '.FeatAndInference');
    feature_inference_data = csvread(file_name);   
    features = feature_inference_data(:, [4,3,5]);
    
    % load true labels
    label_name = strcat(label_path, audio_file, '_final_label_array.txt');
    final_label_array = csvread(label_name);
    % Fix the BUG: 
    % The number of framesteps of final_label_array is equal to the number of
    % framesteps of inference_result.
    % So I just remove the last framestep of final_label_array
    if size(final_label_array, 1) > size(features, 1)
        final_label_array = final_label_array(1:size(features, 1),:);
    end
    
    % only look at the features of voiced frames
    features_for_voiced_frames = [];
    for i = 1:length(final_label_array)
        if (final_label_array(i) == 1)        
            features_for_voiced_frames = [features_for_voiced_frames; features(i,:)];     
        end    
    end
