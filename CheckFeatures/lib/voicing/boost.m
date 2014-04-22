
function [param] = boost(x,y,niter)
n = size(x,1);
p = ones(n,1)/n;
param = [];
for i=1:niter,
    stump = find_stump(x,y,p);
    h = eval_stump(x,stump);
    epsilon = sum(p .* (y ~= h)) ;
    alpha = 0.5*log((1-epsilon)/epsilon) ;
    p = p .* exp(-alpha * y .* h) ;
    p = p / sum(p) ; % normalize 
    param = [param,struct('stump',stump,'alpha',alpha,'eps',epsilon)];
end;