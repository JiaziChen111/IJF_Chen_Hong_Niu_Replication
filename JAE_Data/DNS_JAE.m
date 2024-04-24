% Replication of Van Dijk et al.(2014, JAE): FORECASTING INTEREST RATES WITH SHIFTING ENDPOINTS
% DNS
clear all; close all; clc;
% cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JAE_Data'
% 
% addpath(genpath('./Data'));
% addpath(genpath('./Functions'));
%% Load data
yield_original=importdata("UnsmFB_70-09.txt");

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
yield_original(1,2:18)=Mat;
CCw = [pNS1; pNS2; pNS3]'; %Coefficient matrix for all maturity 1:120
CC = CCw(Mat',:);

% Extract (Estimate) Nelson-Siegel factors for yields by OLS.
yield=yield_original(2:481,2:18);
NS = ((CC'*CC)\eye(size(CC,2)))*CC'*yield';
NS=NS';
NS=[yield_original(2:end,1),NS];
NS_h6=NS(181:474,:); %1985M1-1993M7,..., 1985M1-2009M6, forecast:1994M1-2009M12
NS_h12=NS(181:468,:); %1985M1-1993M1,..., 1985M1-2008M12, forecast:1994M1-2009M12
NS_h24=NS(181:456,:); %1985M1-1992M1,..., 1985M1-2007M12, forecast:1994M1-2009M12

%% DL h=6M  
y_h6=zeros(192,17); yield_actual=yield_original(290:481,1:18);

for i=1:192
    
    Level=[];Slope=[];Curvature=[];
    Level=NS_h6(1:end-192+i,2); Slope=NS_h6(1:end-192+i,3); Curvature=NS_h6(1:end-192+i,4); % 1993M7
    
    Level_forecast=[];Slope_forecast=[];Curvature_forecast=[];
    
    level_reg=fitlm(Level(1:end-1,1),Level(2:end,1));
    mu_l=level_reg.Coefficients.Estimate(1,1);
    phi_l=level_reg.Coefficients.Estimate(2,1);
    uncondi_mean_level=mu_l/(1-phi_l);
    
    slope_reg=fitlm(Slope(1:end-1,1),Slope(2:end,1));
    mu_s=slope_reg.Coefficients.Estimate(1,1);
    phi_s=slope_reg.Coefficients.Estimate(2,1);
    uncondi_mean_slope=mu_s/(1-phi_s);
    
    curvature_reg=fitlm(Curvature(1:end-1,1),Curvature(2:end,1));
    mu_c=curvature_reg.Coefficients.Estimate(1,1);
    phi_c=curvature_reg.Coefficients.Estimate(2,1);
    uncondi_mean_curvature=mu_c/(1-phi_c); 
    
    Level_demean=Level-uncondi_mean_level*ones(size(Level,1),1);
    [level_beta,~,~,~,~]=my_ols(Level_demean(1:end-1,1),Level_demean(2:end,1));
    phi_level=level_beta(1,1);
    Slope_demean=Slope-uncondi_mean_slope*ones(size(Slope,1),1);
    [slope_beta,~,~,~,~]=my_ols(Slope_demean(1:end-1,1),Slope_demean(2:end,1));
    phi_slope=slope_beta(1,1);
    Curvature_demean=Curvature-uncondi_mean_curvature*ones(size(Curvature,1),1);
    [curvature_beta,~,~,~,~]=my_ols(Curvature_demean(1:end-1,1),Curvature_demean(2:end,1));
    phi_curvature=curvature_beta(1,1);

    Level_forecast(1,1)=uncondi_mean_level+phi_level*(Level(end,1)-uncondi_mean_level);
    Slope_forecast(1,1)=uncondi_mean_slope+phi_slope*(Slope(end,1)-uncondi_mean_slope);
    Curvature_forecast(1,1)=uncondi_mean_curvature+phi_curvature*(Curvature(end,1)-uncondi_mean_curvature);
    
    for ii=2:60
        Level_forecast(ii,1)=uncondi_mean_level+phi_level*(Level_forecast(ii-1,1)-uncondi_mean_level);
        Slope_forecast(ii,1)=uncondi_mean_slope+phi_slope*(Slope_forecast(ii-1,1)-uncondi_mean_slope);
        Curvature_forecast(ii,1)=uncondi_mean_curvature+phi_curvature*(Curvature_forecast(ii-1,1)-uncondi_mean_curvature);
    end   
    
    forecast_LSC=[Level_forecast,Slope_forecast,Curvature_forecast];
    
         if i <193 % h=6M
            y_h6(i,:)=CC*forecast_LSC(6,:)';
         end
end


%  RMSFE DL: Mat=[3,6,9,12,15,18,21,24,30,36,48,60,72,84,96,108,120];
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
% rmsfe_display_DNS_h6=[Mat;rmsfe_h6_display] %


%% DL h=12M  
y_h12=zeros(192,17); yield_actual=yield_original(290:481,1:18);

for i=1:192
    
    Level=[];Slope=[];Curvature=[];
    Level=NS_h12(1:end-192+i,2); Slope=NS_h12(1:end-192+i,3); Curvature=NS_h12(1:end-192+i,4); % 1993M1
    
    Level_forecast=[];Slope_forecast=[];Curvature_forecast=[];
    
    level_reg=fitlm(Level(1:end-1,1),Level(2:end,1));
    mu_l=level_reg.Coefficients.Estimate(1,1);
    phi_l=level_reg.Coefficients.Estimate(2,1);
    uncondi_mean_level=mu_l/(1-phi_l);
    
    slope_reg=fitlm(Slope(1:end-1,1),Slope(2:end,1));
    mu_s=slope_reg.Coefficients.Estimate(1,1);
    phi_s=slope_reg.Coefficients.Estimate(2,1);
    uncondi_mean_slope=mu_s/(1-phi_s);
    
    curvature_reg=fitlm(Curvature(1:end-1,1),Curvature(2:end,1));
    mu_c=curvature_reg.Coefficients.Estimate(1,1);
    phi_c=curvature_reg.Coefficients.Estimate(2,1);
    uncondi_mean_curvature=mu_c/(1-phi_c); 
    
    Level_demean=Level-uncondi_mean_level*ones(size(Level,1),1);
    [level_beta,~,~,~,~]=my_ols(Level_demean(1:end-1,1),Level_demean(2:end,1));
    phi_level=level_beta(1,1);
    Slope_demean=Slope-uncondi_mean_slope*ones(size(Slope,1),1);
    [slope_beta,~,~,~,~]=my_ols(Slope_demean(1:end-1,1),Slope_demean(2:end,1));
    phi_slope=slope_beta(1,1);
    Curvature_demean=Curvature-uncondi_mean_curvature*ones(size(Curvature,1),1);
    [curvature_beta,~,~,~,~]=my_ols(Curvature_demean(1:end-1,1),Curvature_demean(2:end,1));
    phi_curvature=curvature_beta(1,1);

    Level_forecast(1,1)=uncondi_mean_level+phi_level*(Level(end,1)-uncondi_mean_level);
    Slope_forecast(1,1)=uncondi_mean_slope+phi_slope*(Slope(end,1)-uncondi_mean_slope);
    Curvature_forecast(1,1)=uncondi_mean_curvature+phi_curvature*(Curvature(end,1)-uncondi_mean_curvature);
    
    for ii=2:60
        Level_forecast(ii,1)=uncondi_mean_level+phi_level*(Level_forecast(ii-1,1)-uncondi_mean_level);
        Slope_forecast(ii,1)=uncondi_mean_slope+phi_slope*(Slope_forecast(ii-1,1)-uncondi_mean_slope);
        Curvature_forecast(ii,1)=uncondi_mean_curvature+phi_curvature*(Curvature_forecast(ii-1,1)-uncondi_mean_curvature);
    end   
    
    forecast_LSC=[Level_forecast,Slope_forecast,Curvature_forecast];
    
         if i <193 % h=12M
            y_h12(i,:)=CC*forecast_LSC(12,:)';
         end
end

%  RMSFE DL: Mat=[3,6,9,12,15,18,21,24,30,36,48,60,72,84,96,108,120];
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
% rmsfe_display_DNS_h12=[Mat;rmsfe_h12_display] %

%% DL h=24M 
y_h24=zeros(192,17); yield_actual=yield_original(290:481,1:18);

for i=1:192
    
    Level=[];Slope=[];Curvature=[];
    Level=NS_h24(1:end-192+i,2); Slope=NS_h24(1:end-192+i,3); Curvature=NS_h24(1:end-192+i,4); % 1992M1
    
    Level_forecast=[];Slope_forecast=[];Curvature_forecast=[];
    
    level_reg=fitlm(Level(1:end-1,1),Level(2:end,1));
    mu_l=level_reg.Coefficients.Estimate(1,1);
    phi_l=level_reg.Coefficients.Estimate(2,1);
    uncondi_mean_level=mu_l/(1-phi_l);
    
    slope_reg=fitlm(Slope(1:end-1,1),Slope(2:end,1));
    mu_s=slope_reg.Coefficients.Estimate(1,1);
    phi_s=slope_reg.Coefficients.Estimate(2,1);
    uncondi_mean_slope=mu_s/(1-phi_s);
    
    curvature_reg=fitlm(Curvature(1:end-1,1),Curvature(2:end,1));
    mu_c=curvature_reg.Coefficients.Estimate(1,1);
    phi_c=curvature_reg.Coefficients.Estimate(2,1);
    uncondi_mean_curvature=mu_c/(1-phi_c); 
    
    Level_demean=Level-uncondi_mean_level*ones(size(Level,1),1);
    [level_beta,~,~,~,~]=my_ols(Level_demean(1:end-1,1),Level_demean(2:end,1));
    phi_level=level_beta(1,1);
    Slope_demean=Slope-uncondi_mean_slope*ones(size(Slope,1),1);
    [slope_beta,~,~,~,~]=my_ols(Slope_demean(1:end-1,1),Slope_demean(2:end,1));
    phi_slope=slope_beta(1,1);
    Curvature_demean=Curvature-uncondi_mean_curvature*ones(size(Curvature,1),1);
    [curvature_beta,~,~,~,~]=my_ols(Curvature_demean(1:end-1,1),Curvature_demean(2:end,1));
    phi_curvature=curvature_beta(1,1);

    Level_forecast(1,1)=uncondi_mean_level+phi_level*(Level(end,1)-uncondi_mean_level);
    Slope_forecast(1,1)=uncondi_mean_slope+phi_slope*(Slope(end,1)-uncondi_mean_slope);
    Curvature_forecast(1,1)=uncondi_mean_curvature+phi_curvature*(Curvature(end,1)-uncondi_mean_curvature);
    
    for ii=2:60
        Level_forecast(ii,1)=uncondi_mean_level+phi_level*(Level_forecast(ii-1,1)-uncondi_mean_level);
        Slope_forecast(ii,1)=uncondi_mean_slope+phi_slope*(Slope_forecast(ii-1,1)-uncondi_mean_slope);
        Curvature_forecast(ii,1)=uncondi_mean_curvature+phi_curvature*(Curvature_forecast(ii-1,1)-uncondi_mean_curvature);
    end   
    
    forecast_LSC=[Level_forecast,Slope_forecast,Curvature_forecast];
    
         if i <193 % h=24M
            y_h24(i,:)=CC*forecast_LSC(24,:)';
         end
end


%  RMSFE DL: Mat=[3,6,9,12,15,18,21,24,30,36,48,60,72,84,96,108,120];
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
% rmsfe_display_DNS_h24=[Mat;rmsfe_h24_display] %
%% Save the results
Rec_DNS_JAE=For_result_save_JAE(y_h6,y_h12,y_h24);
save('.\Results\Rec_DNS_JAE','Rec_DNS_JAE');