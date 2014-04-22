function [alpha, loglik, xi] = forwards(prior, transmat, obslik)
% FORWARDS Compute the filtered probs. in an HMM using the forwards  algo.
% [alpha, loglik, xi] = forwards_backwards(prior, transmat, obslik)
% Use obslik = mk_dhmm_obs_lik(data, B) or obslik = mk_ghmm_obs_lik(data, mu, Sigma) first.
% 
% Inputs:
% prior(i) = Pr(Q(1) = i)
% transmat(i,j) = Pr(Q(t+1)=j | Q(t)=i)
% obslik(i,t) = Pr(y(t) | Q(t)=i)
% 
% Outputs:
% alpha(i,t) = Pr(X(t)=i | O(1:t))
% loglik
% xi(i,j,t)  = Pr(X(t)=i, X(t+1)=j | O(1:t+1)), t <= T-1
%
% Computing xi can take up to 75% of the time. Hence
% We only compute xi if it is requested as a return argument.
  
if nargout < 3
  compute_xi = 0;
else
  compute_xi = 1;
end

T = size(obslik, 2);
Q = length(prior);

scaled = 1;
scale = ones(1,T);
% scale(t) = 1/Pr(O(t) | O(1:t-1))
% Hence prod_t 1/scale(t) = Pr(O(1)) Pr(O(2)|O(1)) Pr(O(3) | O(1:2)) ... = Pr(O(1), ... ,O(T)) = P
% or log P = - sum_t log scale(t)
%
% Note, scale(t) = 1/c(t) as defined in Rabiner
% Hence we divide beta(t) by scale(t).
% Alternatively, we can just normalise beta(t) at each step.

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
if scaled
  [alpha(:,t), n] = normalise(alpha(:,t));
  if n==0
    scale(t) = inf;
  else
    scale(t) = 1/n; % scale(t) = 1/(sum_i alpha(i,t))
  end
end

transmat2 = transmat';
for t=2:T
  alpha(:,t) = (transmat2 * alpha(:,t-1)) .* obslik(:,t);
  if scaled
    [alpha(:,t), n] = normalise(alpha(:,t));
    if n==0
      scale(t) = inf;
    else
      scale(t) = 1/n;
    end
  end
  if compute_xi
    xi(:,:,t-1) = normalise((alpha(:,t-1) * obslik(:,t)') .* transmat);
  end
end

if scaled
  loglik = -sum(log(scale));
else
  [dummy, lik] = normalise(alpha(:,T));
  loglik = log(lik);
end
