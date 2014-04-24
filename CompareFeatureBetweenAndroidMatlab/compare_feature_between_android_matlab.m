

function compare_feature_between_android_matlab ()

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
    
    % global parameters
    framesize = 256;
    framestep = 128;
    noise_level = 0.02;
    num_of_framestep_for_RSE = 500;
    sampling_rate = 8192;
    save('global_parameters.mat', 'framesize', 'framestep', 'noise_level', 'num_of_framestep_for_RSE', 'sampling_rate');

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Step#1: load Android computed frame-level features  
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % class 1: Speech (voiced) (HLH)
%     features_android_s1 = load_android_features_speech_wav_reading('speech_indoor_meeting_t1'); % right
%     features_android_s2 = load_android_features_speech_wav_reading('speech_indoor_restaurant_t1'); % right
%     features_android_s3 = load_android_features_speech_wav_reading('speech_indoor_hallway_t1'); % right
%     features_android_s4 = load_android_features_speech_wav_reading('speech_outdoor_standing_t1'); % right
%     features_android_s5 = load_android_features_speech_wav_reading('speech_outdoor_walking_t1'); % right
%     features_android_s6 = load_android_features_speech_wav_reading('speech_outdoor_standing_t3'); % right
%     features_android_s7 = load_android_features_speech_wav_reading('speech_t2'); % right
%     features_android_s8 = load_android_features_speech_wav_reading('speech_indoor_meeting_t2'); % right
%     features_android_s9 = load_android_features_speech_wav_reading('speech_indoor_meeting_t3'); % right
%     features_android_s10 = load_android_features_speech_wav_reading('speech_indoor_meeting_t4'); % right
%     features_android_s11 = load_android_features_speech_wav_reading('speech_indoor_meeting_t5'); % right
%     features_android_s12 = load_android_features_speech_wav_reading('speech_indoor_meeting_t6'); % right
%     features_android_s13 = load_android_features_speech_wav_reading('speech_indoor_meeting_t7'); % right
%     features_android_s14 = load_android_features_speech_wav_reading('speech_t3'); % right
%     features_android_s15 = load_android_features_speech_wav_reading('speech_t4'); % right
%     features_android_s16 = load_android_features_speech_wav_reading('radio_t1'); % right
%                 
%     % class 2: Speech (unvoiced) and Silence (LHL)   
%     % - speech unvoiced
%     features_android_s1_unvoiced = load_android_features_speech_unvoiced_wav_reading('speech_indoor_meeting_t1');
%     features_android_s2_unvoiced = load_android_features_speech_unvoiced_wav_reading('speech_indoor_restaurant_t1');
%     features_android_s3_unvoiced = load_android_features_speech_unvoiced_wav_reading('speech_indoor_hallway_t1');
%     features_android_s4_unvoiced = load_android_features_speech_unvoiced_wav_reading('speech_outdoor_standing_t1');
%     features_android_s5_unvoiced = load_android_features_speech_unvoiced_wav_reading('speech_outdoor_walking_t1'); 
%     features_android_s6_unvoiced = load_android_features_speech_unvoiced_wav_reading('speech_outdoor_standing_t3');
%     features_android_s7_unvoiced = load_android_features_speech_unvoiced_wav_reading('speech_t2');
%     features_android_s8_unvoiced = load_android_features_speech_unvoiced_wav_reading('speech_indoor_meeting_t2');
%     features_android_s9_unvoiced = load_android_features_speech_unvoiced_wav_reading('speech_indoor_meeting_t3');
%     features_android_s10_unvoiced = load_android_features_speech_unvoiced_wav_reading('speech_indoor_meeting_t4');
%     features_android_s11_unvoiced = load_android_features_speech_unvoiced_wav_reading('speech_indoor_meeting_t5');
%     features_android_s12_unvoiced = load_android_features_speech_unvoiced_wav_reading('speech_indoor_meeting_t6');
%     features_android_s13_unvoiced = load_android_features_speech_unvoiced_wav_reading('speech_indoor_meeting_t7');
%     features_android_s14_unvoiced = load_android_features_speech_unvoiced_wav_reading('speech_t3');
%     features_android_s15_unvoiced = load_android_features_speech_unvoiced_wav_reading('speech_t4');
%     features_android_s16_unvoiced = load_android_features_speech_unvoiced_wav_reading('radio_t1');  
% 
%     % - 'silent'
%     features_android_silent1 = load_android_features_nonspeech_wav_reading('silent_t1'); % right
%     
%     % class 3: Ambient (LLL)
%     % - 'walk'
    features_android_w1 = load_android_features_nonspeech_wav_reading('walk_t1'); % right
