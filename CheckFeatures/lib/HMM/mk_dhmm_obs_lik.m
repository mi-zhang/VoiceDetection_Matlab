function B = mk_dhmm_obs_lik(data, obsmat, obsmat1)
% MK_DHMM_OBS_LIK  Make the observation likelihood vector for a discrete HMM.
% B = mk_dhmm_obs_lik(data, obsmat, obsmat1)
%
% Inputs:
% data(t) = y(t) = observation at time t
% obsmat(i,o) = Pr(Y(t)=o | Q(t)=i)
% obsmat1(i,o) = Pr(Y(1)=o | Q(1)=i). Defaults to obsmat if omitted.
%
% Output:
% B(i,t) = Pr(y(t) | Q(t)=i)

if nargin < 3, obsmat1 = obsmat; end

[Q O] = size(obsmat);
T = length(data);
B = zeros(Q,T);

t = 1;
B(:,t) = obsmat1(:, data(t));
for t=2:T
  B(:,t) = obsmat(:, data(t));
end
