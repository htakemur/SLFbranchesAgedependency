function [d] = s_computedprime(x1, x2);

% Compute paired d-prime
% https://jp.mathworks.com/matlabcentral/fileexchange/62957-computecohen_d-x1-x2-varargin

mean_x1  = nanmean(x1);
mean_x2  = nanmean(x2);
meanDiff = (mean_x1 - mean_x2);
deltas   = x1 - x2;         % differences
sdDeltas = nanstd(deltas);  % standard deviation of the diffferences
s        = sdDeltas;        % re-name
d        =  meanDiff / s;   % Cohen's d (paired version)