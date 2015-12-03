function order = sampleOrder(stoclevel,m)

if (stoclevel == 1)
    % random perm of {1,2,..,m}
    order = randperm(m);
end

if (stoclevel == 2)
        % sample m indices i.i.d. and uniformly over {1,2,\dots,m} 
     order = randi(m,1,m);    
end

end