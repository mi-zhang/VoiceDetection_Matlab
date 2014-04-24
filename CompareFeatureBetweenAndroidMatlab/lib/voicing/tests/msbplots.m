
nplots = 12;

cp = 1;

subplot(nplots,1,cp), plot(xaccel), title('x accel');
cp = cp + 1;

subplot(nplots,1,cp), plot(yaccel), title('y accel');
cp = cp + 1;

subplot(nplots,1,cp), plot(zaccel), title('z accel');
cp = cp + 1;

subplot(nplots,1,cp), plot(hfvis), title('hf vis light');
cp = cp + 1;

subplot(nplots,1,cp), plot(vis), title('vis');
cp = cp + 1;

subplot(nplots,1,cp), plot(ir), title('ir');
cp = cp + 1;

subplot(nplots,1,cp), plot(compass), title('compass');
cp = cp + 1;

%subplot(nplots,1,cp), plot(audio), title('audio');
%cp = cp + 1;

subplot(nplots,1,cp), plot(energies), title('audio energies');
cp = cp + 1;


spread = acMax - acMin;
subplot(nplots,1,cp), plot(spread); axis tight; title('audio spread');
cp = cp + 1;

subplot(nplots,1,cp), plot(relSpecEnts), axis tight; title('rel spec ent');
cp = cp + 1;

subplot(nplots,1,cp), plot(peakVals), axis tight; title('max acorr peak');
cp = cp + 1;

subplot(nplots,1,cp), plot(peakValIdxs), axis tight; title('approx f0');
cp = cp + 1;

