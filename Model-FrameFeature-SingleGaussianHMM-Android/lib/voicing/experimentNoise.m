

%noises = 0.00:0.01:0.2;
%noises = [0.01, 0.02, 0.05, 0.07, 0.09];%, 0.07,  0.09];

noises = [0.00 0.01 0.02 0.05 0.07 0.09];

noiseResults = zeros(length(noises), 2);

counts = zeros(length(noises), 2);

% outer parameter-varying loop
for i=1:length(noises)
    
    disp(sprintf('\nnoise param %d/%d: %f', i, length(noises), noises(i)));

    noiseResults(i,1) = noises(i);
    
    % recompute features for new parameter value
    % also find length of all data
    newTraindata = examples([1 2 4 5 6 7]);
    %newTraindata = traindata;

    totalFrames = 0;
    for j=1:length(newTraindata)

        ex = newTraindata(j);
        
        disp(sprintf('recomputing %d: %s', j, ex.name));

        noiseVec = noises(i)*randn(size(ex.signal));
        acorr = acorrgram(ex.signal + noiseVec, framesize, framestep); %noisy acorr
        
        numframes = size(ex.fstructs, 2);

        %features = ex.features;
        fstructs = ex.fstructs;
        for k = 1:numframes
            [peaks, peakvals] = find_acorr_peaks(acorr(k,:));
            %features(k,1) = max(peakvals);
            %features(k,2) = length(peaks);
            fstructs(k).peaks07 = peaks;
            fstructs(k).peakvals07 = peakvals;
            %features(k,7) = norm(acorr(k,:));
        end

        agram=flipud(acorr');
        
        newTraindata(j) = mk_training_example(ex.name, ex.signal, sr, fstructs, ex.melspec, ex.specgram, agram, noise_level, ex.truth);
        totalFrames = totalFrames + numframes;
    end
    
    
    %feature_index = [1 2 3 16 18];
    feature_index = [1 2 9];
    % or do boosting here
    
  
    [res, paths, hmms] = leaveOneOutXValidation(newTraindata, @featureMatrix);
    %[res, paths, hmms] = leaveOneOutXValidation(newTraindata([1 2 6 7]), feature_index, newTraindata([3 4 5]));
    %[res, paths, hmms] = leaveOneOutXValidation(newTraindata([1 2 6 7]), feature_index);
    counts(i,1) = counts(i,1) + sum(res(:,1));
    counts(i,2) = counts(i,2) + sum(res(:,2));
    
end

noiseResults(:,2) = counts(:,1) ./ counts(:,2)



% figure(1);
% subplot(211), imagesc(newTraindata(1).acorrgram); hold on; plot((newTraindata(1).truth'-1)*100)
% subplot(212), imagesc(newTraindata(1).specgram); hold on; plot((newTraindata(1).truth'-1)*100)
% figure(2);
% subplot(211), imagesc(newTraindata(2).acorrgram); hold on; plot((newTraindata(2).truth'-1)*100)
% subplot(212), imagesc(newTraindata(2).specgram); hold on; plot((newTraindata(2).truth'-1)*100)
% figure(3);
% subplot(211), imagesc(newTraindata(3).acorrgram); hold on; plot((newTraindata(3).truth'-1)*100)
% subplot(212), imagesc(newTraindata(3).specgram); hold on; plot((newTraindata(3).truth'-1)*100)
%figure(4);
%subplot(211), imagesc(newTraindata(4).acorrgram); hold on; plot((newTraindata(4).truth'-1)*100)
%subplot(212), imagesc(newTraindata(4).specgram); hold on; plot((newTraindata(4).truth'-1)*100)
