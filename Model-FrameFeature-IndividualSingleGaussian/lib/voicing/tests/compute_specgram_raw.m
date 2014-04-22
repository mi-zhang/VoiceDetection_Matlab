function spec = compute_specgram_raw(sig, framesize, framestep, nfft, hamm)

if(nargin < 4)
    nfft = framesize;
end

if(nargin < 5)
    hamm = true;
end


frames = mk_frames(sig, framesize, framestep);
for i = 1:size(frames,1);
  % take out DC component
  frames(i,:) = frames(i,:)-mean(frames(i,:));
  % hamming
  if(hamm)
      frames(i,:) = hamming(framesize)'.*frames(i,:);
  end
end


% computing fft
for i = 1:size(frames,1);
  tmp = fft(frames(i,:),nfft); 
  spec(i,:) = tmp;%(1:(nfft/2 + 1)); 
end

