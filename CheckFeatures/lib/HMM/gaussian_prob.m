function p = gaussian_prob(x, m, C, use_log)
% GAUSSIAN_PROB Evaluate a multivariate Gaussian density.
% p = gaussian_prob(x, m, C, use_log)
%
% p(i) = N(x(:,i), m, C) if use_log = 0 (default)
% p(i) = log N(x(:,i), m, C) if use_log = 1. This prevents underflow.
% p has N rows, where N = num columns in x (num. vectors to evaluate).

if nargin < 4, use_log = 0; end

[d N] = size(x);
%assert(length(m)==d); % slow
m = m(:);
M = m*ones(1,N); % replicate the mean across columns
denom = (2*pi)^(d/2)*sqrt(abs(det(C)));
mahal = sum(((x-M)'*inv(C)).*(x-M)',2);   % Chris Bregler's trick
if use_log
  p = -0.5*mahal - log(denom);
else
  numer = exp(-0.5*mahal);
  p = numer/denom;
end
