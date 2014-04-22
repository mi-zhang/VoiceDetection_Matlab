function [gamma, xi, loglik, gamma2] = forwards_backwards_mix(prior, transmat, obslik, obslik2, mixmat, filter_only) 
% FORWARDS_BACKWARDS_MIX Compute the posterior probs. in an HMM using the forwards backwards algo.
%
% Use [GAMMA, XI, LOGLIK] = FORWARDS_BACKWARDS(PRIOR, TRANSMAT, OBSLIK)
% for HMMs where the Y(t) depends only on Q(t).
% Use OBSLIK = MK_DHMM_OBS_LIK(DATA, B) or OBSLIK = MK_GHMM_OBS_LIK(DATA, MU, SIGMA) first.
% If the sequence is of length 1, XI will have size S*S*0.
%
% Use [GAMMA, XI, LOGLIK, GAMMA2] = FORWARDS_BACKWARDS(PRIOR, TRANSMAT, OBSLIK, OBSLIK2, MIXMAT)
% for HMMs where Y(t) depends on Q(t) and M(t), the mixture component.
% Use [OBSLIK, OBSLIK2] = MK_MHMM_OBS_LIK(DATA, MU, SIGMA, MIXMAT) first.
% 
% Use [GAMMA, XI, LOGLIK, GAMMA2] = FORWARDS_BACKWARDS(PRIOR, TRANSMAT, OBSLIK)
%
% FORWARDS_BACKWARDS(PRIOR, TRANSMAT, OBSLIK, [], [], FILTER_ONLY) with FILTER_ONLY = 1
% will just run the forwards algorithm.
% 
% Inputs:
% PRIOR(I) = Pr(Q(1) = I)
% TRANSMAT(I,J) = Pr(Q(T+1)=J | Q(T)=I)
% OBSLIK(I,T) = Pr(Y(T) | Q(T)=I)
%
% For mixture models only:
% OBSLIK2(I,K,T) = Pr(Y(T) | Q(T)=I, M(T)=K)
% MIXMAT(I,K) = Pr(M(T)=K | Q(T)=I)
%
% Outputs:
% gamma(i,t) = Pr(X(t)=i | O(1:T))
% xi(i,j,t)  = Pr(X(t)=i, X(t+1)=j | O(1:T)) t <= T-1
% gamma2(j,k,t) = Pr(Q(t)=j, M(t)=k | O(1:T))


if nargin<4 | isempty(obslik2)
  mix = 0;
  M = 1;
else
  mix = 1;
  M = size(mixmat, 2);
end

T = size(obslik, 2);

if nargin < 6, filter_only = 0; end

Q = length(prior);

scale = ones(1,T);
loglik = 0;
prior = prior(:); 

alpha = zeros(Q,T);
gamma = zeros(Q,T);
xi = zeros(Q,Q,T-1);

t = 1;
alpha(:,1) = prior .* obslik(:,t);
[alpha(:,t), scale(t)] = normalise(alpha(:,t));
transmat2 = transmat';
for t=2:T
  alpha(:,t) = (transmat2 * alpha(:,t-1)) .* obslik(:,t);
  [alpha(:,t), scale(t)] = normalise(alpha(:,t));
  if filter_only
    xi(:,:,t-1) = normalise((alpha(:,t-1) * obslik(:,t)') .* transmat);
  end
end
loglik = sum(log(scale));

if filter_only
  gamma = alpha;
  gamma2 = [];
  return;
end

beta = zeros(Q,T);
gamma2 = zeros(Q,M,T);

beta(:,T) = ones(Q,1);
gamma(:,T) = normalise(alpha(:,T) .* beta(:,T));
t=T;
if mix
  denom = obslik(:,t) + (obslik(:,t)==0); % replace 0s with 1s before dividing
  gamma2(:,:,t) = obslik2(:,:,t) .* mixmat .* repmat(gamma(:,t), [1 M]) ./ repmat(denom, [1 M]);
end
for t=T-1:-1:1
  b = beta(:,t+1) .* obslik(:,t+1); 
  beta(:,t) = normalise((transmat * b));
  gamma(:,t) = normalise(alpha(:,t) .* beta(:,t));
  xi(:,:,t) = normalise((transmat .* (alpha(:,t) * b'))); 
  if mix
    denom = obslik(:,t) + (obslik(:,t)==0); % replace 0s with 1s before dividing
    gamma2(:,:,t) = obslik2(:,:,t) .* mixmat .* repmat(gamma(:,t), [1 M]) ./ repmat(denom, [1 M]);
  end
end


% We now explain the equation for gamma 2
% Let zt=y(1:t-1,t+1:T) be all observations except y(t)
% gamma2(Q,M,t) = P(Qt,Mt|yt,zt) = P(yt|Qt,Mt,zt) P(Qt,Mt|zt) / P(yt|zt)
%                = P(yt|Qt,Mt) P(Mt|Qt) P(Qt|zt) / P(yt|zt)
% Now gamma(Q,t) = P(Qt|yt,zt) = P(yt|Qt) P(Qt|zt) / P(yt|zt)
% hence
% P(Qt,Mt|yt,zt) = P(yt|Qt,Mt) P(Mt|Qt) [P(Qt|yt,zt) P(yt|zt) / P(yt|Qt)] / P(yt|zt)
%                = P(yt|Qt,Mt) P(Mt|Qt) P(Qt|yt,zt) / P(yt|Qt)
%
