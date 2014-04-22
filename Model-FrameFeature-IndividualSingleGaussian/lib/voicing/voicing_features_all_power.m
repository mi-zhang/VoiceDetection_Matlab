function [fstructs, mels, sgram, agrams] = voicing_features_all_power(sig,framesize,framestep,noise_level,num_frames_for_mean,sr);
%[features, fftbands, mels, sgram, agram] = voicing_features_all(sig,framesize,framestep,noise_level,num_frames_for_mean,sr);

if(nargin<6)
    sr = 8192;
    disp('Assuming 8KHz sampling rate')
end

%spec = abs(spectrogram(sig, hamming(framesize), framesize-framestep, framesize, sr));
%spec = spec';
spec = compute_specgram_pwr(sig, framesize, framestep);
mels = compute_melgram_spec(spec, framesize, framestep, sr);

%%fprintf('computing eng...\n');
%engram = compute_engram(sig, framesize, framestep);
%eng = log(engram);
%aveng = mean(eng);
%engdev = cov(eng)^.5;

%fprintf('computing lowbanden...\n');
%lowfrac = lowbandenfrac(spec);

%%fprintf('computing specentropy...\n');
% specg_mean = mean_specgram(spec,adding_matrix);
% rel_specent = rel_specentropy(spec,specg_mean);
specent = specentropy(spec);

meanspecgram = compute_meanspecgram(spec,num_frames_for_mean);

acorrSuffixes = {};

acorr01 = acorrgram(sig+0.01*randn(size(sig)), framesize, framestep); %noisy acorr
acorrSuffixes{end+1} = '01';
acorr02 = acorrgram(sig+0.02*randn(size(sig)), framesize, framestep); %noisy acorr
acorrSuffixes{end+1} = '02';
acorr07 = acorrgram(sig+0.07*randn(size(sig)), framesize, framestep); %noisy acorr
acorrSuffixes{end+1} = '07';

acorrSG01 = acorrFromSpecgramHalf(sig, framesize, framestep, (0.01^2), 0);
acorrSuffixes{end+1} = 'SG01';
acorrSG02 = acorrFromSpecgramHalf(sig, framesize, framestep, (0.02^2), 0);
acorrSuffixes{end+1} = 'SG02';
acorrSG07 = acorrFromSpecgramHalf(sig, framesize, framestep, (0.07^2), 0);
acorrSuffixes{end+1} = 'SG07';

acorrSGR01 = acorrFromSpecgramHalf(sig, framesize, framestep, (0.01^2), 1);
acorrSuffixes{end+1} = 'SGR01';
acorrSGR02 = acorrFromSpecgramHalf(sig, framesize, framestep, (0.02^2), 1);
acorrSuffixes{end+1} = 'SGR02';
acorrSGR07 = acorrFromSpecgramHalf(sig, framesize, framestep, (0.07^2), 1);
acorrSuffixes{end+1} = 'SGR07';

acorrSGOdd02 = acorrFromSpecgramHalf(sig, framesize, framestep, (0.02^2), 2);
acorrSuffixes{end+1} = 'SGOdd02';

numframes = size(spec, 1);


