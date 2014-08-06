O = 3;
Q = 2;

% "true" parameters
prior0 = normalise(rand(Q,1));
transmat0 = mk_stochastic(rand(Q,Q));
obsmat0 = mk_stochastic(rand(Q,O));

% training data
T = 5;
nex = 10;
data = sample_dhmm(prior0, transmat0, obsmat0, T, nex);

% initial guess of parameters
prior1 = normalise(rand(Q,1));
transmat1 = mk_stochastic(rand(Q,Q));
obsmat1 = mk_stochastic(rand(Q,O));

% improve guess of parameters using EM
max_iter = 5;
[LL, prior2, transmat2, obsmat2] = learn_dhmm(data, prior1, transmat1, obsmat1, max_iter);



% use model to compute log likelihood
loglik = log_lik_dhmm(data, prior2, transmat2, obsmat2)
