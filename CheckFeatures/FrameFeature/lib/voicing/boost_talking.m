
load digit_x.dat;
load digit_y.dat; 
digit_y = 2*digit_y-1;

load digit_x_test.dat;
load digit_y_test.dat; 
digit_y_test = 2*digit_y_test-1;

E=[];
M=[]; 
for i=1:16, 

  param = boost(digit_x,digit_y,i);
  yb = eval_boost(digit_x,param);
  trainerr= mean(yb.*digit_y<=0);

  % classification margins on the training set
  % mar = a column vector of length length(digit_y), where
  %       mar(i) is the classification margin of the ith training point
  mar = yb .* digit_y ;
  M = [M,mar];

  yb = eval_boost(digit_x_test,param);
  testerr = mean(yb.*digit_y_test<=0);
  E=[E;trainerr,testerr,param(i).stump.err];
%   mar = yb .* digit_y_test ;
%   M = [M,mar]; 

end;

figure(1); plot(E); 

figure(2); 
n = length(digit_y);
plot(sort(M(:,4)),(1:n)'/n,':g',sort(M(:,16)),(1:n)'/n,'-r');



for i=1:16
tmpA(i)=param(i).alpha;
tmpE(i)=param(i).eps;
end