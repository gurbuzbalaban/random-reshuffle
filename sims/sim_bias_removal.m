function sim_bias_removal(test_nbr,config)

close all

relative_save_dir = strcat('sim_output_',int2str(test_nbr));
 
save_dir = strcat(pwd,'/',relative_save_dir);
%UNCOMMENT THE SECTION BELOW LATER.
% if isequal(exist(save_dir, 'dir'),7) % 7 = directory.
%     Return, there is already a folder!
%     display('Sim folder exists. Error. Terminating.');
%     return 
% else
%     generate folder to save sim results
%     mkdir(pwd,relative_save_dir);
% end
%%% set parameters of the program
m = config.m; %number of functions
n = config.n;  %the dimension
nCycles = config.nCycles; %100000; %number of cycles
step0 = config.step0  %stepsize amplitude parameter
x = config.x; %initial point
stoclevel = config.stoclevel; %stochasticity level 
removebias = config.removebias; 
nbr_paths = config.nbr_paths;
record = config.record;
decayrate = config.stepdecay; 
%%% preprocessing
global funcs;

%load('s.mat') % seed of the random number is from file.
s = rng();
save( strcat(save_dir,'/s.mat'),'s') %save the seed for random numbers
rng(s);
%bias = randn(n,1);
funcs = listRandQuad(m,n); 
save( strcat(save_dir,'/funcs.mat'),'funcs');
order = initializeOrder(stoclevel,m);


% initialize loop variables
ave_iter = zeros(n,nbr_paths); 
ave_step = 0; 
bias = zeros(n, nbr_paths); 

for j=1:nbr_paths
    tic
    if(j == 1) 
        [ave_iter(:,j), ave_step, bias(:,j), step,all_iters,~] = incr_grad(funcs,order,m,n,nCycles,step0,x,stoclevel,removebias,record,decayrate);
    else 
        %%% the second parameter (average step) is the same, no need to save it again
        [ave_iter(:,j), ~, bias(:,j), step, all_iters,~] = incr_grad(funcs,order,m,n,nCycles,step0,x,stoclevel,removebias,record,decayrate); 
    end
    display(sprintf('Sim number %d', j))  
    toc
    
    if (mod(j,100) == 0) 
        save(strcat(save_dir,'/workspace.sim',int2str(j),'.mat'));
    end    
end

% get minimizer of the obj with alternative optimization
%u0 = ave_iter(:,nbr_paths)
%options = optimset('TolFun', 1e-50, 'TolX',1e-50)
%[xstar,fstar,exitflag] = fminsearch( @(u) obj_func(u), u0, options );


% compute limit 
display('xstar')
xstar = obj_minimizer(n)  %minimizer of the objective

limit = computeLimit(funcs, xstar,n);


% exp_error = norm(mean(ave_iter,2) - xstar);
% exp_error_unbiased = norm(mean(ave_iter,2) - xstar - mean(bias,2));
% 
% mymean = mean(ave_iter,2);
% var = 0; 
% for i=1:nbr_paths
%     w = ave_iter(:,i)-mymean;
%     var = var + w'* w;
% end
% var = var/(nbr_paths-1);
% 
% ave_iter_unbiased = ave_iter - bias;
% mymean_unbiased = mean(ave_iter_unbiased,2);
% var_unbiased = 0; 
% for i=1:nbr_paths
%     w = ave_iter_unbiased(:,i)-mymean_unbiased;
%     var_unbiased = var_unbiased + w'* w;
% end
% var_unbiased = var_unbiased/(nbr_paths-1);
% 
% 
 error_vec = ave_iter - repmat(xstar,[1 nbr_paths]);
 norm_error_vec = zeros(1,nbr_paths);
 obj_subopt_vec = zeros(1,nbr_paths);
 norm_error_vec_unbiased = zeros(1,nbr_paths);
 obj_subopt_vec_unbiased = zeros(1,nbr_paths);
 fstar = obj_func(xstar);
 
% compute hist of errors: iterate - optimizer (before and after bias
% removal)
for l=1:nbr_paths
    norm_error_vec(l) = norm(error_vec(:,l));
    norm_error_vec_unbiased(l) = norm(error_vec(:,l)-bias(:,l));
    obj_subopt_vec(l) = obj_func(ave_iter(:,l))-fstar;
    obj_subopt_vec_unbiased(l) = obj_func(ave_iter(:,l)-bias(:,l))-fstar;
end

subplot(2,1,1)
h1 = histogram(norm_error_vec) %histogram before bias removal.
disp('norm error vec')
norm_error_vec 

hold on
h2 = histogram (norm_error_vec_unbiased);
norm_error_vec_unbiased

mycenter = mean(norm_error_vec);
myline = line([mycenter mycenter], get(gca, 'ylim'));
myline.Color = 'blue';
myline.LineWidth = 1;

% add vertical line for means of both histograms to the plot
hold on
mycenter_unbiased = mean(norm_error_vec_unbiased);
myline = line([mycenter_unbiased mycenter_unbiased], get(gca, 'ylim'));
myline.Color = 'red';
myline.LineWidth = 1;
title('Histograms of the norm of distance to minimizer before (in blue) and after noise removal (in orange)')

% plot suboptimality of the objective function
subplot(2,1,2)

h3 = histogram(obj_subopt_vec);
hold on
h4 = histogram(obj_subopt_vec_unbiased);

myfcenter = mean(obj_subopt_vec);
myline = line([myfcenter myfcenter], get(gca, 'ylim'));
myline.Color = 'blue';
myline.LineWidth = 1;

hold on 
myfcenter_unbiased = mean(obj_subopt_vec_unbiased);
myline = line([myfcenter_unbiased myfcenter_unbiased], get(gca, 'ylim'));
myline.Color = 'red';
myline.LineWidth = 1;
title('Histograms of the suboptimality in cost before (in blue) and after noise removal (in orange)')
obj_subopt_vec_unbiased
obj_subopt_vec
%Bottom: Histograms of the suboptimality in cost.')

%save results
save(strcat(save_dir,'/workspace.mat'));  

end
