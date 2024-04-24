%%  RZL_FD: lamda is estimated by MLE method
%   Level factor for semiparametric regression, Recursive scheme
%   1st subsample is 1952:M6-2014:M7, last subsample is 1952:M6-2021:M12
clear all; close all; clc;
% cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\Spuriousness_check\2019M7_2022M6'
% 
% addpath(genpath('./Data'));
% addpath(genpath('./Functions'));
%% load data
% yield data
data_CRSP=xlsread('CRSP_monthly_2022','Monthly');
yield=data_CRSP(1:841,:); % 3M,12M,24M,36M,48M,60M, 1952M6-2022M6
Y=yield;
[T,N] = size(Y); % 841 by 6

%demographic data
data_pop=xlsread('US_Age_Distribution_2022','actualpopulation_2022','A2:CI84'); % Age distribution, annully number, 1940.5-2022.5, 0-1,1-2,...,84-85,85+
pop_ann_num_dis = data_pop(1:83,1:87);%
time_ann = 1940.5:2022.5 ;% annually 
time_mon = 1940+6/12:1/12:2022+6/12;
for i= 1:86 %0-1,1-2,...,84-85,85+, total number: 86
pop_mon_num_dis(:,i) = interp1(time_ann,pop_ann_num_dis(:,1+i),time_mon); % linear interpolation
end
pop_mon_num_dis = [time_mon',pop_mon_num_dis];

for i=1:86
    for j=1:985
        pop_mon_dis(j,i)=pop_mon_num_dis(j,i+1)./sum(pop_mon_num_dis(j,2:end),2);
    end
end
%% CV results 
addpath(genpath('./Results'));
load 'Rec_CV_Level.mat'

 MHCV_L_DL=zeros(90,8);
for i=1:90
    MHCV_L_DL(i,:)=Rec_CV_Level(2*i,:);
end

% CV_L_DL=xlsread('CV_selection_monthly_new','Level_MLE_Recursive');
% MHCV_L_DL=zeros(90,8);
% for i=1:90
%     MHCV_L_DL(i,:)=CV_L_DL(2*i,4:11);
% end
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
z_86_1952=z_86(145:end,:);% 1952:M6-2022:M6
%%
y_h6=zeros(36,6); y_h12=zeros(36,6); y_h24=zeros(36,6);
y_h36=zeros(36,6); y_h48=zeros(36,6); y_h60=zeros(36,6);


for i=1:90
    i
   bdraw0=[0.0609 0.0001]';
   Mt=[3,12,24,36,48,60];
   
   X_mle=[]; Phi=[];mu=[];Phi_Q_mle=[];B_1_mle=[];
   [bdraw_mle,mu,Phi,Omiga,Phi_Q_mle,B_1_mle,sigma,X_mle,VCV,Y_bar_mle,mu_std,Phi_std] = step_3_Q(Y(1:i+745,:)',Mt,bdraw0);
   b = factorloading(Mt,Phi_Q_mle,B_1_mle); % 3 by length(Mt)
   b = b.b';                                % b is length(Mt) by 3 matrix,i.e., 6 by 3
    
    
    Level=[]; Slope=[]; Curvature=[];
    Level=X_mle(1,:)'; Slope=X_mle(2,:)'; Curvature=X_mle(3,:)';
    
    
    % Level factor
    SP_L=[]; SP_L_trend=[];
     if MHCV_L_DL(i,8)==1; % Kappa=2
         SP_L=fitlm(z_86_1952(1:745+i,3),Level);
         SP_L_trend=SP_L.Fitted;
     elseif MHCV_L_DL(i,8)==2; % Kappa=3
         SP_L=fitlm(z_86_1952(1:745+i,3:4),Level);
         SP_L_trend=SP_L.Fitted;
         else MHCV_L_DL(i,8)==3; % Kappa=5
         SP_L=fitlm(z_86_1952(1:745+i,3:6),Level);
         SP_L_trend=SP_L.Fitted;   
     end

    Level_forecast=zeros(60,1);Slope_forecast=zeros(60,1); Curvature_forecast=zeros(60,1);
    L_demean=Level-SP_L_trend;
    L_phi_orig=my_ols(L_demean(1:end-1,1),L_demean(2:end,1));
    L_phi=L_phi_orig(1,1);

    Level_forecast(1,1)=SP_L_trend(end,1)+L_phi*(Level(end,1)-SP_L_trend(end,1));
    
    for ii=2:60
        Level_forecast(ii,1)=SP_L_trend(end,1)+L_phi*(Level_forecast(ii-1,1)-SP_L_trend(end,1));
    end
    
    slope_reg=fitlm(Slope(1:end-1,1),Slope(2:end,1));
    mu_s=slope_reg.Coefficients.Estimate(1,1);
    phi_s=slope_reg.Coefficients.Estimate(2,1);
    uncondi_mean_slope=mu_s/(1-phi_s);
    
    curvature_reg=fitlm(Curvature(1:end-1,1),Curvature(2:end,1));
    mu_c=curvature_reg.Coefficients.Estimate(1,1);
    phi_c=curvature_reg.Coefficients.Estimate(2,1);
    uncondi_mean_curvature=mu_c/(1-phi_c); 
    
    Slope_demean=Slope-uncondi_mean_slope*ones(size(Slope,1),1);
    [slope_beta,~,~,~,~]=my_ols(Slope_demean(1:end-1,1),Slope_demean(2:end,1));
    phi_slope=slope_beta(1,1);
    Curvature_demean=Curvature-uncondi_mean_curvature*ones(size(Curvature,1),1);
    [curvature_beta,~,~,~,~]=my_ols(Curvature_demean(1:end-1,1),Curvature_demean(2:end,1));
    phi_curvature=curvature_beta(1,1);

    Slope_forecast(1,1)=uncondi_mean_slope+phi_slope*(Slope(end,1)-uncondi_mean_slope);
    Curvature_forecast(1,1)=uncondi_mean_curvature+phi_curvature*(Curvature(end,1)-uncondi_mean_curvature);
    
    for ii=2:60
        Slope_forecast(ii,1)=uncondi_mean_slope+phi_slope*(Slope_forecast(ii-1,1)-uncondi_mean_slope);
        Curvature_forecast(ii,1)=uncondi_mean_curvature+phi_curvature*(Curvature_forecast(ii-1,1)-uncondi_mean_curvature);
    end   
    
    forecast_LSC=[Level_forecast,Slope_forecast,Curvature_forecast];
    

         if ((i>54)&(i<91)) % h=6M, 2019M1-2021M12
            y_h6(i-54,:)=b*forecast_LSC(6,:)';
         end
         
         if ((i>48)&&(i<85))% h=12M, 2018M7-2021M6
            y_h12(i-48,:)=b*forecast_LSC(12,:)';
         end
         
         if ((i>36)&&(i<73)) % h=24M, 2017M7-2020M6
            y_h24(i-36,:)=b*forecast_LSC(24,:)';
         end
         
         if ((i>24)&&(i<61)) % h=36M, 2016M7-2019M6
            y_h36(i-24,:)=b*forecast_LSC(36,:)';
         end
         
         if  ((i>12)&&(i<49)) % h=48M, 2015M7-2018M6
            y_h48(i-12,:)=b*forecast_LSC(48,:)';
         end
         
          if ((i>0) && (i<37)) % h=60M, 2014M7-2017M6
            y_h60(i,:)=b*forecast_LSC(60,:)';
         end        
         
end

%% Save the results
Rec_DNS_FD_L_u=For_result_save(y_h6,y_h12,y_h24,y_h36,y_h48,y_h60);
save('.\Results\Rec_DNS_FD_L_u','Rec_DNS_FD_L_u');