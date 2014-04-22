function B = mk_ghmm_obs_lik(data, mu, Sigma)

    % MK_GHMM_OBS_LIK Make the observation likelihood vector for a Gaussian HMM.
    % B = mk_ghmm_obs_lik(data, mu, Sigma)
    %
    % Inputs:
    % data(:,t) = y(t) = observation vector at time t
    % mu(:,j) = E[Y(t) | Q(t)=j]
    % Sigma(:,:,j) = Cov[Y(t) | Q(t)=j]
    %
    % Output:
    % B(i,t) = Pr(y(t) | Q(t)=i)

    %Q = size(mu, 2);
    sz = size(mu);
    Q = prod(sz(2:end)); % in case it's mu(:,i1,i2,...)
    O = size(data, 1);
    T = size(data, 2);
    B = zeros(Q,T);

    for j = 1:Q
        B(j,:) = gaussian_prob(data, mu(:,j), Sigma(:,:,j))';
    end
    
    
    
    