fstructs = [];
%features = zeros(numframes,11);
for i = 1:numframes
    
    for j=1:length(acorrSuffixes)
        
        sfx = acorrSuffixes{j};
        ac = eval(['acorr' sfx]);
        [peaks, peakvalues, maxpeak, numpeaks, variance, hiS, loS, spread] = acorrFeatures(ac(i,:));
        fstructs(i).(['peaks' sfx]) = peaks;
        fstructs(i).(['peakvals' sfx]) = peakvalues;
        fstructs(i).(['variance' sfx]) = variance;
        fstructs(i).(['max' sfx]) = hiS;
        fstructs(i).(['min' sfx]) = loS;
        fstructs(i).(['spread' sfx]) = spread;
    end

    %{
    [peaks02, peakvals02] = find_acorr_peaks(acorr02(i,:));
    fstructs(i).peaks02 = peaks02;
    fstructs(i).peakvals02 = peakvals02;
    fstructs(i).max02 = max(acorr02(i,2:end));
    
    [peaks07, peakvals07] = find_acorr_peaks(acorr07(i,:));
    fstructs(i).peaks07 = peaks07;
    fstructs(i).peakvals07 = peakvals07;
    fstructs(i).max07 = max(acorr07(i,2:end));
    
    
    
    [peaksSG01, peakvalsSG01] = find_acorr_peaks(acorrSG01(i,:));
    fstructs(i).peaksSG01 = peaksSG01;
    fstructs(i).peakvalsSG01 = peakvalsSG01;
    fstructs(i).maxSG01 = max(acorrSG01(i,2:end));
    
    [peaksSG02, peakvalsSG02] = find_acorr_peaks(acorrSG02(i,:));
    fstructs(i).peaksSG02 = peaksSG02;
    fstructs(i).peakvalsSG02 = peakvalsSG02;
    fstructs(i).maxSG02 = max(acorrSG02(i,1:end));
  
    [peaksSG07, peakvalsSG07] = find_acorr_peaks(acorrSG07(i,:));
    fstructs(i).peaksSG07 = peaksSG07;
    fstructs(i).peakvalsSG07 = peakvalsSG07;
    fstructs(i).maxSG07 = max(acorrSG07(i,1:end));
  
  [peaksSGR01, peakvalsSGR01] = find_acorr_peaks(acorrSGR01(i,:));
  fstructs(i).peaksSGR01 = peaksSGR01;
  fstructs(i).peakvalsSGR01 = peakvalsSGR01;
  fstructs(i).maxSGR01 = max(acorrSGR01(i,1:end)); 
  
  [peaksSGR02, peakvalsSGR02] = find_acorr_peaks(acorrSGR02(i,:));
  fstructs(i).peaksSGR02 = peaksSGR02;
  fstructs(i).peakvalsSGR02 = peakvalsSGR02;
  fstructs(i).maxSGR02 = max(acorrSGR02(i,1:end));
  
  [peaksSGR07, peakvalsSGR07] = find_acorr_peaks(acorrSGR07(i,:));
  fstructs(i).peaksSGR07 = peaksSGR07;
  fstructs(i).peakvalsSGR07 = peakvalsSGR07;
  fstructs(i).maxSGR07 = max(acorrSGR07(i,1:end));  
  
 
  [peaksSGOdd02, peakvalsSGOdd02] = find_acorr_peaks(acorrSGOdd02(i,:));
  fstructs(i).peaksSGOdd02 = peaksSGOdd02;
  fstructs(i).peakvalsSGOdd02 = peakvalsSGOdd02;
  fstructs(i).maxSGOdd02 = max(acorrSGOdd02(i,1:end));
    %}
      
  %features(i,8) = specent(i);  
  fstructs(i).specent = specent(i);  

  %features(i,9) = relspecent2(spec,meanspecgram,i);
  %features(i,9) = relspecent(spec,i,num_frames_for_mean);
  fstructs(i).relspecent = relspecent2(spec,meanspecgram,i);
  
  % energy
  %features(i,10) = sum(spec(i,:));
  fstructs(i).energy = sum(spec(i,:));

  % energy below 2khz
  %features(i,11) = sum(spec(i,1:64));
  fstructs(i).energyBelow2khz = sum(spec(i,1:64));
  
  %features(i,9) = (eng(i) - aveng) / engdev;
  %features(i,10) = lowfrac(i);
  %features(i,11) = norm(acorr(i,:));
  %features(i,11) = pmaxi;
  
end

%numbands = log2(framesize) - 1;
%fftbands = zeros(numframes,numbands);
%for i = 1:numframes
%    logfft=compute_logfft_bands(spec(i,:),framesize);
%    fftbands(i,:)=logfft;
%end
%fstructs


sgram = spec;
agrams = {acorr01, acorr02, acorr07};



