function [allVoicingOr] = combineVoicingVectors(allVoicing)
allVoicingOr = sum((allVoicing-1)');
allVoicingOr(find(allVoicingOr)) = 1;