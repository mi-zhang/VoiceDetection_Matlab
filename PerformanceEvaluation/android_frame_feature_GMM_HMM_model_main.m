

function android_frame_feature_GMM_HMM_model_main ()

% audio_type:
% class 1: speech (voiced)
% - 'speech_indoor_meeting' (training)
% - 'speech_phonecall'
% - 'speech_indoor_restaurant'
% - 'speech_indoor_cafe'
% - 'speech_indoor_hallway'
% - 'speech_outdoor_standing'
% - 'speech_outdoor_walking'
% - 'speech_outdoor_bus'
% class 2: speech (unvoiced)
% class 3: Ambient
% - 'silent' (training)
% - 'bus' (training)
% - 'walk' (training)
% - 'cafe'
% class 4: Music
% - 'classical' (training)
% - 'pop' (training)
% class 5: TV
% - 'tv'

% feature_number:
% 1 - Non-Initial Auto-correlation Peak
% 2 - Number of Auto-correlation Peaks
% 3 - Relative Spectral Entropy

    % clc;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Step#1: load frame-level features  
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % class 1: Speech (voiced) (HLH)
    features_s1 = load_android_features_speech('speech_indoor_meeting_t7');
    features_s2 = load_android_features_speech('speech_t2');
    features_s3 = load_android_features_speech('speech_t3');
    features_s4 = load_android_features_speech('speech_t4');
    features_s5 = load_android_features_speech('speech_indoor_meeting_t1'); 
    features_s6 = load_android_features_speech('speech_indoor_meeting_t2');
    features_s7 = load_android_features_speech('speech_indoor_meeting_t3');
    features_s8 = load_android_features_speech('speech_indoor_meeting_t4');
    features_s9 = load_android_features_speech('speech_indoor_meeting_t5');
    features_s10 = load_android_features_speech('speech_indoor_meeting_t6');
                
    % class 2: Speech (unvoiced) and Silence (LHL)   
    % - speech unvoiced
    features_s1_unvoiced = load_android_features_speech_unvoiced('speech_indoor_meeting_t7');
    features_s2_unvoiced = load_android_features_speech_unvoiced('speech_t2');
    features_s3_unvoiced = load_android_features_speech_unvoiced('speech_t3');
    features_s4_unvoiced = load_android_features_speech_unvoiced('speech_t4');
    features_s5_unvoiced = load_android_features_speech_unvoiced('speech_indoor_meeting_t1'); 
    features_s6_unvoiced = load_android_features_speech_unvoiced('speech_indoor_meeting_t2');
    features_s7_unvoiced = load_android_features_speech_unvoiced('speech_indoor_meeting_t3');
    features_s8_unvoiced = load_android_features_speech_unvoiced('speech_indoor_meeting_t4');
    features_s9_unvoiced = load_android_features_speech_unvoiced('speech_indoor_meeting_t5');
    features_s10_unvoiced = load_android_features_speech_unvoiced('speech_indoor_meeting_t6');    
    % - 'silent'
    features_silent1 = load_android_features_nonspeech('silent_t1'); 
    
    % class 3: Ambient (LLL)
    % - 'walk'
    features_w1 = load_android_features_nonspeech('walk_t1');
    features_w2 = load_android_features_nonspeech('walk_t2');
    features_w3 = load_android_features_nonspeech('walk_t3');
%     features_w4 = load_android_features_nonspeech('walk_t4');
%     features_w5 = load_android_features_nonspeech('walk_t5');    
    % - 'bus'
    features_b1 = load_android_features_nonspeech('bus_t1');
    features_b2 = load_android_features_nonspeech('bus_t2');
    features_b3 = load_android_features_nonspeech('bus_t3');
%     features_b4 = load_android_features_nonspeech('bus_t4');
%     features_b5 = load_android_features_nonspeech('bus_t5');
    % - 'cafe'
    features_cafe1 = load_android_features_nonspeech('cafe_t1');
    features_cafe2 = load_android_features_nonspeech('cafe_t2');
    features_cafe3 = load_android_features_nonspeech('cafe_t3');
