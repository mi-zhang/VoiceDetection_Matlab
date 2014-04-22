function [param] = find_single_stump(x,y,p)

Ipos = find(y>0);
Ineg = find(y<0);

npos = sum(p(Ipos));
nneg = sum(p(Ineg));
xpos = sum( p(Ipos).*x(Ipos) )/npos; 
xneg = sum( p(Ineg).*x(Ineg) )/nneg;

s  = sign(xpos-xneg);
xm = (xpos+xneg)/2;

err = sum( p.*(y.*sign(s*(x-xm)) <= 0) );

param = struct('s',s,'x',xm,'err',err,'comp',0);

