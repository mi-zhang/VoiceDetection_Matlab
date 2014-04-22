function [region] = path_to_region(path)
% This is a very specific function for taking path with two states
% State = 2 is the voiced state
% It extracts voiced regions from the path trajectory

tmp = path(1:end-1)-path(2:end);
t1=find(tmp==1);  % transitions to unvoiced
t2=find(tmp==-1); % transitions to voiced

len1=length(t1); % num transitions to unvoiced
len2=length(t2); % num transitions to voiced

if(len1>0 & len2>0)
    if(t2(1)>t1(1)) % first transition is to unvoiced, so first region is voiced
        if(len1==len2)
            %disp('2 first length equal');
            t2=[1 t2+1];
            t1=[t1 length(path)];
            region=[t2' t1'];
        else
            %disp('2 first length unequal');
            t2=[1 t2+1];
            region=[t2' t1'];
        end
    else
        if(len1==len2)
            %disp('1 first length equal');
            region=[t2'+1 t1'];
        else
            %disp('1 first length unequal');
            t1 = [t1 length(path)];
            region=[t2'+1 t1'];
        end
    end
else
    region=[];
end