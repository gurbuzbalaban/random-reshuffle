function order = initializeOrder(stoclevel,m) 


    if (stoclevel == 1 || stoclevel == 2)
        order = sampleOrder(stoclevel,m);
    else   
            order = 1:m; 
    end

end