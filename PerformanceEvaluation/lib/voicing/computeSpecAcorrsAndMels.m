function [spec, acorrs, mels] = computeSpecAcorrsAndMels(sig, framesize, framestep, sr, noiseLevels, numMels)


spec = compute_specgram(sig, framesize, framestep);
if(numMels > 0)
    mels = compute_melgram_spec(spec, framesize, framestep, sr, numMels);
else
    mels = [];
end
acorrs = {};
for i=1:length(noiseLevels)
    %acorr01 = acorrgram(sig+0.01*randn(size(sig)), framesize, framestep); %noisy acorr
    acorrs{end+1} = acorrFromSpecgramHalf(sig, framesize, framestep, (noiseLevels(i)^2), 0);
end