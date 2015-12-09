clear all

% Add the libraries for the code
addpath('../')

config1.m = 2 %50; %number of functions
config1.n = 1 %20;  %the dimension
config1.nCycles = 1000; %100000; %number of cycles
config1.step0 = 1/ (3* config1.m* config1.n)/20;   %stepsize amplitude parameter
 
config1.x = zeros(config1.n,1); %initial point
config1.stoclevel = 0; % default = 1, stochasticity level 
config1.removebias = 1; 
config1.nbr_paths = 1; %500;
config1.record = 0; 
config1.stepdecay = 0.75; 

sim_bias_removal(1,config1)