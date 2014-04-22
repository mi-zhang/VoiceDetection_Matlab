function [allVoicing] = getCombinedVoicing(voicingFeatureFiles)

allVoicing = [];

for i=1:length(voicingFeatureFiles)
    [h,d] = readFeatureFile(voicingFeatureFiles{i});
    voicingIdx = strmatch('voicing', h.columns);
    allVoicing = [allVoicing d{voicingIdx}];
end