function [] = plotVoicingFeatures(spec, fstructs, rse, otherEn)

danny = [0    .367;
         0.45    1.53;
         4.167   4.517;
         4.867   5.55];
     
danny = danny .* 60;


benson = [0   .15;
          1.771  3.083;
          3.383  4.026;
          4.65   5.167];

benson = benson .* 60;


nplots = 3;

nframes = size(spec,1);

numAcorrPeaks = zeros(1,nframes);
acorrMaxPeakVals = zeros(1,nframes);
for i=1:nframes
    numAcorrPeaks(i) = length(fstructs(i).acorrpeakvals{1});
    acorrMaxPeakVals(i) = max(fstructs(i).acorrpeakvals{1});
end

%numAcorrPeaks = numAcorrPeaks - mean(numAcorrPeaks);
numAcorrPeaks = numAcorrPeaks / std(numAcorrPeaks);


%rseT = [fstructs.relspecent];
%rse = rse - mean(rse);
%rseT = rseT ./ std(rseT);
rse = rse ./ std(rse);

%se = [fstructs.specent];
%se = se ./ std(se);

%acorrMaxPeakVals = acorrMaxPeakVals - mean(acorrMaxPeakVals);
acorrMaxPeakVals = acorrMaxPeakVals / std(acorrMaxPeakVals);


np = 0;

np = np + 1;
subplot(nplots,1,np);
imagesc(log(flipud(spec')));
axis([1 nframes 1 256]);
set(gca, 'XTick', [1 2 3 4].*60);
set(gca, 'XTickLabel', [1 2 3 4]);
%set(gca, 'YTick', 32:32:256);
yl = 256 - str2num(get(gca, 'YTickLabel'));
yl = yl .* 30;
set(gca, 'YTickLabel', yl);


np = np + 1;
subplot(nplots,1,np);
plot(rse, 'g');
hold on,
plot(acorrMaxPeakVals, 'm');
plot(numAcorrPeaks, 'c');
%plot(rseT, 'y');

lh = legend('Rel. Spec. Ent', 'Autocorr. Max Peak', 'Num. Autocorr. Peaks');
set(lh, 'Location', 'NorthWest');
set(lh, 'Orientation', 'horizontal');
set(gca, 'YTickLabel', '');
set(gca, 'XTick', [1 2 3 4].*60);
set(gca, 'XTickLabel', [1 2 3 4]);

%{
np = np + 1;
subplot(nplots,1,np);
en = [fstructs.energy];
en = 10*log10(en);
plot(en);
axis([1 nframes min(en) max(en)]);
set(gca, 'XTick', [1 2 3 4].*60);
set(gca, 'XTickLabel', [1 2 3 4]);

hold on
for i=1:size(danny,1)
    s = danny(i,1);
    e = danny(i,2);
    plot([s s], [min(en) max(en)], 'g');
    plot([e e], [min(en) max(en)], 'g');
end

for i=1:size(benson,1)
    s = benson(i,1);
    e = benson(i,2);
    plot([s s], [min(en) max(en)], 'r');
    plot([e e], [min(en) max(en)], 'r');
end
%}

np = np + 1;
subplot(nplots,1,np);
en = [fstructs.energy];

enDiff = log(en) - log(otherEn);

plot(enDiff, 'k');


t = 1.5;%max(enDiff);
b = -t;
m = 0;

axis([1 nframes b t]);

set(gca, 'XTick', [1 2 3 4].*60);
set(gca, 'XTickLabel', [1 2 3 4]);
hold on
for i=1:size(danny,1)
    s = danny(i,1);
    e = danny(i,2);
    rectangle('Position', [s b e-s m-b],...
              'Curvature',0.0,...
              'Clipping','on',...
              'FaceColor','m');
end

for i=1:size(benson,1)
    s = benson(i,1);
    e = benson(i,2);
    rectangle('Position', [s m e-s t-m],...
              'Curvature',0.0,...
              'Clipping','on',...
              'FaceColor','c');
end


plot(enDiff, 'k');



