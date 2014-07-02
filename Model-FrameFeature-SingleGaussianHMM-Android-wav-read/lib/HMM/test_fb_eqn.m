
B = diag([0.1 0.3]);
A = mk_stochastic(rand(2,2));
b= [0.9;0.1];
for i=1:2
  s = 0;
  for j=1:2 
    s = s + A(i,j)*B(j,j)*b(j);
  end
  b2(i) = s;
end
b3 = B * A * b; % wrong
b4 = A * B * b;


f= [0.9;0.1];
for j=1:2
  s = 0;
  for i=1:2 
    s = s + A(i,j)*b(i)*B(j,j);
  end
  f2(j) = s;
end
f4 = B*A'*f;
