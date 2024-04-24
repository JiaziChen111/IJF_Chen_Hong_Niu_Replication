function [outputArg1] = detrend_linear(inputArg1)
% InputArg1: a time series 
% 
% outputArg1:a residual time series after detrended (linear time trend) with OLS regression

[r_med, c_med]=size(inputArg1);

time_var = 1:r_med;

reg_med=fitlm(time_var,inputArg1);

outputArg1 = reg_med.Residuals.Raw;
end

