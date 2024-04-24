function [outputArg1] = QoQ_cal(data_raw_med)
% calculate the quarter-over-quarter growth rate following the definition
% of the SPF documentation (page 25-26)
[r_med, c_med]=size(data_raw_med);
outputArg1 = zeros(r_med-1,1);

for ii=1:r_med-1
    outputArg1(ii,1)=100*(data_raw_med(ii+1,1)/data_raw_med(ii,1)-1);
end
end

