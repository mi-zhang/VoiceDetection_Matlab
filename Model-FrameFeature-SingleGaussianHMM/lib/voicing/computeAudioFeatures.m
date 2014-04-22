function [audioParams, spec] = computeAudioFeatures(signal, audioParams)

if(nargin < 3)
    audioParams = getDefaultAudioParams();
end

spec = computeAudioSpectrogram(signal, audioParams);