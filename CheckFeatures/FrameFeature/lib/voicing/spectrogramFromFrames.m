function [spec] = spectrogramFromFrames(frames, nfft)

nframes = size(frames, 1);
framesize = size(frames, 2);

if (nargin < 2)
  nfft = framesize;
end

window = hamming(framesize);

for i = 1:nframes
  % take out DC component
  frames(i,:) = frames(i,:) - mean(frames(i,:));
  % hamming
  frames(i,:) = window' .* frames(i,:);
end


% computing fft
spec = zeros(nframes, nfft);
for i = 1:nframes
  spec(i,:) = fft(frames(i,:), nfft);
end