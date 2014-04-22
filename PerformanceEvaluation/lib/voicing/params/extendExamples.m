function [nexamples] = extendExamples(examples)


framesize = 256;
framestep = 128;

for i=1:length(examples)

    ex = examples(i);
    
    acorrSGOdd02 = acorrFromSpecgramHalf(ex.signal, framesize, framestep, (0.02^2), 2);
    
    
    for j=1:size(acorrSGOdd02,1)
    
        [peaksSGOdd02, peakvalsSGOdd02] = find_acorr_peaks(acorrSGOdd02(j,:));
        ex.fstructs(j).peaksSGOdd02 = peaksSGOdd02;
        ex.fstructs(j).peakvalsSGOdd02 = peakvalsSGOdd02;
        ex.fstructs(j).maxSGOdd02 = max(acorrSGOdd02(i,1:end));
    end

    nexamples(i) = ex;

end