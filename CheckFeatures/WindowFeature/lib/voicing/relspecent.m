

function [y]= relspecent(spectrogram, index, numframes)

    
    totframes = size(spectrogram,1);

    lookbehind = index - numframes;
    if lookbehind < 0
        lookbehind = 0;
    end
    startindex = lookbehind+1;

    lookahead = numframes - index;
    if lookahead < 0
        lookahead = 0;
    end
    endindex = index+lookahead;

    %mean_spectrogram = sum(spectrogram(startindex:endindex,:),1) ./ numframes;
    mean_spectrogram = sum(spectrogram(startindex:endindex,:),1);
    mean_spectrogram = mean_spectrogram ./ numframes;
    mean_spectrogram = mk_stochastic(mean_spectrogram);

    specg_sig = spectrogram(index,:);
    specg_sig = mk_stochastic(specg_sig);

    y = sum(specg_sig' .* (log(specg_sig)' - log(mean_spectrogram)'))'; 
