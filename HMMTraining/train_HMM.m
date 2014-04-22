% note: all features are framesize 256,framestep 128
%
%

% features are all the features over time - [Nx3 matrix], N=number of data
%points


%these are regions that are labeled as voiced
%the rounding is happening here. 

% It is assumed that features are computed and has the same dimensions as
%labels

vregions = round(voiced_regions); % start and end times of the labeled voiced chunks
numregions = size(vregions,1); % number of voiced chunks 

vfeatures = zeros(0,3);
numfeatures = 0;

numframes = size(features, 1); % this should be total number of data points, here it is equal to N
framestatevals = ones(numframes, 1);

% make a dataset of voiced regions
for region = 1:numregions
    for i = vregions(region,1) : vregions(region,2)
        numfeatures = numfeatures + 1;
        vfeatures(numfeatures, 1) = features(i,1); % creating a matrix of only voiced chunk features
        vfeatures(numfeatures, 2) = features(i,2);
        vfeatures(numfeatures, 3) = features(i,3);
        framestatevals(i) = 2; % label that chunk as voiced
    end
end

% make a dataset of non voiced regions
negfeatures = zeros(0,3);
numnegfeatures = 0;
for i = 1:numframes
    if (framestatevals(i) == 1)
        numnegfeatures = numnegfeatures+1;
        negfeatures(numnegfeatures, 1) = features(i,1);
        negfeatures(numnegfeatures, 2) = features(i,2);
        negfeatures(numnegfeatures, 3) = features(i,3);
    end
end

% train gaussians for emission probability
voiced_mean = mean(vfeatures)';
voiced_cov = cov(vfeatures);
voiced_cov_inv = inv(voiced_cov);%this is no used
n = length(voiced_mean);
voiced_scfactor = (1/ ( ((2*pi)^(n/2)) * (det(voiced_cov)^0.5) ));

unvoiced_mean = mean(negfeatures)';
unvoiced_cov = cov(negfeatures);
unvoiced_cov_inv = inv(unvoiced_cov); %this is no used
unvoiced_scfactor = (1/ ( ((2*pi)^(n/2)) * (det(unvoiced_cov)^0.5) ));

logT = log(estimate_T_table(framestatevals, 2)); %estimating transition table

% Transition matrix
T = estimate_T_table(framestatevals, 2); % estimating transition table

% there are the trained parameters
speech_mu(:,1) = unvoiced_mean;
speech_mu(:,2) = voiced_mean;
speech_cov(:,:,1) = unvoiced_cov;
speech_cov(:,:,2) = voiced_cov;
transmat = T;
prior = [0.5; 0.5];





