

function frac = sb_lowbandenfrac(specg)

% function frac = sb_lowbandenfrac(specg);
%
% computes the fraction of energy in the lower half band

    numbands = size(specg,2);

    mid = round(numbands/2);
    lowen = sum(specg(:, 1:mid)')';
    hien = sum(specg(:, mid+1:numbands)')';

    frac = (lowen+1e-5)./ (hien+1e-5);
