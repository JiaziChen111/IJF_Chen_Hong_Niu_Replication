%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bauer and Hamilton(2018,RFS) bootstrap test
% (1) construct 5000 artificial bootstrap time series by sampling residuals from
% separate VAR(1) specifications for the LSC factors estimated from the DNS
% model by MLE method and functional demographic factors Z_t
% (2) After we get the bootstrap artifical samples, we re-run the
% nonparamtric functional regression to check whether the bootstrapped functional
% demographic factor have any explain power for the bootstrapped LSC
% factors from the F-test statistic.
% (3) caculate the bootstrapped p-values as the fraction of samples in which
% bootstrapped |F| > original |F|, and reject the null if this is less
% than, say, 5%.
%%  DNS_FD_L_u: lamda is estimated by MLE method
% Full sample: 1952M6-2019M6
clear all; close all; clc;
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\Spuriousness_check\Bootstrap_test'
addpath(genpath('./Data'));
addpath(genpath('./Functions'));

%% load data
% yield data
data_CRSP=xlsread('CRSP_monthly','Monthly');
yield=data_CRSP(1:805,:); % 3M,12M,24M,36M,48M,60M
Y=yield;
[T,N] = size(Y); % 805 by 6

%demographic data
data_pop=xlsread('US_Age_Distribution_2019','actualpopulation','A2:CI81'); % Age distribution, annully number, 1940.5-2019.5, 0-1,1-2,...,84-85,85+
pop_ann_num_dis = data_pop(1:80,1:87);%
time_ann = 1940.5:2019.5 ;% annually 
time_mon = 1940+6/12:1/12:2019+6/12;
for i= 1:86 %0-1,1-2,...,84-85,85+, total number: 86
pop_mon_num_dis(:,i) = interp1(time_ann,pop_ann_num_dis(:,1+i),time_mon); % linear interpolation
end
pop_mon_num_dis = [time_mon',pop_mon_num_dis];

for i=1:86
    for j=1:949
        pop_mon_dis(j,i)=pop_mon_num_dis(j,i+1)./sum(pop_mon_num_dis(j,2:end),2);
    end
end

%% integral approximation
s_86 = 0.5:1:85.5; % Middle age for each age interval,e.g.,0-1 is 0.5,...,84-85 is 84.5, and 85.5 for 85+
s_star_86 = s_86./85.5; %Park£¬Shin and Whang(2010,JoE), s_star in [0,1]
ss_star_86 = s_star_86.^2; %s_star_square
cos_s_star_86 = cos(s_star_86);
sin_s_star_86 = sin(s_star_86);
cos_2s_star_86 = cos(2*s_star_86);
sin_2s_star_86 = sin(2*s_star_86);
cos_3s_star_86 = cos(3*s_star_86);
sin_3s_star_86 = sin(3*s_star_86);
cos_4s_star_86 = cos(4*s_star_86);
sin_4s_star_86 = sin(4*s_star_86);
cos_5s_star_86 = cos(5*s_star_86);
sin_5s_star_86 = sin(5*s_star_86);
phi_86 = [ones(1,86); s_star_86;ss_star_86;cos_s_star_86;sin_s_star_86;...
   cos_2s_star_86;sin_2s_star_86;cos_3s_star_86;sin_3s_star_86;cos_4s_star_86;...
   sin_4s_star_86;cos_5s_star_86;sin_5s_star_86]; % 13 by 86

z_86=pop_mon_dis*phi_86';

z_86=[time_mon',z_86]; 
z_86_1952=z_86(145:end,:);% 1952:M6-2019:M6

%%
bdraw0=[0.0609 0.0001]';
Mt=[3,12,24,36,48,60];
   
X_mle=[]; Phi=[];mu=[];Phi_Q_mle=[];B_1_mle=[];
[bdraw_mle,mu,Phi,Omiga,Phi_Q_mle,B_1_mle,sigma,X_mle,VCV,Y_bar_mle,mu_std,Phi_std] = step_3_Q(Y',Mt,bdraw0);
b = factorloading(Mt,Phi_Q_mle,B_1_mle); % 3 by length(Mt)
b = b.b';                                % b is length(Mt) by 3 matrix,i.e., 6 by 3
    
Level=[]; Slope=[]; Curvature=[];
Level=X_mle(1,:)'; Slope=X_mle(2,:)'; Curvature=X_mle(3,:)';
    
%% Original: Nonparamtric functional regression

NP_Level = fitlm(z_86_1952(:,3:6),Level); % Level factor: F-statistic = 862, Kappa=5

%% Bootstrap samples: nonparametric funcitonal regression

numBoot=5000; %number of bootstraps
rgn_num=666;

% (1) bootstrap: the LSC factor in the VAR(1) model
[B_lsc,OMEGA_lsc]   = Var1(X_mle');
Bootlsc = bootstrapVAR(X_mle,B_lsc(:,4),B_lsc(1:3,1:3),chol(OMEGA_lsc,'lower'),numBoot,rgn_num);

% (2) bootstrap: the functional demographic factors z_t for the level
% factor, Kappa=5
[B_l_fd,OMEGA_l_fd] = Var1(z_86_1952(:,3:6));
Boot_l_fd = bootstrapVAR(z_86_1952(:,3:6)',B_l_fd(:,5),B_l_fd(1:4,1:4),chol(OMEGA_l_fd,'lower'),numBoot,rgn_num);

% (3) run the nonparametric functional regression
 F_stat_Boot_L=zeros(1,numBoot); 
 tic
 for i=1:numBoot
     i
     % Level factor: Kappa=5
     NP_L_B=fitlm(Boot_l_fd(:,:,i)',Bootlsc(1,:,i)');
     F_stat_Boot_L(1,i)=(NP_L_B.SSR/4)/(NP_L_B.SSE/(805-5));
 end
toc % 31.914424 sec
%% Analyzing the results
% caculate the bootstrapped p-values as the fraction of samples in which
% bootstrapped |F| > original |F|, and reject the null if this is less
% than, say, 5%. Equivalently, we can calculate the bootstrap critical 
% value as the 95th percentile of bootstrapped |F| and reject the null 
% if original |F| exceeds it.

p_boot_fd=sum(abs(F_stat_Boot_L(1,:))>abs((NP_Level.SSR/4)/(NP_Level.SSE/(805-5))))./numBoot; % Level

(1-p_boot_fd)*100  % percentile: 92.18%
