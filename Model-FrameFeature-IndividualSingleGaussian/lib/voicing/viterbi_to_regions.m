function [regions, out_ind1, out_ind2]= viterbi_to_regions(path)
% This is a very specific function for taking path with two states
% State = 2 is the voiced state
% It extracts voiced regions from the path trajectory
%
% PATH_TO_REGIONS SHOULD REPLACE THIS FUNCTION
ind1 = find(path==1);
l1 = length(ind1);
changes1 = ind1(2:l1) - ind1(1:(l1-1));
ptr_ind1 = find(changes1>1);
out_ind1 = ind1(ptr_ind1);


ind2 = find(path==2);
l2 = length(ind2);
changes2 = ind2(2:l2) - ind2(1:(l2-1));
ptr_ind2 = find(changes2>1);
out_ind2 = ind2(ptr_ind2);

% disp(size(out_ind1))
% disp(size(out_ind2))

if(out_ind2(1)<out_ind1(1))
    start_ind = [1 out_ind1+1];
    end_ind = [out_ind2];
else
    start_ind = [out_ind1+1];
    end_ind = [out_ind2 length(path)];
end

%end_ind = [out_ind2];
regions=[start_ind' end_ind'];





% end_ind = ind(ptr_ind);
% start_ind = [ 1 end_ind(1:end-1)+1];
% regions=[start_ind' end_ind'];

% l = length(path);
% changes = path(2:l) - path(1:(l-1));
% start_ind = find(changes>1); start_in = start_ind+1;
% end_ind = find(changes<1); end_ind = end_ind+1;
% 
% if(start_ind(1)>end_ind(1))
%     