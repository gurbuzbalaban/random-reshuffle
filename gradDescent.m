function ynext = gradDescent(gradFnc, y, step)
   % take a step along the gradient with a stepsize at point y
   % grad(x): assumed to give the gradient of the function at the point x. 
   
   gradient = gradFnc(y);
   ynext = y - step * gradient; 
end