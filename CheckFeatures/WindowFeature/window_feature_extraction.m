

function window_features = window_feature_extraction(data, windowsize, windowstep)
    
    warning off
    
    % import library 
    addpath('./lib/voicing/')
    addpath('./lib/HMM/')    
    
    total_num_of_window_feature = 2;
    
    % parse the data
    audio_raw_data = data(:, 1:256);    
    frame_feature_array = data(:, 257:262);        
    observation_probabilities = data(:, 263:264);   
    % observation_probabilities[1] = unvoice probability (log value)
    % observation_probabilities[2] = voice probability (log value)
    inference_results_array = data(:, 265:284);
    current_inference_result = inference_results_array(:, 1);
    
    % retrieve the frame-level features
    % feature_array[1] = numAcorrPeaks; 
    % feature_array[2] = maxAcorrPeakVal;
    % feature_array[3] = maxAcorrPeakLag;
    % feature_array[4] = spectral_entropy;
    % feature_array[5] = relSpecEntr;
    % feature_array[6] = energy;
    energy = frame_feature_array(:, 6);
    log_energy = log(energy);
    % normalization    
    log_energy_probability = log_energy ./ (sum(log_energy) + 1e-5);

    % break the array into windows
    sig_len = length(log_energy);   
    num_complete_windows = floor((sig_len - windowsize)/windowstep) + 1;
    
    % compute window-level features
    window_features = zeros(num_complete_windows, total_num_of_window_feature);
    for window_index = 0 : num_complete_windows-1

        % f1: Entropy of Log Energy
        log_energy_probability_this_window = log_energy_probability(window_index*windowstep+1 : window_index*windowstep+windowsize);
        % compute the entropy of log energy within each window   
        window_features(window_index+1, 1) = -1 * sum(log_energy_probability_this_window .* log(log_energy_probability_this_window));

        % f2: Voice / Unvoice Ratio 
        current_inference_result_this_window = current_inference_result(window_index*windowstep+1 : window_index*windowstep+windowsize);
        % compute the voice/unvoice ratio
        window_features(window_index+1, 2) = sum(current_inference_result_this_window) / length(current_inference_result_this_window);
        
    end
    
%     disp('I am done!');
    
end


    
   
    
    
    
