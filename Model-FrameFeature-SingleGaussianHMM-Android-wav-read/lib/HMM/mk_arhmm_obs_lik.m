function B = mk_arhmm_obs_lik(data, mu, Sigma, W, mu0, Sigma0)
% MK_ARHMM_OBS_LIK Make the observation likelihood vector for an autoregressive(1) HMM.
% B = mk_arhmm_obs_lik(data, mu, Sigma, W, mu0, Sigma0)
%
% P(Y(t)=y | Y(t-1)=u, Q(t)=j) = N(y; mu(:,j) + W(:,:,j) * u, Sigma(:,:,j))
% P(Y(1)=y | Q(1)=j) = N(y; mu0(:,j), Sigma0(:,:,j))
% y(t) = data(:,t) = observation vector at time t
%
% Output:
% B(i,t) = Pr(y(t) | Q(t)=i, y(t-1))

[d Q] = size(mu);
[d T] = size(data);
B = zeros(Q,T);

for q=1:Q
  X = data(:, 2:T);
  M = repmat(mu(:,q), 1, T-1) + W(:,:,q) * data(:, 1:T-1);
  C = Sigma(:,:,q);
  Cinv = inv(C);
  denom = (2*pi)^(d/2)*sqrt(abs(det(C)));
  % Let D(i,t) = X(i,t) - M(i).
  % mahal(t) = sum_i,j D(i,t) * invC(i,j) D(j,t)
  % Now, [D'*invC](t,j) = sum_i D(i,t) invC(i,j)
  % so [D'*invC .* D'](t,j) = sum_i D(i,t) invC(i,j) D(j,t)
  D = X-M;
  mahal = sum((D'*Cinv).*D',2);
  B(q,2:T) = exp(-0.5*mahal') / denom;
  assert(~any(isinf(B(q,:))))
end


[d Q0] = size(mu0);
for j=1:Q0
  x = data(:, 1);
  m = mu0(:,j);
  C = Sigma0(:,:,j);
  Cinv = inv(C);
  denom = (2*pi)^(d/2)*sqrt(abs(det(C)));
  mahal = sum(((x-m)'*Cinv).*(x-m)',2); 
  B(j,1) = exp(-0.5*mahal) / denom;
end
