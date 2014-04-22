function bel = update_ghmm_bel(prior, data, transmat, mu, Sigma, dirichlet_prior_strength)
% function bel = update_ghmm_bel(prior, data, transmat, mu, Sigma, dirichlet_prior_strength)

if nargin < 6, dirichlet_prior_strength = 0; end

B = mk_ghmm_obs_lik(data, mu, Sigma);
alpha = forwards(prior, transmat, B);
bel = normalise(alpha(:,end) + dirichlet_prior_strength*ones(size(alpha,1),1));
