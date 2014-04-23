

function features_for_unvoiced_frames = load_android_features_speech_unvoiced_wav_reading (audio_file)

       
    % set up dataset path
    dataset_path = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected\';    
    label_path = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected_labels\'; 
    
    % load feature data
    file_name = strcat(dataset_path, audio_file, '_android_features.txt');
    % audio frame, voicing features, observation probabilities, inference results
    data = csvread(file_name);   
    audio_raw_data = data(:, 1:256);
    observation_probabilities = data(:, 263:264);    
    inference_results_array = data(:, 265:284);
    feature_array = data(:, 257:262);
    % 
    % fVector[0] = numAcorrPeaks; 
	% fVector[1] = maxAcorrPeakVal;
	% fVector[2] = maxAcorrPeakLag;
	% fVector[3] = spectral_entropy;
	% fVector[4] = relSpecEntr;
	% fVector[5] = energy;    
    features = feature_array(:, [2,1,5]);
    
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
    if size(final_label_array, 1) < size(features, 1)
        features = features(1:size(final_label_array, 1),:);
    end
    
    % only look at the features of voiced frames
    features_for_unvoiced_frames = [];
    for i = 1:length(final_label_array)
        if (final_label_array(i) == 0)        
            features_for_unvoiced_frames = [features_for_unvoiced_frames; features(i,:)];     
        end    
    end

    
            