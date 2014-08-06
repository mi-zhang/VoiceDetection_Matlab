function [ clusters, centroids ] = cluster_regions(k,regions,sig,sr,framestep,framesize,specgram,acorrgram )
%CLUSTER_REGIONS clusters regions of a signal

featureVectors = [];

frametime = framesize / sr;
steptime = framestep / sr;

ncep = 2;

for i=1:size(regions,1)
    % simple 1-d f0 only
    %featureVectors = [featureVectors; mean_pitch(acorrgram, regions(i,:))];
  
    
    regionSig = regions_of_signal(sig,regions(i,:),framestep);
    
    if(size(regionSig,1) <= 0) continue; end
    
    %disp(sprintf('regionSig: %d',size(regionSig)));
    
    


    %disp(sprintf('vecMean: %d',size(vecMean)));
        
    featureVectors = [featureVectors; vecMean];
    
    disp(sprintf('%d/%d',i,size(regions,1)));
    
end

%[c,centroids] = kmeans(featureVectors', k);

% MoG clustering
[c,centroids,pi,w,Q] = mixtureEM(featureVectors', k, 1);


clusters = {};
for i=1:k
    idxs = find(c==i);
    clusters{i} = regions(idxs,:);
end





function [features] = melFeatures(sig, ncep, frametime, steptime)
    % mel-frec cepstral coefficients 
    cepstra = melfcc(sig*3.3752, sr, 'numcep',ncep, 'wintime',frametime, 'hoptime',steptime);
    
    % deltas and double-deltas of the mecepstral vectors
    del = deltas(cepstra);
    % Double deltas are deltas applied twice with a shorter window
    ddel = deltas(deltas(cepstra,5),5);
    % Composite, 39-element feature vector, just like we use for speech recognition
    vecT = [cepstra;del;ddel];
    
    %disp(sprintf('vec: %d',size(vec)));
    vec = mean(vecT');
    if(size(vecMean,2) ~= ncep*3) continue; end
end

