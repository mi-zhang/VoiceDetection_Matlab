function [peaks, values, maxpeak, numpeaks, variance, hi, lo, spread, maxPIdx, maxIdx] = acorrFeatures(acorrSlice)


[peaks, values] = find_acorr_peaks(acorrSlice);
[maxpeak, pidx] = max(values);
numpeaks = length(peaks);
variance = var(acorrSlice(2:end));

[hi, maxIdx]  = max(acorrSlice(2:end));
maxIdx = maxIdx + 1;

lo = min(acorrSlice);
spread = hi - lo;

if(length(peaks) == 0)
    maxPIdx = 0;
else
    maxPIdx = peaks(pidx);
end


