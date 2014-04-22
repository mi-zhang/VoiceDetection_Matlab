

function fixed_window_feature_model_main (window_length)
    
    % NOTE: 
    % window_length: 64 is equal to 1 second
    % sample command: fixed_window_feature_model_main (64)
    
    % clc;
    
% audio_type:
% class 1: speech (voiced + unvoiced)
% - 'speech_indoor_meeting' (training)
% - 'speech_phonecall'
% - 'speech_indoor_restaurant'
% - 'speech_indoor_cafe'
% - 'speech_indoor_hallway'
% - 'speech_outdoor_standing'
% - 'speech_outdoor_walking'
% - 'speech_outdoor_bus'
% class 2: Ambient
% - 'silent' (training)
% - 'bus' (training)
% - 'walk' (training)
% - 'cafe'
% class 3: Music
% - 'classical' (training)
% - 'pop' (training)
% class 4: TV
% - 'tv'

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Step#1: extract frame-level features  
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % class 1: Speech
    % NOTE: we need to use compute_features_nonspeech instead of
    % compute_features_speech since we need to incorporate both voiced and
    % nonvoiced frames to calculate window-level features.
%     features_s1 = compute_features_nonspeech('radio_t1');
%     features_s2 = compute_features_nonspeech('speech_t2');
%     features_s3 = compute_features_nonspeech('speech_t3');
%     features_s4 = compute_features_nonspeech('speech_t4');
%     features_s5 = compute_features_nonspeech('speech_indoor_meeting_t1'); 
%     features_s6 = compute_features_nonspeech('speech_indoor_meeting_t3'); 
    
    [inference_result_s1 final_label_array_s1 features_s1] = do_inference('radio_t1');
    [inference_result_s2 final_label_array_s2 features_s2] = do_inference('speech_t2');
    [inference_result_s3 final_label_array_s3 features_s3] = do_inference('speech_t3');
    [inference_result_s4 final_label_array_s4 features_s4] = do_inference('speech_t4'); 
    [inference_result_s5 final_label_array_s5 features_s5] = do_inference('speech_indoor_meeting_t1');
    [inference_result_s6 final_label_array_s6 features_s6] = do_inference('speech_indoor_meeting_t3');
    
