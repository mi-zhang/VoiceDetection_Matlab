function [f] = detWhiteSGAcorrRSEMaxPSpreadP01(ex)

f = zeros(size(ex.fstructs,2), 3);

for i=1:size(ex.fstructs,2)
    f(i,1) = max(ex.fstructs(i).peakvalsSG01) - ex.fstructs(i).minSG01;
    f(i,2) = length(ex.fstructs(i).peaksSG01);
    f(i,3) = ex.fstructs(i).relspecent;
end
