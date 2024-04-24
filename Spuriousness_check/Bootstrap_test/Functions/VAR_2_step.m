function [mu,Phi,Omiga]=VAR_2_step(xt)
% xt = X_KF;
% xt is the state variable with K by Time matrix

%SIGMA is the Var-Cov matrix of state equation

%global K,
xt = xt*10^3;
K = size(xt,1);
K_NS = 3;
T=size(xt,2)-1;
mu_hat = mean(xt,2);
var_mu = zeros(K);
var_mu(1:3,1:3) = cov(xt(1:3,:)')/T;

xt = xt-mu_hat*ones(1,T+1);

Y_NS = xt(1:3,2:end);
Z = xt(:,1:end-1);
B_NS = Y_NS*Z'/(Z*Z');
Sigma_NS = (Y_NS-B_NS*Z)*(Y_NS-B_NS*Z)'/(T-K_NS);


Phi=zeros(K);
Phi(1:3,:) = B_NS;

Sigma = zeros(K);
Sigma(1:3,1:3) = Sigma_NS;

mu = (eye(K)-Phi)*(mu_hat)/1000;
var_mu = (eye(K)-Phi)*var_mu*(eye(K)-Phi)'/10^6;


Omiga=Sigma/10^6;
