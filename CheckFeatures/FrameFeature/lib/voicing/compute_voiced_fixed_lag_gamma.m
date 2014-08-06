function [alpha1, gamma1] = compute_voiced_fixed_lag_gamma( features, voicingHMM, lag )


T = size(features,1)
S = 2;
alpha1 = zeros(S, T);
gamma1 = zeros(S, T);
t = 1;
b = mixgauss_prob(features(t,:)', voicingHMM.mean, voicingHMM.covariance);
olik_win = b; % window of conditional observation likelihoods
alpha_win = normalise(voicingHMM.prior .* b);
alpha1(:,t) = alpha_win;
for t=2:T
    b = mixgauss_prob(features(t,:)', voicingHMM.mean, voicingHMM.covariance);
    [alpha_win, olik_win, gamma_win, xi_win] = ...
        fixed_lag_smoother(lag, alpha_win, olik_win, b, voicingHMM.transmat);
    alpha1(:,max(1,t-lag+1):t) = alpha_win;
    gamma1(:,max(1,t-lag+1):t) = gamma_win;
    
    if(rem(t,100)==0), t, end
    
end