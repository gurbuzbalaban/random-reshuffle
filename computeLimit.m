function limit = computeLimit(funcs, xstar,n)

hess_sum = zeros(n,n); 
vec_sum = zeros(n,1);

for i=1:length(funcs)
    f_crnt = funcs{i};
    grad_crnt = f_crnt{2}; 
    hess_crnt = f_crnt{3};
    
    vec_sum = vec_sum + hess_crnt(xstar)* grad_crnt(xstar); 
    hess_sum = hess_sum + hess_crnt(xstar);  
end

limit = - hess_sum \ (vec_sum/2); 

end
