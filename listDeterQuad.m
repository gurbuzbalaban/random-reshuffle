function funcs = listDeterQuad(m,n,bias)
% generate a list of deterministic quadratic functions of length m of the
% form funcs{i} = i (x-bias)^T ones(n,n) (x-bias)
for i=1:m
    funcs{i} = genDeterQuad(n,i,bias); 
end
end

