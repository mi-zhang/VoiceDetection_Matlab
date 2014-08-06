function [new_mu, new_Sigma] = collapse_mog(mu, Sigma, coefs)
% COLLAPSE_MOG Collapse a mixture of Gaussians to a single Gaussian.
% [new_mu, new_Sigma] = collapse_mog(mu, Sigma, coefs)
%
% coefs(i) - weight of i'th mixture component
% mu(:,i), Sigma(:,:,i) - params of i'th mixture component

new_mu = sum(mu * diag(coefs), 2); % weighted sum of columns

n = length(new_mu);
new_Sigma = zeros(n,n);
for j=1:length(coefs)
  m = mu(:,j) - new_mu;
  new_Sigma = new_Sigma + coefs(j) * (Sigma(:,:,j) + m*m');
end
