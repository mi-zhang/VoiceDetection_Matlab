

function gaussian_model = frame_feature_model_train (frame_features_array)
           
    % train a multivariate gaussian model
    gaussian_model.multivariate_mean = mean(frame_features_array);
    gaussian_model.multivariate_cov = cov(frame_features_array);
       
    


    


