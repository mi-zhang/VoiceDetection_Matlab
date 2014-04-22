function [acorr] = acorrFromFullSpectrogram(spec, noise)

nframes = size(spec, 1);
framesize = size(spec, 2);

if(nargin < 2)
    noise = 0;
end

% comp window for un-shifted ifft xcorr
%comp4 = [framesize:-1:1 1:framesize] / framesize;
%comp4 = 1 ./ comp4;

acorr = zeros(nframes, framesize/2);
for i=1:nframes
   
    frame = spec(i,:);
    
    powerSpec = (abs(frame) .^ 2) / framesize; % normalize by nfft (which == framesize)
    % add white noise
    powerSpec = powerSpec + noise ^ 2;
    
    xc = ifft( powerSpec );
    % normalize
    normXC = xc / xc(1);
    
    % keep just the first length/2 lags
    tmp = normXC(1:(framesize/2));% .* comp4(1:(framesize/2));
    
    % just use real (imaginaries creep in after adding noise)
    acorr(i,:) = real(tmp);
end