%     features_android_w2 = load_android_features_nonspeech_wav_reading('walk_t2');
%     features_android_w3 = load_android_features_nonspeech_wav_reading('walk_t3');
%     features_android_w4 = load_android_features_nonspeech_wav_reading('walk_t4'); % right
%     features_android_w5 = load_android_features_nonspeech_wav_reading('walk_t5');    
%     % - 'bus'
%     features_android_b1 = load_android_features_nonspeech_wav_reading('bus_t1');
% %     features_android_b2 = load_android_features_nonspeech_wav_reading('bus_t2'); % this is broken !!!
%     features_android_b3 = load_android_features_nonspeech_wav_reading('bus_t3'); % right
%     features_android_b4 = load_android_features_nonspeech_wav_reading('bus_t4');
%     features_android_b5 = load_android_features_nonspeech_wav_reading('bus_t5');
%     % - 'cafe'
%     features_android_cafe1 = load_android_features_nonspeech_wav_reading('cafe_t1');
%     features_android_cafe2 = load_android_features_nonspeech_wav_reading('cafe_t2');
%     features_android_cafe3 = load_android_features_nonspeech_wav_reading('cafe_t3');  % right
%     features_android_cafe4 = load_android_features_nonspeech_wav_reading('cafe_t4');  % right
%     features_android_cafe5 = load_android_features_nonspeech_wav_reading('cafe_t5');  % right
    
    % class 4: Music
    % - 'classical'
%     features_android_c1 = load_android_features_nonspeech_wav_reading('classical_t1');
%     features_android_c2 = load_android_features_nonspeech_wav_reading('classical_t2');
%     features_android_c3 = load_android_features_nonspeech_wav_reading('classical_t3');
%     features_android_c4 = load_android_features_nonspeech_wav_reading('classical_t4');
    % - 'pop'
%     features_android_p1 = load_android_features_nonspeech_wav_reading('pop_t1');
%     features_android_p2 = load_android_features_nonspeech_wav_reading('pop_t2');
%     features_android_p3 = load_android_features_nonspeech_wav_reading('pop_t3');
%     features_android_p4 = load_android_features_nonspeech_wav_reading('pop_t4');
%     features_android_p5 = load_android_features_nonspeech_wav_reading('pop_t5');
%     features_android_p6 = load_android_features_nonspeech_wav_reading('pop_t6');
    
    % class 5: TV
