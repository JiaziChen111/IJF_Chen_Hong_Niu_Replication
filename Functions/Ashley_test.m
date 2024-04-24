function [beta0,beta1,pbeta0,pbeta1] = Ashley_test(for1,for2,actual)
%% Ashley,Granger, and Schmalensee(1980,Econometrica)' test between Model 1 and Model 2, 
% also see:  Berardi and Torous(2005,JFQA); Berardi et al.(2021, Management Science)
%% Notes: 
% e1t=(for1-actual) at time t, e2t=(for2-actual) at time t;
% e1t: forcasting error of model 1; e2t: forecasting error of model 2
% deltat=e1t-e2t: difference between forecasting errors of model 1 and model 2
% sigmat=e1t+e2t: sum of forecasting errors
% sigmabar: sample mean of sigmat
% run OLS regression:  deltat = beta0 + beta1*(sigmat-sigmabar) + ut
% where ut is an error term with mean zero that can be treated as independence of sigmat

% Meanings of parameters and relative test statistics
% H0: beta0=0, there is no difference in the biases of the Model 1 and Model 2;
% H0: beta1=0, there is no difference in the variances of the Model 1 and Model 2
%  beta0 > 0: the biases of Model 1 is GREAT than Model 2, p values for statistical significance
%  beta1 > 0: the variances of Model is GREAT than Model 2, p values for statistical significance
%%
e1t=for1-actual; e2t=for2-actual;
deltat=e1t-e2t; sigmat=e1t+e2t; sigmabar=mean(sigmat); regressorsigma=sigmat-ones(size(sigmat,1),1)*sigmabar;
reg=fitlm(regressorsigma,deltat);
beta0=reg.Coefficients.Estimate(1,1);
beta1=reg.Coefficients.Estimate(2,1);

ut=reg.Residuals.Raw;
L_NW=floor(4*((size(for1,1)/100)^(2/9))); % Newey-West (1994) plug-in procedure
std_test=NeweyWest_alt(ut,regressorsigma,L_NW,1);

beta0_t=beta0/std_test(1);
beta1_t=beta1/std_test(2);

pbeta0=(1-tcdf(abs(beta0_t),size(for1,1)-2))*2;
pbeta1=(1-tcdf(abs(beta1_t),size(for1,1)-2))*2;

end

