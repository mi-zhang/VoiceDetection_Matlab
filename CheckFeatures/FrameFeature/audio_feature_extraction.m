

function features = audio_feature_extraction(sig, framesize, framestep, noise_level, num_of_framestep_for_RSE)
    
    warning off
    
    % import library 
    addpath('./lib/voicing/')
    addpath('./lib/HMM/')    
    
    % KEY: add some noise to the raw audio signal
    noisy_audio_signal = sig + noise_level*randn(size(sig));

    % compute spectrograms (noisy!!!)
    spec = compute_specgram(noisy_audio_signal, framesize, framestep, 256); 
    
    % normalize the spectrum to remove the influence of the volumn
    normlspec = spec./(sum(spec')' * ones(1, size(spec,2)) + 1e-5);

    % compute autocorrelation (noisy!!!)
    acorr = acorrgram(noisy_audio_signal, framesize, framestep);

    % compute engdev
    X = compute_engram(noisy_audio_signal, framesize, framestep);
    X(X==0) = 0.00001;
    eng = log(X);
    aveng = mean(eng);
    engdev = cov(eng)^.5;

    % compute low energy band (lower half of the frequency spectrum) / high energy band (upper half of the frequency spectrum) ratio
    lowfrac = lowbandenfrac(spec);
    
    % compute the normalized spectral entropy 
    specent = specentropy(spec);
    
    % segment streaming data into frames
    frames = mk_frames(sig, framesize, framestep);    
    
    % construct frame-level feature vector
    numframes = size(spec, 1); 
    features = zeros(numframes, 8); 
    for i = 1:numframes
        
        [peaks, peakvals] = find_acorr_peaks(acorr(i,:));
        features(i,1) = max(peakvals);
        features(i,2) = length(peaks);
        features(i,3) = relspecent(spec, i, num_of_framestep_for_RSE);        
        
        % [MZ] new feature: LF / HF energy ratio
        energy = spec(i,:).^2;
        total_energy = sum(energy);
%         ratio = 1000; % 0 - 4Hz
%         ratio = 100; % 0 - 40Hz
%         ratio = 13; % 0 - 300Hz
%         ratio = 10; % 10% 0 - 400Hz
%         ratio = 8; % 12.5% 0 - 500Hz
        ratio = 4; % 25% 0 - 1KHz
%         ratio = 2; % 50% 0 - 2KHz
        lower_band_energy_sum = sum(energy(1:floor(length(energy)/ratio))) + 1e-5;
        upper_band_energy_sum = sum(energy(floor(length(energy)/ratio)+1:end)) + 1e-5; 
        features(i,4) = log10(lower_band_energy_sum / upper_band_energy_sum);        
        
        features(i,5) = specent(i);
        features(i,6) = (eng(i)-aveng)/engdev;
%         features(i,6) = lowfrac(i);
        
        % [MZ] new feature: spectral flux (SF)
%         if i == 1
%             features(i,5) = 0;
%         else
%             % unnormalized
%             features(i,5) = sqrt(sum((spec(i,:) - spec(i-1,:)).^2));
%             % normalized 
% %             features(i,5) = sqrt(sum((normlspec(i,:) - normlspec(i-1,:)).^2));            
%         end
        
        % [MZ] new time-domain feature: RMS (this feature does not make sense)
%         features(i,6) = sqrt(sum(frames(i,:).^2) / length(frames(i,:)));        
        
        % [MZ] new feature: total energy (this feature does not make sense)
        features(i,7) = total_energy;
        
        % [MZ] new time-domain feature: ZCR
        features(i,8) = sum(abs(diff(frames(i,:)>0))) / length(frames(i,:));     
        
        % [MZ] new time-domain feature: MCR
%         mean_this_frame = sum(frames(i,:));        
%         features(i,9) = sum(abs(diff((frames(i,:)-mean_this_frame)>0))) / length(frames(i,:));    
        
    end


    
   
    
    
    
