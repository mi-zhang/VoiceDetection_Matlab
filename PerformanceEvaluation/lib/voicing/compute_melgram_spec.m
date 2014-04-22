function mels = compute_melgram_spec(specg, framesize, framestep, sr, numMels)
% function spec = compute_specgram(sig, framesize, framestep, [nfft])


numcoeff = numMels;

mels = zeros(size(specg,1),numcoeff);

for i = 1:size(specg,1);

    %  mels(i,:) = melfcc(frames(i,:), sr, 'minfreq', 0, 'maxfreq', sr/2, 'numcep', 25, 'nbands', 19, 'fbtype', 'mel', ...
    %        'dcttype', 1, 'wintime', 0.0313, 'hoptime', 0.0156,'dither',0,'preemph',0)';

    
    %function [cepstra,aspectrum,pspectrum] = melfcc_fixedargs(samples, sr, wintime, hoptime, numcep, lifterexp, sumpower, preemph, dither, minfreq, maxfreq, nbands, bwidth, dcttype, fbtype, usecmp, modelorder)

    mels(i,:) = melfcc_sg(specg(i,:)', sr, ...
        numcoeff,...     numcep
        0.6,...    lifterexp
        1,...      sumpower
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

