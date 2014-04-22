function [ rse ] = relSpecEnt( sg )

meansg = compute_meanspecgram(abs(sg), 500);

for i=1:size(sg,1)
    rse(i) = relspecent2(abs(sg),meansg,i);
end