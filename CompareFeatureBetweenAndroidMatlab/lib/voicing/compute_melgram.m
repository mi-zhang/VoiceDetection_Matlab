function mels = compute_melgram(sig, framesize, framestep,sr)
% function spec = compute_specgram(sig, framesize, framestep, [nfft])


frames = mk_frames(sig, framesize, framestep); 
%size(frames)
mels = zeros(size(frames,1),25);
%size(mels)

for i = 1:size(frames,1);

    %  mels(i,:) = melfcc(frames(i,:), sr, 'minfreq', 0, 'maxfreq', sr/2, 'numcep', 25, 'nbands', 19, 'fbtype', 'mel', ...
    %        'dcttype', 1, 'wintime', 0.0313, 'hoptime', 0.0156,'dither',0,'preemph',0)';

    
    %function [cepstra,aspectrum,pspectrum] = melfcc_fixedargs(samples, sr, wintime, hoptime, numcep, lifterexp, sumpower, preemph, dither, minfreq, maxfreq, nbands, bwidth, dcttype, fbtype, usecmp, modelorder)

    mels(i,:) = melfcc_fixedargs(frames(i,:), sr, ...
        0.0313,...  wintime
        0.0156,... hoptime
        25,...     numcep
        0.6,...    lifterexp
        1,...      sumpower
        0,...      preemph
        0,...      dither
        0,...      minfreq
        sr/2,...   maxfreq
        19,...     nbands
        1.0,...    bwidth
        1,...      dcttype
        'mel',...  fbtype
        0,...      usecmp
        0 ...      modelorder
        );

end

