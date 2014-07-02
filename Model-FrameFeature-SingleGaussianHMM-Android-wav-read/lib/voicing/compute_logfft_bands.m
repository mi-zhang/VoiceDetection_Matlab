function fft_bands = compute_logfft_bands(fftmag,framesize)

numbands = log2(framesize);
samples = 2.^[0:numbands-1];

if(sum(fftmag)>0)
    fft_bands(1,1) = sum(fftmag(samples(1):samples(2))) ./ sum(fftmag);
else
    fft_bands(1,1)=0;
end

for i=2:numbands-1
    if(sum(fftmag)>0)
        fft_bands(1,i) = sum(fftmag((samples(i)+1):samples(i+1))) ./ sum(fftmag);
    else
        fft_bands(1,i)=0;
    end
end