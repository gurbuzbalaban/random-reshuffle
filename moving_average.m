function [ave_new, n_new] = moving_average(ave_past, n_past, data_in)
% Running average of a sequence.
% [ave_new, n_new] = moving_average(ave_past, n_past, data_in) returns the
% running average of the data points and the total number of data points 
% used to compute that average, given the past history:
% data_in: the new data point, 
% ave_past: historical average, 
% n_past: number of data points used to compute the historical average. 

n_new = n_past + 1;

b = n_past/n_new;

ave_new = ave_past * b  +  (1-b) * data_in;

end