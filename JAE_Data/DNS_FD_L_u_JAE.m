%%  DNS_FD_L unspanned lamda=0.0609
%   Level factor for nonparametric regression, Recursive scheme
%   h=6M, 1st subsample is 1985:M1-1993:M7, last subsample is 1985:M1-2009:M6
%   h=12M, 1st subsample is 1985:M1-1993:M1, last subsample is 1985:M1-2008:M12
%   h=24M, 1st subsample is 1985:M1-1992:M1, last subsample is 1985:M1-2007:M12
clear all; close all; clc;
% cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JAE_Data'
% 
% addpath(genpath('./Data'));
% addpath(genpath('./Functions'));
%% load data
% yield data
yield_original=importdata("UnsmFB_70-09.txt");
Mat=[3,6,9,12,15,18,21,24,30,36,48,60,72,84,96,108,120];
yield_original(1,2:18)=Mat;
yield_JAE=yield_original(182:475,1:18); % 1985M1-2009M6

%demographic data
data_pop=xlsread('US_Population','actualpopulation','A2:CI81'); % Age distribution, annully number, 1940.5-2019.5, 0-1,1-2,...,84-85,85+
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
%% CV results 
CV_L_DL=xlsread('CV_selection_recursive_JAE','Level_factor');
MHCV_L_DL=zeros(210,8);
for i=1:210
    MHCV_L_DL(i,:)=CV_L_DL(2*i,4:11);
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
z_86_1985=z_86(536:829,:);% 1985:M1-2009:M6

%% Calculate Nelson-Siegel factor loadings, given lamda=0.0609, Diebold and Li(2006,JoE)
lamda=0.0609;
mat = 1:1:120; 
pNS1 = ones(1,120); 
pNS2 = zeros(1,120); 
pNS3 = zeros(1,120);
for imat = 1:120
    pNS2(imat) = (1 - exp(-lamda*imat))/(lamda*imat);
    pNS3(imat) = pNS2(imat) - exp(-lamda*imat);
end

