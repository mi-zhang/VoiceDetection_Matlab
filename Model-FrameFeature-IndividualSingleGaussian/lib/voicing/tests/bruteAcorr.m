function acorr = bruteAcorr(sig, framesize, framestep, zp)

if(nargin < 4)
    zp = true;
end

frames = mk_frames(sig, framesize, framestep);

acorr = zeros(size(frames));

for i=1:size(frames,1)
    acorr(i,:) = bruteAutocorr(frames(i,:), zp);
end