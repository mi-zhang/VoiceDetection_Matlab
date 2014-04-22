function [loglik, errors] = log_lik_dhmm(data, prior, transmat, obsmat)
% LOG_LIK_DHMM Compute the log-likelihood of a dataset using a discrete HMM
% [loglik, errors] = log_lik_dhmm(data, prior, transmat, obsmat)
%
% data{m} is the m'th sequence
% errors  is a list of the cases which received a loglik of -infinity

if iscell(data)
  ncases = length(data);
else
  ncases = size(data, 2);
end
loglik = 0;
errors = [];
for m=1:ncases
  if  iscell(data)
    obslik = mk_dhmm_obs_lik(data{m}, obsmat);
  else
    obslik = mk_dhmm_obs_lik(data(:,m), obsmat);
  end
  [alpha, ll] = forwards(prior, transmat, obslik);
  if ll==-inf
    errors = [errors m];
  end
  loglik = loglik + ll;
end
