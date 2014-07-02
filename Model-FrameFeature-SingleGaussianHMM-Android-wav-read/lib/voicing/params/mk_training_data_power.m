

noise_level = 0.01;
lastGTIdx = 0;

if(exist('f1') ~= 1 || exist('m1') ~= 1 || exist('s1') ~= 1 || exist('a1') ~= 1)
    [fs1,m1,s1,a1] = voicing_features_all_power(training.A1, framesize, framestep,noise_level,num_mean_frames,sr);
    disp('A1 done');
else
    disp('A1 already done');
end

ex1 = mk_training_example('lin-tanzeem', training.A1, sr, fs1, m1, s1, a1, noise_level, convert_gt(training.gt(lastGTIdx+1:lastGTIdx+size(fs1,2))));
lastGTIdx = lastGTIdx+size(fs1,2);


if(exist('f2') ~= 1 || exist('m2') ~= 1 || exist('s2') ~= 1 || exist('a2') ~= 1)
    [fs2,m2,s2,a2] = voicing_features_all_power(training.A2, framesize, framestep,noise_level,num_mean_frames,sr);
    disp('A2 done');
else
    disp('A2 already done');
end

ex2 = mk_training_example('lin-talking-markovia', training.A2, sr, fs2, m2, s2, a2, noise_level, convert_gt(training.gt(lastGTIdx+1:lastGTIdx+size(fs2,2))));
lastGTIdx = lastGTIdx+size(fs2,2);


if(exist('f3') ~= 1 || exist('m3') ~= 1 || exist('s3') ~= 1 || exist('a3') ~= 1)
    [fs3,m3,s3,a3] = voicing_features_all_power(training.A3, framesize, framestep,noise_level,num_mean_frames,sr);
    disp('A3 done');
else
    disp('A3 already done');
end

ex3 = mk_training_example('vacuuming', training.A3, sr, fs3, m3, s3, a3, noise_level, repmat(1, size(fs3,2), 1));


if(exist('f4') ~= 1 || exist('m4') ~= 1 || exist('s4') ~= 1 || exist('a4') ~= 1)
    [fs4,m4,s4,a4] = voicing_features_all_power(training.A4, framesize, framestep,noise_level,num_mean_frames,sr);
    disp('A4 done');
else
    disp('A4 already done');
end

ex4 = mk_training_example('brushing', training.A4, sr, fs4, m4, s4, a4, noise_level, convert_gt(training.gt(lastGTIdx+1:lastGTIdx+size(fs4,2))));
lastGTIdx = lastGTIdx+size(fs4,2);



if(exist('f5') ~= 1 || exist('b5') ~= 1 || exist('m5') ~= 1 || exist('s5') ~= 1 || exist('a5') ~= 1)
    [fs5,m5,s5,a5] = voicing_features_all_power(training.A5, framesize, framestep,noise_level,num_mean_frames,sr);
    disp('A5 done');
else
    disp('A5 already done');
end

ex5 = mk_training_example('typing', training.A5, sr, fs5, m5, s5, a5, noise_level, convert_gt(training.gt(lastGTIdx+1:lastGTIdx+size(fs5,2))));
lastGTIdx = lastGTIdx+size(fs5,2);


if(exist('f6') ~= 1 || exist('m6') ~= 1 || exist('s6') ~= 1 || exist('a6') ~= 1)
    [fs6,m6,s6,a6] = voicing_features_all_power(training.A6, framesize, framestep,noise_level,num_mean_frames,sr);
    disp('A6 done');
else
    disp('A6 already done');
end

ex6 = mk_training_example('tracemeeting-a', training.A6, sr, fs6, m6, s6, a6, noise_level, convert_gt(training.gt(lastGTIdx+1:lastGTIdx+size(fs6,2))));
lastGTIdx = lastGTIdx+size(fs6,2);


%cd 'S:\uwar\data\tracemeeting-20050722\b'
%[x7, fs]=wavread('Trace_07_22_2005__Time_10_34_38.wav',[orig_sr*60 orig_sr*60*2]);
%A7 = resample(x7,re_sr,orig_sr); 
if(exist('f7') ~= 1 || exist('m7') ~= 1 || exist('s7') ~= 1 || exist('a7') ~= 1)
    
    sig7 = regions_of_signal(training.A7, [1 3500], framestep);
    [fs7,m7,s7,a7] = voicing_features_all_power(sig7, framesize, framestep,noise_level,num_mean_frames,sr);
    disp('A7 done');
else
    disp('A7 already done');
end

ex7 = mk_training_example('tracemeeting-b', sig7, sr, fs7, m7, s7, a7, noise_level, convert_gt(training.gt(lastGTIdx+1:lastGTIdx+size(fs7,2))));
lastGTIdx = lastGTIdx+size(fs7,2);



examples = [ex1, ex2, ex3, ex4, ex5, ex6, ex7];




