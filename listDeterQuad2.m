function funcs = listDeterQuad2(m,n)
% generate a list of deterministic quadratic functions of length m of the
% form funcs{i} =  (x-bias)^T(x-bias)
 
for i=1:m
    bias = (1:n)'*2*(i-(m+1)/2); 
    funcs{i} = genDeterQuad2(n,bias); 
    
end
end