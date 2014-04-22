
% compute energy of each frame

function energy = compute_engram(sig, framesize, framestep)

    % segment streaming data into frames
    frames = mk_frames(sig, framesize, framestep);
    for i = 1:size(frames,1);
        % preem
        frames(i,:) = filter([1],[1 .95], frames(i,:));
    end

    % compute energy
    energy = zeros(size(frames,1),1);
    for i = 1:size(frames,1);
        energy(i) = norm(frames(i,:),2);
    end
    
    
    