%     features_android_tv1 = load_android_features_nonspeech_wav_reading('tv_t1');
%     features_android_tv2 = load_android_features_nonspeech_wav_reading('tv_t2');
%     features_android_tv3 = load_android_features_nonspeech_wav_reading('tv_t3');
%     features_android_tv4 = load_android_features_nonspeech_wav_reading('tv_t4');
%     features_android_tv5 = load_android_features_nonspeech_wav_reading('tv_t5');
%     features_android_tv6 = load_android_features_nonspeech_wav_reading('tv_t6');
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Step#2: compute frame-level features using Matlab
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % class 1: Speech (voiced) (HLH)
%     features_matlab_s1 = compute_features_speech('speech_indoor_meeting_t1'); % right
%     features_matlab_s2 = compute_features_speech('speech_indoor_restaurant_t1'); % right
%     features_matlab_s3 = compute_features_speech('speech_indoor_hallway_t1'); % right
%     features_matlab_s4 = compute_features_speech('speech_outdoor_standing_t1'); % right
%     features_matlab_s5 = compute_features_speech('speech_outdoor_walking_t1'); % right
%     features_matlab_s6 = compute_features_speech('speech_outdoor_standing_t3'); % right
%     features_matlab_s7 = compute_features_speech('speech_t2'); % right
%     features_matlab_s8 = compute_features_speech('speech_indoor_meeting_t2'); % right
%     features_matlab_s9 = compute_features_speech('speech_indoor_meeting_t3'); % right
%     features_matlab_s10 = compute_features_speech('speech_indoor_meeting_t4'); % right
%     features_matlab_s11 = compute_features_speech('speech_indoor_meeting_t5'); % right
%     features_matlab_s12 = compute_features_speech('speech_indoor_meeting_t6'); % right
%     features_matlab_s13 = compute_features_speech('speech_indoor_meeting_t7'); % right
%     features_matlab_s14 = compute_features_speech('speech_t3'); % right
%     features_matlab_s15 = compute_features_speech('speech_t4'); % right
%     features_matlab_s16 = compute_features_speech('radio_t1'); % right    
%                 
%     % class 2: Speech (unvoiced) and Silence (LHL)   
%     % - speech unvoiced
%     features_matlab_s1_unvoiced = compute_features_speech_unvoiced('speech_indoor_meeting_t1');
%     features_matlab_s2_unvoiced = compute_features_speech_unvoiced('speech_indoor_restaurant_t1');
%     features_matlab_s3_unvoiced = compute_features_speech_unvoiced('speech_indoor_hallway_t1');
%     features_matlab_s4_unvoiced = compute_features_speech_unvoiced('speech_outdoor_standing_t1');
%     features_matlab_s5_unvoiced = compute_features_speech_unvoiced('speech_outdoor_walking_t1'); 
%     features_matlab_s6_unvoiced = compute_features_speech_unvoiced('speech_outdoor_standing_t3');
%     features_matlab_s7_unvoiced = compute_features_speech_unvoiced('speech_t2');
%     features_matlab_s8_unvoiced = compute_features_speech_unvoiced('speech_indoor_meeting_t2');
%     features_matlab_s9_unvoiced = compute_features_speech_unvoiced('speech_indoor_meeting_t3');
%     features_matlab_s10_unvoiced = compute_features_speech_unvoiced('speech_indoor_meeting_t4');
%     features_matlab_s11_unvoiced = compute_features_speech_unvoiced('speech_indoor_meeting_t5');
%     features_matlab_s12_unvoiced = compute_features_speech_unvoiced('speech_indoor_meeting_t6');
%     features_matlab_s13_unvoiced = compute_features_speech_unvoiced('speech_indoor_meeting_t7');
%     features_matlab_s14_unvoiced = compute_features_speech_unvoiced('speech_t3');
%     features_matlab_s15_unvoiced = compute_features_speech_unvoiced('speech_t4');
%     features_matlab_s16_unvoiced = compute_features_speech_unvoiced('radio_t1');  
% 
%     % - 'silent'
%     features_matlab_silent1 = compute_features_speech_unvoiced('silent_t1'); % right
%         
%     % class 3: Ambient (LLL)
%     % - 'walk'
    features_matlab_w1 = compute_features_nonspeech('walk_t1'); % right
