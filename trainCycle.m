function [x, step, bias_coef] = trainCycle(fncList, procOrder, x, step0, cycleNbr,get_bias_coef,decayrate)
   m = length(fncList);
   if (m ~= length(procOrder))
       error('procOrder does not have the right size');
   end
   % determine stepsize
   step = determineStep(step0,cycleNbr,decayrate); 
   
   n = length(x);
   ctr_vec = zeros(n,1);
   ctr_hess = zeros(n,n);
   bias_coef = 0; 
   
   for i=1:m
       gradFnc = fncList{procOrder(i)}{2};  
       x = gradDescent(gradFnc, x, step);
       
       if(get_bias_coef)
         % compute bias term  
         hessFnc = fncList{procOrder(i)}{3};
         hess_crnt = hessFnc(x); 
         ctr_vec = ctr_vec + hess_crnt * gradFnc(x);
         ctr_hess = ctr_hess + hess_crnt;
       end
   end
   bias_coef = ctr_hess \ (-ctr_vec/2);
end

 
function step = determineStep(step0, cycleNbr,stepDecayRate)
   
   step = step0 * power(cycleNbr+1, -stepDecayRate); 
end