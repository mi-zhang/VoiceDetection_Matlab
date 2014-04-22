function [ sig ] = invertWholeSpecgram( sg )


% ifft
ftsize = (size(sg,2)-1)*2;
frames = zeros(size(sg,1), ftsize);

for i=1:size(sg,1)    
    ft = sg(i,:);
    ft = [ft(1:(ftsize/2+1)) conj(ft([(ftsize/2):-1:2]))];    
    frames(i,:) = real(ifft(ft));
end

% un-window

% merge

siglen = ftsize + (size(sg,1)-1) * 256;
sig = zeros(1,siglen);

for i=1:size(frames,1)
    b = (i-1)*256;
    idxs = b + [1:ftsize];
    sig(idxs) = sig(idxs) + frames(i,:);
end
