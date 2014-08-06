
%try:
% sg - tanzeem vs. matlab
% mels - orig sig only vs. whole sg vs. sg by row

noise_level = 0.01;
num_frames_for_mean = 500;
sr=8192;

framesize = 256;
framestep = 128;

% recompute features for new parameter value
% also find length of all data
%newTraindata = traindata([1 2 6 7]);
newTraindata = traindata;



feature_index = [1 2 3 7 16 17 18];
% or do boosting here


[res, paths, hmms] = leaveOneOutXValidation(newTraindata, feature_index);
disp('w/ mel')
err = sum(res(:,1)) / sum(res(:,2))


feature_index = [1 2 3 7];
% or do boosting here

[res, paths, hmms] = leaveOneOutXValidation(newTraindata, feature_index);
disp('w/o mel')
err = sum(res(:,1)) / sum(res(:,2))




