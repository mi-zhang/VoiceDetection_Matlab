function loglik = log_lik_ghmm(data, prior, transmat, mu, Sigma)
% LOG_LIK_MHMM Compute the log-likelihood of a dataset using a Gaussian HMM
% loglik = log_lik_ghmm(data, prior, transmat, mu, sigma)

[O T ncases] = size(data);
loglik = 0;
for m=1:ncases
  obslik = mk_ghmm_obs_lik(data(:,:,m), mu, Sigma);
  [alpha, LL, xi] = forwards(prior, transmat, obslik);
  loglik = loglik + LL;
end
