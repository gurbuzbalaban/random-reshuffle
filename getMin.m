function [ustar,vstar] = getMin(myf, u0)
    u0 = ave_iter(:,nbr_paths)
    options = optimset('TolFun', 1e-50, 'TolX',1e-50)
    [ustar,fstar,exitflag] = fminsearch( @(u) myf(u), u0, options );
end