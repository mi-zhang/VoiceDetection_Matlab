function [ acorr, comp4 ] = acorrFromSpecgramHalf( sig, framesize, framestep, noise, rnoise )

if(nargin < 4)
    noise = 0;
else
    noise;
end

if(nargin < 5)
    rnoise = 0
end

frames = mk_frames(sig, framesize, framestep);

nfft = framesize;


% comp window for un-shifted ifft xcorr
comp4 = [framesize:-1:1 1:framesize] / framesize;
comp4 = 1 ./ comp4;

acorr = zeros(size(frames,1), framesize/2);

window = hamming(framesize)';

for i=1:size(frames,1)

    s = frames(i,:);
    s = s - mean(s);
    
    s = s .* window;
    
    ft = fft(s, nfft);
    
    pft = (abs(ft) .^ 2) / nfft;
    
    if(rnoise == 1)
        for j=1:length(pft)
            if(rand > 0.5)
                f = noise * rand * 2;
            else
                f = 0;
            end
            pft(j) = pft(j) + f;
        end
    elseif(rnoise == 2)
        for j=1:length(pft)
            if(mod(j,2) == 1)
                f = noise * 2;
            else
                f = 0;
            end
            pft(j) = pft(j) + f;
        end
    else
        pft = pft + noise;
    end
    
    xc = ifft( pft );

    normXC = xc / xc(1);
    
    %ac = normXC .* comp4;
    ac = normXC;
    
    % keep just the first length/2 lags
    tmp = ac(1:(framesize/2));% .* comp4(1:(framesize/2));

    acorr(i,:) = real(tmp);
end



