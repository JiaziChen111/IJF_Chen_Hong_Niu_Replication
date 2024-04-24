function [mu_all,phi_all] = VAR_1_ALL(YY)
% Input: Level, Slope, Curvature, CPI Inflation Rate, IP Growth rate
% Output: mu_all, phi_all
[R,C]=size(YY);
XXX=[ones(R-1,1),YY(1:end-1,:)];
YYY=YY(2:end,:);
est_all=(XXX'*XXX)\(XXX'*YYY);
mu_all=est_all(1,:)';
phi_all=est_all(2:end,:);

end

