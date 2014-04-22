function [ ] = featureExtractor( infile, outfile )

framesize = 256;
framestep = 128;
newsr = 8192;
num_mean_frames = 500;
noise_level = 0.01;


[sig,sr,ss] = wavread(infile);

newsig = resample(sig, newsr, sr);

clear sig;

[fstructs, mels, sgram, agram] = voicing_features_all(newsig,framesize,framestep,noise_level,num_mean_frames,newsr);



data.fstructs = truncateStructArrayToSingles(fstructs);
%data.fftbands = single(fftbands);
%data.acorrgram = single(agram);
%data.engram = single(egram);
data.mels = single(mels(:,20:40));

%data.melspec = mels;
%data.specgram = sgram;
%data.sig = newsig;

%[pathstr,name,ext,versn] = fileparts(filename);
%matfile = fullfile(pathstr, [name '.mat']);

save(outfile, 'data');

