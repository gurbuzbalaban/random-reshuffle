function myfunc = genDeterQuad(n,scalefac,bias)
% generate deterministic quadratic function in dimension n. myfunc is a list of
% function handles of length 3.  
% myfunc{1} = quad. function, myfunc{2} = the derivative, myfunc{3} = Hessian. 

strCnvxity = 3;

R = rand(n,n); 
A = R + R' + 3 * eye(n); 

myfunc{1} = @(y) (scalefac * (y-bias)' * A * (y-bias)); %function value
myfunc{2} = @(y) (scalefac * 2*A*(y-bias)) ; %derivative
myfunc{3} = @(y) (scalefac * 2*A);       % Hessian

end