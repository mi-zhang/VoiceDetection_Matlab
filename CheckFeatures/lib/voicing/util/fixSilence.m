function [newex] = fixSilence(ex, noisescale, framesize, framestep, sr, num_frames_for_mean)


% first, generate one second of some low energy noise
noise = randn(1,sr*1) * noisescale;
% then compute its specgram and mel-specgram
noisemels = compute_melgram(noise, framesize, framestep, sr);
noisespec = compute_specgram(noise, framesize, framestep);
% then avg the frame vals
avgmel = mean(noisemels);
avgspec = mean(noisespec);


nspecgram = ex.specgram;
for i=1:size(nspecgram,1)
    r = nspecgram(i,:);
    % if the entire frame is zero, replace
    if(sum(r)==0)
        nspecgram(i,:) = avgspec;
    end
end

nmelspec = ex.melspec;
for i=1:size(nmelspec,1)
    r = nmelspec(i,:);
    % if the entire frame is nan, then replace it
    if(sum(isnan(r)) == size(nmelspec,2))
        nmelspec(i,:) = avgmel;
    end
end

% now recompute dependent features

lowfrac = lowbandenfrac(nspecgram);
specent = specentropy(nspecgram);

meanspecgram = compute_meanspecgram(nspecgram,num_frames_for_mean);

numframes = size(nspecgram,1);

features = zeros(numframes,7);
for i = 1:numframes
  features(i,1) = ex.features(i,1);
  features(i,2) = ex.features(i,2);
  features(i,3) = relspecent2(nspecgram,meanspecgram,i);
  features(i,4) = specent(i);
  features(i,5) = ex.features(i,5);
  features(i,6) = lowfrac(i);
  features(i,7) = ex.features(i,7);
end

numbands = log2(framesize) - 1;
fftbands = zeros(numframes,numbands);
for i = 1:numframes
    logfft=compute_logfft_bands(nspecgram(i,:),framesize);
    fftbands(i,:)=logfft;
end




newex = mk_training_example(ex.name, ex.signal, ex.sample_rate, features, fftbands, nmelspec, nspecgram, ex.acorrgram, ex.noise_level, ex.truth);
