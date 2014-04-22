function [gamma, xi, loglik] = forwards_backwards_pomdp(prior, transmat, obslik, act, filter_only)
% FORWARDS_BACKWARDS_POMDP Compute the posterior probs. in an HMM using the forwards backwards algo.
%
% Use [GAMMA, XI, LOGLIK] = FORWARDS_BACKWARDS(PRIOR, TRANSMAT, OBSLIK)
% Use OBSLIK = MK_DHMM_OBS_LIK(DATA, B) or OBSLIK = MK_GHMM_OBS_LIK(DATA, MU, SIGMA) first.
% 
% Use [GAMMA, XI, LOGLIK, GAMMA2] = FORWARDS_BACKWARDS(PRIOR, TRANSMAT, OBSLIK, ACT)
% for POMDPs, where ACT(t) is the action that inputs to Q(t) (so act(1) is ignored)
%
% FORWARDS_BACKWARDS(PRIOR, TRANSMAT, OBSLIK, ACT, FILTER_ONLY) with FILTER_ONLY = 1
% will just run the forwards algorithm.
% 
% Inputs:
% PRIOR(I) = Pr(Q(1) = I)
% TRANSMAT(I,J) = Pr(Q(T+1)=J | Q(T)=I)
% OBSLIK(I,T) = Pr(Y(T) | Q(T)=I)
% For POMDPs, transmat{a}(i,j) = Pr(Q(t+1)=j | Q(t)=i, A(t)=a)
%
% Outputs:
% gamma(i,t) = Pr(X(t)=i | O(1:T))
% xi(i,j,t)  = Pr(X(t)=i, X(t+1)=j | O(1:T)) t <= T-1

% We don't want to pay the penalty of using transmat{act(t)} instead of transmat
% unless we have to, which is why this is a separate function.

T = size(obslik, 2);
Q = length(prior);

if nargin < 4 | isempty(act)
  act = ones(1, T);
  transmat = { transmat };
end

if nargin < 5, filter_only = 0; end

scale = ones(1,T);
loglik = 0;
prior = prior(:); 
alpha = zeros(Q,T);
gamma = zeros(Q,T);
xi = zeros(Q,Q,T-1);

t = 1;
alpha(:,1) = prior .* obslik(:,t);
[alpha(:,t), scale(t)] = normalise(alpha(:,t));
for t=2:T
  alpha(:,t) = (transmat{act(t)}' * alpha(:,t-1)) .* obslik(:,t);
  [alpha(:,t), scale(t)] = normalise(alpha(:,t));
  if filter_only
    xi(:,:,t-1) = normalise((alpha(:,t-1) * obslik(:,t)') .* transmat{act(t)});
  end
end
loglik = sum(log(scale));

if filter_only
  gamma = alpha;
  return;
end

beta = zeros(Q,T);

beta(:,T) = ones(Q,1);
gamma(:,T) = normalise(alpha(:,T) .* beta(:,T));
t=T;
for t=T-1:-1:1
  b = beta(:,t+1) .* obslik(:,t+1); 
  beta(:,t) = normalise((transmat{act(t+1)} * b));
  gamma(:,t) = normalise(alpha(:,t) .* beta(:,t));
  xi(:,:,t) = normalise((transmat{act(t+1)} .* (alpha(:,t) * b')));
end





