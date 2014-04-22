function [LL, init_state_prob, transmat, mu, Sigma, mu_history] = ...
    learn_ghmm(data, init_state_prob, transmat, mu, Sigma, varargin)
% LEARN_GHMM Compute the ML parameters of an HMM with Gaussian output using EM.
% [LL, init_state_prob, transmat, mu, Sigma, mu_history] = ...
%      learn_ghmm(data, init_state_prob, transmat, mu, Sigma, ...)
%
%  -data(:,t,l) is the observation vector at time t for sequence l. If the sequences are of
%    different lengths, you can pass in a cell array, so DATA{l} is an O*T matrix.
%  - init_state_prob(i) = Pr(Q(1) = i), 
%  - transmat(i,j) = Pr(Q(t+1)=j | Q(t)=i)
%  - mu(:,j) = E[Y(t) | Q(t)=j ]
%  - Sigma(:,:,j) = Cov[Y(t) | Q(t)=j]
%
% LL is the "learning curve": a vector of the log lik. values at each iteration.
% LL might go positive, since prob. densities can exceed 1, although this probably
% indicates that something has gone wrong e.g., a variance has collapsed to 0.
% MU_HISTORY(:,:,r) is MU at iteration r.
%
% Optional arguments passed by name [default]
% - max_iter - max num iterations [10]
% - thresh - threshold for stopping EM [1e-4]
% - verbose - 0 to suppress the display of the log lik at each iteration [1]
% - cov_type - 'full', 'diag' or 'spherical' ['full']
% - static - 1 if we don't want to re-estimate prior and transmat, i.e., no dynamics [0]
% - transmat_prior_strength - for uniform dirichlet prior on transmat [0]
%
% For backwards compatibility, you can also specify arguments as follows
%learn_ghmm(data, init_state_prob, transmat, mu, Sigma,  max_iter, thresh, verbose, cov_type, static)
%
% See "A tutorial on Hidden Markov Models and selected applications in speech recognition",
% L. Rabiner, 1989, Proc. IEEE 77(2):257--286.


max_iter = 10; 
thresh = 1e-4; 
verbose = 1; 
cov_type = 'full'; 
static = 0; 
transmat_prior_strength = 0;

args = varargin;
nargs = length(args);
if nargs > 0
  if ~isstr(args{1}) % old style
    if nargs >= 1 & ~isempty(args{1}), max_iter = args{1}; end
    if nargs >= 2 & ~isempty(args{2}), thresh = args{2}; end
    if nargs >= 3 & ~isempty(args{3}), verbose = args{3}; end
    if nargs >= 4 & ~isempty(args{4}), cov_type = args{4}; end
    if nargs >= 5 & ~isempty(args{5}), static = args{5}; end
  else
    % new style
    for i=1:2:nargs
      switch args{i},
       case 'max_iter', max_iter = args{i+1}; 
       case 'thresh', thresh = args{i+1}; 
       case 'verbose', verbose = args{i+1}; 
       case 'cov_type', cov_type = args{i+1}; 
       case 'static', static = args{i+1}; 
       case 'transmat_prior_strength', transmat_prior_strength = args{i+1}; 
       otherwise,  
	error(['invalid argument name ' args{i}]);
      end
    end
  end
end


if ~iscell(data)
  data = num2cell(data, [1 2]); % each elt of the 3rd dim gets its own cell
end
numex = length(data);
  
previous_loglik = -inf;
loglik = 0;
converged = 0;
iter = 1;
LL = [];

O = size(data{1},1);
Q = length(init_state_prob);
mu_history = zeros(O,Q,max_iter);

transmat_prior = transmat_prior_strength*normalise(ones(Q,Q));

