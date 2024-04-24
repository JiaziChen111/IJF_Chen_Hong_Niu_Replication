function [mu] = exp_smooth(beta,alpha)
% This function obtains the unconditional mean, mu , from the Nelson-Siegel
% factor, beta , using the exponential smoothing recursion
% mu_j, t+1 = alpha*beta_j,t + (1-alpha)*mu_j,t
% decay parameter 0 < alpha < 1, starting with mu_j,1 = beta_j,1
% beta is the Nelson-Siegel factor, n by 1 vector

nn=size(beta,1);
mu=zeros(nn,1);
mu(1,1)=beta(1,1);
for jj=2:nn
    mu(jj,1)=alpha*beta(jj-1,1)+(1-alpha)*mu(jj-1,1);
end
end

