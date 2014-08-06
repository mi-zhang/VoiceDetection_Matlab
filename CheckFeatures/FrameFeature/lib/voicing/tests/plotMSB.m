function [] = plotMSB(msbd)


minTime = 2^64;
maxTime = 0;
for i=1:length(msbd)
    minTime = min(minTime, min(msbd(i).data{1}));
    maxTime = max(maxTime, max(msbd(i).data{1}));    
end

minTime
maxTime

accel = msbd(1);
hfvis= msbd(2);
vis= msbd(3);
ir= msbd(4);
energies= msbd(5);
acMax= msbd(6);
acMin= msbd(7);
relSpecEnts= msbd(8);
peakVals= msbd(9);
peakValIdxs= msbd(10);

nplots = 8;
cp = 1;

subplot(nplots,1,cp), plot(accel.data{1}, accel.data{2}, 'r'), title('accel');
axis([minTime maxTime min([accel.data{2};accel.data{3};accel.data{4}]) max([accel.data{2};accel.data{3};accel.data{4}])]);
hold on;
plot(accel.data{1}, accel.data{3}, 'g')
plot(accel.data{1}, accel.data{4}, 'b')
cp = cp + 1;


subplot(nplots,1,cp), plot(hfvis.data{1}, hfvis.data{2}), title('hf vis');
axis([minTime maxTime min(hfvis.data{2}) max(hfvis.data{2})]);
cp = cp + 1;

subplot(nplots,1,cp), plot(ir.data{1}, ir.data{2}), title('ir');
axis([minTime maxTime min(ir.data{2}) max(ir.data{2})]);
cp = cp + 1;

subplot(nplots,1,cp), plot(energies.data{1}, energies.data{2}), title('audio energy');
axis([minTime maxTime min(energies.data{2}) max(energies.data{2})]);
cp = cp + 1;

spread = acMax.data{2} - acMin.data{2};
subplot(nplots,1,cp), plot(acMax.data{1}, spread); axis tight; title('audio spread');
axis([minTime maxTime min(spread) max(spread)]);
cp = cp + 1;

subplot(nplots,1,cp), plot(relSpecEnts.data{1}, relSpecEnts.data{2}); axis tight; title('rse');
axis([minTime maxTime min(relSpecEnts.data{2}) max(relSpecEnts.data{2})]);
cp = cp + 1;

subplot(nplots,1,cp), plot(peakVals.data{1}, peakVals.data{2}); axis tight; title('max acorr peak');
axis([minTime maxTime min(peakVals.data{2}) max(peakVals.data{2})]);
cp = cp + 1;

subplot(nplots,1,cp), plot(peakValIdxs.data{1}, peakValIdxs.data{2}); axis tight; title('approx f0');
axis([minTime maxTime min(peakValIdxs.data{2}) max(peakValIdxs.data{2})]);
cp = cp + 1;


