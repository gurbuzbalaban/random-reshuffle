
%1-d grid
dx = 0.05; 
x = -5 : dx : 5; 

% two functions
f1 = 0.5*((x-1).^2);
f2 = 0.5*((x+1).^2) + 0.5*(x.^2)-0.25;


plot(x, f1, 'b', 'LineWidth',3)
hold on
plot(x, f2, 'r', 'LineWidth',3)

% set properties of the figure
ylim([0 8])
xlabel('x')
ylabel('function value')
LEG = legend('f_1','f_2')
set(LEG,'FontSize',16);

