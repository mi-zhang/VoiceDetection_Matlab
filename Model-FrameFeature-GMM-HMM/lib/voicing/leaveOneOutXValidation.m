function [result, paths, hmms] = leaveOneOutXValidation(dataset, featureFunction, additionalTests)

result = zeros(length(dataset), 2);
paths = {};
hmms = {};

if(nargin >= 3)
    tests = additionalTests;
    tests(end+1) = dataset(1);
else
    tests = dataset(1);
end

for j=1:length(dataset)

    idxs = 1:length(dataset);
    idxs = idxs(find(idxs~=j));

    % train on others, test on additional plus left out
    tests(end) = dataset(j);
    
    [r, path, hmm] = trainAndTestHMM(dataset(idxs), tests, featureFunction);

    paths{end+1} = path;
    hmms{end+1} = hmm;


    missed = sum(r(:,1));
    sz = sum(r(:,2));
    
    tp = sum(r(:,3));
    fp = sum(r(:,4));
    tn = sum(r(:,5));
    fn = sum(r(:,6));
    
    disp(['leaving out: ', tests(end).name]);
    disp(sprintf('missed %d/%d', missed, sz));
    
    result(j,1) = missed;
    result(j,2) = sz;
    result(j,3) = tp;
    result(j,4) = fp;
    result(j,5) = tn;
    result(j,6) = fn;
    
end