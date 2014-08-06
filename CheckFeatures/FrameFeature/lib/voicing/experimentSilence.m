

noises = [0.00 0.01 0.001 0.0001 0.00001];
feature_index = [1 2 3 16 18];


silenceResults = [];

extra = 1;
counts = zeros(length(noises)*2+extra, 2);

num_frames_for_mean = 500;

datas = {};

newTraindata = traindata;

% first, give it a run w/o any silence

[res, paths, hmms] = leaveOneOutXValidation(newTraindata, feature_index);
%[res, paths, hmms] = leaveOneOutXValidation(newTraindata([1 2 6 7]), feature_index, newTraindata([3 4 5]));
%[res, paths, hmms] = leaveOneOutXValidation(newTraindata([1 2 6 7]), feature_index);
counts(1,1) = counts(1,1) + sum(res(:,1));
counts(1,2) = counts(1,2) + sum(res(:,2));


% now go through and insert silence 
% and test post-facto silence fix
for i=1:length(newTraindata)
    newTraindata(i).signal = insert_silence(newTraindata(i).signal, 20, 500, 2000);

    [features, fftbands, mels, sgram, agram] = voicing_features_all(newTraindata(i).signal,framesize,framestep,0.01,num_frames_for_mean,sr);
                
    newTraindata(i) = mk_training_example(newTraindata(i).name, newTraindata(i).signal, sr, features, fftbands, mels, sgram, agram, 0.01, newTraindata(i).truth);

end



% outer parameter-varying loop
for i=1:length(noises)
    
    disp(sprintf('\nnoise param %d/%d: %f', i, length(noises), noises(i)));

    silenceResults(i+extra,1) = noises(i);
    
    for j=1:length(newTraindata)

        ex = newTraindata(j);
        
        disp(sprintf('recomputing %d: %s', j, ex.name));    

        % fill silence with noise
        sig = fill_regions_with_noise(ex.signal, find_silence(ex.signal), noises(i));

        [features, fftbands, mels, sgram, agram] = voicing_features_all(sig,framesize,framestep,0.01,num_frames_for_mean,sr);
                
        noiseEx = mk_training_example(ex.name, sig, sr, features, fftbands, mels, sgram, agram, 0.01, ex.truth);
        
        %datas{end+1} = newTraindata(j);
        
        % compute results        
        idxs = 1:length(traindata);
        idxs = idxs(find(idxs~=j));
        [res, path, hmm] = trainAndTestHMM(traindata(idxs), [noiseEx], feature_index);
        
        counts(i+extra,1) = counts(i+extra,1) + sum(res(:,1));
        counts(i+extra,2) = counts(i+extra,2) + sum(res(:,2));
        
    end
   
end

% outer parameter-varying loop
for i=1:length(noises)
    
    disp(sprintf('\nnoise param %d/%d: %f', i, length(noises), noises(i)));

    silenceResults(i+length(noises)+extra,1) = noises(i);
    
    for j=1:length(newTraindata)

        ex = newTraindata(j);
        
        disp(sprintf('recomputing %d: %s', j, ex.name));    

        % fill silence with noise stats
        fixedEx = fixSilence(ex, noises(i), framesize, framestep, sr, num_frames_for_mean);
        
        % compute results        
        idxs = 1:length(traindata);
        idxs = idxs(find(idxs~=j));
        [res, path, hmm] = trainAndTestHMM(traindata(idxs), [fixedEx], feature_index);
        
        counts(i+length(noises)+extra,1) = counts(i+length(noises)+extra,1) + sum(res(:,1));
        counts(i+length(noises)+extra,2) = counts(i+length(noises)+extra,2) + sum(res(:,2));
        
    end
   
end


silenceResults(:,2) = counts(:,1) ./ counts(:,2)



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