%     features_cafe4 = load_android_features_nonspeech('cafe_t4');
%     features_cafe5 = load_android_features_nonspeech('cafe_t5');
    
    % class 4: Music
    % - 'classical'
    features_c1 = load_android_features_nonspeech('classical_t1');
    features_c2 = load_android_features_nonspeech('classical_t2');
    features_c3 = load_android_features_nonspeech('classical_t3');
    features_c4 = load_android_features_nonspeech('classical_t4');
    % - 'pop'
%     features_p1 = load_android_features_nonspeech('pop_t1');
%     features_p2 = load_android_features_nonspeech('pop_t2');
%     features_p3 = load_android_features_nonspeech('pop_t3');
%     features_p4 = load_android_features_nonspeech('pop_t4');
%     features_p5 = load_android_features_nonspeech('pop_t5');
%     features_p6 = load_android_features_nonspeech('pop_t6');
    
    % class 5: TV
%     features_tv1 = load_android_features_nonspeech('tv_t1');
%     features_tv2 = load_android_features_nonspeech('tv_t2');
%     features_tv3 = load_android_features_nonspeech('tv_t3');
%     features_tv4 = load_android_features_nonspeech('tv_t4');
%     features_tv5 = load_android_features_nonspeech('tv_t5');
%     features_tv6 = load_android_features_nonspeech('tv_t6');
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Step#2: training
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % 2-1: compile the training dataset     
    % class 1: speech (voiced) 
%     features_speech_voiced = [features_s5; features_s6; features_s7; features_s8; features_s9; features_s10];
    features_speech_voiced = [features_s1; features_s2; features_s3; features_s4];
   
    % class 2: everything else
    features_speech_unvoiced = [features_silent1; 
              features_s1_unvoiced; features_s2_unvoiced; features_s3_unvoiced; features_s4_unvoiced;
%               features_s6_unvoiced; features_s7_unvoiced; features_s8_unvoiced; features_s9_unvoiced; features_s10_unvoiced; 
              features_w1; features_w2; features_w3; features_b1; features_b2; features_b3; features_cafe1; features_cafe2; features_cafe3;
              features_c1; features_c2; features_c3; features_c4
              ];   
          
    % class 2: everything else except music
%     features_speech_unvoiced = [features_silent1; 
%               features_s1_unvoiced; features_s2_unvoiced; features_s3_unvoiced; features_s4_unvoiced; 
%               features_w1; features_w2; features_b1; features_b2; features_cafe1; features_cafe2];   
          
    % class 2: unvoiced + silent
%     features_speech_unvoiced = [features_silent1; 
%               features_s1_unvoiced; features_s2_unvoiced; features_s3_unvoiced; features_s4_unvoiced; features_s5_unvoiced; 
%               features_s6_unvoiced; features_s7_unvoiced; features_s8_unvoiced; features_s9_unvoiced; features_s10_unvoiced];       
    
%     features_speech_unvoiced = [
%               features_s1_unvoiced; features_s2_unvoiced; features_s3_unvoiced; features_s4_unvoiced; features_s5_unvoiced];             
%     features_silent = [features_silent1];    
%     features_walk = [features_w1; features_w2];
%     features_bus = [features_b1; features_b2];
%     features_cafe = [features_cafe1; features_cafe2];
%     features_classical = [features_c1; features_c2; features_c3; features_c4];

    % 2-2: plot the scatter plot
    % plot the scatter plot
%     figure;
% %     scatter(features_speech_voiced(:, 2), features_speech_voiced(:, 3));
% %     hold on;
%     scatter(features_speech_unvoiced(:, 2), features_speech_unvoiced(:, 3));
% %     xlabel('Feature 2');
% %     ylabel('Feature 3');
% %     legend('Speech Voiced', 'Non-Speech')    
% %     title([' Feature 1 vs. Feature 2 Scatter Plot']);
%     axis tight
    
    % save the scatter plot
%     saveas(gcf, [audio_file_1 '_'  audio_file_2 '_energy_ratio_likelihood_scatter_plot'], 'jpg'); 
    
