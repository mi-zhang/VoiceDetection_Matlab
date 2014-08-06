function fft_bands = compute_logfft_bands(fftmag,framesize)

numbands = log(framesize)/log(2);
samples = 2.^[0:numbands-1];

for i=1:numbands-1
    fft_bands(1,i) = sum(fftmag(samples(i):samples(i+1)))./sum(fftmag);
end