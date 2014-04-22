noise_level=0.09;
framesize=256; framestep=128;
num_mean_frames = 500;

cd 'C:\tanzeem\students\lin\talking\lin-tanzeem'
x=wavread('S_sensor_audio_complete.wav');
x1=x(1:16000*60); y1 = resample(x1,8192,15360); A1=y1(128000:364000);
[f1,s1,a1] = voicing_features_large(A1, framesize, framestep,noise_level,num_mean_frames);
clear x x1 y1 

cd 'C:\tanzeem\students\lin\talking\markovia\Journal'
tmp=GetLabelsByRegExp('journal.jrl', 'talking_chunk','talking',0,1e300);
A=GetAudioSeq('journal.jrl','jrl_completeSensorAudio',tmp(1,1),1000);
A = (A./32513);
A2=resample(A,8192,15360);
[f2, s2,a2] = voicing_features_large(A2, framesize, framestep,noise_level,num_mean_frames);
clear A 

cd 'Y:\ubicomp05\03_02_2005 tanzeem\part_01\Journal'
tmp=GetLabelsByRegExp('journal.jrl', 'Activity Labels','Vacuuming',0,1e300);
A=GetAudioSeq('journal.jrl','jrl_completeSensorAudio',tmp(1,1),1000);
A3=resample(A,8192,15360);
[f3, s3,a3] = voicing_features_large(A3, framesize, framestep,noise_level,num_mean_frames);
clear A 

cd 'Y:\ubicomp05\03_02_2005 tanzeem\part_01\Journal'
tmp=GetLabelsByRegExp('journal.jrl', 'Activity Labels','Brushing',0,1e300);
A=GetAudioSeq('journal.jrl','jrl_completeSensorAudio',tmp(1,1),1000);
A = (A./32513);
A4=resample(A,8192,15360);
[f4, s4,a4] = voicing_features_large(A4, framesize, framestep,noise_level,num_mean_frames);
clear A 

cd 'C:\tanzeem\students\lin\typing\Journal'
tmp=GetLabelsByRegExp('journal.jrl', 'typing_label','typing',0,1e300);
A=GetAudioSeq('journal.jrl','jrl_completeSensorAudio',tmp(1,1),1000);
A = (A./32513);
A5=resample(A,8192,15360);
[f5, s5,a5] = voicing_features_large(A5, framesize, framestep,noise_level,num_mean_frames);
clear A 

cd 'C:\tanzeem\students\lin\talking\training data'
F=[f1;f2;f4;f5];
F=F(:,feature_index);
[speech_mu, speech_cov, prior1,transmat]=compute_voicingHMM(F,voiced_ind);


F=[f1;f2;f4;f5];
gt=[gt1_2; gt4; gt5];
i=16;
param = boost(F,gt,i);
for i=1:16
    tmp(i)=param(i).stump.comp;
end

feature_index=unique(sort(tmp));
F=[f1;f2;f4;f5]; F=F(:,feature_index);
% [speech_mu, speech_cov, prior1,transmat]=compute_voicingHMM(F,voiced_ind);


F=[f1;f2;f3;f4;f5]; F=F(:,feature_index);
B = mk_ghmm_obs_lik(F', speech_mu,speech_cov) ;
% or, for newer BNT, 
% B= mixgauss_prob(F', speech_mu, speech_cov)
[path, loglik] = viterbi_path(prior1, transmat, B);
[region] = path_to_region(path);
A=[A1; A2; A3; A4; A5];
[region_sig]= play_regions(A,region,128,8192);
path_flip = abs(path-3);
[region_flip] = path_to_region(path_flip);
[region_sig_flip]= play_regions(A,region_flip,128,8192);
[region_sig_flip]= play_regions(A,region_flip(1:49,:),128,8192);