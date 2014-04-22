function [] = computeAndSaveVoicingBinFileRSEMaxPNumP01(pdir, base)


recDir = fullfile(pdir, base);

disp(['computing voicing for ' recDir])


if(ispc())
    hmmfile = 'C:\documents and Settings\danny\my Documents\work\hsd-matlab\voicing\params\rseMaxPNumP01HMM15360.mat';
elseif(isunix())
    hmmfile = '/projects/hsd/homes/danny/projects/hsd-matlab/voicing/params/rseMaxPNumP01HMM15360.mat';
end


% load hmm
h = load(hmmfile);

% read features
disp('loading rse...')
rse = readBinMat(fullfile(recDir, [base '.audio_rel_spec_entropy.bin']));
if(nnz(isnan(rse)))
    disp('warning: interpolating nans in rse');
    rse = interpolateNaNs(rse);
    rse = rse(:);
end

disp('loading peak vals...')
peakVals = readBinMat(fullfile(recDir, [base '.audio_max_acorr_peak_val.bin']));
if(nnz(isnan(peakVals)))
    disp('warning: interpolating nans in peakVals');
    peakVals = interpolateNaNs(peakVals);
    peakVals = peakVals(:);
end

disp('loading num peaks...')
numPeaks = readBinMat(fullfile(recDir, [base '.audio_num_acorr_peaks.bin']));
if(nnz(isnan(numPeaks)))
    disp('warning: interpolating nans in numPeaks');
    numPeaks = interpolateNaNs(numPeaks);
    numPeaks = numPeaks(:);
end


%size(peakVals)
%size(numPeaks)
%size(rse)
features = [peakVals numPeaks rse];

% viterbi path
disp('viterbi...')
voicing = compute_voiced_path(features, h.hmm);

disp('saving viterbi...')
pathfile = fullfile(recDir, [base '.voicing_viterbi.bin'])
writeBinMat(pathfile, voicing);


disp('alpha-beta...')
[alpha, beta, gamma, loglik] = compute_voiced_gamma( features, h.hmm );

disp('saving gamma...')
pathfile = fullfile(recDir, [base '.voicing_gamma.bin'])
gamma = gamma';
writeBinMat(pathfile, gamma(:,2));

disp('saving alpha...')
pathfile = fullfile(recDir, [base '.voicing_alpha.bin'])
alpha = alpha';
writeBinMat(pathfile, alpha(:,2));

disp('saving beta...')
pathfile = fullfile(recDir, [base '.voicing_beta.bin'])
beta = beta';
writeBinMat(pathfile, beta(:,2));

disp('...done')