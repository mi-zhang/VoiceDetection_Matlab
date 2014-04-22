clear;
clc;

% addpath('/Users/Shuvo/Desktop/All_lab/Kendal_temp/')


%Don't care about this
%This is just loading audio from early MSP data
%currently we are getting the audio data directly from *.wav files
% fname1 ='/Users/Shuvo/Desktop/All_lab/kendal_final/shahid/080509 conversation data/080509/SU01/B048 Calibrate/log-2009-08-05-10.54.uwar';
% au1 = uwar_io_getSensorData(fname1,'msb/audio');
% save audio_data.mat au1
% 
% 
% %audio data that we need to care about
% A1=double(au1.data{1});

% 1. silence
% filename = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected\silent_t1.wav';
% 2. voice
filename = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected\speech_t2.wav';
% 3. classical music
% filename = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected\classical_t1.wav';
% 4. tv 
% filename = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected\tv_t1.wav';
% 5. pop music
% filename = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected\pop_t1.wav';
% 6. ambient sound
% filename = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected\ambient_t1.wav';

A1 = wavread(filename);

fprintf('Total Number of Frames = %d\n', floor(size(A1)/128));

ii = 1;
figure

%this is the first subset of the first dataset for training
%change to 256 to 128, which is half the window size
start_index1 = 500*128+1;
end_index1 = length(A1);

% relative spectrual entropy needs to wait for 500 frames to be ready to
% compute
% start_index1 = 500*128+1;
% end_index1 = 700*128;
A_for_label1 = A1(start_index1:end_index1);
specgram(A_for_label1, 256, 128);
labels5 = label_speech_features('signal',A_for_label1, 'framesize',256, 'framestep',128, 'samplingrate',8192, 'segheight',30);
saveas(gcf, ['figure_' num2str(ii)], 'fig')
% movefile('audio.wav',['audio_' num2str(ii) '.wav'])
ii = ii + 1;



%this is the second subset of the first dataset for training
start_index1 = 700*128+1;
end_index1 = 900*128;
A_for_label2 = A1(start_index1:end_index1);
specgram(A_for_label2, 256, 128)
labels6 = label_speech_features('signal',A_for_label2,'framesize',256,'framestep',128,'samplingrate',8192,'segheight',30);
saveas(gcf, ['figure_' num2str(ii)], 'fig')
% movefile('audio.wav',['audio_' num2str(ii) '.wav'])
ii = ii + 1;

%this is the third subset of the first dataset for training
start_index1 = 900*128;
end_index1 = 1100*128;
A_for_label3 = A1(start_index1:end_index1);
specgram(A_for_label3, 256,128)
labels7=label_speech_features('signal',A_for_label3,'framesize',256,'framestep',128,'samplingrate',8192,'segheight',30);
saveas(gcf, ['figure_' num2str(ii)], 'fig')
% movefile('audio.wav',['audio_' num2str(ii) '.wav'])
ii = ii + 1;


%this is the forth subset of the first dataset for training
start_index1=1100*128;
end_index1=1300*128;
A_for_label4=A1(start_index1:end_index1);
specgram(A_for_label4,256,128)
labels8=label_speech_features('signal',A_for_label4,'framesize',256,'framestep',128,'samplingrate',8192,'segheight',30);
saveas(gcf, ['figure_' num2str(ii)], 'fig')
movefile('audio.wav',['audio_' num2str(ii) '.wav'])
ii = ii + 1;

%this is the fifth subset of the first dataset for training
start_index1=1300*128;
end_index1=1500*128;
A_for_label5=A1(start_index1:end_index1);
specgram(A_for_label5,256,128)
labels9=label_speech_features('signal',A_for_label5,'framesize',256,'framestep',128,'samplingrate',8192,'segheight',30);
saveas(gcf, ['figure_' num2str(ii)], 'fig')
movefile('audio.wav',['audio_' num2str(ii) '.wav'])
ii = ii + 1;



%add steps onto labels so that they aren't all 1-200
labels5=round(labels5);
labels6=round(labels6)+200;
labels7=round(labels7)+400;
labels8=round(labels8)+600;
labels9=round(labels9)+800;
%put all labels into one array
labels1=[labels5; labels6; labels7; labels8; labels9];

%all audio data
A_for_label = [A_for_label1;A_for_label2;A_for_label3;A_for_label4;A_for_label5];







