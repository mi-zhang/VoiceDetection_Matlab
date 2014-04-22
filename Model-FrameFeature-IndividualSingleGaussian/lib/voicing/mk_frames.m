

function frames = mk_frames(sig, framesize, framestep)

    % function frames = mk_frames(sig, framesize, framestep)
    %
    % breaks a signal up into frames

    sig_len = length(sig);
    num_complete_frames = floor((sig_len - (framesize-framestep)) / framestep);
    if ((framesize-framestep) + num_complete_frames*framestep == sig_len)
        num_partial_frames = 0;
    else
        num_partial_frames = 1;
    end

    frames = zeros(num_complete_frames+num_partial_frames, framesize);
    for framenum = 0:num_complete_frames-1
        if (rem(framenum,100) == 0)
        %   fprintf(1,'finished %d/%d frames\n', framenum, num_complete_frames+num_partial_frames);
        end

        frames(framenum+1,:) = ...
          sig(framenum*framestep+1:framenum*framestep+framesize)';
    end
    
    framenum=num_complete_frames;
    for i = 1:num_partial_frames
        finalsigpiece = sig( (framenum)*framestep + 1:sig_len);
        frames(framenum+1,1:length(finalsigpiece)) = finalsigpiece';
    end



