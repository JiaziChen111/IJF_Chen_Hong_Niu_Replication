function [h6tb,h12tb,h24tb,h36tb,h48tb,h60tb] = Ashley_test_arrangement(model1,model2,actual)
%% 
% Ashley,Granger, and Schmalensee(1980,Econometrica)' test between Model 1 and Model 2, 
% also see:  Berardi and Torous(2005,JFQA); Berardi et al.(2021, Management Science)

%% Notes: 
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
%% Output of tables for different forecasting horizons: h= 6, 12, 24, 36, 48, 60 months
% 6 by 4 matrix
% 6 means 6 maturities: mat= 3, 12, 24, 36, 48, 60 months
% 4 means 2 parameters and 2 statistics: beta0, beta1, p value of beta0, p value of beta1
%% h = 6 months
h6tb=zeros(6,4); 
[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig]=Ashley_test(model1.h6.m3,model2.h6.m3,actual.h6.m3);
h6tb(1,:)=[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig];

[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig]=Ashley_test(model1.h6.m12,model2.h6.m12,actual.h6.m12);
h6tb(2,:)=[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig];

[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig]=Ashley_test(model1.h6.m24,model2.h6.m24,actual.h6.m24);
h6tb(3,:)=[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig];

[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig]=Ashley_test(model1.h6.m36,model2.h6.m36,actual.h6.m36);
h6tb(4,:)=[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig];

[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig]=Ashley_test(model1.h6.m48,model2.h6.m48,actual.h6.m48);
h6tb(5,:)=[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig];

[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig]=Ashley_test(model1.h6.m60,model2.h6.m60,actual.h6.m60);
h6tb(6,:)=[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig];


%% h = 12 months
h12tb=zeros(6,4); 
[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig]=Ashley_test(model1.h12.m3,model2.h12.m3,actual.h12.m3);
h12tb(1,:)=[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig];

[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig]=Ashley_test(model1.h12.m12,model2.h12.m12,actual.h12.m12);
h12tb(2,:)=[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig];

[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig]=Ashley_test(model1.h12.m24,model2.h12.m24,actual.h12.m24);
h12tb(3,:)=[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig];

[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig]=Ashley_test(model1.h12.m36,model2.h12.m36,actual.h12.m36);
h12tb(4,:)=[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig];

[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig]=Ashley_test(model1.h12.m48,model2.h12.m48,actual.h12.m48);
h12tb(5,:)=[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig];

[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig]=Ashley_test(model1.h12.m60,model2.h12.m60,actual.h12.m60);
h12tb(6,:)=[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig];
%% h = 24 months
h24tb=zeros(6,4); 
[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig]=Ashley_test(model1.h24.m3,model2.h24.m3,actual.h24.m3);
h24tb(1,:)=[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig];

[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig]=Ashley_test(model1.h24.m12,model2.h24.m12,actual.h24.m12);
h24tb(2,:)=[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig];

[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig]=Ashley_test(model1.h24.m24,model2.h24.m24,actual.h24.m24);
h24tb(3,:)=[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig];

[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig]=Ashley_test(model1.h24.m36,model2.h24.m36,actual.h24.m36);
h24tb(4,:)=[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig];

[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig]=Ashley_test(model1.h24.m48,model2.h24.m48,actual.h24.m48);
h24tb(5,:)=[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig];

[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig]=Ashley_test(model1.h24.m60,model2.h24.m60,actual.h24.m60);
h24tb(6,:)=[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig];
%% h = 36 months
h36tb=zeros(6,4); 
[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig]=Ashley_test(model1.h36.m3,model2.h36.m3,actual.h36.m3);
h36tb(1,:)=[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig];

[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig]=Ashley_test(model1.h36.m12,model2.h36.m12,actual.h36.m12);
h36tb(2,:)=[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig];

[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig]=Ashley_test(model1.h36.m24,model2.h36.m24,actual.h36.m24);
h36tb(3,:)=[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig];

[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig]=Ashley_test(model1.h36.m36,model2.h36.m36,actual.h36.m36);
h36tb(4,:)=[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig];

[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig]=Ashley_test(model1.h36.m48,model2.h36.m48,actual.h36.m48);
h36tb(5,:)=[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig];

[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig]=Ashley_test(model1.h36.m60,model2.h36.m60,actual.h36.m60);
h36tb(6,:)=[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig];
%% h = 48 months
h48tb=zeros(6,4); 
[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig]=Ashley_test(model1.h48.m3,model2.h48.m3,actual.h48.m3);
h48tb(1,:)=[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig];

[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig]=Ashley_test(model1.h48.m12,model2.h48.m12,actual.h48.m12);
h48tb(2,:)=[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig];

[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig]=Ashley_test(model1.h48.m24,model2.h48.m24,actual.h48.m24);
h48tb(3,:)=[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig];

[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig]=Ashley_test(model1.h48.m36,model2.h48.m36,actual.h48.m36);
h48tb(4,:)=[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig];

[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig]=Ashley_test(model1.h48.m48,model2.h48.m48,actual.h48.m48);
h48tb(5,:)=[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig];

[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig]=Ashley_test(model1.h48.m60,model2.h48.m60,actual.h48.m60);
h48tb(6,:)=[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig];
%% h = 60 months
h60tb=zeros(6,4); 
[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig]=Ashley_test(model1.h60.m3,model2.h60.m3,actual.h60.m3);
h60tb(1,:)=[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig];

[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig]=Ashley_test(model1.h60.m12,model2.h60.m12,actual.h60.m12);
h60tb(2,:)=[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig];

[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig]=Ashley_test(model1.h60.m24,model2.h60.m24,actual.h60.m24);
h60tb(3,:)=[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig];

[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig]=Ashley_test(model1.h60.m36,model2.h60.m36,actual.h60.m36);
h60tb(4,:)=[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig];

[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig]=Ashley_test(model1.h60.m48,model2.h60.m48,actual.h60.m48);
h60tb(5,:)=[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig];

[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig]=Ashley_test(model1.h60.m60,model2.h60.m60,actual.h60.m60);
h60tb(6,:)=[beta0_orig,beta1_orig,pbeta0_orig,pbeta1_orig];
end

