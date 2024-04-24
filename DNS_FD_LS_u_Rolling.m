%%  DNS_FD_LS_u: lambda is estimated by MLE method
%   Level factor and Slope factor for nonparametric regression, Rolling scheme
%   1st subsample is 1978:M12-1998:M11, last subsample is 1999:M4-2019:M3
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
pop_mon_num_dis(:,i) = interp1(time_ann,pop_ann_num_dis(:,1+i),time_mon); %  linear interpolation
end
pop_mon_num_dis = [time_mon',pop_mon_num_dis];

for i=1:86
    for j=1:949
        pop_mon_dis(j,i)=pop_mon_num_dis(j,i+1)./sum(pop_mon_num_dis(j,2:end),2);
    end
end
%% CV results 

addpath(genpath('./Results'));

load 'Rol_CV_Level.mat'
MHCV_L_DL=zeros(245,8);
for i=1:245
    MHCV_L_DL(i,:)=Rol_CV_Level(2*i,:);
end

load 'Rol_CV_Slope.mat'
MHCV_S_DL=zeros(245,8);
for i=1:245
    MHCV_S_DL(i,:)=Rol_CV_Slope(2*i,:);
end

% CV_L_DL=xlsread('CV_selection_rolling_window_monthly','Level');
% MHCV_L_DL=zeros(245,8);
% for i=1:245
%     MHCV_L_DL(i,:)=CV_L_DL(2*i,4:11);
% end
% CV_S_DL=xlsread('CV_selection_rolling_window_monthly','Slope');
% MHCV_S_DL=zeros(245,8);
% for i=1:245
%     MHCV_S_DL(i,:)=CV_S_DL(2*i,4:11);
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
z_86_1952=z_86(145:end,:);% 1952:M6-2019:M6


%%
y_h3=zeros(245,6); y_h6=zeros(242,6); y_h12=zeros(236,6); y_h24=zeros(224,6);
y_h36=zeros(212,6); y_h48=zeros(200,6); y_h60=zeros(188,6);

for i=1:245
    i
   bdraw0=[0.0609 0.0001]';
   Mt=[3,12,24,36,48,60];
   
   X_mle=[]; Phi=[];mu=[];Phi_Q_mle=[];B_1_mle=[];
   [bdraw_mle,mu,Phi,Omiga,Phi_Q_mle,B_1_mle,sigma,X_mle,VCV,Y_bar_mle,mu_std,Phi_std] = step_3_Q(Y(318+i:i+557,:)',Mt,bdraw0);
   b = factorloading(Mt,Phi_Q_mle,B_1_mle); % 3 by length(Mt)
   b = b.b';                                % b is length(Mt) by 3 matrix,i.e., 6 by 3
    
    Level=[]; Slope=[]; Curvature=[];
    Level=X_mle(1,:)'; Slope=X_mle(2,:)'; Curvature=X_mle(3,:)';
    
    % Level factor
    SP_L=[]; SP_L_trend=[];
     if MHCV_L_DL(i,8)==1; % Kappa=2
         SP_L=fitlm(z_86_1952(318+i:557+i,3),Level);
         SP_L_trend=SP_L.Fitted;
     elseif MHCV_L_DL(i,8)==2; % Kappa=3
         SP_L=fitlm(z_86_1952(318+i:557+i,3:4),Level);
         SP_L_trend=SP_L.Fitted;
         else MHCV_L_DL(i,8)==3; % Kappa=5
         SP_L=fitlm(z_86_1952(318+i:557+i,3:6),Level);
         SP_L_trend=SP_L.Fitted;   
     end

          % Slope factor
    SP_S=[]; SP_S_trend=[];
     if MHCV_S_DL(i,8)==1; % Kappa=2
         SP_S=fitlm(z_86_1952(318+i:557+i,3),Slope);
         SP_S_trend=SP_S.Fitted;
     elseif MHCV_S_DL(i,8)==2; % Kappa=3
         SP_S=fitlm(z_86_1952(318+i:557+i,3:4),Slope);
         SP_S_trend=SP_S.Fitted;
         else MHCV_S_DL(i,8)==3; % Kappa=5
         SP_S=fitlm(z_86_1952(318+i:557+i,3:6),Slope);
         SP_S_trend=SP_S.Fitted;   
     end    
     
    Level_forecast=zeros(60,1);Slope_forecast=zeros(60,1); Curvature_forecast=zeros(60,1);
    L_demean=Level-SP_L_trend;
    L_phi_orig=my_ols(L_demean(1:end-1,1),L_demean(2:end,1));
    L_phi=L_phi_orig(1,1);
    Level_forecast(1,1)=SP_L_trend(end,1)+L_phi*(Level(end,1)-SP_L_trend(end,1));
    for ii=2:60
        Level_forecast(ii,1)=SP_L_trend(end,1)+L_phi*(Level_forecast(ii-1,1)-SP_L_trend(end,1));
    end
    
    S_demean=Slope-SP_S_trend;
    S_phi_orig=my_ols(S_demean(1:end-1,1),S_demean(2:end,1));
    S_phi=S_phi_orig(1,1);
    Slope_forecast(1,1)=SP_S_trend(end,1)+S_phi*(Slope(end,1)-SP_S_trend(end,1));
    for ii=2:60
        Slope_forecast(ii,1)=SP_S_trend(end,1)+S_phi*(Slope_forecast(ii-1,1)-SP_S_trend(end,1));
    end 
    
    curvature_reg=fitlm(Curvature(1:end-1,1),Curvature(2:end,1));
    mu_c=curvature_reg.Coefficients.Estimate(1,1);
    phi_c=curvature_reg.Coefficients.Estimate(2,1);
    uncondi_mean_curvature=mu_c/(1-phi_c); 
    
    Curvature_demean=Curvature-uncondi_mean_curvature*ones(size(Curvature,1),1);
    [curvature_beta,~,~,~,~]=my_ols(Curvature_demean(1:end-1,1),Curvature_demean(2:end,1));
    phi_curvature=curvature_beta(1,1);

    Curvature_forecast(1,1)=uncondi_mean_curvature+phi_curvature*(Curvature(end,1)-uncondi_mean_curvature);
    
    for ii=2:60
        Curvature_forecast(ii,1)=uncondi_mean_curvature+phi_curvature*(Curvature_forecast(ii-1,1)-uncondi_mean_curvature);
    end   
    
    forecast_LSC=[Level_forecast,Slope_forecast,Curvature_forecast];
    
         if i <246 % h=3M
            y_h3(i,:)=b*forecast_LSC(3,:)';
         end

         if i <243 % h=6M
            y_h6(i,:)=b*forecast_LSC(6,:)';
         end
         
         if i<237 % h=12M
            y_h12(i,:)=b*forecast_LSC(12,:)';
         end
         
         
         if i<225 % h=24M
            y_h24(i,:)=b*forecast_LSC(24,:)';
         end
         
         if i<213 % h=36M
            y_h36(i,:)=b*forecast_LSC(36,:)';
         end
         
         if i<201 % h=48M
            y_h48(i,:)=b*forecast_LSC(48,:)';
         end
         
          if i<189 % h=60M
            y_h60(i,:)=b*forecast_LSC(60,:)';
         end        
         
end


%% Save the resuts
Rol_DNS_FD_LS_u=For_result_save(y_h3,y_h6,y_h12,y_h24,y_h36,y_h48,y_h60);
save('.\Results\Rol_DNS_FD_LS_u','Rol_DNS_FD_LS_u');
