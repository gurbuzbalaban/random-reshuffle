% find min of the sum of functions with an alternative method
function val = obj_func(x)
   global funcs
   m = length(funcs);
   val = 0;
   for i=1:m 
     val  = val + funcs{i}{1}(x);
   end
end
