function [alpha, loglik, xi] = forwards(prior, transmat, obslik, maximize)
% FORWARDS Compute the filtered probs. in an HMM using the forwards  algo.
% [alpha, loglik, xi] = forwards_backwards(prior, transmat, obslik, maximize)
% Use obslik = mk_dhmm_obs_lik(data, B) or obslik = mk_ghmm_obs_lik(data, mu, Sigma) first.
% 
% Inputs:
% prior(i) = Pr(Q(1) = i)
% transmat(i,j) = Pr(Q(t+1)=j | Q(t)=i)
% obslik(i,t) = Pr(y(t) | Q(t)=i)
% maximize is optional; if 1, we do max-product (as in Viterbi) instead of sum-product
%
% Outputs:
% alpha(i,t) = Pr(X(t)=i | O(1:t))
% loglik
% xi(i,j,t)  = Pr(X(t)=i, X(t+1)=j | O(1:t+1)), t <= T-1
%
% Computing xi can take up to 75% of the time. Hence
% We only compute xi if it is requested as a return argument.
%

if nargout < 3
  compute_xi = 0;
else
  compute_xi = 1;
end
if nargin < 4, maximize = 0; end

T = size(obslik, 2);
Q = length(prior);

scale = ones(1,T);
% scale(t) = Pr(O(t) | O(1:t-1))
% Hence prod_t 1/scale(t) = Pr(O(1)) Pr(O(2)|O(1)) Pr(O(3) | O(1:2)) ... = Pr(O(1), ... ,O(T)) = P
% or log P = sum_t log scale(t)

loglik = 0;
prior = prior(:); 

alpha = zeros(Q,T);
if compute_xi
  xi = zeros(Q,Q,T);
else
  xi = [];
end

t = 1;
alpha(:,1) = prior .* obslik(:,t);
[alpha(:,t), scale(t)] = normalise(alpha(:,t));
transmat2 = transmat';
for t=2:T
  if maximize
    A = repmat(alpha(:,t-1), [1 Q]);
    m = max(transmat .* A, [], 1);
    [alpha(:,t),scale(t)] = normalise(m(:) .* obslik(:,t));
  else
    [alpha(:,t),scale(t)] = normalise((transmat2 * alpha(:,t-1)) .* obslik(:,t));
  end
  if compute_xi
    xi(:,:,t-1) = normalise((alpha(:,t-1) * obslik(:,t)') .* transmat);
  end
end
if any(scale==0)
  loglik = -inf;
else
  loglik = sum(log(scale));
end
