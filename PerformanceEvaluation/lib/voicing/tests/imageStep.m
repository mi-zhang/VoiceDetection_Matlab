function [] = imageStep(a, b, start, stop, boff)


a = a(start:stop,:);
b = b(start:stop,:);

aYmax = max(max(a));
aYmin = min(min(a));

bYmax = max(max(b));
bYmin = min(min(b));



for i=1:size(a,1)
    subplot(221), imagesc(flipud(a'));
    subplot(222),
    plot(a(i,:)); 
    axis([0 size(a,2) aYmin aYmax]);
    grid on;

    [pa,va] = find_acorr_peaks(a(i,:));
    ma = max(va);
    na = length(pa);
    title(sprintf('frame %d - num peaks: %d, max peak: %d', i, na, ma))
    
    subplot(223), imagesc(flipud(b'));
    subplot(224), plot(b(i,:)); axis([0 size(b,2) bYmin bYmax]);
    grid on;
    
    
    [pb,vb] = find_acorr_peaks(b(i,:));
    mb = max(vb);
    nb = length(pb);
    title(sprintf('frame %d - num peaks: %d, max peak: %d', i, nb, mb))
    
    
    pause
end