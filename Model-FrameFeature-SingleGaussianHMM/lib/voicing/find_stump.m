function [param] = find_stump(x,y,p)

[n,m] = size(x);

Err = [];
param=[]; 
for i=1:m,
  param = [param,find_single_stump(x(:,i),y,p)];
  param(i).comp = i;
  Err = [Err;param(i).err];
end;

[et,I] = sort(Err);
param = param(I(1));


