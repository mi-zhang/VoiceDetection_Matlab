function [LL, init_state_prob, transmat, mu, Sigma, mixmat, mu_history] = ...
    learn_mhmm(data, init_state_prob, transmat, mu, Sigma, mixmat, ...
    max_iter, thresh, verbose, cov_type, static)
% LEARN_MHMM Compute the ML parameters of an HMM with mixtures of Gaussians output using EM.
% 
% [LL, PRIOR, TRANSMAT, MU, SIGMA, MIXMAT, MU_HISTORY] = LEARN_MHMM(DATA, PRIOR0, TRANSMAT0,
% MU0, SIGMA0, MIXMAT0) computes the ML estimates of the following parameters,
% where, for each time t, Q(t) is the hidden state, M(t) is the mixture component, and Y(t) is
% the observation.
%   prior(i) = Pr(Q(1) = i), 
%   transmat(i,j) = Pr(Q(t+1)=j | Q(t)=i)
%   mixmat(j,k) = Pr(M(t)=k | Q(t)=j) 
%   mu(:,j,k) = E[Y(t) | Q(t)=j, M(t)=k ]
%   Sigma(:,:,j,k) = Cov[Y(t) | Q(t)=j, M(t)=k]
% PRIOR0 is the initial estimate of PRIOR, etc.
% To learn an HMM with a single Gaussian output, just set mixmat = ones(Q,1).
%
% DATA(:,t,l) is the observation vector at time t for sequence l. If the sequences are of
% different lengths, you can pass in a cell array, so DATA{l} is an O*T matrix.
%
% LL is the "learning curve": a vector of the log lik. values at each iteration.
% LL might go positive, since prob. densities can exceed 1, although this probably
% indicates that something has gone wrong e.g., a variance has collapsed to 0.
% MU_HISTORY(:,:,:,r) is MU at iteration r.
%
% There are several optional arguments, which should be passed in the following order
%  LEARN_MHMM(DATA, INIT_STATE_PROB, TRANSMAT, MU, SIGMA, MIXMAT, ...
%    MAX_ITER, THRESH, VERBOSE, COV_TYPE, STATIC)
% These have the following meanings
%
% max_iter = max. num EM steps to take (default 10)
% thresh = threshold for stopping EM (default 1e-4)
% verbose = 0 to suppress the display of the log lik at each iteration (Default 1).
% cov_type = 'full', 'diag' or 'spherical' (default 'full')
% static = 1 if we don't want to re-estimate prior and transmat, i.e., no dynamics (default = 0)
%
% See "A tutorial on Hidden Markov Models and selected applications in speech recognition",
% L. Rabiner, 1989, Proc. IEEE 77(2):257--286.


%learn_mhmm(data, init_state_prob, transmat, mu, Sigma, mixmat, max_iter, thresh, verbose, cov_type, static)

if nargin<7, max_iter = 10; end
if nargin<8, thresh = 1e-4; end
if nargin<9, verbose = 1; end
if nargin<10, cov_type = 'full'; end
if nargin<11, static = 0; end

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
M = size(mixmat,2);
mu_history = zeros(O,Q,M,max_iter);

