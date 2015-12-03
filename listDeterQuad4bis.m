function myfuncs = listDeterQuad4bis(m,n)
% generate a list of deterministic quadratic functions of length m of the
% form funcs{i} =  (x-bias)^T(x-bias)

if (n ~= 1)
    error('the dimension of the domain has to be 1')
end

for i=1:m
    myfuncs{i} = q4bis(mod(i,3)); 
end
end

function func = q4bis(i)

a=0;
b=0; 
c=0;

myeps = 1e-2; 

if (i == 0)
    % first function
    a = 1/(myeps^2); b = -1.0; c=0.0;
    
end

if (i == 1) 
    % second function
    a = 1/myeps; b = -1.0; c=0.0; 
end

if (i == 2)
    % third function
    a = myeps; b = 2.0; c=0.0;
    
end

func{1} = @(x) (a*x*x + b*x + c);
func{2} = @(x) (2*a*x + b);
func{3} = @(x) (2*a);


end