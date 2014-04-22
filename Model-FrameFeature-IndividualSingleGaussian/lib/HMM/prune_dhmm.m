function hmm = prune_dhmm(hmm, data, thresh)
% PRUNE_DHMM Prune redundant transitions and observations
% hmm = prune_dhmm(hmm, data, thresh)
%
% We use the criterion in Stolcke's thesis p50

if nargin < 3, thresh = 1e-2; end

[loglik, exp_num_trans, exp_num_visits1, exp_num_emit] = ...
    compute_ess_dhmm(hmm.startprob, hmm.transmat, hmm.obsmat, data, 0);

Q = hmm.nstates;
for i=1:Q
  prune = find(exp_num_trans(i,:) < thresh);
  hmm.transmat(i,prune) = 0;
  prune = find(exp_num_emit(i,:) < thresh);
  hmm.obsmat(i,prune) = 0;
end

