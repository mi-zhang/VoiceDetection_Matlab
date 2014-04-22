function spec = compute_specgram_whole_padded(sig, framesize, framestep, nfft)
% function spec = compute_specgram(sig, framesize, framestep, [nfft])

if (nargin < 4)
  nfft = framesize;
end

frames = mk_frames(sig, framesize, framestep);
for i = 1:size(frames,1);
  % take out DC component
  frames(i,:) = frames(i,:)-mean(frames(i,:));
  % hamming
  %frames(i,:) = hamming(framesize)'.*frames(i,:);
end

% zero padding

pframes = zeros(size(frames,1), size(frames,2)*2);
pframes(1:size(frames,1),1:size(frames,2)) = frames;

%imagesc(pframes); 
%keyboard;

% computing fft
nfft = framesize * 2;
spec = zeros(size(pframes,1),(nfft/2)+1);
for i = 1:size(pframes,1);
  tmp = fft(pframes(i,:),nfft); 
  spec(i,:) = tmp(1:(nfft/2 + 1)); 
end