%     figure;
%     scatter3(features_speech_voiced(:, 1), features_speech_voiced(:, 2), features_speech_voiced(:, 3));
%     hold on;
%     scatter3(features_speech_unvoiced(:, 1), features_speech_unvoiced(:, 2), features_speech_unvoiced(:, 3));
%     xlabel('Feature 1');
%     ylabel('Feature 2');
%     zlabel('Feature 3');
%     legend('Speech Voiced', 'Speech UnVoiced')    
%     title(['3D Scatter Plot']);
%     axis tight
%     saveas(gcf, ['speech_voiced_speech_unvoiced_scatter_plot'], 'jpg');
%     
%     figure;
%     scatter3(features_speech_voiced(:, 1), features_speech_voiced(:, 2), features_speech_voiced(:, 3));
%     hold on;
%     scatter3(features_silent(:, 1), features_silent(:, 2), features_silent(:, 3));
%     xlabel('Feature 1');
%     ylabel('Feature 2');
%     zlabel('Feature 3');
%     legend('Speech Voiced', 'Silent')    
%     title(['3D Scatter Plot']);
%     axis tight
%     saveas(gcf, ['speech_voiced_silent_scatter_plot'], 'jpg');
%     
%     figure;
%     scatter3(features_speech_voiced(:, 1), features_speech_voiced(:, 2), features_speech_voiced(:, 3));
%     hold on;
%     scatter3(features_walk(:, 1), features_walk(:, 2), features_walk(:, 3));
%     xlabel('Feature 1');
%     ylabel('Feature 2');
%     zlabel('Feature 3');
%     legend('Speech Voiced', 'Walk')    
%     title(['3D Scatter Plot']);
%     axis tight
%     saveas(gcf, ['speech_voiced_walk_scatter_plot'], 'jpg'); 
%     
%     figure;
%     scatter3(features_speech_voiced(:, 1), features_speech_voiced(:, 2), features_speech_voiced(:, 3));
%     hold on;
%     scatter3(features_bus(:, 1), features_bus(:, 2), features_bus(:, 3));
%     xlabel('Feature 1');
%     ylabel('Feature 2');
%     zlabel('Feature 3');
%     legend('Speech Voiced', 'Bus')    
%     title(['3D Scatter Plot']);
%     axis tight
%     saveas(gcf, ['speech_voiced_bus_scatter_plot'], 'jpg');
%     
%     figure;
%     scatter3(features_speech_voiced(:, 1), features_speech_voiced(:, 2), features_speech_voiced(:, 3));
%     hold on;
%     scatter3(features_cafe(:, 1), features_cafe(:, 2), features_cafe(:, 3));
%     xlabel('Feature 1');
%     ylabel('Feature 2');
%     zlabel('Feature 3');
%     legend('Speech Voiced', 'Cafe')    
%     title(['3D Scatter Plot']);
%     axis tight
%     saveas(gcf, ['speech_voiced_cafe_scatter_plot'], 'jpg');
%     
%     figure;
%     scatter3(features_speech_voiced(:, 1), features_speech_voiced(:, 2), features_speech_voiced(:, 3));
%     hold on;
%     scatter3(features_classical(:, 1), features_classical(:, 2), features_classical(:, 3));
%     xlabel('Feature 1');
%     ylabel('Feature 2');
%     zlabel('Feature 3');
%     legend('Speech Voiced', 'Classical')    
%     title(['3D Scatter Plot']);
%     axis tight
%     saveas(gcf, ['speech_voiced_classical_scatter_plot'], 'jpg');
    
    % 2-3: train a GMM-HMM model
    speech_voiced_GMM_model = android_frame_feature_GMM_HMM_model_train(features_speech_voiced(:, 1:3), 2);
    speech_unvoiced_GMM_model = android_frame_feature_GMM_HMM_model_train(features_speech_unvoiced(:, 1:3), 3);
    
    % 2-4: save the model
