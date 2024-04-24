function [mu_history, mu_forecast, beta_forecast] = ES_forecast(beta,alpha)
% This function obtains the unconditional mean, mu_history , from the Nelson-Siegel
% factor, beta , using the exponential smoothing recursion
% mu_j, t+1 = alpha*beta_j,t + (1-alpha)*mu_j,t
% decay parameter 0 < alpha < 1, starting with mu_j,1 = beta_j,1
% beta is the Nelson-Siegel factor, n by 1 vector
% mu_forecast is 60 periods ahead forecast of shifting endpoint
% beta_forecast is 60 periods ahead forecast of beta
mu_history=exp_smooth(beta,alpha);
de_mu_beta_history=beta-mu_history;
[phi_all,~,~,~,~]=my_ols(de_mu_beta_history(1:end-1,1),de_mu_beta_history(2:end,1));
phi=phi_all(1,1);
omega=phi+alpha;
% forecasting mu and beta
mu_forecast=zeros(60,1); beta_forecast=zeros(60,1);
mu_forecast(1,1)=alpha*beta(end,1)+(1-alpha)*mu_history(end,1);
beta_forecast(1,1)=omega*beta(end,1)+(1-omega)*mu_history(end,1);

for ii=2:60
    mu_forecast(ii,1)=alpha*beta_forecast(ii-1,1)+(1-alpha)*mu_forecast(ii-1,1);
    beta_forecast(ii,1)=omega*beta_forecast(ii-1,1)+(1-omega)*mu_forecast(ii-1,1);
end
    
end