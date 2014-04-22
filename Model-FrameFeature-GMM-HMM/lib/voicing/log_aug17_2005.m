noise_level=0.02;
framesize=256; framestep=128;
num_mean_frames = 500;
orig_sr = 15360;
re_sr = 8192;
sr = re_sr;

cd 'C:\tanzeem\students\lin\talking\lin-tanzeem'
x=wavread('S_sensor_audio_complete.wav');
x1=x(1:16000*60); y1 = resample(x1,re_sr,orig_sr); A1=y1(128000:364000);
[f1,m1,s1,a1] = voicing_features_large(A1, framesize, framestep,noise_level,num_mean_frames,sr);
clear x x1 y1 
cd 'C:\tanzeem\students\lin\talking\training data'
save trainset1 A1 f1 m1 s1 a1 

cd 'C:\tanzeem\students\lin\talking\markovia\Journal'
tmp=GetLabelsByRegExp('journal.jrl', 'talking_chunk','talking',0,1e300);
A=GetAudioSeq('journal.jrl','jrl_completeSensorAudio',tmp(1,1),1000);
A = (A./32513); 
A2=resample(A,re_sr,orig_sr);
[f2, m2, s2,a2] = voicing_features_large(A2, framesize, framestep,noise_level,num_mean_frames,sr);
clear A 
cd 'C:\tanzeem\students\lin\talking\training data'
save trainset2 A2 f2 m2 s2 a2 

cd 'Y:\ubicomp05\03_02_2005 tanzeem\part_01\Journal'
tmp=GetLabelsByRegExp('journal.jrl', 'Activity Labels','Vacuuming',0,1e300);
A=GetAudioSeq('journal.jrl','jrl_completeSensorAudio',tmp(1,1),1000);
A = (A./32513);
A3=resample(A,re_sr,orig_sr);
[f3, m3,s3,a3] = voicing_features_large(A3, framesize, framestep,noise_level,num_mean_frames,sr);
clear A 
cd 'C:\tanzeem\students\lin\talking\training data'
save trainset3 A3 f3 m3 s3 a3 

cd 'Y:\ubicomp05\03_02_2005 tanzeem\part_01\Journal'
tmp=GetLabelsByRegExp('journal.jrl', 'Activity Labels','Brushing',0,1e300);
A=GetAudioSeq('journal.jrl','jrl_completeSensorAudio',tmp(1,1),1000);
A = (A./32513);
A4=resample(A,re_sr,orig_sr);
[f4,m4, s4,a4] = voicing_features_large(A4, framesize, framestep,noise_level,num_mean_frames,sr);
clear A 
cd 'C:\tanzeem\students\lin\talking\training data'
save trainset4 A4 f4 m4 s4 a4 

cd 'C:\tanzeem\students\lin\typing\Journal'
tmp=GetLabelsByRegExp('journal.jrl', 'typing_label','typing',0,1e300);
A=GetAudioSeq('journal.jrl','jrl_completeSensorAudio',tmp(1,1),1000);
A = (A./32513);
A5=resample(A,re_sr,orig_sr);
[f5, m5,s5,a5] = voicing_features_large(A5, framesize, framestep,noise_level,num_mean_frames,sr);
clear A 
cd 'C:\tanzeem\students\lin\talking\training data'
save trainset5 A5 f5 m5 s5 a5 

cd 'S:\uwar\data\tracemeeting-20050722\a'
[x6, fs]=wavread('Trace_07_22_2005__Time_10_33_30.wav',[orig_sr*60 orig_sr*60*2]);
A6 = resample(x6,re_sr,orig_sr); 
[f6,m6,s6,a6] = voicing_features_large(A6, framesize, framestep,noise_level,num_mean_frames,sr);
clear x x6 y6 
% cd 'C:\tanzeem\students\lin\talking\training data'
% save trainset6 y6 f6 m6 s6 a6

cd 'S:\uwar\data\tracemeeting-20050722\b'
[x7, fs]=wavread('Trace_07_22_2005__Time_10_34_38.wav',[orig_sr*60 orig_sr*60*2]);
A7 = resample(x7,re_sr,orig_sr); 
[f7,m7,s7,a7] = voicing_features_large(A7, framesize, framestep,noise_level,num_mean_frames,sr);
clear x x7 y7 
% cd 'C:\tanzeem\students\lin\talking\training data'
% save trainset7 A7 f7 m7 s7 a7 

cd 'C:\tanzeem\students\lin\talking\training data'
F=[f1 m1;f2 m2;f4 m4;f5 m5;f6 m6;f7(1:3500,:) m7(1:3500,:)];
num_params=50;
param = boost(F,gt,num_params);
M=[];
for i=1:num_params
    p=param(1:i);
    yb = eval_boost(F,p);
    trainerr(i)= mean(yb.*gt<=0);
    mar = yb .* gt ;
    M = [M,mar];
end
for i=1:num_params
    tmp(i)=param(i).stump.comp;
end
feature_index=unique(sort(tmp));


Fselect=F(:,feature_index);
[speech_mu, speech_cov, prior1,transmat]=compute_voicingHMM(Fselect,voiced_ind);

Ftest=[f1 m1;f2 m2;f3 m3;f4 m4;f5 m5;f6 m6;f7(1:3500,:) m7(1:3500,:)];
B = mk_ghmm_obs_lik(Ftest(:,feature_index)', speech_mu,speech_cov) ;
[path, loglik] = viterbi_path(prior1, transmat, B);
[region] = path_to_region(path);
A=[A1; A2; A3; A4; A5; A6; A7];
[region_sig]= play_regions(A,region,128,re_sr);
path_flip = abs(path-3);
[region_flip] = path_to_region(path_flip);
[region_sig_flip]= play_regions(A,region_flip,128,re_sr);
[region_sig_flip]= play_regions(A,region_flip(1:49,:),128,re_sr);