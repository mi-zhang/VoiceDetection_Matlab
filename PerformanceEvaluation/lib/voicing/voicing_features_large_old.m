function [features, sgram, agram] = voicing_features_large_old(sig, framesize, framestep,noise_level,num_frames_for_mean);
%function features = voicing_features(sig, framesize, framestep);
%

spec = compute_specgram(sig, framesize, framestep);
num_for_meanframes = num_frames_for_mean; % for relative spectral entropy - how many frames in mean
%%fprintf('computing eng...\n');
eng = log(compute_engram(sig, framesize, framestep));
aveng = mean(eng);
engdev = cov(eng)^.5;

%fprintf('computing lowbanden...\n');
lowfrac = lowbandenfrac(spec);

%%fprintf('computing specentropy...\n');
% specg_mean = mean_specgram(spec,adding_matrix);
% rel_specent = rel_specentropy(spec,specg_mean);
specent = specentropy(spec);


acorr = acorrgram(sig+noise_level*randn(size(sig)), framesize, framestep); %noisy acorr
numframes = size(spec, 1);
numbands = log(framesize)/log(2) - 1;

features = zeros(numframes,6+numbands);
for i = 1:numframes
  [peaks, peakvals] = find_acorr_peaks(acorr(i,:));
  features(i,1) = max(peakvals);
  features(i,2) = length(peaks);
  features(i,3) = relspecent(spec,i,num_for_meanframes);
  features(i,4) = specent(i);
  features(i,5) = (eng(i)-aveng)/engdev;
  features(i,6) = lowfrac(i);
  logfft=compute_logfft_bands(spec(i,:),framesize);
  features(i,7:end)=logfft;
end


if(nargout == 2)
    sgram=flipud(20*log(spec'));
elseif(nargout == 3)
    sgram=flipud(20*log(spec'));
    agram=flipud(acorr');
end
