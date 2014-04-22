

function main_matlab_check_frame_feature_model_train_old ()
    
    % clc;

    % get feature values    
    feature1_ss1 = compute_feature_speech('speech_indoor_meeting_t1', 1);
    feature1_ss2 = compute_feature_speech('speech_indoor_meeting_t2', 1);
    feature1_ss3 = compute_feature_speech('speech_indoor_meeting_t3', 1);
    feature1_ss4 = compute_feature_speech('speech_indoor_meeting_t4', 1);
    feature1_ss5 = compute_feature_speech('speech_indoor_meeting_t5', 1);
    feature1_ss6 = compute_feature_speech('speech_indoor_meeting_t6', 1);
    feature1_ss7 = compute_feature_speech('speech_indoor_meeting_t7', 1);
                
    feature1_ss_unvoiced1 = compute_feature_speech_unvoiced('speech_indoor_meeting_t1', 1);
    feature1_ss_unvoiced2 = compute_feature_speech_unvoiced('speech_indoor_meeting_t2', 1);
    feature1_ss_unvoiced3 = compute_feature_speech_unvoiced('speech_indoor_meeting_t3', 1);
    feature1_ss_unvoiced4 = compute_feature_speech_unvoiced('speech_indoor_meeting_t4', 1);
    feature1_ss_unvoiced5 = compute_feature_speech_unvoiced('speech_indoor_meeting_t5', 1);
    feature1_ss_unvoiced6 = compute_feature_speech_unvoiced('speech_indoor_meeting_t6', 1);
    feature1_ss_unvoiced7 = compute_feature_speech_unvoiced('speech_indoor_meeting_t7', 1);
    
    feature2_ss1 = compute_feature_speech('speech_indoor_meeting_t1', 2);
    feature2_ss2 = compute_feature_speech('speech_indoor_meeting_t2', 2);
    feature2_ss3 = compute_feature_speech('speech_indoor_meeting_t3', 2);
    feature2_ss4 = compute_feature_speech('speech_indoor_meeting_t4', 2);
    feature2_ss5 = compute_feature_speech('speech_indoor_meeting_t5', 2);
    feature2_ss6 = compute_feature_speech('speech_indoor_meeting_t6', 2);
    feature2_ss7 = compute_feature_speech('speech_indoor_meeting_t7', 2);
                
    feature2_ss_unvoiced1 = compute_feature_speech_unvoiced('speech_indoor_meeting_t1', 2);
    feature2_ss_unvoiced2 = compute_feature_speech_unvoiced('speech_indoor_meeting_t2', 2);
    feature2_ss_unvoiced3 = compute_feature_speech_unvoiced('speech_indoor_meeting_t3', 2);
    feature2_ss_unvoiced4 = compute_feature_speech_unvoiced('speech_indoor_meeting_t4', 2);
    feature2_ss_unvoiced5 = compute_feature_speech_unvoiced('speech_indoor_meeting_t5', 2);
    feature2_ss_unvoiced6 = compute_feature_speech_unvoiced('speech_indoor_meeting_t6', 2);
    feature2_ss_unvoiced7 = compute_feature_speech_unvoiced('speech_indoor_meeting_t7', 2);
    
    feature3_ss1 = compute_feature_speech('speech_indoor_meeting_t1', 3);
    feature3_ss2 = compute_feature_speech('speech_indoor_meeting_t2', 3);
    feature3_ss3 = compute_feature_speech('speech_indoor_meeting_t3', 3);
    feature3_ss4 = compute_feature_speech('speech_indoor_meeting_t4', 3);
    feature3_ss5 = compute_feature_speech('speech_indoor_meeting_t5', 3);
    feature3_ss6 = compute_feature_speech('speech_indoor_meeting_t6', 3);
    feature3_ss7 = compute_feature_speech('speech_indoor_meeting_t7', 3);
                
    feature3_ss_unvoiced1 = compute_feature_speech_unvoiced('speech_indoor_meeting_t1', 3);
    feature3_ss_unvoiced2 = compute_feature_speech_unvoiced('speech_indoor_meeting_t2', 3);
    feature3_ss_unvoiced3 = compute_feature_speech_unvoiced('speech_indoor_meeting_t3', 3);
    feature3_ss_unvoiced4 = compute_feature_speech_unvoiced('speech_indoor_meeting_t4', 3);
    feature3_ss_unvoiced5 = compute_feature_speech_unvoiced('speech_indoor_meeting_t5', 3);
    feature3_ss_unvoiced6 = compute_feature_speech_unvoiced('speech_indoor_meeting_t6', 3);
    feature3_ss_unvoiced7 = compute_feature_speech_unvoiced('speech_indoor_meeting_t7', 3);
    
    % compile the training data
    feature1_ss = [feature1_ss1; feature1_ss2; feature1_ss3; feature1_ss4; feature1_ss5; feature1_ss6; feature1_ss7];
    feature2_ss = [feature2_ss1; feature2_ss2; feature2_ss3; feature2_ss4; feature2_ss5; feature2_ss6; feature2_ss7];
    feature3_ss = [feature3_ss1; feature3_ss2; feature3_ss3; feature3_ss4; feature3_ss5; feature3_ss6; feature3_ss7];
    feature1_ss_unvoiced = [feature1_ss_unvoiced1; feature1_ss_unvoiced2; feature1_ss_unvoiced3; feature1_ss_unvoiced4; feature1_ss_unvoiced5; feature1_ss_unvoiced6; feature1_ss_unvoiced7];
    feature2_ss_unvoiced = [feature2_ss_unvoiced1; feature2_ss_unvoiced2; feature2_ss_unvoiced3; feature2_ss_unvoiced4; feature2_ss_unvoiced5; feature2_ss_unvoiced6; feature2_ss_unvoiced7];
    feature3_ss_unvoiced = [feature3_ss_unvoiced1; feature3_ss_unvoiced2; feature3_ss_unvoiced3; feature3_ss_unvoiced4; feature3_ss_unvoiced5; feature3_ss_unvoiced6; feature3_ss_unvoiced7];
    
    feature_ss = [feature1_ss, feature2_ss, feature3_ss];
    feature_ss_unvoiced = [feature1_ss_unvoiced, feature2_ss_unvoiced, feature3_ss_unvoiced];
    
    % train a gaussian model
    ss_model_mean = mean(feature_ss);
    ss_model_cov = cov(feature_ss); 
    
    ss_unvoiced_model_mean = mean(feature_ss_unvoiced);
    ss_unvoiced_model_cov = cov(feature_ss_unvoiced); 
    
    prior = [0.5; 0.5];
    transmat = [0.974496641110761,0.0255033588892392;0.0583775654529558,0.941622434547044];
    speech_mu = [ss_unvoiced_model_mean', ss_model_mean'];
    speech_cov = zeros(3,3,2);
    speech_cov(:,:,1) = ss_unvoiced_model_cov;
    speech_cov(:,:,2) = ss_model_cov;
    save('voicing_parameter_Mi_dataset2.mat','prior','transmat','speech_mu','speech_cov');
    
    fprintf('I am here.\n');
    


    


