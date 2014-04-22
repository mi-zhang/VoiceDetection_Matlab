

function main_matlab_check_energy_ratio ()
    
    % clc;

    % get energy ratio feature values
    feature_silent1 = compute_feature_nonspeech('silent_t1', 7);
    
    feature_c1 = compute_feature_nonspeech('classical_t1', 7);
    feature_c2 = compute_feature_nonspeech('classical_t2', 7);
    feature_c3 = compute_feature_nonspeech('classical_t3', 7);
    feature_c4 = compute_feature_nonspeech('classical_t4', 7);       
    
    feature_p1 = compute_feature_nonspeech('pop_t1', 7);
    feature_p2 = compute_feature_nonspeech('pop_t2', 7);
    feature_p3 = compute_feature_nonspeech('pop_t3', 7);
    feature_p4 = compute_feature_nonspeech('pop_t4', 7);
    feature_p5 = compute_feature_nonspeech('pop_t5', 7);
    feature_p6 = compute_feature_nonspeech('pop_t6', 7); 
    
    feature_s1 = compute_feature_speech('radio_t1', 7);
    feature_s2 = compute_feature_speech('speech_t2', 7);
    feature_s3 = compute_feature_speech('speech_t3', 7);
    feature_s4 = compute_feature_speech('speech_t4', 7);

    % compile the training data together
    feature_silent = feature_silent1;    
    feature_c = [feature_c1; feature_c2; feature_c3; feature_c4];
    feature_p = [feature_p1; feature_p2; feature_p3; feature_p4; feature_p5; feature_p6];
    feature_s = [feature_s1; feature_s2; feature_s3; feature_s4];
    
    % transform into log scale
    energy_ratio_silent = log10(feature_silent);
    energy_ratio_c = log10(feature_c);
    energy_ratio_p = log10(feature_p);
    energy_ratio_s = log10(feature_s);
    
    % train the Gaussian model
    gaussian_model_silent = [mean(energy_ratio_silent) std(energy_ratio_silent)]; 
    gaussian_model_c = [mean(energy_ratio_c) std(energy_ratio_c)];
    gaussian_model_p = [mean(energy_ratio_p) std(energy_ratio_p)];
    gaussian_model_s = [mean(energy_ratio_s) std(energy_ratio_s)];    
        
    % train the Gaussian model
%     gaussian_model_silent = fitdist(energy_ratio_silent, 'Normal');
%     gaussian_model_c = fitdist(energy_ratio_c, 'Normal');
%     gaussian_model_p = fitdist(energy_ratio_p, 'Normal');    
%     gaussian_model_s = fitdist(energy_ratio_s, 'Normal');       
    
    % train the GMM model
%     gmm_model_silent = gmdistribution.fit(energy_ratio_silent, 1);
%     gmm_model_c = gmdistribution.fit(energy_ratio_c, 1);
%     gmm_model_p = gmdistribution.fit(energy_ratio_p, 2);
%     gmm_model_s = gmdistribution.fit(energy_ratio_s, 2);

    % test (this is sanity check!)
    main_matlab_check_energy_ratio_test(gaussian_model_silent, gaussian_model_c, gaussian_model_p, gaussian_model_s, 'silent_t1');
        
    main_matlab_check_energy_ratio_test(gaussian_model_silent, gaussian_model_c, gaussian_model_p, gaussian_model_s, 'classical_t1');
    main_matlab_check_energy_ratio_test(gaussian_model_silent, gaussian_model_c, gaussian_model_p, gaussian_model_s, 'classical_t2');
    main_matlab_check_energy_ratio_test(gaussian_model_silent, gaussian_model_c, gaussian_model_p, gaussian_model_s, 'classical_t3');
    main_matlab_check_energy_ratio_test(gaussian_model_silent, gaussian_model_c, gaussian_model_p, gaussian_model_s, 'classical_t4');
    
    main_matlab_check_energy_ratio_test(gaussian_model_silent, gaussian_model_c, gaussian_model_p, gaussian_model_s, 'radio_t1');
    main_matlab_check_energy_ratio_test(gaussian_model_silent, gaussian_model_c, gaussian_model_p, gaussian_model_s, 'speech_t2');
    main_matlab_check_energy_ratio_test(gaussian_model_silent, gaussian_model_c, gaussian_model_p, gaussian_model_s, 'speech_t3');
    main_matlab_check_energy_ratio_test(gaussian_model_silent, gaussian_model_c, gaussian_model_p, gaussian_model_s, 'speech_t4');
   
    main_matlab_check_energy_ratio_test(gaussian_model_silent, gaussian_model_c, gaussian_model_p, gaussian_model_s, 'pop_t1');
    main_matlab_check_energy_ratio_test(gaussian_model_silent, gaussian_model_c, gaussian_model_p, gaussian_model_s, 'pop_t2');
    main_matlab_check_energy_ratio_test(gaussian_model_silent, gaussian_model_c, gaussian_model_p, gaussian_model_s, 'pop_t3');
    main_matlab_check_energy_ratio_test(gaussian_model_silent, gaussian_model_c, gaussian_model_p, gaussian_model_s, 'pop_t4');
    main_matlab_check_energy_ratio_test(gaussian_model_silent, gaussian_model_c, gaussian_model_p, gaussian_model_s, 'pop_t5');
    main_matlab_check_energy_ratio_test(gaussian_model_silent, gaussian_model_c, gaussian_model_p, gaussian_model_s, 'pop_t6'); 
        
    fprintf('I am here.\n');
    
    
    
    
    

    


