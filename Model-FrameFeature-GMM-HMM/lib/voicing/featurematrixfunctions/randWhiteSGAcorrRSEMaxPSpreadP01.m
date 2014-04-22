function [f] = randWhiteSGAcorrRSEMaxPSpreadP01(ex)

f = zeros(size(ex.fstructs,2), 3);

for i=1:size(ex.fstructs,2)
    f(i,1) = max(ex.fstructs(i).peakvalsSGR01) - ex.fstructs(i).minSGR01;
    f(i,2) = length(ex.fstructs(i).peaksSGR01);
    f(i,3) = ex.fstructs(i).relspecent;
end