%     features_matlab_w2 = compute_features_nonspeech('walk_t2');
%     features_matlab_w3 = compute_features_nonspeech('walk_t3');
%     features_matlab_w4 = compute_features_nonspeech('walk_t4'); % right
%     features_matlab_w5 = compute_features_nonspeech('walk_t5');    
%     % - 'bus'
%     features_matlab_b1 = compute_features_nonspeech('bus_t1');
% %     features_matlab_b2 = compute_features_nonspeech('bus_t2'); % this is broken !!!
%     features_matlab_b3 = compute_features_nonspeech('bus_t3'); % right
%     features_matlab_b4 = compute_features_nonspeech('bus_t4');
%     features_matlab_b5 = compute_features_nonspeech('bus_t5');
%     % - 'cafe'
%     features_matlab_cafe1 = compute_features_nonspeech('cafe_t1');
%     features_matlab_cafe2 = compute_features_nonspeech('cafe_t2');
%     features_matlab_cafe3 = compute_features_nonspeech('cafe_t3');  % right
%     features_matlab_cafe4 = compute_features_nonspeech('cafe_t4');  % right
%     features_matlab_cafe5 = compute_features_nonspeech('cafe_t5');  % right
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Step#3: compare Android calcuated and Matlab calculated features
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%     figure;
%     plot(features_android_s1(201:500, 1), '--b')
%     hold on
%     plot(features_matlab_s1(201:500, 1), ':r')
%     hold off
%     legend('Android','Matlab')
%     title('voiced speech - speech_indoor_meeting_t1 - f1 (maxAcorrPeakVal)')
%     axis tight
%     
%     % save the plot
%     saveas(gcf, ['feature_comparison_speech_indoor_meeting_t1_voiced_speech_f1'], 'jpg');
%     
%     figure;
%     plot(features_android_s1(201:500, 2), '--b')
%     hold on
%     plot(features_matlab_s1(201:500, 2), ':r')
%     hold off
%     legend('Android','Matlab')
%     title('voiced speech - speech_indoor_meeting_t1 - f2 (numAcorrPeaks)')
%     axis tight
%     
%     % save the plot
%     saveas(gcf, ['feature_comparison_speech_indoor_meeting_t1_voiced_speech_f2'], 'jpg');
%     
%     figure;
%     plot(features_android_s1(201:500, 3), '--b')
%     hold on
%     plot(features_matlab_s1(201:500, 3), ':r')
%     hold off
%     legend('Android','Matlab')
%     title('voiced speech - speech_indoor_meeting_t1 - f3 (RSE)')
%     axis tight
%     
%     % save the plot
%     saveas(gcf, ['feature_comparison_speech_indoor_meeting_t1_voiced_speech_f3'], 'jpg');
  
%     figure;
%     plot(features_android_s1_unvoiced(201:500, 1), '--b')
%     hold on
%     plot(features_matlab_s1_unvoiced(201:500, 1), ':r')
%     hold off
%     legend('Android','Matlab')
%     title('unvoiced speech - speech_indoor_meeting_t1 - f1 (maxAcorrPeakVal)')
%     axis tight
%     
%     % save the plot
%     saveas(gcf, ['feature_comparison_speech_indoor_meeting_t1_unvoiced_speech_f1'], 'jpg');
%     
%     figure;
%     plot(features_android_s1_unvoiced(201:500, 2), '--b')
%     hold on
%     plot(features_matlab_s1_unvoiced(201:500, 2), ':r')
%     hold off
%     legend('Android','Matlab')
%     title('unvoiced speech - speech_indoor_meeting_t1 - f2 (numAcorrPeaks)')
%     axis tight
%     
%     % save the plot
%     saveas(gcf, ['feature_comparison_speech_indoor_meeting_t1_unvoiced_speech_f2'], 'jpg');
%     
%     figure;
%     plot(features_android_s1_unvoiced(201:500, 3), '--b')
%     hold on
%     plot(features_matlab_s1_unvoiced(201:500, 3), ':r')
%     hold off
%     legend('Android','Matlab')
%     title('unvoiced speech - speech_indoor_meeting_t1 - f3 (RSE)')
%     axis tight
%     
%     % save the plot
%     saveas(gcf, ['feature_comparison_speech_indoor_meeting_t1_unvoiced_speech_f3'], 'jpg');
    
    figure;
    plot(features_android_w1(201:500, 1), '--b')
    hold on
    plot(features_matlab_w1(201:500, 1), ':r')
    hold off
    legend('Android','Matlab')
    title('walk_t1 - f1 (maxAcorrPeakVal)')
    axis tight
    
    % save the plot
    saveas(gcf, ['feature_comparison_walk_t1_f1'], 'jpg');
    
    figure;
    plot(features_android_w1(201:500, 2), '--b')
    hold on
    plot(features_matlab_w1(201:500, 2), ':r')
    hold off
    legend('Android','Matlab')
    title('walk_t1 - f2 (numAcorrPeaks)')
    axis tight
    
    % save the plot
    saveas(gcf, ['feature_comparison_walk_t1_f2'], 'jpg');
    
    figure;
    plot(features_android_w1(201:500, 3), '--b')
    hold on
    plot(features_matlab_w1(201:500, 3), ':r')
    hold off
    legend('Android','Matlab')
    title('walk_t1 - f3 (RSE)')
    axis tight
    
    % save the plot
    saveas(gcf, ['feature_comparison_walk_t1_f3'], 'jpg');
    
    disp('I am done');
    
    
    
    
    
    
    
    
    
    
    
    
    