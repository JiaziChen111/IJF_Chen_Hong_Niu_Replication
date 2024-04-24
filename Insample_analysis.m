%% DNS_FD_L_u model estimation with the full samples, and results in Insample_results.xlsx
% Prepare for the DNS_FD_L_u level trend in Figure 5: Comparison of trends
clear all; close all; clc;
% cd 'Z:\User\IJF_Chen_Hong_Niu_Replication'
% 
% addpath(genpath('./Data'));
% addpath(genpath('./Functions'));

%% load data
% yield data
data_CRSP=xlsread('CRSP_monthly','Monthly');
yield=data_CRSP(1:805,:); % 3M,12M,24M,36M,48M,60M
Y=yield;
[T,N] = size(Y); % 805 by 6

%% DNS estimation, lambda is estimated by MLE method
bdraw0 = [0.0609 0.0001]';
Mt=[3,12,24,36,48,60];

[bdraw_mle,mu,Phi,Omiga,Phi_Q_mle,B_1_mle,sigma,X_mle,VCV,Y_bar_mle,mu_std,Phi_std] = step_3_Q(Y',Mt,bdraw0);

Level=X_mle(1,:)';
Slope=X_mle(2,:)';
%%
%demographic data
data_pop=xlsread('US_Age_Distribution_2019','actualpopulation','A2:CI81'); % Age distribution, annully number, 1940.5-2019.5, 0-1,1-2,...,84-85,85+
pop_ann_num_dis = data_pop(1:80,1:87);%
time_ann = 1940.5:2019.5 ;% annually 
time_mon = 1940+6/12:1/12:2019+6/12;
for i= 1:86 %0-1,1-2,...,84-85,85+, total number: 86
pop_mon_num_dis(:,i) = interp1(time_ann,pop_ann_num_dis(:,1+i),time_mon);
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
%% CV selection
% CV_Level=CV_Single_FFF(Level,z_86_1952(:,2:end)) %HCV: Kappa=5£¬ MHCV: Kappa=5
% [12.9133269557544,9.10015638927456,8.59792824344727,414.334429749457,11750.6451428548,317837.695071275,2267.27748539350;
% 27.1945140522928,17.5481909274430,12.5369658274104,744.918212494065,19886.8365105466,651124.489978834,4820.17459775255]
%% Nonparametric regression Level
DNS_FD= fitlm(z_86_1952(:,3:6),Level); % Level
n=805;
maxlag = floor(4*(n/100)^(2/9));
[NWEstParamCov,~,NWCoeff] = hac(DNS_FD,'type','hac', 'bandwidth',maxlag + 1);
NWstd_DNS_FD=sqrt(diag(NWEstParamCov(1:5,1:5)));
g_s_DNS_FD = phi_86(1:5,1:86)'*NWCoeff(1:5,1);
% caculate the covariance matrix for age impact function g(s):
covariance_gs = phi_86(1:5,1:86)'*NWEstParamCov(1:5,1:5)*phi_86(1:5,1:86);

for i = 1:86
    sd_gs(i,1) = covariance_gs(i,i);
end 
for i = 1:86
   gs_upper_DNS_FD(i,1) = g_s_DNS_FD(i,1)+sqrt(sd_gs(i,1))*1.96;
   gs_lower_DNS_FD(i,1) = g_s_DNS_FD(i,1)-sqrt(sd_gs(i,1))*1.96;
end
% caculate the covariance matrix for the trend:
trend_DNS_FD=DNS_FD.Fitted;
% Cov(Y)=Z*Cov(alpha)*Z', Y:T by 1; Z: T by kappa; alpha: kappa by 1
covariance_trend = z_86_1952(1:805,2:6)*NWEstParamCov(1:5,1:5)*z_86_1952(1:805,2:6)';
for i = 1:805
    sd_trend(i,1) = covariance_trend(i,i);
end 
for i = 1:805
   trend_upper_DNS_FD(i,1) = trend_DNS_FD(i,1)+sqrt(sd_trend(i,1))*1.96;
   trend_lower_DNS_FD(i,1) = trend_DNS_FD(i,1)-sqrt(sd_trend(i,1))*1.96;
end

% save: (1) trend_lower_DNS_FD, (2) trend_DNS_FD, (3) trend_upper_DNS_FD in the Insample_results.xlsx
trends_save = [trend_lower_DNS_FD,trend_DNS_FD, trend_upper_DNS_FD];

xlswrite('Insample_results.xlsx',trends_save,'DNS_FD_L_u',strcat("B",num2str(2)));
%% plots
% Age impact function comparison
% figure('Name','g(s)_Level','Color',[1 1 1],'NumberTitle','off');
% [ha_3m]=shadedplot(0.5:85.5,gs_upper_DNS_FD',gs_lower_DNS_FD',[255/255 1/255 255/255]);%[200/255 200/255 200/255]
% hold on
% h_1Q=plot(0.5:85.5,g_s_DNS_FD,'r--','LineWidth',2)
% grid on
% xlabel '\bf Age'
% title '\bf Age impact function of DNS level factor'
% 
% % trend component driven by demographic age distribution
% figure('Name','Trend_level','Color',[1 1 1],'NumberTitle','off');
% [ha_1Q]=shadedplot(1952.5:1/12:2019.5,trend_upper_DNS_FD',trend_lower_DNS_FD',[255/255 1/255 255/255]);%[200/255 200/255 200/255]
% hold on
% h_1Q=plot(1952.5:1/12:2019.5,trend_DNS_FD,'r--','LineWidth',2)
% grid on
% xlabel '\bf Time: 1952M6-2019M6'
% ylabel '\bf Percent (%)'
% title '\bf Demographic-driven trends of DNS level factor'




%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RZIG model estimation with the full samples, and results in Insample_results.xlsx
% Prepare for the RZIG level trend in Figure 5: Comparison of trends
clear all; close all; clc;
% cd 'Z:\User\IJF_Chen_Hong_Niu_Replication'
% 
% addpath(genpath('./Data'));
% addpath(genpath('./Functions'));

%% load data
% yield data
data_CRSP=xlsread('CRSP_monthly','Monthly');
yield=data_CRSP(1:805,:); % 3M,12M,24M,36M,48M,60M
Y=yield;
[T,N] = size(Y); % 805 by 6

%% DNS estimation, lambda is estimated by MLE method
bdraw0 = [0.0609 0.0001]';
Mt=[3,12,24,36,48,60];

[bdraw_mle,mu,Phi,Omiga,Phi_Q_mle,B_1_mle,sigma,X_mle,VCV,Y_bar_mle,mu_std,Phi_std] = step_3_Q(Y',Mt,bdraw0);

Level=X_mle(1,:)';
Slope=X_mle(2,:)';

%% real-time CPI inflation data from the dataset of 
%   the Federal Reserve Bank of Philadelphia (month t vintage data) 
data_cpi_original=xlsread('real_time_CPI_inflation_vintage','pcpi');
data_cpi_date=xlsread('real_time_CPI_inflation_vintage','date');
data_cpi_mon=NaN(894,274);
for i=1:274
    if i<18
        data_cpi_mon(13:620+i,i)=(log(data_cpi_original(14:621+i,i))-log(data_cpi_original(13:620+i,i)))*100;
    else
        data_cpi_mon(1:620+i,i)=(log(data_cpi_original(2:621+i,i))-log(data_cpi_original(1:620+i,i)))*100;
    end
end

data_cpi_stand=NaN(894,274);
for i=1:274
    if i<18
        data_cpi_stand(13:620+i,i)=standarized_mon(data_cpi_mon(13:620+i,i));
    else
        data_cpi_stand(1:620+i,i)=standarized_mon(data_cpi_mon(1:620+i,i));
    end
end
data_cpi_stand=[data_cpi_date(2:end,1),data_cpi_stand];
data_cpi_stand=[NaN(1,275);data_cpi_stand];
data_cpi_stand(1,2:end)=[data_cpi_date(623:end,1)',202108];

%% Real-time data IP data  from the Federal Reserve Bank of Philadelphia (month t vintage)
data_ip_original=xlsread('real_time_IP_vintage','ipt','PR338:AAE1232');
data_ip_date=xlsread('real_time_IP_vintage','date');
data_ip_mon=NaN(894,274);
for i=1:274
    data_ip_mon(1:620+i,i)=(log(data_ip_original(2:621+i,i))-log(data_ip_original(1:620+i,i)))*100;
end

data_ip_stand=NaN(894,274);
for i=1:274
    data_ip_stand(1:620+i,i)=standarized_mon(data_ip_mon(1:620+i,i));
end
data_ip_stand=[data_ip_date(2:end,1),data_ip_stand];
data_ip_stand=[NaN(1,275);data_ip_stand];
data_ip_stand(1,2:end)=[data_ip_date(623:end,1)',202108];

%% exponential smoothing
stand_inflation_2019m6=data_cpi_stand(2:869,249); %1947M2-2019M5
alpha=0.01; % exponential smoothing parameter
esi_history_orig=exp_smooth(stand_inflation_2019m6,alpha); % month on month growth

es_inflation_2019m6=zeros(805,1);% 1952M6-2019M6
es_inflation_2019m6(end,1)=alpha*stand_inflation_2019m6(end,1)+(1-alpha)*esi_history_orig(end,1); %2019M6
es_inflation_2019m6(1:end-1,1)=esi_history_orig(65:868,1); %1952M6-2019M5

stand_ip_2019m6=data_ip_stand(2:869,249); %1947M2-2019M5
esi_history_orig_ip=exp_smooth(stand_ip_2019m6,alpha); % month on month growth
es_ip_2019m6=zeros(805,1);% 1952M6-2019M6
es_ip_2019m6(end,1)=alpha*stand_ip_2019m6(end,1)+(1-alpha)*esi_history_orig_ip(end,1); %2019M6
es_ip_2019m6(1:end-1,1)=esi_history_orig_ip(65:868,1); %1952M6-2019M5

%% OLS fit
level_pi_es=fitlm(es_inflation_2019m6,Level);
trend_RZI=level_pi_es.Fitted;
n=805;
maxlag = floor(4*(n/100)^(2/9));
[NWEstParamCov,~,NWCoeff] = hac(level_pi_es,'type','hac', 'bandwidth',maxlag + 1);

% covariance matrix for trend:
trend_RZI=level_pi_es.Fitted;
% Cov(Y)=Z*Cov(alpha)*Z'
covariance_trend = [ones(805,1),es_inflation_2019m6]*NWEstParamCov(1:2,1:2)*[ones(805,1),es_inflation_2019m6]';
for i = 1:805
    sd_trend(i,1) = covariance_trend(i,i);
end 
for i = 1:805
   trend_upper_RZI(i,1) = trend_RZI(i,1)+sqrt(sd_trend(i,1))*1.96;
   trend_lower_RZI(i,1) = trend_RZI(i,1)-sqrt(sd_trend(i,1))*1.96;
end

% save: (1) trend_lower_RZI, (2) trend_RZI, (3) trend_upper_RZI in the Insample_results.xlsx
trend_save_RZIG = [trend_lower_RZI,trend_RZI,trend_upper_RZI];
xlswrite('Insample_results.xlsx',trend_save_RZIG,'RZIG',strcat("D",num2str(2)));
%%
slope_ip_es=fitlm(es_ip_2019m6,Slope);
trend_RZIG=slope_ip_es.Fitted;
n=805;
maxlag = floor(4*(n/100)^(2/9));
[NWEstParamCov,~,NWCoeff] = hac(slope_ip_es,'type','hac', 'bandwidth',maxlag + 1);
%covariance matrix of slope trend:
trend_RZIG=slope_ip_es.Fitted;
% Cov(Y)=Z*Cov(alpha)*Z',
covariance_trend = [ones(805,1),es_ip_2019m6]*NWEstParamCov(1:2,1:2)*[ones(805,1),es_ip_2019m6]';
for i = 1:805
    sd_trend(i,1) = covariance_trend(i,i);
end 
for i = 1:805
   trend_upper_RZIG(i,1) = trend_RZIG(i,1)+sqrt(sd_trend(i,1))*1.96;
   trend_lower_RZIG(i,1) = trend_RZIG(i,1)-sqrt(sd_trend(i,1))*1.96;
end


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% DNS_MY_L_u model estimation with the full samples, and results in Insample_results.xlsx
% Prepare for the DNS_MY_L_u level trend in Figure 5: Comparison of trends
clear all; close all; clc;
% cd 'Z:\User\IJF_Chen_Hong_Niu_Replication'
% 
% addpath(genpath('./Data'));
% addpath(genpath('./Functions'));

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
pop_mon_num_dis(:,i) = interp1(time_ann,pop_ann_num_dis(:,1+i),time_mon); 
end
pop_mon_num_dis = [time_mon',pop_mon_num_dis];

for i=1:86
    for j=1:949
        pop_mon_dis(j,i)=pop_mon_num_dis(j,i+1)./sum(pop_mon_num_dis(j,2:end),2);
    end
end
%% MY ratio, 40-49/20-29
MY_1952=zeros(805,2); %1952:M6-2019:M6
MY_1952(:,1)=time_mon(1,145:end)';
for i=1:805
    MY_1952(i,2)=sum(pop_mon_dis(144+i,41:50))/sum(pop_mon_dis(144+i,21:30));
end
%%
bdraw0=[0.0609 0.0001]';
Mt=[3,12,24,36,48,60];
[bdraw_mle,mu,Phi,Omiga,Phi_Q_mle,B_1_mle,sigma,X_mle,VCV,Y_bar_mle,mu_std,Phi_std] = step_3_Q(Y',Mt,bdraw0);

Level=X_mle(1,:)'; 

%% Linear regression
reg_my= fitlm(MY_1952(:,2),Level);%fitlm function includes constant term as default
n=805;
maxlag = floor(4*(n/100)^(2/9));
[NWEstParamCov,~,NWCoeff] = hac(reg_my,'type','hac', 'bandwidth',maxlag + 1);
%
trend_my=[ones(805,1),MY_1952(:,2)]*NWCoeff; 
% Cov(Y)=Z*Cov(alpha)*Z'
covariance_trend = [ones(805,1),MY_1952(:,2)]*NWEstParamCov(1:2,1:2)*[ones(805,1),MY_1952(:,2)]';
for i = 1:805
    sd_trend(i,1) = covariance_trend(i,i);
end 
for i = 1:805
   trend_upper_my(i,1) = trend_my(i,1)+sqrt(sd_trend(i,1))*1.96;
   trend_lower_my(i,1) = trend_my(i,1)-sqrt(sd_trend(i,1))*1.96;
end

% save: (1) trend_lower_my, (2) trend_my, (3) trend_upper_my in the Insample_results.xlsx
trend_save_DNS_MY_L_u=[trend_lower_my,trend_my,trend_upper_my];
xlswrite('Insample_results.xlsx',trend_save_DNS_MY_L_u,'DNS_MY_L_u',strcat("B",num2str(2)));
%% Trend with interval confidence
% figure('Name','i_star','Color',[1 1 1],'NumberTitle','off');
% 
% [haaa]=shadedplot(1952+6/12.:1/12:2019+6/12,trend_upper_my',trend_lower_my',[255/255 100/255 255/255]);%[200/255 200/255 200/255]
% hold on
% h33=plot(1952+6/12:1/12:2019+6/12,trend_my,'r','LineWidth',2);
% h_raw=plot(1952+6/12:1/12:2019+6/12,Level,'K:','Linewidth',2);
% hold on
% grid on
% xlabel('\bf Time: 1952M6-2019M6')
% ylabel('\bf Percent (%)')
% title('\bf Trend driven by MY ratio: Level factor');
% 
% axis([1952 2020  0 16])
% h = legend([h33 haaa(2) h_raw],texlabel('MY trend'),texlabel('MY trend 95% interval'),texlabel('Level factor'))
% set(h,'Position', [0.5 0.005 0.05 0.05], 'Orientation', 'horizontal','Box', 'off');


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% DNS model estimation with the full samples, and save the LSC factors in Insample_results.xlsx
% Prepare for the DNS level factor in Figure 5: Comparison of trends
clear all; close all; clc;
% cd 'Z:\User\IJF_Chen_Hong_Niu_Replication'
% 
% addpath(genpath('./Data'));
% addpath(genpath('./Functions'));

%% load yield data
data_CRSP=xlsread('CRSP_monthly','Monthly');
yield=data_CRSP(1:805,:); % 3M,12M,24M,36M,48M,60M
Y=yield;
[T,N] = size(Y); % 805 by 6
%% DNS model, lambda is estimated by MLE method
bdraw0 = [0.0609 0.0001]';
Mt=[3,12,24,36,48,60];

[bdraw_mle,mu,Phi,Omiga,Phi_Q_mle,B_1_mle,sigma,X_mle,VCV,Y_bar_mle,mu_std,Phi_std] = step_3_Q(Y',Mt,bdraw0);

%% LSC factor: save in the Insample_results.xlsx
Level=X_mle(1,:)'; Slope=X_mle(2,:)'; Curvature=X_mle(3,:)';

trend_save_DNS=[Level,Slope,Curvature];
xlswrite('Insample_results.xlsx',trend_save_DNS,'DNS_factors',strcat("B",num2str(2)));
