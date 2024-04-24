function [outputArg1] = annual_growth_quarter_yoy(annual_med_level)
% Annual-Average Over Annual-Average Growth Rates: page 28 of the SPF documentation

outputArg1 = zeros(4,1);

outputArg1(1,1) = 100*(annual_med_level(5,1)/annual_med_level(1,1)-1); % first quarter
outputArg1(2,1) = 100*(annual_med_level(6,1)/annual_med_level(2,1)-1); % second quarter
outputArg1(3,1) = 100*(annual_med_level(7,1)/annual_med_level(3,1)-1); % third quarter
outputArg1(4,1) = 100*(annual_med_level(8,1)/annual_med_level(4,1)-1); % fourth quarter
end

