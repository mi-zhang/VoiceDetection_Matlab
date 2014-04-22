function [ voiced_regions, unvoiced_regions ] = compute_voiced_regions( path )
%compute_voiced_regions Returns voiced regions of the signal.

% change path to regions
voiced_regions = path_to_region(path);

% invert to find unvoiced regions
path_flip = abs(path-3);
unvoiced_regions = path_to_region(path_flip);