%     [inference_result_s1 final_label_array_s1 features_s1] = do_inference('speech_indoor_meeting_t1');
%     [inference_result_s2 final_label_array_s2 features_s2] = do_inference('speech_indoor_meeting_t2');
%     [inference_result_s3 final_label_array_s3 features_s3] = do_inference('speech_indoor_meeting_t3');
%     [inference_result_s4 final_label_array_s4 features_s4] = do_inference('speech_indoor_meeting_t4');
%     [inference_result_s5 final_label_array_s5 features_s5] = do_inference('speech_indoor_meeting_t5');
%     [inference_result_s6 final_label_array_s6 features_s6] = do_inference('speech_indoor_meeting_t6');
%     [inference_result_s7 final_label_array_s7 features_s7] = do_inference('speech_indoor_meeting_t7');
        
    % class 2: Ambient
    % - 'silent'
    features_silent1 = compute_features_nonspeech('silent_t1');    
    % - 'walk'
    features_w1 = compute_features_nonspeech('walk_t1');
    features_w2 = compute_features_nonspeech('walk_t2');
    features_w3 = compute_features_nonspeech('walk_t3');
    features_w4 = compute_features_nonspeech('walk_t4');
    features_w5 = compute_features_nonspeech('walk_t5');    
    % - 'bus'
    features_b1 = compute_features_nonspeech('bus_t1');
    features_b2 = compute_features_nonspeech('bus_t2');
    features_b3 = compute_features_nonspeech('bus_t3');
    features_b4 = compute_features_nonspeech('bus_t4');
    features_b5 = compute_features_nonspeech('bus_t5');
    % - 'cafe'
    features_cafe1 = compute_features_nonspeech('cafe_t1');
    features_cafe2 = compute_features_nonspeech('cafe_t2');
    features_cafe3 = compute_features_nonspeech('cafe_t3');
    features_cafe4 = compute_features_nonspeech('cafe_t4');
    features_cafe5 = compute_features_nonspeech('cafe_t5');
    
    % class 3: Music
    % - 'classical'
    features_c1 = compute_features_nonspeech('classical_t1');
    features_c2 = compute_features_nonspeech('classical_t2');
    features_c3 = compute_features_nonspeech('classical_t3');
    features_c4 = compute_features_nonspeech('classical_t4');
    % - 'pop'
    features_p1 = compute_features_nonspeech('pop_t1');
    features_p2 = compute_features_nonspeech('pop_t2');
    features_p3 = compute_features_nonspeech('pop_t3');
    features_p4 = compute_features_nonspeech('pop_t4');
    features_p5 = compute_features_nonspeech('pop_t5');
    features_p6 = compute_features_nonspeech('pop_t6');
    
    % class 4: TV
    features_tv1 = compute_features_nonspeech('tv_t1');
    features_tv2 = compute_features_nonspeech('tv_t2');
    features_tv3 = compute_features_nonspeech('tv_t3');
    features_tv4 = compute_features_nonspeech('tv_t4');
    features_tv5 = compute_features_nonspeech('tv_t5');
    features_tv6 = compute_features_nonspeech('tv_t6');
          
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Step#2: segment windows and extract window-level features
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    num_of_framestep_for_each_window = window_length; 
    window_step = num_of_framestep_for_each_window/2;
         
    % class 1: Speech
    features_window_level_array_s1 = audio_feature_extraction_window_level_with_constraint(num_of_framestep_for_each_window, window_step, features_s1, final_label_array_s1);
    features_window_level_array_s2 = audio_feature_extraction_window_level_with_constraint(num_of_framestep_for_each_window, window_step, features_s2, final_label_array_s2);
    features_window_level_array_s3 = audio_feature_extraction_window_level_with_constraint(num_of_framestep_for_each_window, window_step, features_s3, final_label_array_s3);
    features_window_level_array_s4 = audio_feature_extraction_window_level_with_constraint(num_of_framestep_for_each_window, window_step, features_s4, final_label_array_s4);
    features_window_level_array_s5 = audio_feature_extraction_window_level_with_constraint(num_of_framestep_for_each_window, window_step, features_s5, final_label_array_s5);
    features_window_level_array_s6 = audio_feature_extraction_window_level_with_constraint(num_of_framestep_for_each_window, window_step, features_s6, final_label_array_s6);
    
    % class 2: Ambient
    % - 'silent'
    features_window_level_array_silent1 = audio_feature_extraction_window_level(num_of_framestep_for_each_window, window_step, features_silent1);
    % - 'walk'
    features_window_level_array_w1 = audio_feature_extraction_window_level(num_of_framestep_for_each_window, window_step, features_w1);
    features_window_level_array_w2 = audio_feature_extraction_window_level(num_of_framestep_for_each_window, window_step, features_w2);
    features_window_level_array_w3 = audio_feature_extraction_window_level(num_of_framestep_for_each_window, window_step, features_w3);
    features_window_level_array_w4 = audio_feature_extraction_window_level(num_of_framestep_for_each_window, window_step, features_w4);
    features_window_level_array_w5 = audio_feature_extraction_window_level(num_of_framestep_for_each_window, window_step, features_w5);
    % - 'bus'
    features_window_level_array_b1 = audio_feature_extraction_window_level(num_of_framestep_for_each_window, window_step, features_b1);
    features_window_level_array_b2 = audio_feature_extraction_window_level(num_of_framestep_for_each_window, window_step, features_b2);
    features_window_level_array_b3 = audio_feature_extraction_window_level(num_of_framestep_for_each_window, window_step, features_b3);
    features_window_level_array_b4 = audio_feature_extraction_window_level(num_of_framestep_for_each_window, window_step, features_b4);
    features_window_level_array_b5 = audio_feature_extraction_window_level(num_of_framestep_for_each_window, window_step, features_b5);
    % - 'cafe'
    features_window_level_array_cafe1 = audio_feature_extraction_window_level(num_of_framestep_for_each_window, window_step, features_cafe1);
    features_window_level_array_cafe2 = audio_feature_extraction_window_level(num_of_framestep_for_each_window, window_step, features_cafe2);
    features_window_level_array_cafe3 = audio_feature_extraction_window_level(num_of_framestep_for_each_window, window_step, features_cafe3);
    features_window_level_array_cafe4 = audio_feature_extraction_window_level(num_of_framestep_for_each_window, window_step, features_cafe4);
    features_window_level_array_cafe5 = audio_feature_extraction_window_level(num_of_framestep_for_each_window, window_step, features_cafe5);
    
    % class 3: Music
    % - 'classical'
    features_window_level_array_c1 = audio_feature_extraction_window_level(num_of_framestep_for_each_window, window_step, features_c1);
    features_window_level_array_c2 = audio_feature_extraction_window_level(num_of_framestep_for_each_window, window_step, features_c2);
    features_window_level_array_c3 = audio_feature_extraction_window_level(num_of_framestep_for_each_window, window_step, features_c3);
    features_window_level_array_c4 = audio_feature_extraction_window_level(num_of_framestep_for_each_window, window_step, features_c4);
    % - 'pop'    
    features_window_level_array_p1 = audio_feature_extraction_window_level(num_of_framestep_for_each_window, window_step, features_p1);
    features_window_level_array_p2 = audio_feature_extraction_window_level(num_of_framestep_for_each_window, window_step, features_p2);
    features_window_level_array_p3 = audio_feature_extraction_window_level(num_of_framestep_for_each_window, window_step, features_p3);
    features_window_level_array_p4 = audio_feature_extraction_window_level(num_of_framestep_for_each_window, window_step, features_p4);
    features_window_level_array_p5 = audio_feature_extraction_window_level(num_of_framestep_for_each_window, window_step, features_p5);
    features_window_level_array_p6 = audio_feature_extraction_window_level(num_of_framestep_for_each_window, window_step, features_p6);
        
    % class 4: TV
    features_window_level_array_tv1 = audio_feature_extraction_window_level(num_of_framestep_for_each_window, window_step, features_tv1);
    features_window_level_array_tv2 = audio_feature_extraction_window_level(num_of_framestep_for_each_window, window_step, features_tv2);
    features_window_level_array_tv3 = audio_feature_extraction_window_level(num_of_framestep_for_each_window, window_step, features_tv3);
    features_window_level_array_tv4 = audio_feature_extraction_window_level(num_of_framestep_for_each_window, window_step, features_tv4);
    features_window_level_array_tv5 = audio_feature_extraction_window_level(num_of_framestep_for_each_window, window_step, features_tv5);
    features_window_level_array_tv6 = audio_feature_extraction_window_level(num_of_framestep_for_each_window, window_step, features_tv6);
   
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Step#3: training
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % 3-1: compile the training dataset
    % class 1: Speech
