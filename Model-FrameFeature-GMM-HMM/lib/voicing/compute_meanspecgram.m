function [meanspecgram, msgorig]= compute_meanspecgram(specgram,numframes)

totframes = size(specgram,1);

meanspecgram = zeros(size(specgram));
%msgorig = zeros(size(specgram));

% first indices < numframes all get the same avg
numinitframes = min(numframes, totframes);
initsum = sum(specgram(1:numinitframes,:),1);
initmean = initsum ./ numinitframes;
initmean = mk_stochastic(initmean);

meanspecgram(1:numframes,:) = repmat(initmean,numframes,1);

%msgorig(1:numframes,:) = repmat(initmean,numframes,1);

runningsum = initsum;

for index=numframes+1:totframes
    
    dropped = index - numframes;
    runningsum = runningsum - specgram(dropped,:);
    runningsum = runningsum + specgram(index,:);
    
    mean_spectrogram = runningsum ./ numframes;
    mean_spectrogram = mk_stochastic(mean_spectrogram);
    
    meanspecgram(index,:) = mean_spectrogram;
    
%     
%     lookbehind = index - numframes;
%     if lookbehind < 0
%         lookbehind = 0;
%     end
%     startindex = lookbehind+1;
% 
%     lookahead = numframes - index;
%     if lookahead < 0
%         lookahead = 0;
%     end
%     endindex = index+lookahead;    
% 
%     mean_sgorig = sum(specgram(startindex:endindex,:),1);
%     mean_sgorig = mean_sgorig ./ numframes;
%     mean_sgorig = mk_stochastic(mean_sgorig);
% 
%     msgorig(index,:) = mean_sgorig;    
%     
%     if(meanspecgram(index,:) - msgorig(index,:) ~= 0)
%         disp('running sum:');
%         runningsum
%         disp('brute sum:');
%         brute = sum(specgram(startindex:endindex,:),1)
%         disp('diff')
%         runningsum - brute
% 
%         index
%         startindex
%         endindex
%         dropped
%         keyboard
%     end
    
end