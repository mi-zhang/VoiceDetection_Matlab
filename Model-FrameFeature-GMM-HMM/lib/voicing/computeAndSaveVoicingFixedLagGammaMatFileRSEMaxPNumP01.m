function [] = computeAndSaveVoicingFixedLagGammaMatFileRSEMaxPNumP01(bdir, base, lag, hmmfile)

if(nargin < 4)
    hmmfile = 'C:\documents and Settings\danny\my Documents\work\hsd-matlab\voicing\params\rseMaxPNumP01HMM15360.mat';
end



% load hmm
h = load(hmmfile);

% read features
rse = readBinMat(fullfile(bdir, [base '.relspecent.bin']));
peakVals = readBinMat(fullfile(bdir, [base '.acorr01MaxPeakVal.bin']));
numPeaks = readBinMat(fullfile(bdir, [base '.relspecent.bin']));

features = [peakVals numPeaks rse];


pathfile = fullfile(bdir, [base '.voicing-gamma-lag-' num2str(lag) '.bin'])
[alpha,gamma] = compute_voiced_fixed_lag_gamma(features, h.hmm, lag);
writeBinMat(pathfile, gamma');
