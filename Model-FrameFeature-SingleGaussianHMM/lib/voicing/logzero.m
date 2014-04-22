function [y] = logzero(x)
%LOGZERO(X) same as log(x), but defines log(0)=0.
% Useful when calculating entropy.

if(find(x==0))
    [i,h,v]=find(x);
    y=zeros(size(x));
    y(sub2ind(size(y),i,h))=log(v);
else
    y = log(x);
end