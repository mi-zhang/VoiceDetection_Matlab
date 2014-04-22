function [alpha, beta, gamma, loglik] = forwards_backwards_oneslice(prior, transmat, obslik, filter_only)
% FORWARDS_BACKWARDS_ONESLICE Compute the posterior probs. in an HMM using the forwards backwardsalgo.
% [alpha, beta, gamma, loglik] = forwards_backwards_oneslice(prior, transmat, obslik, filter_only)
% Just like forwards_backwards, except we never compute xi, which has size Q*Q*T.

if nargin < 4, filter_only = 0; end

T = size(obslik, 2);
Q = length(prior);

scale = ones(1,T);
loglik = 0;
alpha = zeros(Q,T); 
gamma = zeros(Q,T);

t = 1;
alpha(:,1) = prior(:) .* obslik(:,t);
[alpha(:,t), scale(t)] = normalise(alpha(:,t));
transmat2 = transmat';
for t=2:T
  [alpha(:,t),scale(t)] = normalise((transmat2 * alpha(:,t-1)) .* obslik(:,t));
end
loglik = sum(log(scale));

if filter_only
  beta = [];
  gamma = alpha;
  return;
end

beta = zeros(Q,T); % beta(i,t)  = Pr(O(t+1:T) | X(t)=i)
gamma = zeros(Q,T);
beta(:,T) = ones(Q,1);
gamma(:,T) = normalise(alpha(:,T) .* beta(:,T));
t=T;
for t=T-1:-1:1
  b = beta(:,t+1) .* obslik(:,t+1); 
  beta(:,t) = normalise((transmat * b));
  gamma(:,t) = normalise(alpha(:,t) .* beta(:,t));
end

