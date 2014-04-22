

function features_window_level_array = audio_feature_extraction_window_level (window_size, window_step, features)
    

    total_num_of_window = 1 + floor((size(features, 1) - window_size) / window_step);
    features_window_level_array = [];    

    for window_index = 1:1:total_num_of_window

        features_in_this_window = features(1+(window_index-1)*window_step : (window_index-1)*window_step + window_size, :);                
        
        % 1. variance of ZCR
        zcr_var = var(features_in_this_window(:,8));
        
        % 2. percentage of low energy frames
        mean_RMS = mean(features_in_this_window(:,6));
        low_energy_frame_num = 0;
        for i = 1:length(features_in_this_window(:,6))
            if features_in_this_window(i,6) < mean_RMS / 2
                low_energy_frame_num = low_energy_frame_num + 1;
            end
        end
        percentage_low_energy_frame = low_energy_frame_num / length(features_in_this_window(:,6));
        
        % 3. variance of spectral flux
        sf_var = var(features_in_this_window(:,5));
        
        % 4. mean of max(peakvals)
        max_peakvals = mean(features_in_this_window(:,1));
        
        % 5. mean of length(peaks)
        peak_length = mean(features_in_this_window(:,2));
                
        % compose the feature vector
        features_window_level_array = [features_window_level_array; zcr_var, percentage_low_energy_frame, sf_var, max_peakvals, peak_length];
        
    end
    
    
    


    
   
    
    
    
