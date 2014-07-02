

function acorr = acorrgram(sig, framesize, framestep, nacorr, usecomp)
% function acorr = acorrgram(sig, framesize, framestep, nacorr)

    frames = mk_frames(sig, framesize, framestep);

    if (nargin < 4)
      nacorr = framesize/2;
    end

    if(nargin < 5)
        usecomp = true;
    end

    if(0)
        for i = 1:size(frames,1);
          % preem
          %frames(i,:) = filter([1],[1 .95], frames(i,:));
          % hamming
          frames(i,:) = hamming(framesize)'.*frames(i,:);
          disp('ham')
        end
    end

    % compensate for frame effects: scale by 1/( 1/framesize -- framesize/framesize -- 1/framesize)
    % compensating multiplier
    comp = [1:framesize framesize-1:-1:1]/framesize;
    comp = 1./comp;

    % computing acorr
    acorr = zeros(size(frames,1),nacorr);
    for i = 1:size(frames,1);
        % zero-mean the signal
        frames(i,:) = frames(i,:) - mean(frames(i,:));
        framec = frames(i,:);
        %tmp = xcorr(framec,framec)/(norm(framec)^2);
        tmp = xcorr(framec) / (norm(framec)^2);
        % compensate for frame effects
        if(usecomp)
            tmp = tmp.*comp;
        end
        acorr(i,:) = tmp(framesize:framesize+nacorr-1);
    end
