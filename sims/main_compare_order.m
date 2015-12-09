function main_compare_order()
% compares two orders
[rate_const_sim, rate_const_theo, rate_pwr, dist, rate_const_sim_bis, mvec, all_error] = compare_order()

[nx, ny] = size(all_error{1});
p = 0.7;
figure
for i=1:length(mvec)
    
    plot((p*ny):ny, log(abs(all_error{i}(1,(p*ny):ny))),'b','LineWidth',3)
    hold on
    plot((p*ny):ny, log(abs(all_error{i}(2,(p*ny):ny))),'r','LineWidth',3)
    xlabel('cycles k', 'FontSize',15)
    ylabel('log(dist_k)','FontSize',15)
    title('In Blue: Order A, In Red: Order B. m=4', 'FontSize',15)
end
end

function [rate_const_sim, rate_const_theo,rate_pwr, dist,rate_const_sim_bis, mvec,all_error] = compare_order()

   mvec = [4] %[4,6,8,10,20,30];
   nvec = length(mvec); 
   rate_const_sim = zeros(2,nvec);
   rate_const_sim_bis = zeros(2,nvec);
   rate_const_theo = zeros(2,nvec);
   rate_pwr = zeros(2,nvec); 
   dist = zeros(2,nvec);
   
   for i=1:nvec
      [rate_const_sim(:,i), rate_const_theo(:,i),rate_pwr(:,i), dist(:,i), rate_const_sim_bis(:,i),all_error{i}] = rateCheck(mvec(i));
   end
   
%    plot(mvec/2, dist,'r','LineWidth',3)
%    xlabel('m')
%    ylabel('distance to optimal solution')
%    title('m vs distance to optimal solution after K=10^5 cycles')
   
end

% set up config for sim

function [rate_const_emp, rate_const_est,rate, dist,rate_const_emp_bis,all_error] = rateCheck(m)
 
config1.m = m %50; %number of functions
config1.n = 1 %20;  %the dimension
config1.nCycles = 10000;  %100000; %number of cycles
config1.step0 = 1 / (3 * 4 * config1.n);   %stepsize amplitude parameter
config1.x = zeros(config1.n,1); %initial point
config1.stoclevel = 0; % default = 1, stochasticity level 
config1.removebias = 0; 
config1.nbr_paths = 1; 
config1.record = 1;
config1.stepdecay = 0.75;
% Form matrix with rows that are orders (permutations of {1,2,..,m}
%P = perms(1:config1.m); % list of permutations to test
P = zeros(2,m);
P(1,:) = m:(-1):1; %P(1,:) %test only the order m, m-1, .., 1
% P = zeros(1,m);
for i=1:(m/2)
   P(2,2*i-1) = i; 
   P(2,2*i)= m+1-i;
end
% P
%% initialization
[numorder,~] = size(P);
rate = zeros(numorder,1);
rate_const_emp_bis = zeros(numorder,1);
rate_const_emp = zeros(numorder,1);
rate_const_est = zeros(numorder,1);

%% Numerical simulation
for nord = 1:numorder
% for each order, estimate the empirical rate constant by simulation

% update input

order = P(nord,:)
config1.funorder =  order;  

% simulate, save output into xstar.mat and all_iters.mat
[xstar, all_iters] = sim_compare_order(6,config1); 
close all
q = 0.02; %for the decay of iterates, ignore initial iterates 
% by considering last q percent of data 
% contains output

error = all_iters - xstar;  %fails if the dimension n is not 1
len = length(error);
logerror = log( abs(error( (q*len) : len )));
all_error(nord,:) = error; 

L = polyfit( log(q*len:len), logerror,1); %linear fit to log error
rate(nord) = L(1);   % L is a line of the form L = L(1) x + L(2)
% error ~ rate_const * k^rate
s = 0.75; 
rate_const_emp_bis(nord) = abs(error(len)) * (len)^s;

rate_const_emp(nord) = exp(L(2)) %empirical rate constant
end

dist = abs(error(len));
%% Get rate constants from theory
Lips = ones(1,m); %Lipschitz constants for functions f_j = j(x-j)^2 in index j
Grads = [ones(1,floor(m/2)), -ones( 1,m - floor(m/2) )];

for nord = 1:numorder

rate_const_est(nord) = getRateConst(Lips,Grads,order, config1.m, config1.step0)

end

end









