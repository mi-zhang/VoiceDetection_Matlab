function [result, paths, hmm] = trainAndTestHMM(train, test, featureFunction)

result = zeros(length(test), 2);
paths = {};

%F = [];
F2 = [];
allPaths = [];
for k=1:length(train)
    featureMat2 = featureFunction(train(k));
    F2 = [F2; featureMat2];
    allPaths = [allPaths train(k).truth'];
end

vregions = path_to_region(allPaths);
    
% train hmm
hmm = trainVoicingHMM(F2, vregions, featureFunction);
    
% test
for i=1:length(test)
    t = test(i);
    f = featureFunction(t);
    path = compute_voiced_path(f, hmm);
    
    paths{i} = path;
    
    % find number of misclassified
    % size(path)
    % size(t.truth')
    missed = sum(abs(path - t.truth'));

    
    %disp(sprintf('missed %d/%d', missed, size(test.features,1)));
    
    result(i,1) = missed;
    result(i,2) = size(t.fstructs,2);
    [tp,fp,tn,fn] = metrics(path, t.truth');
    result(i,[3 4 5 6]) = [tp,fp,tn,fn];
    
end


end

function [tp,fp,tn,fn] = metrics(path, truth)

tp = nnz( (path == 2) & (truth == 2) );
fp = nnz( (path == 2) & (truth == 1) );
tn = nnz( (path == 1) & (truth == 1) );
fn = nnz( (path == 1) & (truth == 2) );

end
