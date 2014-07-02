noise_level=0.02;
framesize=256; framestep=128;
num_mean_frames = 500;
orig_sr = 15360;
re_sr = 8192;
sr = re_sr;


F=[f1 b1 m1;f2 b2 m2;f4 b4 m4;f5 b5 m5;f6 b6 m6;f7(1:3500,:) b7(1:3500,:) m7(1:3500,:)];

if(exist('feature_index') ~= 1)

    num_params=50;
    param = boost(F,training.gt,num_params);
    M=[];
    for i=1:num_params
        p=param(1:i);
        yb = eval_boost(F,p);
        trainerr(i)= mean(yb.*training.gt<=0);
        mar = yb .* training.gt ;
        M = [M,mar];
    end
    for i=1:num_params
        tmp(i)=param(i).stump.comp;
    end
    feature_index=unique(sort(tmp));
else
    disp('boosting already done');
end


testHMM = trainVoicingHMM(F, feature_index, training.voiced_ind);

Ftest=[f1 b1 m1;f2 b2 m2;f3 b3 m3;f4 b4 m4;f5 b5 m5;f6 b6 m6;f7(1:3500,:) b7(1:3500,:) m7(1:3500,:)];

path = compute_voiced_path(Ftest, testHMM);

[voiced unvoiced] = compute_voiced_regions(path);

%A=[A1; A2; A3; A4; A5; A6; A7];
%[region_sig]= play_regions(A,region,128,re_sr);
%path_flip = abs(path-3);
%[region_flip] = path_to_region(path_flip);
%[region_sig_flip]= play_regions(A,region_flip,128,re_sr);
%[region_sig_flip]= play_regions(A,region_flip(1:49,:),128,re_sr);