function [ path] = compute_voiced_path( features, voicingHMM )
%compute_voiced_path Returns labeled frames.

% use only selected features
%f = features(:, voicingHMM.feature_index);

% compute probability of obersvations
B = mixgauss_prob(features', voicingHMM.mean, voicingHMM.covariance);

% compute most likely states
path = viterbi_path(voicingHMM.prior, voicingHMM.transmat, B);