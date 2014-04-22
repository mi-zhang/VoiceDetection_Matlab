function [] = computeAndSaveVoicingGammaMatFileRSEMaxPNumP01(bdir, base, hmmfile)

if(nargin < 3)
    hmmfile = 'C:\documents and Settings\danny\my Documents\work\hsd-matlab\voicing\params\rseMaxPNumP01HMM15360.mat';
end

% load hmm
h = load(hmmfile);

% read features
rse = readBinMat(fullfile(bdir, [base '.relspecent.bin']));
peakVals = readBinMat(fullfile(bdir, [base '.acorr01MaxPeakVal.bin']));
numPeaks = readBinMat(fullfile(bdir, [base '.relspecent.bin']));

features = [peakVals numPeaks rse];


[alpha, beta, gamma, loglik] = compute_voiced_gamma( features, h.hmm );

pathfile = fullfile(bdir, [base '.voicing-gamma.bin'])
writeBinMat(pathfile, gamma');

pathfile = fullfile(bdir, [base '.voicing-alpha.bin'])
writeBinMat(pathfile, alpha');

pathfile = fullfile(bdir, [base '.voicing-beta.bin'])
writeBinMat(pathfile, beta');
