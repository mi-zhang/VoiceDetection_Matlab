

function gaussian_model = fixed_window_feature_model_train (features_window_level_array)
        
    % train a gaussian model
    gaussian_model.multivariate_mean = mean(features_window_level_array);
    gaussian_model.multivariate_cov = cov(features_window_level_array);
    
    
    
    
    
    
    
    
    
    
    
    
    