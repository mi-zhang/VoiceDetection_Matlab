

%try:
% sg - tanzeem vs. matlab
% mels - orig sig only vs. whole sg vs. sg by row

noise_level = 0.01;
num_frames_for_mean = 500;
sr=8192;

framesize = 256;
framestep = 128;




numvars = 6;

% 1 - orig sg, orig mels
% 2 - orig sg, sg row mels
% 3 - orig sg, whole sg mels
% 4 - matlab sg, orig mels
% 5 - matlab sg, sg row mels
% 6 - matlab sg, whole mels

counts = zeros(numvars, 2);

global featuretype;

for i=1:numvars
    
    featuretype = i;

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

        if(length(ex.truth) ~= size(features,1))
            ex.truth = ex.truth(1:size(features,1));
            disp('truth off')
        end

        newTraindata(j) = mk_training_example(ex.name, ex.signal, sr, features, fftbands, mels, sgram, agram, noise_level, ex.truth);
    end


    feature_index = [1 2 3 16 17 18];
    % or do boosting here


    [res, paths, hmms] = leaveOneOutXValidation(newTraindata, feature_index);
    featuretype
    err = sum(res(:,1)) / sum(res(:,2))
    
    counts(i,1) = counts(i,1) + sum(res(:,1));
    counts(i,2) = counts(i,2) + sum(res(:,2));

end
