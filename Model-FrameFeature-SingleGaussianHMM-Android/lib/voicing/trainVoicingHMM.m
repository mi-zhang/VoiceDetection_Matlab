function [hmm] = trainVoicingHMM(f, voiced_regions, featureFunction)

%FSelect = features(:,feature_index);


%keyboard;

[speech_mu,speech_cov,prior1,transmat] = compute_voicingHMM(f,voiced_regions);

hmm.mean = speech_mu;
hmm.covariance = speech_cov;
hmm.prior = prior1;
hmm.transmat = transmat;
if(nargin > 3)
    hmm.featureFunction = featureFunction;
end
%hmm.feature_index = feature_index;

