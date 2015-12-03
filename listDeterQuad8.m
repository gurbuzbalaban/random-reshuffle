function myfuncs = listDeterQuad8(m,n,order)
% generate a list of deterministic quadratic functions of length m of the
% form funcs{i} =  (x-bias)^T(x-bias)
% order has to be a permutation of {1,2,..,m}

if (n ~= 1)
    error('the dimension of the domain has to be 1')
end

for i=1:m
    myfuncs{i} = q8bis(order(i)); 
end
end

function func = q8(j)

%implements the function fj = j(x-j)^2 = j x^2 - 2j^2 x + j^3 
a = 1.0  *     j;
b = -2.0 *   j*j;
c = 1.0  * j*j*j;

func{1} = @(x) (a*x*x + b*x + c);
func{2} = @(x) (2*a*x + b);
func{3} = @(x) (2*a);


end


function func = q8(j)

%implements the function fj = j(x-j)^2 = j x^2 - 2j^2 x + j^3 
a = 1.0  *     j;
b = -2.0 *   j*j;
c = 1.0  * j*j*j;

func{1} = @(x) (a*x*x + b*x + c);
func{2} = @(x) (2*a*x + b);
func{3} = @(x) (2*a);


end


function func = q8bis(j)

%implements the function fj = sqrt{j}(x-j)^2 = j x^2 - 2j^2 x + j^3 
a = 1.0  *      sqrt(j);
b = -2.0 *    j*sqrt(j);
c = 1.0  *  j*j*sqrt(j);

func{1} = @(x) (a*x*x + b*x + c);
func{2} = @(x) (2*a*x + b);
func{3} = @(x) (2*a);


end