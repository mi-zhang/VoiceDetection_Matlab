function [speech_mu, speech_cov, prior1,transmat]=compute_voicingHMM(F,voiced_labels)
% Computes the paramters of voicing HMM
% F is the training feature file - contains both voiced and unvoiced
% regions
% voice_labels - num_labelsX2 matrix which contains start and end times of
% voiced regions


%F=[features;featuresV];
vregions = floor(voiced_labels);
numregions = size(vregions,1);
tot_features = size(F,2);
vfeatures = zeros(0,tot_features);
numfeatures = 0;
numframes = length(F);
framestatevals = ones(numframes,1);

for region = 1:numregions
    for i = vregions(region,1):vregions(region,2)
        numfeatures = numfeatures+1;
        for j = 1:tot_features
            if(i<size(F,1))
                vfeatures(numfeatures, j) = F(i,j);
            end
        end
        framestatevals(i) = 2;
    end
end

negfeatures = zeros(0,tot_features);
numnegfeatures = 0;

for i = 1:numframes
    if (framestatevals(i) == 1)
        numnegfeatures = numnegfeatures+1;
        for j = 1:tot_features
            negfeatures(numnegfeatures, j) = F(i,j);
        end
    end
end


voiced_mean = mean(vfeatures)';
voiced_cov = cov(vfeatures);
voiced_cov_inv = inv(voiced_cov);
n = length(voiced_mean);
voiced_scfactor = (1/ ( ((2*pi)^(n/2)) * (det(voiced_cov)^0.5) ));

unvoiced_mean = mean(negfeatures)';
unvoiced_cov = cov(negfeatures);
unvoiced_cov_inv = inv(unvoiced_cov);
unvoiced_scfactor = (1/ ( ((2*pi)^(n/2)) * (det(unvoiced_cov)^0.5) ));
logT = log(estimate_T_table(framestatevals, 2));

%speech_cov(:,:,1)=diag(diag(unvoiced_cov));
%speech_cov(:,:,2)=diag(diag(voiced_cov));
speech_cov(:,:,1)=unvoiced_cov;
speech_cov(:,:,2)=voiced_cov;
speech_mu(:,2)=voiced_mean;
speech_mu(:,1)=unvoiced_mean;

transmat=exp(logT);
prior1 =[0.5;0.5];

% data07=features07';
% data07=data07(1:3,:);
% B07 = mk_ghmm_obs_lik(data07, speech_mu,speech_cov) ;
% [path_07, loglik] = viterbi_path(prior1, transmat, B07);
% 
% data01=features01';
% data01=data01(1:3,:);
% B01 = mk_ghmm_obs_lik(data01, speech_mu,speech_cov) ;
% [path_01, loglik] = viterbi_path(prior1, transmat, B01);
% 
% [regions01, oind1,oind2]= viterbi_to_regions(path_01);
% [regions07, oind1,oind2]= viterbi_to_regions(path_07);
% [voiced_sig01]= play_regions(xtest_01,regions01,128,8000);
% [voiced_sig07]= play_regions(xtest_07,regions07,128,8000);

