function [outputArg1] = M_to_Q_ave(data_raw_med)
%Monthly data to Quarterly data: average
%
[r_med, c_med]=size(data_raw_med);

r_med_use=(r_med-mod(r_med,3))/3;
outputArg1 = zeros(r_med_use,1);

for ii=1:r_med_use
    outputArg1(ii,1)=mean(data_raw_med(3*(ii-1)+1:3*ii,1));
end

end

