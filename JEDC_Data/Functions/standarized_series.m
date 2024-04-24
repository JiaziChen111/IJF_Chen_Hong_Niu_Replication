function [stand_xx] = standarized_mon(xx)
% standarized of a time series: mean is zero, and variance is 1
% 
[aa bb]=size(xx);
stand_xx=NaN(aa,bb);
for ii=1:bb
   stand_xx(:,ii)=(xx(:,ii)-mean(xx(:,ii))*ones(aa,1))/std(xx(:,ii));
end

end

