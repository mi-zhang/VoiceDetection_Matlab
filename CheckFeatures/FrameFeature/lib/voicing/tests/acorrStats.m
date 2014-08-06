function [n, m, v, hi, lo, s, mpi, hii] = acorrStats(acorr)

for i=1:size(acorr,1)    
    [peaks, values, maxpeak, numpeaks, variance, hiS, loS, spread, maxpeakIdx, hiIdx] = acorrFeatures(acorr(i,:));    
   
    n(i) = numpeaks;
    m(i) = maxpeak;   
    v(i) = variance;
    hi(i) = hiS;
    lo(i) = loS;
    s(i) = spread;
    mpi(i) = maxpeakIdx;
    hii(i)= hiIdx;
end