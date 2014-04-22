function [obs, hidden] = sample_dhmm(initial_prob, transmat, obsmat, numex, len)
% SAMPLE_DHMM Generate random sequences from a Hidden Markov Model with discrete outputs.
% [obs, hidden] = sample_dhmm(initial_prob, transmat, obsmat, numex, len)
%
% Each row of obs is an observation sequence of length len.

hidden = sample_mc(initial_prob, transmat, len, numex);
obs = zeros(numex, len);

for i=1:numex
  h = hidden(i,1);
  obs(i,1) = sample_discrete(obsmat(h,:), 1, 1);
  for t=2:len
    h = hidden(i,t);
    obs(i,t) = sample_discrete(obsmat(h,:), 1, 1);
  end
end