% Nelson-Siegle Coefficients for yields:
Mat=[3,6,9,12,15,18,21,24,30,36,48,60,72,84,96,108,120];
CCw = [pNS1; pNS2; pNS3]'; %Coefficient matrix for all maturity 1:120
CC = CCw(Mat',:);

% Extract (Estimate) Nelson-Siegel factors for yields by OLS.
NS = ((CC'*CC)\eye(size(CC,2)))*CC'*yield_JAE(:,2:end)';
NS=NS';
NS=[yield_JAE(:,1),NS];
%% h=6M, 1st subsample is 1985:M1-1993:M7, last subsample is 1985:M1-2009:M6
y_h6=zeros(192,17); yield_actual=yield_original(290:481,1:18);

for i=1:192
    Level=[];Slope=[];Curvature=[];
    Level=NS(1:102+i,2); Slope=NS(1:102+i,3); Curvature=NS(1:102+i,4);
    
    
    % Level factor
    SP_L=[]; SP_L_trend=[];
%      if MHCV_L_DL(18+i,8)==1; % Kappa=2
         SP_L=fitlm(z_86_1985(1:102+i,3),Level);
         SP_L_trend=SP_L.Fitted;
%      elseif MHCV_L_DL(18+i,8)==2; % Kappa=3
%          SP_L=fitlm(z_86_1985(1:102+i,3:4),Level);
%          SP_L_trend=SP_L.Fitted;
%          else MHCV_L_DL(18+i,8)==3; % Kappa=5
%          SP_L=fitlm(z_86_1985(1:102+i,3:6),Level);
%          SP_L_trend=SP_L.Fitted;   
%      end

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
   
         if i <193 % h=6M
            y_h6(i,:)=CC*forecast_LSC(6,:)';
         end
end

%  Mat=[3,6,9,12,15,18,21,24,30,36,48,60,72,84,96,108,120];
y_forecast=y_h6;
rmsfe_3m=sqrt(sum((y_forecast(:,1)-yield_actual(:,2)).^2)/192);
rmsfe_6m=sqrt(sum((y_forecast(:,2)-yield_actual(:,3)).^2)/192);
rmsfe_9m=sqrt(sum((y_forecast(:,3)-yield_actual(:,4)).^2)/192);
rmsfe_12m=sqrt(sum((y_forecast(:,4)-yield_actual(:,5)).^2)/192);
rmsfe_15m=sqrt(sum((y_forecast(:,5)-yield_actual(:,6)).^2)/192);
rmsfe_18m=sqrt(sum((y_forecast(:,6)-yield_actual(:,7)).^2)/192);
rmsfe_21m=sqrt(sum((y_forecast(:,7)-yield_actual(:,8)).^2)/192);
rmsfe_24m=sqrt(sum((y_forecast(:,8)-yield_actual(:,9)).^2)/192);
rmsfe_30m=sqrt(sum((y_forecast(:,9)-yield_actual(:,10)).^2)/192);
rmsfe_36m=sqrt(sum((y_forecast(:,10)-yield_actual(:,11)).^2)/192);
rmsfe_48m=sqrt(sum((y_forecast(:,11)-yield_actual(:,12)).^2)/192);
rmsfe_60m=sqrt(sum((y_forecast(:,12)-yield_actual(:,13)).^2)/192);
rmsfe_72m=sqrt(sum((y_forecast(:,13)-yield_actual(:,14)).^2)/192);
rmsfe_84m=sqrt(sum((y_forecast(:,14)-yield_actual(:,15)).^2)/192);
rmsfe_96m=sqrt(sum((y_forecast(:,15)-yield_actual(:,16)).^2)/192);
rmsfe_108m=sqrt(sum((y_forecast(:,16)-yield_actual(:,17)).^2)/192);
rmsfe_120m=sqrt(sum((y_forecast(:,17)-yield_actual(:,18)).^2)/192);
%%% Mat=[3,6,9,12,15,18,21,24,30,36,48,60,72,84,96,108,120];
rmsfe_h6_display=[rmsfe_3m,rmsfe_6m,rmsfe_9m,rmsfe_12m,...
   rmsfe_15m, rmsfe_18m, rmsfe_21m, rmsfe_24m,...
   rmsfe_30m,rmsfe_36m,rmsfe_48m, rmsfe_60m, rmsfe_72m,...
   rmsfe_84m,rmsfe_96m, rmsfe_108m, rmsfe_120m];
% rmsfe_display_DNS_FD_Lu_h6=[Mat;rmsfe_h6_display]


%% h=12M, 1st subsample is 1985:M1-1993:M1, last subsample is 1985:M1-2008:M12
y_h12=zeros(192,17); yield_actual=yield_original(290:481,1:18);

for i=1:192
    Level=[];Slope=[];Curvature=[];
    Level=NS(1:96+i,2); Slope=NS(1:96+i,3); Curvature=NS(1:96+i,4);
    
    % Level factor
    SP_L=[]; SP_L_trend=[];
%      if MHCV_L_DL(12+i,8)==1; % Kappa=2
         SP_L=fitlm(z_86_1985(1:96+i,3),Level);
         SP_L_trend=SP_L.Fitted;
%      elseif MHCV_L_DL(12+i,8)==2; % Kappa=3
%          SP_L=fitlm(z_86_1985(1:96+i,3:4),Level);
%          SP_L_trend=SP_L.Fitted;
%          else MHCV_L_DL(12+i,8)==3; % Kappa=5
%          SP_L=fitlm(z_86_1985(1:96+i,3:6),Level);
%          SP_L_trend=SP_L.Fitted;   
%      end

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
   
         if i <193 % h=12M
            y_h12(i,:)=CC*forecast_LSC(12,:)';
         end
end

%  Mat=[3,6,9,12,15,18,21,24,30,36,48,60,72,84,96,108,120];
y_forecast=y_h12;
rmsfe_3m=sqrt(sum((y_forecast(:,1)-yield_actual(:,2)).^2)/192);
rmsfe_6m=sqrt(sum((y_forecast(:,2)-yield_actual(:,3)).^2)/192);
rmsfe_9m=sqrt(sum((y_forecast(:,3)-yield_actual(:,4)).^2)/192);
rmsfe_12m=sqrt(sum((y_forecast(:,4)-yield_actual(:,5)).^2)/192);
rmsfe_15m=sqrt(sum((y_forecast(:,5)-yield_actual(:,6)).^2)/192);
rmsfe_18m=sqrt(sum((y_forecast(:,6)-yield_actual(:,7)).^2)/192);
rmsfe_21m=sqrt(sum((y_forecast(:,7)-yield_actual(:,8)).^2)/192);
rmsfe_24m=sqrt(sum((y_forecast(:,8)-yield_actual(:,9)).^2)/192);
rmsfe_30m=sqrt(sum((y_forecast(:,9)-yield_actual(:,10)).^2)/192);
rmsfe_36m=sqrt(sum((y_forecast(:,10)-yield_actual(:,11)).^2)/192);
rmsfe_48m=sqrt(sum((y_forecast(:,11)-yield_actual(:,12)).^2)/192);
rmsfe_60m=sqrt(sum((y_forecast(:,12)-yield_actual(:,13)).^2)/192);
rmsfe_72m=sqrt(sum((y_forecast(:,13)-yield_actual(:,14)).^2)/192);
rmsfe_84m=sqrt(sum((y_forecast(:,14)-yield_actual(:,15)).^2)/192);
rmsfe_96m=sqrt(sum((y_forecast(:,15)-yield_actual(:,16)).^2)/192);
rmsfe_108m=sqrt(sum((y_forecast(:,16)-yield_actual(:,17)).^2)/192);
rmsfe_120m=sqrt(sum((y_forecast(:,17)-yield_actual(:,18)).^2)/192);
%%% Mat=[3,6,9,12,15,18,21,24,30,36,48,60,72,84,96,108,120];
rmsfe_h12_display=[rmsfe_3m,rmsfe_6m,rmsfe_9m,rmsfe_12m,...
   rmsfe_15m, rmsfe_18m, rmsfe_21m, rmsfe_24m,...
   rmsfe_30m,rmsfe_36m,rmsfe_48m, rmsfe_60m, rmsfe_72m,...
   rmsfe_84m,rmsfe_96m, rmsfe_108m, rmsfe_120m];
% rmsfe_display_DNS_FD_L_h12=[Mat;rmsfe_h12_display]


%% h=24M, 1st subsample is 1985:M1-1992:M1, last subsample is 1985:M6-2007:M12
y_h24=zeros(192,17); yield_actual=yield_original(290:481,1:18);

for i=1:192
    Level=[];Slope=[];Curvature=[];
    Level=NS(1:84+i,2); Slope=NS(1:84+i,3); Curvature=NS(1:84+i,4);
    
    % Level factor
    SP_L=[]; SP_L_trend=[];
%      if MHCV_L_DL(i,8)==1; % Kappa=2
         SP_L=fitlm(z_86_1985(1:84+i,3),Level);
         SP_L_trend=SP_L.Fitted;
%      elseif MHCV_L_DL(i,8)==2; % Kappa=3
%          SP_L=fitlm(z_86_1985(1:84+i,3:4),Level);
%          SP_L_trend=SP_L.Fitted;
%          else MHCV_L_DL(i,8)==3; % Kappa=5
%          SP_L=fitlm(z_86_1985(1:84+i,3:6),Level);
%          SP_L_trend=SP_L.Fitted;   
%      end

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
   
         if i <193 % h=24M
            y_h24(i,:)=CC*forecast_LSC(24,:)';
         end
end
% Mat=[3,6,9,12,15,18,21,24,30,36,48,60,72,84,96,108,120];
y_forecast=y_h24;
rmsfe_3m=sqrt(sum((y_forecast(:,1)-yield_actual(:,2)).^2)/192);
rmsfe_6m=sqrt(sum((y_forecast(:,2)-yield_actual(:,3)).^2)/192);
rmsfe_9m=sqrt(sum((y_forecast(:,3)-yield_actual(:,4)).^2)/192);
rmsfe_12m=sqrt(sum((y_forecast(:,4)-yield_actual(:,5)).^2)/192);
rmsfe_15m=sqrt(sum((y_forecast(:,5)-yield_actual(:,6)).^2)/192);
rmsfe_18m=sqrt(sum((y_forecast(:,6)-yield_actual(:,7)).^2)/192);
rmsfe_21m=sqrt(sum((y_forecast(:,7)-yield_actual(:,8)).^2)/192);
rmsfe_24m=sqrt(sum((y_forecast(:,8)-yield_actual(:,9)).^2)/192);
rmsfe_30m=sqrt(sum((y_forecast(:,9)-yield_actual(:,10)).^2)/192);
rmsfe_36m=sqrt(sum((y_forecast(:,10)-yield_actual(:,11)).^2)/192);
rmsfe_48m=sqrt(sum((y_forecast(:,11)-yield_actual(:,12)).^2)/192);
rmsfe_60m=sqrt(sum((y_forecast(:,12)-yield_actual(:,13)).^2)/192);
rmsfe_72m=sqrt(sum((y_forecast(:,13)-yield_actual(:,14)).^2)/192);
rmsfe_84m=sqrt(sum((y_forecast(:,14)-yield_actual(:,15)).^2)/192);
rmsfe_96m=sqrt(sum((y_forecast(:,15)-yield_actual(:,16)).^2)/192);
rmsfe_108m=sqrt(sum((y_forecast(:,16)-yield_actual(:,17)).^2)/192);
rmsfe_120m=sqrt(sum((y_forecast(:,17)-yield_actual(:,18)).^2)/192);
%%% Mat=[3,6,9,12,15,18,21,24,30,36,48,60,72,84,96,108,120];
rmsfe_h24_display=[rmsfe_3m,rmsfe_6m,rmsfe_9m,rmsfe_12m,...
   rmsfe_15m, rmsfe_18m, rmsfe_21m, rmsfe_24m,...
   rmsfe_30m,rmsfe_36m,rmsfe_48m, rmsfe_60m, rmsfe_72m,...
   rmsfe_84m,rmsfe_96m, rmsfe_108m, rmsfe_120m];
% rmsfe_display_DNS_FD_L_h24=[Mat;rmsfe_h24_display]

%% Save the results
Rec_DNS_FD_L_JAE=For_result_save_JAE(y_h6,y_h12,y_h24);
save('.\Results\Rec_DNS_FD_L_JAE','Rec_DNS_FD_L_JAE');