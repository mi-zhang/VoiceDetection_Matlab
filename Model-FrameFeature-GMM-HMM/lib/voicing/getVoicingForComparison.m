function [sig, spec, v] = getVoicingForComparison(traceStruct, voicing, startMin, endMin)


sIdx = startMin * 60 * 8192;
eIdx = endMin * 60 * 8192;

sig = traceStruct.audio.signal(sIdx:eIdx);

sCol = ceil(sIdx / 128);
eCol = ceil(eIdx / 128);

spec = traceStruct.audio.spectrogram(sCol:eCol,:);

v = voicing(sCol:eCol);