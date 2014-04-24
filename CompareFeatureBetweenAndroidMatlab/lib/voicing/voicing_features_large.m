


function [features, mels, sgram, agram] = voicing_features_large(sig, framesize, framestep, noise_level, num_of_framestep_for_RSE, sr)
%function features = voicing_features(sig, framesize, framestep);


    if(nargin<6)
        sr = 8192;
        disp('Assuming 8KHz sampling rate')
    end

    mels = [] ; % compute_melgram(sig, framesize, framestep,sr);
    
    % KEY: add some noise to the raw audio signal!!! 
    spec = compute_specgram(sig + noise_level*randn(size(sig)), framesize, framestep); 
    
    % fprintf('computing eng...\n');
    X = compute_engram(sig, framesize, framestep);
    X(X==0) = 0.00001;
    eng = log(X);
    aveng = mean(eng);
    engdev = cov(eng)^.5;

    % fprintf('computing lowbanden...\n');
    lowfrac = lowbandenfrac(spec);

    % fprintf('computing specentropy...\n');
    % specg_mean = mean_specgram(spec,adding_matrix);
    % rel_specent = rel_specentropy(spec,specg_mean);
    
    specent = specentropy(spec);
    %
    acorr = acorrgram(sig + noise_level*randn(size(sig)), framesize, framestep); % noisy acorr
    numframes = size(spec, 1);
    numbands = log2(framesize) - 1;
    
    
    

    features = zeros(numframes, 6); %zeros(numframes,6+numbands);
    for i = 1:numframes
        [peaks, peakvals] = find_acorr_peaks(acorr(i,:));
        features(i,1) = max(peakvals);
        features(i,2) = length(peaks);
        features(i,3) = relspecent(spec,i,num_of_framestep_for_RSE);
        features(i,4) = specent(i);
        features(i,5) = (eng(i)-aveng)/engdev;
        features(i,6) = lowfrac(i);
        % [MZ] calculate energy in subbands
        energy = spec(i,:).^2;
        ratio = 4;
        lower_band_energy_sum = sum(energy(1:floor(length(energy)/ratio)));
        upper_band_energy_sum = sum(energy(floor(length(energy)/ratio)+1:end)); 
%         features(i,3) = lower_band_energy_sum/upper_band_energy_sum;
        %   logfft=compute_logfft_bands(spec(i,:),framesize);
%           features(i,7:end)=logfft;
    end
    
    if(nargout == 3)
        sgram=flipud(20*log(spec'));
    elseif(nargout == 4)
        sgram=flipud(20*log(spec'));
        agram=flipud(acorr');
    end
    
    
    
    
