function [stand_xx] = standarized_mon(xx)
% standarized of a time series: mean is zero, and variance is 1
% 
[aa bb]=size(xx);

stand_xx=(xx-mean(xx)*ones(aa,1))/std(xx);

end

