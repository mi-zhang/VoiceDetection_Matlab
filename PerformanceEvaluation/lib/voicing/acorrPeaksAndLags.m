function [lags, vals] = acorrPeaksAndLags(acorr)

for i=1:size(acorr,1)
    [peaks, values, maxpeak, numpeaks, variance, hi, lo, spread, maxPIdx, maxIdx] = acorrFeatures(acorr(i,:));
    [maxpeakVal, pidx] = max(values);
    lags(i) = peaks(pidx);
    vals(i) = maxpeakVal;
end