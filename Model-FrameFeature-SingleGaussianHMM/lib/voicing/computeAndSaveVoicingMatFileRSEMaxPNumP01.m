function [] = computeAndSaveVoicingMatFileRSEMaxPNumP01(bdir, base, hmmfile)

if(nargin < 3)
	if(ispc())
		hmmfile = 'C:\documents and Settings\danny\my Documents\work\hsd-matlab\voicing\params\rseMaxPNumP01HMM15360.mat';
	elseif(isunix())
		hmmfile = '/projects/hsd/homes/danny/projects/hsd-matlab/voicing/params/rseMaxPNumP01HMM15360.mat';
	end
end

pathfile = fullfile(bdir, [base '.voicing.bin'])

% load hmm
h = load(hmmfile);

% read features
rse = readBinMat(fullfile(bdir, [base '.relspecent.bin']));
peakVals = readBinMat(fullfile(bdir, [base '.acorr01MaxPeakVal.bin']));
numPeaks = readBinMat(fullfile(bdir, [base '.relspecent.bin']));

features = [peakVals numPeaks rse];

voicing = compute_voiced_path(features, h.hmm);

writeBinMat(pathfile, voicing);