while (iter <= max_iter) & ~converged
  % E step
  [loglik, exp_num_trans, exp_num_visits1, postmix, m, ip, op] = ...
      ess_mhmm(init_state_prob, transmat, mixmat, mu, Sigma, data);

  if verbose, fprintf('iteration %d, loglik = %f\n', iter, loglik); end

  % M step
  if ~static
    init_state_prob = normalise(exp_num_visits1);
    transmat = mk_stochastic(exp_num_trans);
  end
  if M == 1
    mixmat = ones(Q,1);
  else
    mixmat = mk_stochastic(postmix);
  end

  for j=1:Q
    for k=1:M
      mu(:,j,k) = m(:,j,k) / postmix(j,k);
      
      if cov_type(1) == 's'
	s2 = (1/O)*( (ip(j,k)/postmix(j,k)) - mu(:,j,k)'*mu(:,j,k) );
	Sigma(:,:,j,k) = s2 * eye(O);
      else
	SS = op(:,:,j,k)/postmix(j,k) - mu(:,j,k)*mu(:,j,k)';
	if cov_type(1)=='d'
	  SS = diag(diag(SS));
	end
	Sigma(:,:,j,k) = SS;
      end
      
    end
  end
  
  mu_history(:,:,:,iter) = mu;
  ll_history(iter) = loglik;
  converged = em_converged(loglik, previous_loglik, thresh);
  previous_loglik = loglik;
  iter =  iter + 1;
  LL = [LL loglik];
end


%%%%%%%%%

function [loglik, exp_num_trans, exp_num_visits1, postmix, m, ip, op] = ...
    ess_mhmm(prior, transmat, mixmat, mu, Sigma, data)
% ESS_MHMM Compute the Expected Sufficient Statistics for a MOG Hidden Markov Model.
%
% Outputs:
% exp_num_trans(i,j)   = sum_l sum_{t=2}^T Pr(Q(t-1) = i, Q(t) = j| Obs(l))
% exp_num_visits1(i)   = sum_l Pr(Q(1)=i | Obs(l))
% postmix(i,k) = sum_l sum_t w(i,k,t) where w(i,k,t) = Pr(Q(t)=i, M(t)=k | Obs(l))  (posterior mixing weights)
% m(:,i,k)   = sum_l sum_t w(i,k,l) * Obs(:,t,l)
% ip(i,k) = sum_l sum_t w(i,k,l) * Obs(:,t,l)' * Obs(:,t,l)
% op(:,:,i,k) = sum_l sum_t w(i,k,l) * Obs(:,t,l) * Obs(:,t,l)'
%
% where Obs(l) = Obs(:,:,l) = O_1 .. O_T for sequence l


verbose = 0;

%[O T numex] = size(data);
numex = length(data);
O = size(data{1},1);
Q = length(prior);
M = size(mixmat,2);
exp_num_trans = zeros(Q,Q);
exp_num_visits1 = zeros(Q,1);
postmix = zeros(Q,M);
m = zeros(O,Q,M);
op = zeros(O,O,Q,M);
ip = zeros(Q,M);

loglik = 0;
if verbose, fprintf(1, 'forwards-backwards example # '); end
for ex=1:numex
  if verbose, fprintf(1, '%d ', ex); end
  %obs = data(:,:,ex);
  obs = data{ex};
  T = size(obs,2);
  [B, B2] = mk_mhmm_obs_lik(obs, mu, Sigma, mixmat);
  [gamma, xit, current_loglik, gamma2] = forwards_backwards_mix(prior, transmat, B, B2, mixmat);
  loglik = loglik +  current_loglik; 
  if verbose, fprintf(1, 'll at ex %d = %f\n', ex, loglik); end

  exp_num_trans = exp_num_trans + sum(xit,3);
  exp_num_visits1 = exp_num_visits1 + gamma(:,1);
  postmix = postmix + sum(gamma2,3);
  for j=1:Q
    for k=1:M
      w = reshape(gamma2(j,k,:), [1 T]); % w(t) = Pr(Q(t)=j, M(t)=k | obs)
      wobs = obs .* repmat(w, [O 1]); % wobs(:,t) = w(t) * obs(:,t)
      m(:,j,k) = m(:,j,k) + sum(wobs, 2); % m(:) = sum_t w(t) obs(:,t)
      op(:,:,j,k) = op(:,:,j,k) + wobs * obs'; % op(:,:) = sum_t w(t) * obs(:,t) * obs(:,t)'
      ip(j,k) = ip(j,k) + sum(sum(wobs .* obs, 2)); % ip = sum_t w(t) * obs(:,t)' * obs(:,t)
    end
  end
end
if verbose, fprintf(1, '\n'); end
