function spec = computeAudioSpectrogram(signal, audioParams)

if(nargin < 2)
    audioParams = getDefaultAudioParams();
end

%size(signal)
spec = spectrogram(signal, hamming(audioParams.framesize), audioParams.framesize-audioParams.framestep, audioParams.framesize, audioParams.sample_rate);
spec = abs(spec);
spec = spec';