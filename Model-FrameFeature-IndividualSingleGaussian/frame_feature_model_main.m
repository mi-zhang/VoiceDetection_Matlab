

function frame_feature_model_main ()

% audio_type:
% class 1: speech (voiced)
% - 'speech_phonecall'
% - 'speech_indoor_meeting'
% - 'speech_indoor_restaurant'
% - 'speech_indoor_hallway'
% - 'speech_outdoor_standing'
% - 'speech_outdoor_walking'
% - 'speech_outdoor_bus'
% - 'speech_radio'
% - 'speech_voiced'
% class 2: speech (unvoiced)
% - speech_unvoiced
% class 3: Ambient
% - 'silent'
% - 'bus'
% - 'walk'
% - 'cafe'
% - 'restaurant'
% - 'party'
% class 4: Music
% - 'classical'
% - 'pop'
% class 5: TV
% - 'tv'

% feature_number:
% 1 - Non-Initial Auto-correlation Peak
% 2 - Number of Auto-correlation Peaks
% 3 - Relative Spectral Entropy
% 4 - Low-High Energy Ratio
% 5 - Spectral Entropy
% 6 - Normalized Energy
% 7 - Total Energy
% 8 - ZCR

    % clc;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Step#1: extract frame-level features  
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % class 1: Speech (voiced) (HLH)
    features_s1 = compute_features_speech('speech_indoor_meeting_t1');
    features_s2 = compute_features_speech('speech_indoor_restaurant_t1');
    features_s3 = compute_features_speech('speech_indoor_hallway_t1');
    features_s4 = compute_features_speech('speech_outdoor_standing_t1');
%     features_s2 = compute_features_speech('speech_t2');
%     features_s3 = compute_features_speech('speech_t3');
%     features_s4 = compute_features_speech('speech_t4');
%     features_s5 = compute_features_speech('speech_indoor_restaurant_t1'); 
%     features_s6 = compute_features_speech('speech_indoor_hallway_t1');
%     features_s7 = compute_features_speech('speech_indoor_meeting_t3');
%     features_s8 = compute_features_speech('speech_indoor_meeting_t4');
%     features_s9 = compute_features_speech('speech_indoor_meeting_t5');
%     features_s10 = compute_features_speech('speech_indoor_meeting_t6');
%     features_s11 = compute_features_speech('speech_indoor_meeting_t6');
                
    % class 2: Speech (unvoiced) and Silence (LHL)   
    % - speech unvoiced
    features_s1_unvoiced = compute_features_speech_unvoiced('speech_indoor_meeting_t1');
    features_s2_unvoiced = compute_features_speech_unvoiced('speech_indoor_restaurant_t1');
    features_s3_unvoiced = compute_features_speech_unvoiced('speech_indoor_hallway_t1');
    features_s4_unvoiced = compute_features_speech_unvoiced('speech_outdoor_standing_t1');
%     features_s5_unvoiced = compute_features_speech_unvoiced('speech_indoor_meeting_t1'); 
%     features_s6_unvoiced = compute_features_speech_unvoiced('speech_indoor_meeting_t2');
%     features_s7_unvoiced = compute_features_speech_unvoiced('speech_indoor_meeting_t3');
%     features_s8_unvoiced = compute_features_speech_unvoiced('speech_indoor_meeting_t4');
%     features_s9_unvoiced = compute_features_speech_unvoiced('speech_indoor_meeting_t5');
%     features_s10_unvoiced = compute_features_speech_unvoiced('speech_indoor_meeting_t6');    
    % - 'silent'
    features_silent1 = compute_features_nonspeech('silent_t1');
    
    % class 3: Ambient (LLL)
    % - 'walk'
    features_w1 = compute_features_nonspeech('walk_t1');
    features_w2 = compute_features_nonspeech('walk_t2');
