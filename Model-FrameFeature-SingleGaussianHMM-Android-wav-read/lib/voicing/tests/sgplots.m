function [ ] = sgplots(matlabPowSG, matlabAcorr, matlabEnergies, matlabSE, matlabRSE, ipaqsgp, ipaqacorr, ipaqse, ipaqrse, ipaqenergies, ipaqnumpeaks, ipaqmaxpeakvals, ipaqacgmax, ipaqacgmin, ipaqpeakidxs, ipaqgmaxidxs )

framesize = 512;
framestep = 256;

% power sg's
%ipaqPowSG = abs(ipaqsg);
%matlabPowSG = abs(compute_specgram_whole(sig, framesize, framestep));

% raw specents
%ipaqSEm = specentropy(ipaqPowSG);

%ipaqpSE = specentropy(ipaqsgp);

%for i=1:size(matlabPowSG,1)
%    matlabEnergies(i) = (matlabPowSG(i,:)*matlabPowSG(i,:)') / size(matlabPowSG,2);
%end

%for i=1:size(ipaqsgp,1)
%    ipaqSGEnergies(i) = (ipaqsgp(i,:)*ipaqsgp(i,:)')*2 / 512;
%end

% relative specents

%meansg = compute_meanspecgram(ipaqPowSG, 500);
%for i=1:size(ipaqPowSG,1)
%    ipaqRSEm(i) = relspecent2(ipaqPowSG,meansg,i);
%end

%meansg = compute_meanspecgram(ipaqsgp, 500);
%for i=1:size(ipaqsgp,1)
%    ipaqpRSE(i) = relspecent2(ipaqsgp,meansg,i);
%end

% plots

%minlen = min(size(ipaqsg,1), size(matlabsg,1));

comp = [1:framesize framesize-1:-1:1] / framesize;
comp = 1./comp;
tc = comp(framesize:framesize+255);


%for i=1:size(ipaqacorr,1)
%    ipaqacorr(i,:) = ipaqacorr(i,:) .* tc;
%end

%matlabAcorr = acorrgram(sig, framesize, framestep);

[mP, mV, mVar, mHi, mLo, mSpread, mPidxs, mHiIdxs] = acorrStats(matlabAcorr);

%[iP, iV, iVar, iHi, iLo, iSpread, iPidxs, iHiIdixs] = acorrStats(ipaqacorr);

%ipaqacgmin(find(ipaqacgmin == 100)) = 1; 



nplots = 9;

sp=1;
subplot(nplots,1,sp), imagesc(flipud(log(matlabPowSG)'));
axis tight;sp = sp+1;

%subplot(nplots,1,2), imagesc(flipud(log(ipaqPowSG)'));  
%axis tight;sp = sp+1;

if(size(ipaqsgp,1) ~= 0 && size(ipaqsgp,2) ~= 0)
    subplot(nplots,1,sp), imagesc(flipud(log(ipaqsgp)'));
    axis tight;sp = sp+1;
end

subplot(nplots,1,sp), plot(matlabSE); hold on; plot(ipaqse, 'g')
axis tight;sp = sp+1;

subplot(nplots,1,sp), plot(matlabRSE); hold on; plot(ipaqrse, 'g')
axis([0 max(length(matlabRSE), length(ipaqrse)) 0 1]);
sp = sp+1;

subplot(nplots,1,sp), plot(matlabEnergies); hold on; plot(ipaqenergies, 'g');
axis tight;
sp = sp+1;


subplot(nplots,1,sp), imagesc(flipud(matlabAcorr'));
axis tight; sp = sp+1;

if(size(ipaqacorr,1) ~= 0 && size(ipaqacorr,2) ~= 0)
    subplot(nplots,1,sp), imagesc(flipud(ipaqacorr'));
    axis tight; sp = sp+1;
end

subplot(nplots,1,sp), plot(mV); hold on; plot(ipaqmaxpeakvals, 'g');
axis tight; sp = sp+1;

subplot(nplots,1,sp), plot(mP); hold on; plot(ipaqnumpeaks, 'g');
axis tight; sp = sp+1;

%subplot(nplots,1,sp), plot(mHi); hold on; plot(ipaqacgmax, 'g');
%axis tight; sp = sp+1;

%subplot(nplots,1,sp), plot(mLo); hold on; plot(ipaqacgmin, 'g');
%axis tight; sp = sp+1;

subplot(nplots,1,sp), plot(mSpread); hold on; plot(ipaqacgmax - ipaqacgmin, 'g');
axis tight; sp = sp+1;

subplot(nplots,1,sp), plot(mPidxs); hold on; plot(ipaqpeakidxs, 'g');
axis tight; sp = sp+1;

%subplot(nplots,1,sp), plot(mHiIdxs); hold on; plot(ipaqgmaxidxs, 'g');
%axis tight; sp = sp+1;


