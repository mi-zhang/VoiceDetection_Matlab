function [singledArray] = truncateStructArrayToSingles(s)

singledArray = [];
for i=1:length(s)

    names = fieldnames(s(i));

    for j=1:length(names)
        name = names{j};
        val = s(i).(name);
        
        if(isnumeric(val))
            sval = single(val);
        elseif(isstruct(val))
            sval = truncateStructToSingle(val);
        else
            sval = val;
        end
        
        singledArray(i).(name) = sval;
        
    end
end