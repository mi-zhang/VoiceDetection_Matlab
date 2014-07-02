function [loglik, exp_num_trans, exp_num_visits1, exp_num_emit, exp_num_visitsT] = ...
    compute_ess_dhmm(startprob, transmat, obsmat, data, dirichlet)
%
% Compute the Expected Sufficient Statistics for a discrete Hidden Markov Model.
%
% Outputs:
% exp_num_trans(i,j) = sum_l sum_{t=2}^T Pr(X(t-1) = i, X(t) = j| Obs(l))
% exp_num_visits1(i) = sum_l Pr(X(1)=i | Obs(l))
% exp_num_visitsT(i) = sum_l Pr(X(T)=i | Obs(l)) 
% exp_num_emit(i,o) = sum_l sum_{t=1}^T Pr(X(t) = i, O(t)=o| Obs(l))
% where Obs(l) = O_1 .. O_T for sequence l.

numex = length(data);
[S O] = size(obsmat);
exp_num_trans = zeros(S,S);
exp_num_visits1 = zeros(S,1);
exp_num_visitsT = zeros(S,1);
exp_num_emit = dirichlet*ones(S,O);
loglik = 0;

for ex=1:numex
  obs = data{ex};
  T = length(obs);
  obslik = mk_dhmm_obs_lik(obs, obsmat);
  [gamma, xi, current_ll] = forwards_backwards(startprob, transmat, obslik);
  
  loglik = loglik +  current_ll; 
  exp_num_trans = exp_num_trans + sum(xi,3);
  exp_num_visits1 = exp_num_visits1 + gamma(:,1);
  exp_num_visitsT = exp_num_visitsT + gamma(:,T);
  % loop over whichever is shorter
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
