function [mv] = mvse(spec)

for i=1:size(spec,1)
    
    row = spec(i,:);
    
    dist = spec .* spec;
    dist = 1 + dist;
    
    dist = log(dist);
    
    total = sum(dist);
    
    dist = dist ./ total;
    
    
end