while (iter <= max_iter) & ~converged
  % E step
  [loglik, exp_num_trans, exp_num_visits1, postmix, m, ip, op] = ...
      ess_ghmm(init_state_prob, transmat, mu, Sigma, data);

  if verbose, fprintf('iteration %d, loglik = %f\n', iter, loglik); end

  % M step
  if ~static
    init_state_prob = normalise(exp_num_visits1);
    transmat = mk_stochastic(exp_num_trans + transmat_prior);
  end

  for j=1:Q
    mu(:,j) = m(:,j) / postmix(j);
    if cov_type(1) == 's'
      s2 = (1/O)*( (ip(j)/postmix(j)) - mu(:,j)'*mu(:,j) );
      Sigma(:,:,j) = s2 * eye(O);
    else
      SS = op(:,:,j)/postmix(j) - mu(:,j)*mu(:,j)';
      if cov_type(1)=='d'
	SS = diag(diag(SS));
      end
      Sigma(:,:,j) = SS;
    end
  end
  
  mu_history(:,:,iter) = mu;
  ll_history(iter) = loglik;
  converged = em_converged(loglik, previous_loglik, thresh);
  previous_loglik = loglik;
  iter =  iter + 1;
  LL = [LL loglik];
end


%%%%%%%%%

function [loglik, exp_num_trans, exp_num_visits1, postmix, m, ip, op] = ess_ghmm(prior, transmat, mu, Sigma, data)
% ESS_GHMM Compute the Expected Sufficient Statistics for an HMM with Gaussian outputs.
%
% Outputs:
% exp_num_trans(i,j)   = sum_l sum_{t=2}^T Pr(Q(t-1) = i, Q(t) = j| Obs(l))
% exp_num_visits1(i)   = sum_l Pr(Q(1)=i | Obs(l))
% postmix(i) = sum_l sum_t w(i,t) where w(i,t,l) = Pr(Q(t)=i | Obs(l))  (posterior mixing weights)
% m(:,i)   = sum_l sum_t w(i,t,l) * Obs(:,t,l)
% ip(i) = sum_l sum_t w(i,t,l) * Obs(:,t,l)' * Obs(:,t,l)
% op(:,:,i) = sum_l sum_t w(i,t,l) * Obs(:,t,l) * Obs(:,t,l)'
%
% where Obs(l) = Obs(:,:,l) = O_1 .. O_T for sequence l


verbose = 0;

%[O T numex] = size(data);
numex = length(data);
O = size(data{1},1);
Q = length(prior);
exp_num_trans = zeros(Q,Q);
exp_num_visits1 = zeros(Q,1);
postmix = zeros(Q,1);
m = zeros(O,Q);
op = zeros(O,O,Q);
ip = zeros(Q,1);

loglik = 0;
if verbose, fprintf(1, 'forwards-backwards example # '); end
for ex=1:numex
  if verbose, fprintf(1, '%d ', ex); end
  %obs = data(:,:,ex);
  obs = data{ex};
  T = size(obs,2);
  B = mk_ghmm_obs_lik(obs, mu, Sigma);
  [gamma, xit, current_loglik] = forwards_backwards(prior, transmat, B);
  loglik = loglik +  current_loglik; 
  if verbose, fprintf(1, 'll at ex %d = %f\n', ex, loglik); end
  exp_num_trans = exp_num_trans + sum(xit,3);
  exp_num_visits1 = exp_num_visits1 + gamma(:,1);
  postmix = postmix + sum(gamma,2);
  for j=1:Q
    w = reshape(gamma(j,:), [1 T]); % w(t) = Pr(Q(t)=j | obs)
    wobs = obs .* repmat(w, [O 1]); % wobs(:,t) = w(t) * obs(:,t)
    m(:,j) = m(:,j) + sum(wobs, 2); % m(:) = sum_t w(t) obs(:,t)
    op(:,:,j) = op(:,:,j) + wobs * obs'; % op(:,:) = sum_t w(t) * obs(:,t) * obs(:,t)'
    ip(j) = ip(j) + sum(sum(wobs .* obs, 2)); % ip = sum_t w(t) * obs(:,t)' * obs(:,t)
  end
end
if verbose, fprintf(1, '\n'); end
