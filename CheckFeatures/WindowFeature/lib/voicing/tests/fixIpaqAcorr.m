function [nacorr] = fixIpaqAcorr(acorr, sg)

for i=1:size(acorr,1)

    sgI = double(sg(i,:));
    ac = double(acorr(i,:));

    %nacorr(i,:) = ac / ((sgI*sgI')/512);
    ac(1)
    nacorr(i,:) = ac / ac(1);

end