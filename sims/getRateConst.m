function const = getRateConst(Lips,Grads,order, m, R)
%% Input:
% Lips: vector of size m, Lips(i) is the Lipschitz constant of the i-th
% component function f_i at the optimal solution.
% Grads:vector of size m, Grads(i) is the gradient of the i-th component
% function f_i at the optimal solution.
% str_cvx : strong convexity of the sum function f=sum_{i=1}^m f_i
% order: is an integer vector of size m and is a permutation of {1,2,..,m}.
% 
%% Output: Rate constant parameter M_order R/c.
const = 0; 
for i=1:m
    for j=1:(i-1)
       const = const + Lips(order(i)) * Grads(order(j));
    end
end
% normalize by strong convexity constant and stepsize amplitude
str_cvx_const = sum(Lips);
const = R * abs(const) / str_cvx_const;

end