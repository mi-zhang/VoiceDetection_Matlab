function [nt] = convert_gt(gt)

nt = gt;
nt(find(nt==1)) = 2;
nt(find(nt==-1)) = 1;