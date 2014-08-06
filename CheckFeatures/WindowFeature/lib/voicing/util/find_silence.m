function [silent_regions] = find_silence(sig, silenceValue)

silent_regions = [];

silentSamples = find(sig==silenceValue);

rgnStart = silentSamples(1);
rgnEnd = rgnStart;

for i=2:length(silentSamples)-1
    if(silentSamples(i) == rgnEnd+1)
        rgnEnd = silentSamples(i);
    else
        silent_regions = [silent_regions; rgnStart rgnEnd];
        rgnStart = silentSamples(i);
        rgnEnd = rgnStart;
    end
end

silent_regions = [silent_regions; rgnStart rgnEnd];