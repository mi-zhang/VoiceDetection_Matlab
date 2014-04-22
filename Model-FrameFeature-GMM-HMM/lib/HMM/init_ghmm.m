function [startprob, transmat, mu, Sigma] =  init_ghmm(cases, K, varargin)
% INIT_GHMM Compute initial param. estimates for an HMM with Gaussian outputs
% [startprob, transmat, mu, Sigma] =  init_ghmm(cases, K, ...)
%
% We concatenate all the data together and treat it as iid, and run K-means
% to get the initial mu/Sigma. startprob and transmat are uniform.
%
% Inputs:
% cases{m}(:,t) = observation vector at time t in sequence m
% K = num. hidden states
%
% Optional inputs [defaults]
% - 'cov_type' - 'full', 'diag' or 'spherical' [ 'full' ]
% - 'max_iter' - max. num. iterations of K-means [10]
%
% Outputs:
% startprob(i) = Pr(Q(1) = i)
% transmat(i,j) = Pr(Q(t+1)=j | Q(t)=i)
% mu(:,j) = E[Y(t)|Q(t)=j]
% Sigma(:,:,j) = Cov[Y(t)|Q(t)=j]


cov_type = 'full';
max_iter = 10;

args = varargin;
nargs = length(args);
for i=1:2:nargs
  switch args{i},
   case 'cov_type',    cov_type = args{i+1}; 
   case 'max_iter',   max_iter = args{i+1};
   otherwise,  
    error(['invalid argument name ' args{i}]); 
  end
end


nex = length(cases);
data = [];
for m=1:nex
  data = [data cases{m}];
end
O = size(data, 1);

startprob = normalise(ones(K,1));
transmat = mk_stochastic(ones(K,K));

% Initialize using K-means (netlab)
mix = gmm(O, K, cov_type);
options = foptions;
options(14) = max_iter;
mix = gmminit(mix, data', options);
mu = mix.centres';
for q=1:K
  switch cov_type
   case 'diag',
    Sigma(:,:,q) = diag(mix.covars(q,:));
   case 'full',
    Sigma(:,:,q) = mix.covars(:,:,q);
   case 'spherical',
    Sigma(:,:,q) = mix.covars(q) * eye(O);
  end
end

