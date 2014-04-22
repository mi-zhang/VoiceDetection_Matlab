function [ ] = audplots(matlabPowSG, matlabAcorr, matlabEnergies, matlabLowFreqEnergies, matlabSE, matlabRSE, ipaqse, ipaqrse, ipaqenergies, ipaqmaxpeakvals, ipaqacgmax, ipaqacgmin, ipaqpeakidxs, ipaqlowfreqens )

framesize = 512;
framestep = 256;


comp = [1:framesize framesize-1:-1:1] / framesize;
comp = 1./comp;
tc = comp(framesize:framesize+255);


[mP, mV, mVar, mHi, mLo, mSpread, mPidxs, mHiIdxs] = acorrStats(matlabAcorr);



nplots = 9;

sp=1;
subplot(nplots,1,sp), imagesc(flipud(log(matlabPowSG)'));
axis tight;sp = sp+1;


subplot(nplots,1,sp), plot(matlabSE); hold on; plot(ipaqse, 'g')
axis tight;sp = sp+1;

subplot(nplots,1,sp), plot(matlabRSE); hold on; plot(ipaqrse, 'g')
axis([0 max(length(matlabRSE), length(ipaqrse)) 0 1]);
sp = sp+1;

subplot(nplots,1,sp), plot(matlabEnergies); hold on; plot(ipaqenergies, 'g');
axis tight;
sp = sp+1;

subplot(nplots,1,sp), plot(matlabLowFreqEnergies ./ matlabEnergies); hold on; plot((ipaqlowfreqens/512) ./ ipaqenergies, 'g');
axis tight;
sp = sp+1;


subplot(nplots,1,sp), imagesc(flipud(matlabAcorr'));
axis tight; sp = sp+1;

subplot(nplots,1,sp), plot(mV); hold on; plot(ipaqmaxpeakvals, 'g');
axis tight; sp = sp+1;

subplot(nplots,1,sp), plot(mSpread); hold on; plot(ipaqacgmax - ipaqacgmin, 'g');
axis tight; sp = sp+1;

subplot(nplots,1,sp), plot(mPidxs); hold on; plot(ipaqpeakidxs, 'g');
axis tight; sp = sp+1;


