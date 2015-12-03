function funcs = listRandQuad(m,n)
% generate a list of random quadratic functions of length m
for i=1:m
    funcs{i} = genRandQuad(n,m); 
end
end