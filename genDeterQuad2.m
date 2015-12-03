function myfunc = genDeterQuad2(n,bias)
% generates deterministic quadratic function in dimension n. myfunc is a list of
% function handles of length 3.  
% myfunc{1} = quad. function, myfunc{2} = the derivative, myfunc{3} = Hessian. 

A = eye(n); 

myfunc{1} = @(y) ((y-bias)' * A * (y-bias)); %function value
myfunc{2} = @(y) (2*A*(y-bias)) ; %derivative
myfunc{3} = @(y) (2*A);       % Hessian

end