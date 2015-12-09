function [ave_iter, ave_step, bias, step,all_iters,last_iter] = incr_grad(funcs,order,m,n,nCycles,step0,x,stoclevel, removebias, record,decayrate)
%%% save outer iterates and their averages for analysis 
%iters = zeros(n,nCycles);
%run_ave = zeros(n,nCycles); %i-th column is the averaged iterates in cycles 0 to i-1.
%run_ave(:,1) = x; 
%step_ave = zeros(1,nCycles); % i-th column is the aver stepsize cycles 0 to i-1.
%step_ave(1,1) = 0; 
%stephist = zeros(1,nCycles);

all_iters = -1; 
if (record == 1) 
    all_iters = zeros(n,nCycles); 
end

ave_iter = 0; 
ave_step = 0; 
bias = 0;
last_iter = 0; 

%%% for each cycle k
for k=0:(nCycles-1)
  
    %%% if random flag is on, resample the order at each cycle
    if (stoclevel == 1 || stoclevel == 2)
        order = sampleOrder(stoclevel,m);
    end
    % display(k), display(order)
    
    %%% Perform a cycle of the alg.
      
     [x,step,bias_coef] = trainCycle(funcs, order, x, step0, k,removebias,decayrate);
     if(record == 1) 
        all_iters(:,k+1) = x; 
     end
     %stephist(1,k+1) = step; 
     % TO DO: WHAT TO DO WITH BIAS COEF.
    if (k==0)
        ave_iter = x;
        ave_step = step; 
    else
        ave_iter = moving_average(ave_iter,k,x);
        ave_step = moving_average(ave_step,k,step);
    end
    
     if ( k == nCycles - 1 && removebias == 1)
         bias = bias_coef * ave_step;
         %display(sprintf('estimated bias of %15.15f', bias)) 
         %x = x - bias; 
     end
     
     last_iter = x; 
%     if ( k == 0 )
%         run_ave(:,1)  = x; 
%         step_ave(1,1) = step;
%        
%     else    
%        [run_ave(:,k+1),  ~] = moving_average(run_ave(:,k), k, x);
%        [step_ave(1,k+1), ~] = moving_average(step_ave(1,k),k,step);
%        
%     end

   %save('all_iters.mat','all_iters');
end
