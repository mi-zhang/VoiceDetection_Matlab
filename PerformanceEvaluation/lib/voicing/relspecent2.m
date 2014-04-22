function [y] = relspecent2(spectrogram,meanspecgram,index)

specg_sig = spectrogram(index,:);
specg_sig = mk_stochastic(specg_sig);

%speclog = log(specg_sig)';
speclog = logzero(specg_sig)';

% if(find(isinf(speclog)))
%     index
%     specg_sig
%     keyboard
% end

y = sum(specg_sig' .* (speclog - logzero(meanspecgram(index,:))'))';
