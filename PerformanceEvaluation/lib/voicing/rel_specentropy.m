function rel_specent = rel_specentropy(specg_sig,specg_mean);
% function specent = rel_specentropy(specg);
%
% computes the relative spectral entropy for each frame,
% normalizing each frame to a distribution
% 
% 06/16/02

normlspecg_sig = normalize_specgram(specg_sig) + 1e-30; % to prevent zero entries
normlspecg_mean = normalize_specgram(specg_mean) + 1e-30;
rel_specent = sum(normlspecg_sig' .* (log(normlspecg_sig)' - log(normlspecg_mean)'))';