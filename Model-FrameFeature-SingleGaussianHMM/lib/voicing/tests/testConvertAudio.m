function [ nsig ] = testConvertAudio( sig )

% shift down
sig = sig - 32768;

% normalize
sig = sig ./ 32768;

% break into frames
frames = mk_frames(sig, 512, 256);


% hamming window per frame
for i=1:size(frames,1) 
    frames(i,:) = frames(i,:) .* hamming(512)';
end


% reshape to signal
nsig = reshape(frames', size(frames,1)*size(frames,2), 1);