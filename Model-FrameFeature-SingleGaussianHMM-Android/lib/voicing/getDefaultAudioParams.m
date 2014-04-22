function [audioParams] = getDefaultAudioParams()

audioParams.noise_level = 0.01;
audioParams.sample_rate = 15360;
audioParams.framesize = 512;
audioParams.framestep = 256;
audioParams.num_frames_for_entropy = 500;