%     features_w3 = compute_features_nonspeech('walk_t3');
%     features_w4 = compute_features_nonspeech('walk_t4');
%     features_w5 = compute_features_nonspeech('walk_t5');    
    % - 'bus'
    features_b1 = compute_features_nonspeech('bus_t1');
    features_b2 = compute_features_nonspeech('bus_t2');
%     features_b3 = compute_features_nonspeech('bus_t3');
%     features_b4 = compute_features_nonspeech('bus_t4');
%     features_b5 = compute_features_nonspeech('bus_t5');
    % - 'cafe'
    features_cafe1 = compute_features_nonspeech('cafe_t1');
    features_cafe2 = compute_features_nonspeech('cafe_t2');
%     features_cafe3 = compute_features_nonspeech('cafe_t3');
%     features_cafe4 = compute_features_nonspeech('cafe_t4');
%     features_cafe5 = compute_features_nonspeech('cafe_t5');
    
    % class 4: Music
    % - 'classical'
    features_c1 = compute_features_nonspeech('classical_t1');
    features_c2 = compute_features_nonspeech('classical_t2');
    features_c3 = compute_features_nonspeech('classical_t3');
    features_c4 = compute_features_nonspeech('classical_t4');
    % - 'pop'
%     features_p1 = compute_features_nonspeech('pop_t1');
%     features_p2 = compute_features_nonspeech('pop_t2');
%     features_p3 = compute_features_nonspeech('pop_t3');
%     features_p4 = compute_features_nonspeech('pop_t4');
%     features_p5 = compute_features_nonspeech('pop_t5');
%     features_p6 = compute_features_nonspeech('pop_t6');
    
    % class 5: TV
%     features_tv1 = compute_features_nonspeech('tv_t1');
%     features_tv2 = compute_features_nonspeech('tv_t2');
%     features_tv3 = compute_features_nonspeech('tv_t3');
%     features_tv4 = compute_features_nonspeech('tv_t4');
%     features_tv5 = compute_features_nonspeech('tv_t5');
%     features_tv6 = compute_features_nonspeech('tv_t6');
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Step#2: training
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % 2-1: compile the training dataset     
    % class 1: speech (voiced) 
%     features_speech_voiced = [features_s1; features_s2; features_s3; features_s4; features_s5; 
%         features_s6; features_s7; features_s8; features_s9; features_s10];
    features_speech_voiced = [features_s1; features_s2; features_s3; features_s4];
    
    % class 2: speech (unvoiced) + silent
    features_speech_unvoiced = [features_silent1; 
        features_s1_unvoiced; features_s2_unvoiced; features_s3_unvoiced; features_s4_unvoiced];              
    
    % class 3: Ambient
    features_walk = [features_w1; features_w2];
    features_bus = [features_b1; features_b2];
    features_cafe = [features_cafe1; features_cafe2];
    features_ambient = [features_w1; features_w2; features_b1; features_b2; features_cafe1; features_cafe2];
    
    % class 4: Music
    features_music = [features_c1; features_c2; features_c3; features_c4];
                
    % 2-2: train a single Gaussian model for each class
    number_of_features = 3;
    speech_voiced_gaussian_model = frame_feature_model_train(features_speech_voiced(:, 1:number_of_features));
    speech_unvoiced_gaussian_model = frame_feature_model_train(features_speech_unvoiced(:, 1:number_of_features));
    walk_gaussian_model = frame_feature_model_train(features_walk(:, 1:number_of_features));
    bus_gaussian_model = frame_feature_model_train(features_bus(:, 1:number_of_features));
    cafe_gaussian_model = frame_feature_model_train(features_cafe(:, 1:number_of_features));
