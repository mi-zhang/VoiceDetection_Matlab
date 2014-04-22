

function results = infer(raw_audio_data, sampling_rate, framesize, framestep, noise_level, num_of_framestep_for_RSE)


    warning off
    
    % import library 
    addpath('./lib/voicing/')
    addpath('./lib/HMM/')
    
    % load trained voice detection HMM model parameters
    load voicing_parameters.mat

    % calculate audio features
    features = audio_feature_extraction(raw_audio_data, framesize, framestep, noise_level, num_of_framestep_for_RSE);
    
    % calculate the likelihood (B)
    B = mk_ghmm_obs_lik(features(:, 1:3)', speech_mu, speech_cov);
    % B(1,:) is the nonvoiced likelihood
    % B(2,:) is the voiced likelihood
    
%     obsLikNan =  mk_ghmm_obs_lik(speech_mu(:,1), speech_mu, speech_cov);
%     B(1,isnan(B(1,:) + B(2,:))) = obsLikNan(1); % make them nonvoice
%     B(2,isnan(B(1,:) + B(2,:))) = obsLikNan(2); % make them voice

    % do inference and output inference results (P)
    [P, loglik] = viterbi_path(prior, transmat, B);

    % output results
    results = [P' B' features];
    
    % save results
%     save('results.mat', 'results');








