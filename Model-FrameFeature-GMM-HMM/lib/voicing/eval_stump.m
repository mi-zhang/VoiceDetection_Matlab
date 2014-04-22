function [y] = eval_stump(X,param)

y = sign(param.s*(X(:,param.comp)-param.x));

