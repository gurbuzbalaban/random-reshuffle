function myfuncs = listDeterQuad5(m,n)
% generate a list of deterministic quadratic functions of length m of the
% form funcs{i} =  (x-bias)^T(x-bias)

if (n ~= 1)
    error('the dimension of the domain has to be 1')
end

half = floor(m/2); 
for i=1:half 
    myfuncs{i} = q2(1); 
end

for i=(half+1):m
    myfuncs{i} = q2(0); 
end

end

function func = q2(i)

a=0;
b=0; 
c=0;

if (i == 0) 
    % first function
    a = 0.5; b = -1.0; c=0.5; 
end

if (i == 1)
    % second function
    a = 1.0; b = 1.0; c=0.5;
    
end

func{1} = @(x) (a*x*x + b*x + c);
func{2} = @(x) (2*a*x + b);
func{3} = @(x) (2*a);


end