%     prior = [0.5; 0.5];
%     transmat = [0.974496641110761, 0.0255033588892392; 0.0583775654529558, 0.941622434547044];
%     speech_mu = [speech_unvoiced_gaussian_model.multivariate_mean', speech_voiced_gaussian_model.multivariate_mean'];
%     speech_cov = zeros(3,3,2);
%     speech_cov(:,:,1) = speech_unvoiced_gaussian_model.multivariate_cov;
%     speech_cov(:,:,2) = speech_voiced_gaussian_model.multivariate_cov;
%     save('android_voicing_parameters.mat', 'prior', 'transmat', 'speech_mu', 'speech_cov');

%     framesize = 256;
%     framestep = 128;
%     noise_level = 0.03;
%     num_of_framestep_for_RSE = 300;
%     sampling_rate = 8192;
%     save('global_parameters.mat', 'framesize', 'framestep', 'noise_level', 'num_of_framestep_for_RSE', 'sampling_rate');

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Step#3: testing
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
    % class 1: speech (voiced)
    android_frame_feature_GMM_HMM_model_test ('radio_t1', speech_voiced_GMM_model, speech_unvoiced_GMM_model);
    android_frame_feature_GMM_HMM_model_test ('speech_t2', speech_voiced_GMM_model, speech_unvoiced_GMM_model);
    android_frame_feature_GMM_HMM_model_test ('speech_t3', speech_voiced_GMM_model, speech_unvoiced_GMM_model);
    android_frame_feature_GMM_HMM_model_test ('speech_t4', speech_voiced_GMM_model, speech_unvoiced_GMM_model);    
    android_frame_feature_GMM_HMM_model_test ('speech_indoor_meeting_t1', speech_voiced_GMM_model, speech_unvoiced_GMM_model);
    android_frame_feature_GMM_HMM_model_test ('speech_indoor_meeting_t2', speech_voiced_GMM_model, speech_unvoiced_GMM_model);
    android_frame_feature_GMM_HMM_model_test ('speech_indoor_meeting_t3', speech_voiced_GMM_model, speech_unvoiced_GMM_model);
    android_frame_feature_GMM_HMM_model_test ('speech_indoor_meeting_t4', speech_voiced_GMM_model, speech_unvoiced_GMM_model);
    android_frame_feature_GMM_HMM_model_test ('speech_indoor_meeting_t5', speech_voiced_GMM_model, speech_unvoiced_GMM_model);
    android_frame_feature_GMM_HMM_model_test ('speech_indoor_meeting_t6', speech_voiced_GMM_model, speech_unvoiced_GMM_model);
    android_frame_feature_GMM_HMM_model_test ('speech_indoor_meeting_t7', speech_voiced_GMM_model, speech_unvoiced_GMM_model);    
    
    android_frame_feature_GMM_HMM_model_test ('speech_phonecall_t1', speech_voiced_GMM_model, speech_unvoiced_GMM_model);
    android_frame_feature_GMM_HMM_model_test ('speech_phonecall_t2', speech_voiced_GMM_model, speech_unvoiced_GMM_model);
    
    android_frame_feature_GMM_HMM_model_test ('speech_indoor_restaurant_t1', speech_voiced_GMM_model, speech_unvoiced_GMM_model);
    
    android_frame_feature_GMM_HMM_model_test ('speech_indoor_hallway_t1', speech_voiced_GMM_model, speech_unvoiced_GMM_model);
    android_frame_feature_GMM_HMM_model_test ('speech_indoor_hallway_t3', speech_voiced_GMM_model, speech_unvoiced_GMM_model);
    
    android_frame_feature_GMM_HMM_model_test ('speech_outdoor_standing_t1', speech_voiced_GMM_model, speech_unvoiced_GMM_model);
    android_frame_feature_GMM_HMM_model_test ('speech_outdoor_standing_t3', speech_voiced_GMM_model, speech_unvoiced_GMM_model);    
    
    android_frame_feature_GMM_HMM_model_test ('speech_outdoor_walking_t1', speech_voiced_GMM_model, speech_unvoiced_GMM_model);
    android_frame_feature_GMM_HMM_model_test ('speech_outdoor_walking_t3', speech_voiced_GMM_model, speech_unvoiced_GMM_model);
    
    android_frame_feature_GMM_HMM_model_test ('speech_outdoor_bus_t1', speech_voiced_GMM_model, speech_unvoiced_GMM_model);  
    
    % class 2: Ambient
    % - 'silent'
    android_frame_feature_GMM_HMM_model_test ('silent_t1', speech_voiced_GMM_model, speech_unvoiced_GMM_model);
    % - 'walk'
    android_frame_feature_GMM_HMM_model_test ('walk_t1', speech_voiced_GMM_model, speech_unvoiced_GMM_model);
    android_frame_feature_GMM_HMM_model_test ('walk_t2', speech_voiced_GMM_model, speech_unvoiced_GMM_model);
    android_frame_feature_GMM_HMM_model_test ('walk_t3', speech_voiced_GMM_model, speech_unvoiced_GMM_model);
    android_frame_feature_GMM_HMM_model_test ('walk_t4', speech_voiced_GMM_model, speech_unvoiced_GMM_model);
    android_frame_feature_GMM_HMM_model_test ('walk_t5', speech_voiced_GMM_model, speech_unvoiced_GMM_model);    
    % - 'bus'
    android_frame_feature_GMM_HMM_model_test ('bus_t1', speech_voiced_GMM_model, speech_unvoiced_GMM_model);
    android_frame_feature_GMM_HMM_model_test ('bus_t2', speech_voiced_GMM_model, speech_unvoiced_GMM_model);
    android_frame_feature_GMM_HMM_model_test ('bus_t3', speech_voiced_GMM_model, speech_unvoiced_GMM_model);
    android_frame_feature_GMM_HMM_model_test ('bus_t4', speech_voiced_GMM_model, speech_unvoiced_GMM_model);
    android_frame_feature_GMM_HMM_model_test ('bus_t5', speech_voiced_GMM_model, speech_unvoiced_GMM_model);    
    % - 'cafe'
    android_frame_feature_GMM_HMM_model_test ('cafe_t1', speech_voiced_GMM_model, speech_unvoiced_GMM_model);
    android_frame_feature_GMM_HMM_model_test ('cafe_t2', speech_voiced_GMM_model, speech_unvoiced_GMM_model);
    android_frame_feature_GMM_HMM_model_test ('cafe_t3', speech_voiced_GMM_model, speech_unvoiced_GMM_model);
    android_frame_feature_GMM_HMM_model_test ('cafe_t4', speech_voiced_GMM_model, speech_unvoiced_GMM_model);        
    android_frame_feature_GMM_HMM_model_test ('cafe_t5', speech_voiced_GMM_model, speech_unvoiced_GMM_model);
    
    % class 3: Music
    % - 'classical'         
    android_frame_feature_GMM_HMM_model_test ('classical_t1', speech_voiced_GMM_model, speech_unvoiced_GMM_model);
    android_frame_feature_GMM_HMM_model_test ('classical_t2', speech_voiced_GMM_model, speech_unvoiced_GMM_model);
    android_frame_feature_GMM_HMM_model_test ('classical_t3', speech_voiced_GMM_model, speech_unvoiced_GMM_model);
    android_frame_feature_GMM_HMM_model_test ('classical_t4', speech_voiced_GMM_model, speech_unvoiced_GMM_model);        
    % - 'pop'
%     android_frame_feature_GMM_HMM_model_test ('pop_t1');
%     android_frame_feature_GMM_HMM_model_test ('pop_t2');
%     android_frame_feature_GMM_HMM_model_test ('pop_t3');
%     android_frame_feature_GMM_HMM_model_test ('pop_t4');
%     android_frame_feature_GMM_HMM_model_test ('pop_t5');        
%     android_frame_feature_GMM_HMM_model_test ('pop_t6');
    
    % class 4: TV
%     android_frame_feature_GMM_HMM_model_test ('tv_t1');
%     android_frame_feature_GMM_HMM_model_test ('tv_t2');
%     android_frame_feature_GMM_HMM_model_test ('tv_t3');
%     android_frame_feature_GMM_HMM_model_test ('tv_t4');
%     android_frame_feature_GMM_HMM_model_test ('tv_t5');        
%     android_frame_feature_GMM_HMM_model_test ('tv_t6');
    
    
    
    
    
    
    
    
    
    
    
   
    
    
       
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
    
    

    




