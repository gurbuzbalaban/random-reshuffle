function myfuncs = listDeterQuad3()
% generate a list of deterministic quadratic functions of length m of the
% form funcs{i} =  (x-bias)^T(x-bias)
 
for i=1:2
    myfuncs{i} = q(i); 
end
end

function func = q(i)

a=0;
b=0; 
c=0;

if (i == 1) 
    a = 2.0; b = -4.0; c=2.0; 
end

if (i == 2)
    a = 4.0; b = 4.0; c=2.0;
    
end

func{1} = @(x) (a*x*x + b*x + c);
func{2} = @(x) (2*a*x + b);
func{3} = @(x) (2*a);


end