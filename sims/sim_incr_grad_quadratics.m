function [xstar, fstar,iters, all_iters,ave_iter,ave_step, limit] = sim_incr_grad_quadratics(config,out_folder_suffix)

close all

relative_save_dir = strcat('sim_output_',out_folder_suffix);
 
save_dir = strcat(pwd,'/',relative_save_dir);
if isequal(exist(save_dir, 'dir'),7) % 7 = directory.
    % Return, there is already a folder!
    display('Warning. Sim folder exists. Might overwrite to the existing data');
   
else
    % generate folder to save sim results
    mkdir(pwd,relative_save_dir);
end
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
save( strcat(save_dir,'/seed.mat'),'s') %save the seed for random numbers
rng(s);
%bias = randn(n,1);
funcs = listDeterQuad4(m,n); 
save( strcat(save_dir,'/funcs.mat'),'funcs');
order = initializeOrder(stoclevel,m);

% initialize loop variables
ave_iter = zeros(n,nbr_paths); 
ave_step = 0; 
bias = zeros(n, nbr_paths); 
iters = zeros(n,nbr_paths); %un-averaged iters when the cycles are complete


for j=1:nbr_paths
    tic
    if(j == 1) 
        [ave_iter(:,j), ave_step, bias(:,j), step,all_iters{j},iters(:,j)] = incr_grad(funcs,order,m,n,nCycles,step0,x,stoclevel,removebias,record,decayrate);
    else 
        %%% the second parameter (average step) is the same, no need to save it again
        [ave_iter(:,j), ave_step, bias(:,j), step, all_iters{j}, iters(:,j)] = incr_grad(funcs,order,m,n,nCycles,step0,x,stoclevel,removebias,record,decayrate); 
    end
    display(sprintf('Sim number %d', j))  
    toc
    
    if (mod(j,100) == 0) 
        save(strcat(save_dir,'/workspace.sim',int2str(j),'.mat'));
    end    
end

% compute limit 
display('xstar')
xstar = obj_minimizer(n)  %minimizer of the objective
fstar = obj_func(xstar);

limit = computeLimit(funcs, xstar,n);

end
