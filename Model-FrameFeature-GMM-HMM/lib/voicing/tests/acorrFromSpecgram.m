function [ acorr, comp ] = acorrFromSpecgram( sig, framesize, framestep, noise )

if(nargin < 4)
    noise = 0;
end

frames = mk_frames(sig, framesize, framestep);

nfft = 2^nextpow2(2*framesize-1);
mid = nfft/2;


% complete compensation window for all possible lags
comp = [1:framesize framesize-1:-1:1] / framesize;
comp = 1./comp;

% comp window for un-shifted ifft xcorr
comp4 = [framesize:-1:1 1:framesize] / framesize;
comp4 = 1 ./ comp4;

% middle of window that covers computed lags
%comp = comp(framesize-mid+1:framesize+mid-1);

%comp2 = [mid:-1:(mid/2)+1] / mid;
%comp2 = 1./comp2;

%comp3 = [framesize:-1:(framesize/2)+1] / framesize;
%comp3 = 1./comp3;

for i=1:size(frames,1)

    s = frames(i,:);
    s = s - mean(s);
    ft = fft(s, nfft);
    
    pft = (abs(ft) .^ 2) / length(s);
    pft = pft + noise;
    
    xc = ifft( pft );

    %normXC = xc / (s*s');
    normXC = xc / xc(1);
    
    %ac = [normXC(:,end-mid+2:end) normXC(:,1:mid)];

    %ac = normXC .* comp4;
    
    % keep just the first length/2 lags
    tmp = normXC(1:(framesize/2)) .* comp4(1:(framesize/2));
    %tmp = ac(mid:mid+(mid)-1);
    
    %tmp = normXC(1:framesize/2);
    %tmp = ac;

    acorr(i,:) = tmp;
end



