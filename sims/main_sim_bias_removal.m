clear all

rng('default');
rng(1);

profile on 

% Add the libraries for the code
addpath('../')
addpath('/Users/mertgurbuzb/Code/random-reshuffle/')
% npath= 150; ncycle = 500; m=10 n=5
config1.m = 50 %50; %number of functions
config1.n = 20 %20;  %the dimension
config1.nCycles = 500; %100000; %number of cycles. effect seen at 1000
config1.step0 = 1/(3* config1.m* config1.n) %1/ (3* config1.m* config1.n)/20;   %stepsize amplitude parameter
 
config1.x = zeros(config1.n,1); %initial point
config1.stoclevel = 1; % default = 1, stochasticity level 
config1.removebias = 1; 
config1.nbr_paths = 20; %500;
config1.record = 0; 
config1.stepdecay = 0.75; 


sim_bias_removal(19,config1)
profile viewer