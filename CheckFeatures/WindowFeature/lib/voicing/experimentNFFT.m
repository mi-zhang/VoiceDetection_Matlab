

%try:
% sg - tanzeem vs. matlab
% mels - orig sig only vs. whole sg vs. sg by row

noise_level = 0.01;
sr=8192;


nffts = [256 128 64 32 16];


counts = zeros(length(nffts), 2);
nfftResults = zeros(size(counts));

global featuretype;

for i=1:length(nffts)
    
    nfft = nffts(i);
    nfftResults(i,1) = nfft;
    
    framesize = nfft;
    framestep = nfft / 2;
    num_frames_for_mean = ((500*(256/8192))*8192) / nfft 
    
    % recompute features for new parameter value
    % also find length of all data
    %newTraindata = traindata([1 2 6 7]);
    newTraindata = traindata;

    for j=1:length(newTraindata)

        ex = newTraindata(j);

        disp(sprintf('recomputing %d: %s', j, ex.name));

        [features, fftbands, mels, sgram, agram] = voicing_features_all(ex.signal,framesize,framestep,noise_level,num_frames_for_mean,sr);

        if(size(mels,1) ~= size(features,1))
            mels = mels(1:size(features,1),:);
            disp('mels off')
        end
        
        ratio = 256 / nfft;
        if(round(ratio)==ratio)
            ex.truth = expand_truth(ex.truth, ratio);
            disp('expanded')
        end

        if(length(ex.truth) > size(features,1))
            length(ex.truth)
            size(features,1)
            ex.truth = ex.truth(1:size(features,1));
            disp('truth long')
        elseif(length(ex.truth) < size(features,1))
            length(ex.truth)
            size(features,1)
            while(length(ex.truth) < size(features,1))
                ex.truth(end+1) = ex.truth(end);
            end
            disp('truth short')            
        end

        newTraindata(j) = mk_training_example(ex.name, ex.signal, sr, features, fftbands, mels, sgram, agram, noise_level, ex.truth);
    end


    feature_index = [1 2 3 16 17 18];
    % or do boosting here


    [res, paths, hmms] = leaveOneOutXValidation(newTraindata, feature_index);
    nfft
    err = sum(res(:,1)) / sum(res(:,2))
    
    counts(i,1) = counts(i,1) + sum(res(:,1));
    counts(i,2) = counts(i,2) + sum(res(:,2));

end

nfftResults(:,2) = counts(:,1) ./ counts(:,2)
