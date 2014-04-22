function [f] = featureMatrix(ex)

f = zeros(size(ex.fstructs,2), 3);

for i=1:size(ex.fstructs,2)
    f(i,1) = max(ex.fstructs(i).peakvals07);
    f(i,2) = length(ex.fstructs(i).peaks07);
    f(i,3) = ex.fstructs(i).relspecent;
end
