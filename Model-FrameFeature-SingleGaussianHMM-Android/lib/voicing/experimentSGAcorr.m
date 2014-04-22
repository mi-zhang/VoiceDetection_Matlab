



newTraindata = examples;

%[res, paths, hmms] = leaveOneOutXValidation(newTraindata, @origAcorrRSEMaxPNumP);
%err = sum(res(:,1)) / sum(res(:,2))

%[res, paths, hmms] = leaveOneOutXValidation(newTraindata, @detWhiteSGAcorrRSEMaxPNumPMax);
%err = sum(res(:,1)) / sum(res(:,2))

%[res, paths, hmms] = leaveOneOutXValidation(newTraindata, @detWhiteSGAcorrRSENumPMax);
%err = sum(res(:,1)) / sum(res(:,2))

%[res, paths, hmms] = leaveOneOutXValidation(newTraindata, @randWhiteSGAcorrRSEMaxPNumP);
%err = sum(res(:,1)) / sum(res(:,2))

%[res, paths, hmms] = leaveOneOutXValidation(newTraindata, @randWhiteSGAcorrRSEMaxPNumPMax);
%err = sum(res(:,1)) / sum(res(:,2))

%[res, paths, hmms] = leaveOneOutXValidation(newTraindata, @randWhiteSGAcorrRSENumPMax);
%err = sum(res(:,1)) / sum(res(:,2))

%[res, paths, hmms] = leaveOneOutXValidation(newTraindata, @oddWhiteSGAcorrRSEMaxPNumP);
%err = sum(res(:,1)) / sum(res(:,2))

%[res, paths, hmms] = leaveOneOutXValidation(newTraindata, @origAcorrRSEMaxPNumP01);
%err = sum(res(:,1)) / sum(res(:,2))

%[res, paths, hmms] = leaveOneOutXValidation(newTraindata, @randWhiteSGAcorrRSEMaxPVar01);
%err = sum(res(:,1)) / sum(res(:,2))


[res, paths, hmms] = leaveOneOutXValidation(newTraindata, @origAcorrRSEMaxPSpread01);
err = sum(res(:,1)) / sum(res(:,2))

[res, paths, hmms] = leaveOneOutXValidation(newTraindata, @detWhiteSGAcorrRSEMaxPSpread01);
err = sum(res(:,1)) / sum(res(:,2))

[res, paths, hmms] = leaveOneOutXValidation(newTraindata, @randWhiteSGAcorrRSEMaxPSpread01);
err = sum(res(:,1)) / sum(res(:,2))



