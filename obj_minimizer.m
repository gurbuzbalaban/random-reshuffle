function minimizer = obj_minimizer(n)
   % funcs{i} = f_i = x'Ax + b x + const
   % funcs{i}{2} = grad of f_i = 2Ax + b' 

   global funcs
   m = length(funcs);
   b = zeros(n,1);
   H = zeros(n,n);
   myzeros = zeros(n,1);
   for i=1:m 
     b  = b + funcs{i}{2}(myzeros);
     H = H + funcs{i}{3}(myzeros);
   end
   
   %objective = sum f_i = x_T A x + b^T x + const
   minimizer = H \ (-b);
end