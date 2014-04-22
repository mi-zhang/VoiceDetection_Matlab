function [LL, prior, transmat, obsmat, gamma] = learn_dhmm(data, prior, transmat, obsmat, max_iter, thresh, ...
						  verbose, act, adj_prior, adj_trans, adj_obs, dirichlet)
% LEARN_HMM Find the ML parameters of an HMM with discrete outputs using EM.
%
% [LL, PRIOR, TRANSMAT, OBSMAT] = LEARN_HMM(DATA, PRIOR0, TRANSMAT0, OBSMAT0) 
% computes maximum likelihood estimates of the following parameters,
% where, for each time t, Q(t) is the hidden state, and
% Y(t) is the observation
%   prior(i) = Pr(Q(1) = i)
%   transmat(i,j) = Pr(Q(t+1)=j | Q(t)=i)
%   obsmat(i,o) = Pr(Y(t)=o | Q(t)=i)
% It uses PRIOR0 as the initial estimate of PRIOR, etc.
%
% Row l of DATA is the observation sequence for example l. If the sequences are of
% different lengths, you can pass in a cell array, so DATA{l} is a vector.
% If there is only one sequence, the estimate of prior will be poor.
% If all the sequences are of length 1, transmat cannot be estimated.
%
% LL is the "learning curve": a vector of the log likelihood values at each iteration.
%
% There are several optional arguments, which should be passed in the following order
%   LEARN_HMM(DATA, PRIOR, TRANSMAT, OBSMAT, MAX_ITER, THRESH, VERBOSE)
% These have the following meanings
%   max_iter = max. num EM steps to take (default 10)
%   thresh = threshold for stopping EM (default 1e-4)
%   verbose = 0 to suppress the display of the log lik at each iteration (Default 1).
%
% If the transition matrix is non-stationary (e.g., as in a POMDP),
% then TRANSMAT should be a cell array, where T{a}(i,j) = Pr(Q(t+1)=j|Q(t)=i,A(t)=a).
% The last arg should specify the sequence of actions in the same form as DATA:
%   LEARN_HMM(DATA, PRIOR, TRANSMAT, OBSMAT, MAX_ITER, THRESH, VERBOSE, As)
% The action at time 1 is ignored.
%
% If you want to clamp some of the parameters at fixed values, set the corresponding adjustable
% argument to 0 (default: everything is adjustable)
%   LEARN_HMM(..., VERBOSE, As, ADJ_PRIOR, ADJ_TRANS, ADJ_OBS)
%
% To avoid 0s when estimating OBSMAT, specify a non-zero equivalent sample size (e.g., 0.01) for
% the Dirichlet prior: LEARN_HMM(..., ADJ_OBS, DIRICHLET)
%
% When there is a single sequence, the smoothed posteriors using the penultimate set of
% parameters are returned in GAMMA:
%   [LL, PRIOR, TRANSMAT, OBSMAT, GAMMA] = LEARN_HMM(...)
% This can be useful for online learning and decision making.

%learn_dhmm(data, prior, transmat, obsmat, max_iter, thresh, verbose, act, adj_prior, adj_trans, adj_obs, dirichlet)
if nargin < 5, max_iter = 10; end
if nargin < 6, thresh = 1e-4; end
if nargin < 7, verbose = 1; end
if nargin < 8
  act = [];
  A = 0;
else
  A = length(transmat);
end
if nargin < 9, adj_prior = 1; end
if nargin < 10, adj_trans = 1; end
if nargin < 11, adj_obs = 1; end
if nargin < 12, dirichlet = 0; end

previous_loglik = -inf;
loglik = 0;
converged = 0;
num_iter = 1;
LL = [];

if ~iscell(data)
  data = num2cell(data, 2); % each row gets its own cell
end
if ~isempty(act) & ~iscell(act)
  act = num2cell(act, 2);
end
numex = length(data);


while (num_iter <= max_iter) & ~converged
  % E step
  [loglik, exp_num_trans, exp_num_visits1, exp_num_emit, gamma] = ...
      compute_ess(prior, transmat, obsmat, data, act, dirichlet);

  if verbose, fprintf(1, 'iteration %d, loglik = %f\n', num_iter, loglik); end
  num_iter =  num_iter + 1;

  % M step
  if adj_prior
    prior = normalise(exp_num_visits1);
  end
  if adj_trans & ~isempty(exp_num_trans)
    if isempty(act)
      transmat = mk_stochastic(exp_num_trans);
    else
      for a=1:A
	transmat{a} = mk_stochastic(exp_num_trans{a});
      end
    end
  end
  if adj_obs
    obsmat = mk_stochastic(exp_num_emit);
  end
  
  converged = em_converged(loglik, previous_loglik, thresh);
  previous_loglik = loglik;
  LL = [LL loglik];
end


%%%%%%%%%%%

function [loglik, exp_num_trans, exp_num_visits1, exp_num_emit, gamma] = ...
    compute_ess(prior, transmat, obsmat, data, act, dirichlet)
%
% Compute the Expected Sufficient Statistics for a discrete Hidden Markov Model.
%
% Outputs:
% exp_num_trans(i,j) = sum_l sum_{t=2}^T Pr(X(t-1) = i, X(t) = j| Obs(l))
% exp_num_visits1(i) = sum_l Pr(X(1)=i | Obs(l))
% exp_num_emit(i,o) = sum_l sum_{t=1}^T Pr(X(t) = i, O(t)=o| Obs(l))
% where Obs(l) = O_1 .. O_T for sequence l.

numex = length(data);
[S O] = size(obsmat);
if isempty(act)
  exp_num_trans = zeros(S,S);
  A = 0;
else
  A = length(transmat);
  exp_num_trans = cell(1,A);
  for a=1:A
    exp_num_trans{a} = zeros(S,S);
  end
end
exp_num_visits1 = zeros(S,1);
exp_num_emit = dirichlet*ones(S,O);
loglik = 0;
estimated_trans = 0;

for ex=1:numex
  obs = data{ex};
  T = length(obs);
  olikseq = mk_dhmm_obs_lik(obs, obsmat);
  if isempty(act)
    [gamma, xi, current_ll] = forwards_backwards(prior, transmat, olikseq);
  else
    [gamma, xi, current_ll] = forwards_backwards_pomdp(prior, transmat, olikseq, act{ex});
  end
  loglik = loglik +  current_ll; 

  if T > 1
    estimated_trans = 1;
    if isempty(act)
      exp_num_trans = exp_num_trans + sum(xi,3);
    else
      % act(2) determines Q(2), xi(:,:,1) holds P(Q(1), Q(2))
      A = length(transmat);
      for a=1:A
	ndx = find(act{ex}(2:end)==a);
	if ~isempty(ndx)
	  exp_num_trans{a} = exp_num_trans{a} + sum(xi(:,:,ndx), 3);
	end
      end
    end
  end
  
  exp_num_visits1 = exp_num_visits1 + gamma(:,1);
  
  if T < O
    for t=1:T
      o = obs(t);
      exp_num_emit(:,o) = exp_num_emit(:,o) + gamma(:,t);
    end
  else
    for o=1:O
      ndx = find(obs==o);
      if ~isempty(ndx)
	exp_num_emit(:,o) = exp_num_emit(:,o) + sum(gamma(:, ndx), 2);
      end
    end
  end
end

if ~estimated_trans
  exp_num_trans = [];
end
