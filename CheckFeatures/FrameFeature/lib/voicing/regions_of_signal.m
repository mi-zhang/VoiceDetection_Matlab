function [region_sig]= regions_of_signal(sig, regions, framestep)
% function []= regions_of_signal(sig, regions, framestep)
%
% returns the signal chunks specified in region
% sig = audio signal
% regions = matrix where first_col = starttime and second_col=endtime
% framestep used in specgram

numregions = size(regions,1);
if(size(regions)~=0)
    startpt = round((regions(:,1)-1)*framestep)+1;
    endpt = round((regions(:,2)-1)*framestep);
    
    region_sig =[];
    for i=1:numregions
        region_sig = [region_sig; sig(startpt(i):endpt(i))];
    end
    %disp('Playing region')
    %soundsc(region_sig,sampling_rate);
else
    region_sig=[];
end