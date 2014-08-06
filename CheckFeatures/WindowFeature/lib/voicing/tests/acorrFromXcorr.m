function [ acorr, comp] = acorrFromXcorr( sig, framesize, framestep )


frames = mk_frames(sig, framesize, framestep);

nfft = 2^nextpow2(2*framesize-1);

acorr = zeros(size(frames,1), nfft-1);

comp = [1:framesize framesize-1:-1:1]/framesize;
comp = 1./comp;


for i=1:size(frames,1)
    frames(i,:) = frames(i,:) - mean(frames(i,:));
    acorr(i,:) = xcorr(frames(i,:)) / norm(frames(i,:))^2;
    acorr(i,:) = acorr(i,:) .* comp;
end
