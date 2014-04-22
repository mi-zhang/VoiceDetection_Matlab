function x = invpowspec(sg, sr, framesize, framestep)
%x = invpowspec(y, sr, wintime, steptime, sumlin)
%
% Attempt to go back from specgram-like powerspec to audio waveform
% by scaling specgram of white noise
%
% default values:
% sr = 8000Hz
% wintime = 25ms (200 samps)
% steptime = 10ms (80 samps)
% which means use 256 point fft
% hamming window

% for sr = 8000
%NFFT = 256;
%NOVERLAP = 120;
%SAMPRATE = 8000;
%WINDOW = hamming(200);

[nrow, ncol] = size(sg);

NFFT = 2^(ceil(log(framesize)/log(2)));

if NFFT ~= 2*(nrow-1)
  disp('Inferred FFT size doesn''t match specgram');
end

NOVERLAP = framesize - framestep;
SAMPRATE = sr;

% Values coming out of rasta treat samples as integers, 
% not range -1..1, hence scale up here to match (approx)
%y = abs(specgram(x*32768,NFFT,SAMPRATE,WINDOW,NOVERLAP)).^2;

xlen = winpts + steppts*(ncol - 1);

r = randn(xlen,1);

R = specgram(r/32768/12, NFFT, SAMPRATE, winpts, NOVERLAP);
%R = R .* sqrt(y);;
R = R .* sg;
x = ispecgram(R, NFFT, SAMPRATE, winpts, NOVERLAP);
