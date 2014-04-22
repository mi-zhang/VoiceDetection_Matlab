function [p, prob] = parseable_dhmm(hmm, seq)
% PARSEABLE_DHMM Return 1 if there is a non-zero prob of entering an end state given this string, 0 otherwise
% function [p, prob] = parseable_dhmm(hmm, seq)

obslik = mk_dhmm_obs_lik(seq, hmm.obsmat);
[alpha, xi, loglik] = forwards(hmm.startprob, hmm.transmat, obslik);
prob = sum(alpha(:,end) .* hmm.endprob(:));
p = (prob > 0);
