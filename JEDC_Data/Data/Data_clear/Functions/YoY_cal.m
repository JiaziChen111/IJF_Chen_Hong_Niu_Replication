function [outputArg1] = YoY_cal(data_raw_med)
% calculate the year-over-year growth rate following the definition
% of the SPF documentation (page 28)
[r_med, c_med]=size(data_raw_med);
outputArg1 = zeros(r_med-4,1);

outputArg1(:,1)=100*(data_raw_med(5:end,1)./data_raw_med(1:end-4)-ones(r_med-4,1));
end
