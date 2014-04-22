function [ns] = enhanceAcorrSlice(sl)

sl(find(sl<0)) = 0;

expanded = interp(sl,2);

ns = sl - expanded(1:length(sl));

ns(find(ns<0)) = 0;

plot(sl, '.-'), hold on, plot(expanded, 'r'), plot(ns, 'g')