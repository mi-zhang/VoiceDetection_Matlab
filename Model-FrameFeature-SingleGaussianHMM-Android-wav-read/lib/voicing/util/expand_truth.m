function [nt] = expand_truth(truth, factor)

nt = upsample(truth, factor);
zs = find(nt==0);
nzs = find(nt);


for i=1:length(zs)
    t = find(nzs<zs(i));
    nt(zs(i)) = truth(t(end));
end
    
