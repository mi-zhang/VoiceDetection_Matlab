function [avg, weightedAvg] = mean_pitch(acorrgram, region)


firstpeaks = [];
weightedFirstpeaks = [];

for i=region(1):region(2)
    [peaks, peakvals] = find_acorr_peaks(flipud(acorrgram(:,i)));
    firstpeaks(end+1) = peaks(1);
    weightedFirstpeaks(end+1) = peaks(1)*peakvals(1);
end

avg = mean(firstpeaks);

weightedAvg = mean(weightedFirstpeaks);