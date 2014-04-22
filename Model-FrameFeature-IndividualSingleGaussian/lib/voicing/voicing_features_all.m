function [fstructs, mels, spec, acorrs] = voicing_features_all(sig,framesize,framestep,noiseLevels,numMels,num_frames_for_mean,sr);


acorrSuffixes = {'01', '02', '07'};


[spec, acorrs, mels] = computeSpecAcorrsAndMels(sig, framesize, framestep, sr, noiseLevels, numMels);

pack

specent = specentropy(spec);

meanspecgram = compute_meanspecgram(spec,num_frames_for_mean);

numframes = size(spec, 1);

fstructs = [];
for i = 1:numframes
    
    %fstructs(i).acorrpeaklags = {};
    %fstructs(i).acorrpeakvals = {};
    %fstructs(i).acorrvariance = {};
    %fstructs(i).acorrmax = {};
    %fstructs(i).acorrmin = {};
    %fstructs(i).acorrspread = {};
    
    for j=1:length(noiseLevels)
        
        sfx = acorrSuffixes{j};
        ac = acorrs{j};
        [peaks, peakvalues, maxpeak, numpeaks, variance, hiS, loS, spread] = acorrFeatures(ac(i,:));
        fstructs(i).acorrpeaklags{j} = peaks;
        fstructs(i).acorrpeakvals{j} = peakvalues;
        fstructs(i).acorrvariance{j} = variance;
        fstructs(i).acorrmax{j} = hiS;
        fstructs(i).acorrmin{j} = loS;
        fstructs(i).acorrspread{j} = spread;
    end

  fstructs(i).specent = specent(i);  

  fstructs(i).relspecent = relspecent2(spec,meanspecgram,i);
  
  % energy
  fstructs(i).energy = sum(spec(i,:));


  twoKilohertzBin = round(2000 / (sr / framesize));
  fstructs(i).energyBelow2khz = sum(spec(i,1:twoKilohertzBin));
  
end

%numbands = log2(framesize) - 1;
%fftbands = zeros(numframes,numbands);
%for i = 1:numframes
%    logfft=compute_logfft_bands(spec(i,:),framesize);
%    fftbands(i,:)=logfft;
%end
%fstructs


