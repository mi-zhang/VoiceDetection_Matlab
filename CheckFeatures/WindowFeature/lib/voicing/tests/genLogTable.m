function [] = genLogTable()


file = 'logtableFloat.h';

fid = fopen(file, 'w');

fprintf(fid, '#ifndef __LOGTABLE_ZERO_TO_ONE_FLOAT_');
fprintf(fid, '\n');
fprintf(fid, '#define __LOGTABLE_ZERO_TO_ONE_FLOAT_');
fprintf(fid, '\n');

fprintf(fid, 'float logsZeroToOne_float[] = {0.0F,');
fprintf(fid, '\n');
for i=int32(1:2^16)
    
    oval = toFloatPoint(i);
    %nval = i;
    
    %disp(sprintf('oval: %g, nval: %d', oval, nval));
    
    olog = log(oval);
    
    fprintf(fid, '%7fF, ', olog);
    if(mod(i,24) == 0)
        fprintf(fid, '\n');
    end
        
end

fprintf(fid, '};');
fprintf(fid, '\n\n');
fprintf(fid, '#endif');
fprintf(fid, '\n');

fclose(fid);


file = 'logtableFixed.h';

fid = fopen(file, 'w');

fprintf(fid, '#ifndef __LOGTABLE_ZERO_TO_ONE_FIXED_');
fprintf(fid, '\n');
fprintf(fid, '#define __LOGTABLE_ZERO_TO_ONE_FIXED_');
fprintf(fid, '\n');

fprintf(fid, 'float logsZeroToOne_fixed[] = {0,');
fprintf(fid, '\n');

for i=int32(1:2^16)
    
    oval = toFloatPoint(i);
    %nval = i;
    
    %disp(sprintf('oval: %g, nval: %d', oval, nval));
    
    olog = log(oval);
    
    fprintf(fid, '%10d, ', toFixedPoint(olog));
    if(mod(i,24) == 0)
        fprintf(fid, '\n');
    end
        
end

fprintf(fid, '}');
fprintf(fid, '\n\n');
fprintf(fid, '#endif');
fprintf(fid, '\n');

fclose(fid);




end

function [n] = toFixedPoint(x)
n = int32(x * (2^16));
end

function [n] = toFloatPoint(x)
n = double(x) / 2^16;
end
    


