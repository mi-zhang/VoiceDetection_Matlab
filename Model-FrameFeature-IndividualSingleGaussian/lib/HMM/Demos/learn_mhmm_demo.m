if 1
  O = 2;
  T = 5;
  nex = 10;
  M = 2;
  Q = 2;
else
  O = 8;          %Number of coefficients in a vector 
  T = 420;         %Number of vectors in a sequence 
  nex = 1;        %Number of sequences 
  M = 1;          %Number of mixtures 
  Q = 6;          %Number of states 
end


data = randn(O,T,nex);
[prior0, transmat0, mixmat0, mu0, Sigma0] =  init_mhmm(data, Q, M, 'diag', 0);

max_iter = 5;
[LL, prior1, transmat1, mu1, Sigma1, mixmat1] = ...
    learn_mhmm(data, prior0, transmat0, mu0, Sigma0, mixmat0, max_iter);


loglik = log_lik_mhmm(data, prior1, transmat1, mixmat1, mu1, Sigma1);
