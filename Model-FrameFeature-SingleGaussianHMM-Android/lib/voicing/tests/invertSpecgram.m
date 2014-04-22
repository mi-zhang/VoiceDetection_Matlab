function x = invertSpecgram(sig, spec, sr, framesize, framestep)
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


%[nrow, ncol] = size(y);

y = stretchSpecgram(spec, framesize);

winpts = framesize;
steppts = framestep;

NFFT = 2^(ceil(log(winpts)/log(2)));
%NFFT = framesize;

NOVERLAP = winpts - steppts;
SAMPRATE = sr;

% Values coming out of rasta treat samples as integers, 
% not range -1..1, hence scale up here to match (approx)
%y = abs(specgram(x*32768,NFFT,SAMPRATE,WINDOW,NOVERLAP)).^2;

%xlen = winpts + steppts*(ncol - 1)
xlen = length(sig)

r = randn(xlen,1);

%return

%R = specgram(r/32768/12, NFFT, SAMPRATE, winpts, NOVERLAP);
R = compute_specgram(r*0.2, framesize, framestep, NFFT);

size(R)
size(y)

R = R .* sqrt(y);
%x = tispec(R, NFFT, SAMPRATE, winpts, NOVERLAP);
%x = invpowspec(R, sr, wintime, steptime)
x = ispecgram(R', NFFT, SAMPRATE, winpts, NOVERLAP);