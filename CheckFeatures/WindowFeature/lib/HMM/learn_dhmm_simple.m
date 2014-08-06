function [hmm, LL] = learn_dhmm_simple(data, hmm, varargin)
% LEARN_DHMM_SIMPLE Find the ML/MAP params of an HMM with discrete outputs using EM 
%
% [hmm, LL] = learn_dhmm_simple(data, hmm, ...)
%
% Input
%   data{m} is the m'th training sequence.
%   hmm is a structure created with mk_rnd_dhmm.
%
% Output
%   hmm is a structure containing the learned params
%   LL(i) is the log likelihood at iteration i
%
% Optional arguments are passed as name/value pairs, e.g, 
%    learn_dhmm(data, hmm, 'max_iter', 30)
% Defaults are in [brackets]
%
% max_iter - max num iterations [100]
% thresh - threshold for stopping EM (relative change in log-lik must drop below this) [1e-4]
% verbose - 1 means display the log lik at each iteration [0]
% dirichlet - equivalent sample size of a uniform Dirichlet prior applied to obsmat [0]

max_iter = 100;
thresh = 1e-4;
verbose = 0;
dirichlet = 0;

if nargin >= 3
  args = varargin;
  for i=1:2:length(args)
    switch args{i},
     case 'max_iter', max_iter = args{i+1};
     case 'thresh', thresh = args{i+1};
     case 'verbose', verbose = args{i+1};
     case 'dirichlet', dirichlet = args{i+1};
    end
  end
end      

check_score_increases = 1;

previous_loglik = -inf;
loglik = 0;
converged = 0;
num_iter = 1;
LL = [];

if ~iscell(data)
  data = num2cell(data, 2); % each row gets its own cell
end
numex = length(data);

startprob = hmm.startprob;
endprob = hmm.endprob;
transmat = hmm.transmat;
obsmat = hmm.obsmat;
  
while (num_iter <= max_iter) & ~converged
  % E step
  [loglik, exp_num_trans, exp_num_visits1, exp_num_emit, exp_num_visitsT] = ...
      compute_ess_dhmm(startprob, transmat, obsmat, data, dirichlet);
  
  if verbose, fprintf(1, 'iteration %d, loglik = %f\n', num_iter, loglik); end
  num_iter = num_iter + 1;
  
  % M step
  startprob = normalise(exp_num_visits1);
  endprob = normalise(exp_num_visitsT );
  obsmat = mk_stochastic(exp_num_emit);
  transmat = mk_stochastic(exp_num_trans);
  
  converged = em_converged(loglik, previous_loglik, thresh, check_score_increases);
  previous_loglik = loglik;
  LL = [LL loglik];
end


hmm.startprob = startprob;
hmm.endprob = endprob;
hmm.transmat = transmat;
hmm.obsmat = obsmat;

