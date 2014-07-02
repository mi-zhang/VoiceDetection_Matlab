function loglik = log_lik_mhmm(data, prior, transmat, mixmat, mu, Sigma)
% LOG_LIK_MHMM Compute the log-likelihood of a dataset using a mixture of Gaussians HMM
% loglik = log_lik_mhmm(data, prior, transmat, mixmat, mu, sigma)

[O T ncases] = size(data);
loglik = 0;
for m=1:ncases
  obslik = mk_mhmm_obs_lik(data(:,:,m), mu, Sigma, mixmat);
  [alpha, LL, xi] = forwards(prior, transmat, obslik);
  loglik = loglik + LL;
end
