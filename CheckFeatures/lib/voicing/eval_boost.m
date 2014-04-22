
function [H] = eval_boost(X,param);
[n,m] = size(X);
H = zeros(n,1); % combined predictions
totalalpha = 0; % Total weight of all votes
for i = 1:length(param),
    H = H + param(i).alpha*eval_stump(X,param(i).stump);
    totalalpha = totalalpha + param(i).alpha ;
end;
H = H/totalalpha ; % Normalize by the total vote weight