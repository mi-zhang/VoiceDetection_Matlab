function [nsig] = fill_regions_with_noise(sig, regions, noisescale)

nsig = sig;

for i=1:size(regions,1)
    len = regions(i,2)-regions(i,1);
    if(len >= 4)
        nsig(regions(i,1):regions(i,2)) = randn(1,len+1) * noisescale;
    end
end