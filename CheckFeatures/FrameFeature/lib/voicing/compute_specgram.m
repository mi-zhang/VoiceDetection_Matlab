
% compute spectrogram

function spec = compute_specgram(sig, framesize, framestep, nfft)

    if (nargin < 4)
        nfft = framesize;
    end

    % segment streaming data into frames
    frames = mk_frames(sig, framesize, framestep);
    
    for i = 1:size(frames,1);
        % take out DC component
        frames(i,:) = frames(i,:) - mean(frames(i,:));
        % hamming
        frames(i,:) = hamming(framesize)' .* frames(i,:);
    end

    % computing FFT
    spec = zeros(size(frames,1), nfft/2);
    for i = 1:size(frames, 1);
        tmp = abs(fft(frames(i,:), nfft)); 
        spec(i,:) = tmp(1:(nfft/2)); 
    end

