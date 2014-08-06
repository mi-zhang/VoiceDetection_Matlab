function [sig] = deframeSignal(framed, framesize, framestep)

% put in first full frame
sig = framed(1:framesize);
numframes = (length(framed) - framesize) / framesize;

for i=1:numframes
    
    framestart = i * framesize + 1 + framestep;
    frameend = framestart + (framesize - framestep - 1);
    frameend = min(frameend, length(framed));
    
    sig = [sig; framed(framestart:frameend)];

end