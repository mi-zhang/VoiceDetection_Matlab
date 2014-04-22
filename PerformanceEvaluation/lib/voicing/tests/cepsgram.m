function [cg] = cepsgram(powsg)

for i=1:size(powsg,1)
    %cg(i,:) = real(ifft(logzero(powsg(i,:))));
    cg(i,:) = rceps(powsg(i,:));
end