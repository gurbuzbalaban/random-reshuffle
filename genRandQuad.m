function myfunc = genRandQuad(n,m)
% generate random quadratic function in dimension n. myfunc is a list of
% function handles of length 3.  
% myfunc{1} = quad. function, myfunc{2} = the derivative, myfunc{3} = Hessian. 
str_cvxity = 5; 

%R = n^(-1/2) *  randn(n,n);
R = n^(-1/2) *  randi([-m m],n,n);
A = R * R' + str_cvxity * eye(n) ; 

%b = randn(1,n); 
b = randi([-m m],n,1)';

c = randi([-1 1], 1,1);

myfunc{1} = @(y) ( y' * A *y + b*y + c ); %function value
myfunc{2} = @(y) ( 2*A*y + b' ); %derivative
myfunc{3} = @(y) ( 2 * A );       % Hessian

end
