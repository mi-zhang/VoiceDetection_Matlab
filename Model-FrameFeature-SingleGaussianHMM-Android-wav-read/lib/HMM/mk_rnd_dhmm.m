function hmm = mk_rnd_dhmm(Q, O)
% MK_RND_DHMM Make an HMM with discrete outputs and random parameters
% function hmm = mk_rnd_dhmm(Q, O)
%
% Q = num states, O = num output symbols
%
% hmm contains the following fields
%   startprob(i) = Pr(Q(1) = i)
%   endprob(i) = Pr(Q(t+1)=end | Q(t)=i)
%   transmat(i,j) = Pr(Q(t+1)=j | Q(t)=i)
%   obsmat(i,o) = Pr(Y(t)=o | Q(t)=i)


hmm.type = 'discrete';
hmm.nstates = Q;
hmm.nobs = O;
hmm.startprob = normalise(rand(Q,1));
hmm.endprob = normalise(rand(Q,1));
hmm.transmat = mk_stochastic(rand(Q,Q));
hmm.obsmat = mk_stochastic(rand(Q,O));
