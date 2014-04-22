function [B, B2] = mk_mhmm_obs_lik(data, mu, Sigma, mixmat)
% MK_MHMM_OBS_LIK Make the observation likelihood vector for a mixture of Gaussians HMM.
% [B, B2] = mk_mhmm_obs_lik(data, mu, Sigma, mixmat)
%
% Inputs:
% data(:,t) = y(t) = observation vector at time t
% mu(:,j,k) = E[Y(t) | Q(t)=j, M(t)=k]
% Sigma(:,:,j,k) = Cov[Y(t) | Q(t)=j, M(t)=k]
% mixmat(j,k) = Pr(M(t)=k | Q(t)=j) where M(t) is the mixture component at time t
%
% Output:
% B(i,t) = Pr(y(t) | Q(t)=i)
% B2(i,k,t) = Pr(y(t) | Q(t)=i, M(t)=k)


Q = size(mixmat, 1);
M = size(mixmat, 2);
O = size(data, 1);
T = size(data, 2);

B2 = zeros(Q,M,T);
B = zeros(Q,T);

for j=1:Q
  for k=1:M
    B2(j,k,:) = gaussian_prob(data, mu(:,j,k), Sigma(:,:,j,k));
  end
end
% B(j,t) = sum_k B2(j,k,t) * Pr(M(t)=k | Q(t)=j) 
B = squeeze(sum(B2 .* repmat(mixmat, [1 1 T]), 2));
B = reshape(B, [Q T]); % in case Q = 1

