clear all
m = 3; 
config1.m = m %50; %number of functions
config1.n = 1 %20;  %the dimension
config1.nCycles = 15000;  %100000; %number of cycles
config1.step0 = 1 / (3 * config1.m* config1.n);   %stepsize amplitude parameter
 %(2*config1.m +1)/3 *
config1.x = (2*m + 1)/3.0*ones(config1.n,1); %initial point
config1.stoclevel = 0; % default = 1, stochasticity level 
config1.removebias = 0; 
config1.nbr_paths = 1; %500;

P = perms(1:config1.m); % list of permutations to test

[numorder,~] = size(P);
rate = zeros(numorder,1);
rate_const_emp = zeros(numorder,1);
rate_const_est = zeros(numorder,1);

for nord = 1:numorder
% for each order, estimate the empirical rate constant and calculate the predicted 
% rate constant.

order = P(nord,:)
config1.funorder =  order; %first order 
test_case2(6,config1);
close all
%iterates are saved into all_iters.mat file

load('all_iters.mat')
q = 0.2; %for the decay of iterates, ignore initial iterates 
% by considering last q percent of data 
xstar = (2*m + 1)/3.0; 

error = all_iters - xstar;  %fails if the dimension n is not 1
len = length(error);
logerror = log( abs(error( (q*len) : len )));

L = polyfit( log(q*len:len), logerror,1); %linear fit to log error
rate(nord) = L(1)   % L is a line of the form L = L(1) x + L(2)
rate_const_emp(nord) = exp(L(2)) % error ~ rate_const * k^rate


%%% ESTIMATE RATE CONSTANT FOR A GIVEN ORDER order and NUM FUNCS m
Lips = 2 * (1:m); %Lipschitz constants for functions f_j = j(x-j)^2 in index j
xstar = (2*m + 1)/3.0; 
Grads = 2* (1:m) .* (xstar - (1:m));

ctr = 0; 
for i=1:m
    for j=1:(i-1)
        %display('i,j,')
        %order(i),order(j)
        Lips(order(i)) * Grads(order(j))
       ctr = ctr + Lips(order(i)) * Grads(order(j));
    end
end
str_cvx_const = sum(Lips); %strong convex constant of f = sum_j f_j
rate_const_est(nord) = config1.step0 * abs(ctr) / str_cvx_const;

end









