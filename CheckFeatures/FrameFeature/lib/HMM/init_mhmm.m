function [init_state_prob, transmat, mixmat, mu, Sigma] =  init_mhmm(data, Q, M, cov_type, left_right)
% INIT_MHMM Compute initial param. estimates for an HMM with mixture of Gaussian outputs.
% [init_state_prob, transmat, obsmat, mixmat, mu, Sigma] = init_mhmm(data, Q, M, cov_type, left_right)
%
% Inputs:
% data(:,t,l) = observation vector at time t in sequence l
% Q = num. hidden states
% M = num. mixture components
% cov_type = 'full', 'diag' or 'spherical'
% left_right = 1 if the model is a left-to-right HMM, 0 otherwise
%
% Outputs:
% init_state_prob(i) = Pr(Q(1) = i)
% transmat(i,j) = Pr(Q(t+1)=j | Q(t)=i)
% mixmat(j,k) = Pr(M(t)=k | Q(t)=j) where M(t) is the mixture component at time t
% mu(:,j,k) = mean of Y(t) given Q(t)=j, M(t)=k
% Sigma(:,:,j,k) = cov. of Y(t) given Q(t)=j, M(t)=k

O = size(data, 1);
T = size(data, 2);
nex = size(data, 3);
data = reshape(data, [O T*nex]);
init_state_prob = normalise(ones(Q,1));
transmat = mk_stochastic(ones(Q,Q));

if M > 1
  mixmat = mk_stochastic(rand(Q,M));
else
  mixmat = ones(Q, 1);
end

if 0
  Sigma = repmat(eye(O), [1 1 Q M]);
  % Initialize each mean to a random data point
  indices = randperm(T);
  mu = reshape(data(:,indices(1:(Q*M))), [O Q M]);
end

% Initialize using K-means, where K = Q*M
% We should really segment the sequence uniformly into Q strips,
% and run M-means on each segment.
mix = gmm(O, Q*M, cov_type);
options = foptions;
max_iter = 5;
options(14) = max_iter;
mix = gmminit(mix, data', options);
mu = reshape(mix.centres', [O Q M]);
i = 1;
for q=1:Q
  for m=1:M
    switch cov_type
      case 'diag',
	Sigma(:,:,q,m) = diag(mix.covars(i,:));
      case 'full',
	Sigma(:,:,q,m) = mix.covars(:,:,i);
      case 'spherical',
	Sigma(:,:,q,m) = mix.covars(i) * eye(O);
    end
    i = i + 1;
  end
end