%     features_window_level_array_s = [features_window_level_array_s1; features_window_level_array_s2; features_window_level_array_s3; features_window_level_array_s4];    
    features_window_level_array_s = [features_window_level_array_s1; features_window_level_array_s2; features_window_level_array_s3; features_window_level_array_s4; features_window_level_array_s5; features_window_level_array_s6];    
    % class 2: Ambient
    % - 'silent'
    features_window_level_array_silent = features_window_level_array_silent1;  
    % - 'walk'
    features_window_level_array_w = [features_window_level_array_w1; features_window_level_array_w2; features_window_level_array_w3; features_window_level_array_w4; features_window_level_array_w5];
    % - 'bus'
    features_window_level_array_b = [features_window_level_array_b1; features_window_level_array_b2; features_window_level_array_b3; features_window_level_array_b4; features_window_level_array_b5];    
    % class 3: Music
    % - 'classical'
    features_window_level_array_c = [features_window_level_array_c1; features_window_level_array_c2; features_window_level_array_c3; features_window_level_array_c4];
    % - 'pop'
    features_window_level_array_p = [features_window_level_array_p1; features_window_level_array_p2; features_window_level_array_p3; features_window_level_array_p4; features_window_level_array_p5; features_window_level_array_p6];    
    
    % 3-2: train a multivariate single Gaussian model based on window-level features
    % class 1: Speech
    gaussian_model_s = fixed_window_feature_model_train(features_window_level_array_s);
    % class 2: Ambient
    % - 'silent'
    gaussian_model_silent = fixed_window_feature_model_train(features_window_level_array_silent);
    % - 'walk'
    gaussian_model_w = fixed_window_feature_model_train(features_window_level_array_w);
    % - 'bus'
    gaussian_model_b = fixed_window_feature_model_train(features_window_level_array_b);
    % class 3: Music
    % - 'classical'
    gaussian_model_c = fixed_window_feature_model_train(features_window_level_array_c);
    % - 'pop'
    gaussian_model_p = fixed_window_feature_model_train(features_window_level_array_p);
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Step#4: testing   
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % class 1: Speech
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'radio_t1', num_of_framestep_for_each_window);
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'speech_t2', num_of_framestep_for_each_window);
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'speech_t3', num_of_framestep_for_each_window);
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'speech_t4', num_of_framestep_for_each_window);
    
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'speech_indoor_meeting_t1', num_of_framestep_for_each_window);
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'speech_indoor_meeting_t2', num_of_framestep_for_each_window);
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'speech_indoor_meeting_t3', num_of_framestep_for_each_window);
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'speech_indoor_meeting_t4', num_of_framestep_for_each_window);
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'speech_indoor_meeting_t5', num_of_framestep_for_each_window);
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'speech_indoor_meeting_t6', num_of_framestep_for_each_window);
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'speech_indoor_meeting_t7', num_of_framestep_for_each_window);
    
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'speech_phonecall_t1', num_of_framestep_for_each_window);
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'speech_phonecall_t2', num_of_framestep_for_each_window);
    
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'speech_indoor_restaurant_t1', num_of_framestep_for_each_window);
    
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'speech_indoor_hallway_t1', num_of_framestep_for_each_window);
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'speech_indoor_hallway_t3', num_of_framestep_for_each_window);

    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'speech_outdoor_standing_t1', num_of_framestep_for_each_window);
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'speech_outdoor_standing_t3', num_of_framestep_for_each_window);
        
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'speech_outdoor_walking_t1', num_of_framestep_for_each_window);
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'speech_outdoor_walking_t3', num_of_framestep_for_each_window);
    
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'speech_outdoor_bus_t1', num_of_framestep_for_each_window);
        
    % class 2: Ambient
    % - 'silent'
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'silent_t1', num_of_framestep_for_each_window);
    % - 'walk'
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'walk_t1', num_of_framestep_for_each_window);
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'walk_t2', num_of_framestep_for_each_window);
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'walk_t3', num_of_framestep_for_each_window);
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'walk_t4', num_of_framestep_for_each_window);
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'walk_t5', num_of_framestep_for_each_window);
    % - 'bus'
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'bus_t1', num_of_framestep_for_each_window);
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'bus_t2', num_of_framestep_for_each_window);
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'bus_t3', num_of_framestep_for_each_window);
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'bus_t4', num_of_framestep_for_each_window);
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'bus_t5', num_of_framestep_for_each_window);
    % - 'cafe'
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'cafe_t1', num_of_framestep_for_each_window);
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'cafe_t2', num_of_framestep_for_each_window);
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'cafe_t3', num_of_framestep_for_each_window);
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'cafe_t4', num_of_framestep_for_each_window);
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'cafe_t5', num_of_framestep_for_each_window);
    
    % class 3: Music
    % - 'classical'         
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'classical_t1', num_of_framestep_for_each_window);
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'classical_t2', num_of_framestep_for_each_window);
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'classical_t3', num_of_framestep_for_each_window);
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'classical_t4', num_of_framestep_for_each_window);
    % - 'pop'    
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'pop_t1', num_of_framestep_for_each_window);
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'pop_t2', num_of_framestep_for_each_window);
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'pop_t3', num_of_framestep_for_each_window);
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'pop_t4', num_of_framestep_for_each_window);
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'pop_t5', num_of_framestep_for_each_window);
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'pop_t6', num_of_framestep_for_each_window); 
    
    % class 4: TV
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'tv_t1', num_of_framestep_for_each_window);
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'tv_t2', num_of_framestep_for_each_window);
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'tv_t3', num_of_framestep_for_each_window);
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'tv_t4', num_of_framestep_for_each_window);
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'tv_t5', num_of_framestep_for_each_window);
    fixed_window_feature_model_test(gaussian_model_w, gaussian_model_b, gaussian_model_silent, gaussian_model_c, gaussian_model_s, gaussian_model_p, 'tv_t6', num_of_framestep_for_each_window); 
    
   
    
    
       
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
    
    

    




