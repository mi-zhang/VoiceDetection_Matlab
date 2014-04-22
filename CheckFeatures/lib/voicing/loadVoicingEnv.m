noise_level=0.09;
framesize=256;
framestep=128;
num_mean_frames = 500;

if(strcmp(computer,'PCWIN'))
    voicingDir = 'C:\Documents and Settings\danny\My Documents\work\hsd\src\matlab\conversation\voicing';
else
    voicingDir = '/homes/gws/danny/research/hsd/src/matlab/conversation/voicing';
end

voicingHMMFile = fullfile(voicingDir, 'params', 'voicingHMM');

load(voicingHMMFile)