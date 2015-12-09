clear all

addpath('../')
config1.m = 2  %number of functions
config1.n = 1  %the dimension for the iterates
config1.nCycles = 50 %100000 %100000;  %50 %number of cycles
config1.step0 = 1; %/ (3 * config1.m* config1.n);   %initial stepsize
config1.x = ones(config1.n,1); %initial point
config1.removebias = 0; 
config1.nbr_paths = 10000 %2000% 10000 %10000 % 750; %1000;
config1.record = 0; %no need to record all the iters
config1.stepdecay = 0.75; % 1.0; 

out_folder_suffix = 'dim_one_ex'


%figure



% normalized error for Random Reshuffling
config1.stoclevel = 1; % Random Reshuffle (RR)
[xstar1, fstar1, iters1,all_iters1, ave_iters1,ave_step, limit] = sim_incr_grad_quadratics(config1,out_folder_suffix);

config1.stoclevel = 2; % for SGD 
[xstar2, fstar2, iters2,all_iters2, ave_iters2] = sim_incr_grad_quadratics(config1,out_folder_suffix);

%% PLOT HISTOGRAMS OF SCALED ERROR WITH RESPECT TO NON-AVERAGED ITERATES: scaled with sqrt(iteration number)
scaled_error_1 = sqrt(config1.nCycles)*(iters1-xstar1);
scaled_error_2 = sqrt(config1.nCycles)*(iters2-xstar2);
% plot error histograms on top of each other
subplot(2,2,[1 3])
xmax = max(abs(scaled_error_2));
%xlims = [-xmax,xmax];
xlims = [min(scaled_error_2), max(scaled_error_2)]
ngrid = 100; 
deltax = abs(xlims(2)-xlims(1))/ngrid;
xgrid = xlims(1) : deltax : xlims(2); 
[n1,b1] = hist(scaled_error_1,xgrid);
[n2,b2] = hist(scaled_error_2,xgrid);
h1 = bar(b1,n1), h1.FaceColor = [1 0 0]; %red
hold on; 
h2 = bar(b2,n2), h2.FaceColor = [0 0 1] % blue 

%'facecolor','r')



%hist(scaled_error_1)
subplot(2,2,2)
hrr= histogram(scaled_error_1);
hrr.FaceColor = [1 0 0]
subplot(2,2,4)
%hist(scaled_error_2)
%[n2other,b2other] = 
hsgd = histogram(scaled_error_2);
%bar(b2other,n2other,'facecolor','r')
hsgd.FaceColor = [0 0 1];

%% PLOT HISTOGRAMS OF SCALED ERROR WITH RESPECT TO AVERAGED ITERATES
error_1ave = (ave_iters1-xstar1); %power(config1.nCycles,config1.stepdecay)*
error_2ave = (ave_iters2-xstar2); %sqrt(config1.nCycles)*
% plot error histograms on top of each other
figure
subplot(2,2,[1 3])
xmax = max(abs(error_2ave));
%xlims = [-xmax,xmax];
xlims = [min(error_2ave), max(error_2ave)]
ngrid = 100; 
deltax = abs(xlims(2)-xlims(1))/ngrid;
xgrid = xlims(1) : deltax : xlims(2); 
[n1,b1] = hist(error_1ave,xgrid);
[n2,b2] = hist(error_2ave,xgrid);
h1 = bar(b1,n1), h1.FaceColor = [1 0 0]; %red
hold on; 
h2 = bar(b2,n2), h2.FaceColor = [0 0 1] % blue 
xlhand = get(gca,'xlabel')
set(xlhand,'string','Approximation error','fontsize',30)
ylhand = get(gca,'ylabel')
set(ylhand,'string','Number of paths','fontsize',30)
%ylabel('Number of paths')
h_legend = legend('RR','SGD')
set(h_legend,'FontSize',30);
set(gca,'fontsize',30)
%'facecolor','r')



%hist(scaled_error_1)

scaled_error_1ave = error_1ave/ave_step; %power(config1.nCycles,config1.stepdecay) * error_1ave;
scaled_error_2ave = sqrt(config1.nCycles) * error_2ave;

subplot(2,2,4)
%hist(scaled_error_2)
%[n2other,b2other] = 
hsgd = histogram(scaled_error_2ave);
%bar(b2other,n2other,'facecolor','r')
hsgd.FaceColor = [0 0 1];
mycenter2 = mean(scaled_error_2ave);
myline2 = line([mycenter2 mycenter2], get(gca, 'ylim'));
myline2.Color = 'blue';
myline2.LineWidth = 4;
xlhand = get(gca,'xlabel')
set(xlhand,'string','Approximation error of SGD multiplied by k^{1/2}','fontsize',30)
ylhand = get(gca,'ylabel')
set(ylhand,'string','Number of paths','fontsize',30)
%ylabel('Number of paths')
set(gca,'fontsize',30)
xl = xlim

subplot(2,2,2)
hrr= histogram(scaled_error_1ave);
hrr.FaceColor = [1 0 0]

mycenter1 = mean(scaled_error_1ave);
myline1 = line([mycenter1 mycenter1], get(gca, 'ylim'));
myline1.Color = 'red';
myline1.LineWidth = 4;
xlim(xl) %set x-axis limits the same as the other plot
xlhand = get(gca,'xlabel')
set(xlhand,'string','Approximation error of RR multiplied by k^{s}','fontsize',20)
ylhand = get(gca,'ylabel')
set(ylhand,'string','Number of paths','fontsize',30)
%ylabel('Number of paths')
set(gca,'fontsize',30)
% 

% % PLOT ERROR DECAY
% niter = length(all_iters1{1});
% objval1 = zeros(config1.n,niter); 
% objval2 = zeros(config1.n,niter); 
% for i=1:niter
%     objval1(i) = obj_func(all_iters1{1}(i) ); % RR iterates
%     objval2(i) = obj_func(all_iters2{1}(i) ); % SGD iterates
% end
% loglog(1:config1.nCycles, objval1-fstar1);
% hold on
% loglog(1:config1.nCycles, objval2-fstar2);














