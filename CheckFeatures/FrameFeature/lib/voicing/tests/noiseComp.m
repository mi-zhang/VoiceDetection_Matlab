function [] = noiseComp(acorr, nacorr, nsgacorr)

framesize = 512;
framestep = 256;
scale = 32768;

nlags = 256;


%noise = randn(size(sig))*level;
%nsig = sig + noise;
%nacorr = acorrgram(nsig, framesize, framestep);
%sg = compute_specgram_raw(sig, framesize, framestep, false);
%sgp = (abs(sg).^2) / size(sg,2);

%nvar = level^2 * scale^2;

%nsgp = sgp + nvar;

%comp = [1:framesize framesize-1:-1:1] / framesize;
%comp = 1./comp;

%for i=1:size(nsgp,1)
%    xc = ifft( nsgp(i,:) );
%    normXC = xc / xc(1);
%    nsgacorr(i,:) = normXC(1:nlags).* comp(framesize:framesize+nlags-1);  
%end

[nP, nV, nE, nHI, nLO, nS] = acorrStats(nacorr);

[nsgP, nsgV, nsgE, nsgHI, nsgLO, nsgS] = acorrStats(nsgacorr);


nplots = 9;
np = 1;

subplot(nplots,1,np), imagesc(flipud(acorr'));
axis tight;
np = np+1;

subplot(nplots,1,np), imagesc(flipud(nacorr'));
axis tight;
np = np+1;

subplot(nplots,1,np), imagesc(flipud(nsgacorr'));
axis tight;
np = np+1;

subplot(nplots,1,np), plot(nP), hold on, plot(nsgP, 'g');
axis tight;
np = np+1;

subplot(nplots,1,np), plot(nV), hold on, plot(nsgV, 'g');% axis([0 max(length(nV), length(nsgV)) -1 1]);
axis tight;
np = np+1;

subplot(nplots,1,np), plot(nE), hold on, plot(nsgE, 'g');% axis([0 max(length(nV), length(nsgV)) -1 1]);
axis tight;
np = np+1;

subplot(nplots,1,np), plot(nHI), hold on, plot(nsgHI, 'g');% axis([0 max(length(nV), length(nsgV)) -1 1]);
axis tight;
np = np+1;

subplot(nplots,1,np), plot(nLO), hold on, plot(nsgLO, 'g');% axis([0 max(length(nV), length(nsgV)) -1 1]);
axis tight;
np = np+1;

subplot(nplots,1,np), plot(nS), hold on, plot(nsgS, 'g');% axis([0 max(length(nV), length(nsgV)) -1 1]);
axis tight;
np = np+1;