%     ambient_gaussian_model = frame_feature_model_train(features_ambient(:, 1:number_of_features));
    music_gaussian_model = frame_feature_model_train(features_music(:, 1:number_of_features));       
    
    % save the trained model
    class_label = {'speech_voiced', 'speech_unvoiced', 'walk', 'bus', 'cafe', 'music'};
    mean_array = [speech_voiced_gaussian_model.multivariate_mean', ...
        speech_unvoiced_gaussian_model.multivariate_mean', ...
        walk_gaussian_model.multivariate_mean', ...
        bus_gaussian_model.multivariate_mean', ...
        cafe_gaussian_model.multivariate_mean', ...
        music_gaussian_model.multivariate_mean'];
    cov_array = zeros(number_of_features,number_of_features,6);
    cov_array(:,:,1) = speech_voiced_gaussian_model.multivariate_cov;
    cov_array(:,:,2) = speech_unvoiced_gaussian_model.multivariate_cov;
    cov_array(:,:,3) = walk_gaussian_model.multivariate_cov;
    cov_array(:,:,4) = bus_gaussian_model.multivariate_cov;
    cov_array(:,:,5) = cafe_gaussian_model.multivariate_cov;
    cov_array(:,:,6) = music_gaussian_model.multivariate_cov;
    save('frame_feature_individual_single_gaussian_models.mat','class_label','mean_array','cov_array');
    
    % test
    % class 1: speech (voiced)     
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'radio_t1', number_of_features);
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'speech_t2', number_of_features);
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'speech_t3', number_of_features);
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'speech_t4', number_of_features);
    
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'speech_indoor_meeting_t1', number_of_features);
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'speech_indoor_meeting_t2', number_of_features);
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'speech_indoor_meeting_t3', number_of_features);
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'speech_indoor_meeting_t4', number_of_features);
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'speech_indoor_meeting_t5', number_of_features);
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'speech_indoor_meeting_t6', number_of_features);
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'speech_indoor_meeting_t7', number_of_features);    
    
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'speech_phonecall_t1', number_of_features);
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'speech_phonecall_t2', number_of_features);
    
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'speech_indoor_restaurant_t1', number_of_features);
    
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'speech_indoor_hallway_t1', number_of_features);
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'speech_indoor_hallway_t3', number_of_features);
    
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'speech_outdoor_standing_t1', number_of_features);
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'speech_outdoor_standing_t3', number_of_features);    
    
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'speech_outdoor_walking_t1', number_of_features);
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'speech_outdoor_walking_t3', number_of_features);
    
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'speech_outdoor_bus_t1', number_of_features);  
    
    % class 2: silent
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'silent_t1', number_of_features);
    
    % class 3: Ambient    
    % - 'walk'
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'walk_t1', number_of_features);
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'walk_t2', number_of_features);
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'walk_t3', number_of_features);
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'walk_t4', number_of_features);
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'walk_t5', number_of_features);    
    % - 'bus'
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'bus_t1', number_of_features);
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'bus_t2', number_of_features);
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'bus_t3', number_of_features);
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'bus_t4', number_of_features);
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'bus_t5', number_of_features);    
    % - 'cafe'
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'cafe_t1', number_of_features);
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'cafe_t2', number_of_features);
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'cafe_t3', number_of_features);
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'cafe_t4', number_of_features);        
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'cafe_t5', number_of_features);
    
    % class 4: Music
    % - 'classical'         
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'classical_t1', number_of_features);
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'classical_t2', number_of_features);
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'classical_t3', number_of_features);
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'classical_t4', number_of_features);        
    % - 'pop'
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'pop_t1', number_of_features);
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'pop_t2', number_of_features);
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'pop_t3', number_of_features);
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'pop_t4', number_of_features);
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'pop_t5', number_of_features);        
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'pop_t6', number_of_features);
    
    % class 5: TV
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'tv_t1', number_of_features);
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'tv_t2', number_of_features);
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'tv_t3', number_of_features);
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'tv_t4', number_of_features);
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'tv_t5', number_of_features);        
    frame_feature_model_test (speech_voiced_gaussian_model, speech_unvoiced_gaussian_model, walk_gaussian_model, bus_gaussian_model, cafe_gaussian_model, music_gaussian_model, 'tv_t6', number_of_features);
    
    
    
    
    
    
    
    
    
    
    
   
    
    
       
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
    
    

    




