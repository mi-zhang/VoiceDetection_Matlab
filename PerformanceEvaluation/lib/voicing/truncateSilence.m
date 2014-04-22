function [ nsig ] = fixSilence( sig, silenceValue )
%findSilence( sig )


silentRegions = find_silence(sig, silenceValue);

removeIdxs = [];

for i=1:size(silentRegions,1)
    len = silentRegions(i,2) - silentRegions(i,1) + 1;
    if(len >= 20)
        frames = floor(len / 44);
        
        newLen = round(len * (28/44));
        newEnd = silentRegions(i,1) + newLen;
        
        for j=newEnd+1:silentRegions(i,2)
            removeIdxs(end+1) = j;
        end
        
    end
end

sig(removeIdxs) = [];



nsig = sig;




