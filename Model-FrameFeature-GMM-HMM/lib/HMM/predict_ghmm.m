function [pred_alpha, pred_mu, pred_Sigma] = predict_ghmm(alpha, lag, transmat, mu, Sigma)
% PREDICT_GHMM Predict future belief state and observation for a Gaussian HMM
% [pred_alpha, pred_mu, pred_Sigma] = predict_ghmm(alpha, lag, transmat, mu, Sigma)

if lag == 0
  pred_alpha = alpha;
else
  T = transmat';
  pred_alpha = (T^lag) * alpha;
end
[pred_mu, pred_Sigma] = collapse_mog(mu, Sigma, pred_alpha);
