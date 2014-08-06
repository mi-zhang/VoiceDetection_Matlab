

function specent = specentropy(specg)

% function specent = specentropy(specg);
%
% computes the spectral entropy for each frame,
% normalizing each frame to a distribution
% 

    %lspecg = specg;
    normlspecg = specg./(sum(specg')' * ones(1,size(specg,2)) + 1e-5);
    specent = -1*sum(normlspecg' .* logzero(normlspecg)')';

