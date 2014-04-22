function [vrate] = voicingRate(voicingProbs)

rateParams = globalFrameRateParams();

binaryVoicing = voicingProbs > 0.5;
voicedSegments = segmentLogicalVec(binaryVoicing);

vrate = (size(voicedSegments,1) - 1) / (length(voicingProbs) / rateParams.voicingFrameRate);
