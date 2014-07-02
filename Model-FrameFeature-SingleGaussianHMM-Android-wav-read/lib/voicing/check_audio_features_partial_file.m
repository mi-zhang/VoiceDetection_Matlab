%this script works with a clean file
%where there is no misses in the audio file

%it plots different features for partial() file on a specgram of audio
%for both msp computed features and matlab computed features

%figure 5 is matlab computed features
%figure 1 is msp computed features


%Thus the audio features were clean because 
%there is no chance of voiced frames mixing 
%with unvoiced frames and potentially giving wrong values
%in auto-correlation peaks and number of auto-correlation peaks


clear;

addpath('/Users/Shuvo/Desktop/All_lab/Kendal_temp/hsd-matlab/audio-feature-test/');
addpath('/Users/Shuvo/Desktop/All_lab/Kendal_temp/src/voicing/voicing_debug/hsd-matlab/voicing/')
addpath('/Users/Shuvo/Desktop/All_lab/Kendal_temp/src/old_codes_from_kelly')

fname2 = '/Users/Shuvo/Desktop/All_lab/kendal_final/shahid/080509 conversation data/080509/SU01/B048 Calibrate/log-2009-08-05-11.07.uwar';

a = uwar_io_getSensorData(fname2, {'audvoicingfeats/energy', 'audvoicingfeats/msb_counter','msb/audio_counter','msb/audio','audvoicingfeats/missed_samples'});%, 1);

%save data.mat a;
%load data.mat


en = [];
sig = [];
fc = [];

ac = [];

%extract audio signals from  file
for i=1:length(a)
    if(strcmp(a(i).sensorId, 'audvoicingfeats/energy'))
        en = a(i).data{1};
    elseif(strcmp(a(i).sensorId, 'msb/audio'))
        sig = double(a(i).data{1});
    elseif(strcmp(a(i).sensorId, 'audvoicingfeats/msb_counter'))
        fc(:,1:4) = [a(i).data{1}, a(i).data{2} a(i).data{3} a(i).data{4}];
    elseif(strcmp(a(i).sensorId, 'audvoicingfeats/missed_samples'))
        fc(:,5) = a(i).data{1};
    elseif(strcmp(a(i).sensorId, 'msb/audio_counter'))
        ac = a(i).data{1} * 5120 + a(i).data{2};
    end
end

A1 = sig;
sig = sig ./ 32768;
A_for_label1 = sig;



%extract audio features
audioAPD2 = uwar_io_getSensorData(fname2,'audvoicingfeats/acorr_peak_data');
audioRSE2 = uwar_io_getSensorData(fname2,'audvoicingfeats/spec_entropy');
nsamps2=(size(audioAPD2.timestamps,1));
T1=cell(audioAPD2.data{1});
for k=1:length(T1)
    x=double(T1{k});
    x=x./x(1);
    if(length(x)>1)
        f1(k)=max(x(2:end));
        f2(k)=length(x)-1;
    else
        f1(k)=0;
        f2(k)=0;
    end
end
f3=double(audioRSE2.data{1});
f5(1,:)=f1;
f5(2,:)=f2;
f5(3,:)=f3';
f5=f5';
ind=isnan(f5(:,3)); if(~isempty(ind)) v=find(ind==1); f5(v,3)=0; end
ind=isnan(f5(:,2)); if(~isempty(ind)) v=find(ind==1); f5(v,2)=0; end
ind=isnan(f5(:,1)); if(~isempty(ind)) v=find(ind==1); f5(v,1)=0; end
f5=f5';

%extract features from normalized raw audio signal 
[features, sgram, agram] = voicing_features(sig, 512, 256);
features = features(1:500,:);

%look at the first 500 features
start_index1 = 1;
end_index1 = 500*256;
A_for_label1=A1(start_index1:end_index1);
offset = 2;
f5 = f5(:,1+offset:500+offset);





% plot matlab computed features
temp_f5 = f5;
f5 = features';

figure(5)
subplot(411)
hold on
specgram(A_for_label1,512,256);
%plot((framestatevals-1)*40,'LineWidth',2)
title('Specgram of Raw Audio and Label')
axis tight
hold off

subplot(412)
hold on
specgram(A_for_label1,512,256);
%plot((framestatevals-1)*100,'k','LineWidth',1)
plot(f5(1,:)*100,'LineWidth',1)
title('Specgram of Raw Audio and Label and non-initial autocorrelation peak')
hold off
axis tight

subplot(413)
hold on
specgram(A_for_label1,512,256);
%plot((framestatevals-1)*100,'k','LineWidth',1)
plot(f5(2,:)*4,'LineWidth',1)
title('Specgram of Raw Audio and Label and num of peaks')
hold off
axis tight


subplot(414)
hold on
specgram(A_for_label1,512,256);
%plot((framestatevals-1)*100,'k','LineWidth',1)
plot(f5(3,:)*20,'LineWidth',1)
title('Specgram of Raw Audio and Label and Relative spectral entropy')
hold off
axis tight







%plot msp computed features
figure(1)
f5 = temp_f5;

disp('msp')

subplot(411)
%A_for_label1=A1;%(start_index1:end_index1);
hold on
specgram(A_for_label1,512,256);
%plot((framestatevals-1)*40,'LineWidth',2)
title('Specgram of Raw Audio and Label')
axis tight
hold off

subplot(412)
hold on
specgram(A_for_label1,512,256);
%plot((framestatevals-1)*100,'k','LineWidth',1)
plot(f5(1,:)*100,'LineWidth',1)
title('Specgram of Raw Audio and Label and non-initial autocorrelation peak')
hold off
axis tight

subplot(413)
hold on
specgram(A_for_label1,512,256);
%plot((framestatevals-1)*100,'k','LineWidth',1)
plot(f5(2,:)*4,'LineWidth',1)
title('Specgram of Raw Audio and Label and num of peaks')
hold off
axis tight


subplot(414)
hold on
specgram(A_for_label1,512,256);
%plot((framestatevals-1)*100,'k','LineWidth',1)
plot(f5(3,:)*20,'LineWidth',1)
title('Specgram of Raw Audio and Label and Relative spectral entropy')
hold off
axis tight