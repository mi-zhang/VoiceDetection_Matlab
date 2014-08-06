function [features, sgram, agram] = voicing_features(sig, framesize, framestep,noise);
%function features = voicing_features(sig, framesize, framestep);
%
% compute all features for voicing.

if(nargin ==3)
    noise = 0.01;
end
%%fprintf('computing spec...\n');
spec = compute_specgram(sig, framesize, framestep);

%%fprintf('computing specentropy...\n');
specent = specentropy(spec);

%%fprintf('computing acorr...\n');
acorr = acorrgram(sig+randn(size(sig))*noise, framesize, framestep); %noisy acorr
numframes = size(spec, 1);

%%fprintf('computing features...\n');
features = zeros(numframes,3);
for i = 1:numframes
  [peaks, peakvals] = find_acorr_peaks(acorr(i,:));
  features(i,1) = max(peakvals);
  features(i,2) = length(peaks);
  features(i,3) = specent(i);
end

if(nargout == 2)
    sgram=flipud(20*log(spec'));
elseif(nargout == 3)
    sgram=flipud(20*log(spec'));
    agram=flipud(acorr');
end
