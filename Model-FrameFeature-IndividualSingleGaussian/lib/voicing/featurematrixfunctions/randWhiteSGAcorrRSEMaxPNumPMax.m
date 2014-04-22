function [f] = randWhiteSGAcorrRSEMaxPNumPMax(ex)
% rse, max peak, num peaks, for acorr from deterministically whitened psd

f = zeros(size(ex.fstructs,2), 3);

for i=1:size(ex.fstructs,2)
    f(i,1) = max(ex.fstructs(i).peakvalsSGR02);
    f(i,2) = length(ex.fstructs(i).peaksSGR02);
    f(i,3) = ex.fstructs(i).relspecent;
    f(i,4) = ex.fstructs(i).maxSGR02;
end
