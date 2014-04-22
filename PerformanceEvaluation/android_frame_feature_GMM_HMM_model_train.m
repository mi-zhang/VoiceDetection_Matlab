

function GMModel = android_frame_feature_GMM_HMM_model_train (frame_features_array, number_of_gaussian)
        
    % train a GMM model
    GMModel = gmdistribution.fit(frame_features_array, number_of_gaussian, 'Replicates', 10);    
    
                