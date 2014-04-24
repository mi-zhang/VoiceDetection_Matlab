function [ example ] = mk_training_example(name,sig,sr,fstructs,melspec,specgram,acorrgrams,noise_level,ground_truth)
%MK_TRAINING_EXAMPLE Makes a struct for a voicing example.

example.name = name;
example.signal = sig;
example.sample_rate = sr;
%example.features = features;
example.fstructs = fstructs;
example.melspec = melspec;
example.specgram = specgram;
example.acorrgrams = acorrgrams;
example.noise_level = noise_level;
example.truth = ground_truth;


