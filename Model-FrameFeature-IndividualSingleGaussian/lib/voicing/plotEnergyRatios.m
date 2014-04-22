function [] = plotEnergyRatios(enA, enB)

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




enDiff = log(enA) - log(enB);
nframes = length(enDiff);

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
    rectangle('Position', [s m e-s t-m],...
              'Curvature',0.0,...
              'Clipping','on',...
              'FaceColor','r');
end

for i=1:size(benson,1)
    s = benson(i,1);
    e = benson(i,2);
    rectangle('Position', [s b e-s m-b],...
              'Curvature',0.0,...
              'Clipping','on',...
              'FaceColor','b');
end


plot(enDiff, 'k');
