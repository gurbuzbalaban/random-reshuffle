function myfuncs = listDeterQuad6(m,n)
% generate a list of deterministic quadratic functions of length m of the
% form funcs{i} =  (x-bias)^T(x-bias)

if (n ~= 1)
    error('the dimension of the domain has to be 1')
end

for i=1:m
    myfuncs{i} = q6(m-i+1); 
end
end

function func = q6(j)

%implements the function fj = j(x-j)^2 = j x^2 - 2j^2 x + j^3 
a = 1.0  *     j;
b = -2.0 *   j*j;
c = 1.0  * j*j*j;

func{1} = @(x) (a*x*x + b*x + c);
func{2} = @(x) (2*a*x + b);
func{3} = @(x) (2*a);


end