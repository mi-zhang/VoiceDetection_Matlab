

function features = load_android_features_nonspeech_wav_reading (audio_file)

       
    % set up dataset path
    dataset_path = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected\';    

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
    features = feature_array(:, [1,2,5]);
    
    
    
