% Replication of Van Dijk et al.(2014, JAE): FORECASTING INTEREST RATES WITH SHIFTING ENDPOINTS
% RZIG
clear all; close all; clc;
% cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JAE_Data'
% 
% addpath(genpath('./Data'));
% addpath(genpath('./Functions'));
%% Load data
yield_original=importdata("UnsmFB_70-09.txt");
RLZcpi=importdata("RLZcpi.txt");
RLZip=importdata("RLZip.txt");
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

%% RZIG h=6M 
y_h6=zeros(192,17); yield_actual=yield_original(290:481,1:18);
alpha=0.01;% monthly inflation and growth are quite noisy,set the exponential smoothing parameter to 0.01

for i=1:192
    
    Level=[];Slope=[];Curvature=[];
    Level=NS_h6(1:end-192+i,2); Slope=NS_h6(1:end-192+i,3); Curvature=NS_h6(1:end-192+i,4); % 1993M7开始
    
    % real-time exponentially smoothed realized inflation
    esi_history=[];
    esi_history=exp_smooth(RLZcpi(3:114+i,19+i),alpha); % 1st sample: vintage 1993M7, 1984M2-1993M6
    esi_history=esi_history(12:end,1); %1985M1
    phi_es_t=alpha*RLZcpi(114+i,19+i)+(1-alpha)*esi_history(end,1); % phi^ES
    esi_history=[esi_history; phi_es_t];
    
   % real-time exponentially smoothed realized IP growth
    esg_history=[];
    esg_history=exp_smooth(RLZip(3:114+i,19+i),alpha); % 1st sample: vintage 1993M7, 1984M2-1993M6
    esg_history=esg_history(12:end,1); %1985M1
    gamma_es_t=alpha*RLZip(114+i,19+i)+(1-alpha)*esg_history(end,1); % gamma^ES
    esg_history=[esg_history; gamma_es_t];
    
    %theta_0,1 and theta_1,1
    equation_9=fitlm(esi_history,Level);
    cpi_coef=equation_9.Coefficients.Estimate;
    esi_mean=[1,phi_es_t]*cpi_coef;
    level_mean_history=[ones(size(esi_history,1),1),esi_history]*cpi_coef;
    
    %theta_0,2 and theta_1,2
    equation_10=fitlm(esg_history,Slope);
    ip_coef=equation_10.Coefficients.Estimate;
    esg_mean=[1,gamma_es_t]*ip_coef;
    slope_mean_history=[ones(size(esg_history,1),1),esg_history]*ip_coef;   
    
    % 
    Level_demean=[]; 
    Level_demean=Level-level_mean_history;
    [phi_level_orig,~,~,~,~]=my_ols(Level_demean(1:end-1,1),Level_demean(2:end,1));
    phi_level=phi_level_orig(1,1);

    % 
    Slope_demean=[]; 
    Slope_demean=Slope-slope_mean_history;
    [phi_slope_orig,~,~,~,~]=my_ols(Slope_demean(1:end-1,1),Slope_demean(2:end,1));
    phi_slope=phi_slope_orig(1,1);    
    
    % 
    Level_forecast=zeros(60,1);Slope_forecast=zeros(60,1); Curvature_forecast=zeros(60,1);
     
    % 
    Level_forecast(1,1)=esi_mean+phi_level*(Level(end,1)-esi_mean);
    Slope_forecast(1,1)=esg_mean+phi_slope*(Slope(end,1)-esg_mean);
    
    for ii=2:60
        Level_forecast(ii,1)=esi_mean+phi_level*(Level_forecast(ii-1,1)-esi_mean);
        Slope_forecast(ii,1)=esg_mean+phi_slope*(Slope_forecast(ii-1,1)-esg_mean);
    end
    
    % 
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
    
         if i <193 % h=6M
            y_h6(i,:)=CC*forecast_LSC(6,:)';
         end
         
end

%  RMSFE RZIG: Mat=[3,6,9,12,15,18,21,24,30,36,48,60,72,84,96,108,120];
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
% rmsfe_display_RZIG_h6=[Mat;rmsfe_h6_display] %

%% RZIG h=12M 
y_h12=zeros(192,17); yield_actual=yield_original(290:481,1:18);
alpha=0.01;% monthly inflation and growth are quite noisy,set the exponential smoothing parameter to 0.01

for i=1:192
    
    Level=[];Slope=[];Curvature=[];
    Level=NS_h12(1:end-192+i,2); Slope=NS_h12(1:end-192+i,3); Curvature=NS_h12(1:end-192+i,4); % 1993M1
    
    %  real-time exponentially smoothed realized inflation
    esi_history=[];
    esi_history=exp_smooth(RLZcpi(3:108+i,13+i),alpha); % 1st sample: vintage 1993M1, 1984M2-1992M12
    esi_history=esi_history(12:end,1); %1985M1
    phi_es_t=alpha*RLZcpi(108+i,13+i)+(1-alpha)*esi_history(end,1); %phi^ES
    esi_history=[esi_history; phi_es_t];
    
   % real-time exponentially smoothed realized IP growth
    esg_history=[];
    esg_history=exp_smooth(RLZip(3:108+i,13+i),alpha); % 1st sample: vintage 1993M1, 1984M2-1992M12
    esg_history=esg_history(12:end,1); %1985M1
    gamma_es_t=alpha*RLZip(108+i,13+i)+(1-alpha)*esg_history(end,1); %gamma^ES
    esg_history=[esg_history; gamma_es_t];
    
    % theta_0,1 and theta_1,1
    equation_9=fitlm(esi_history,Level);
    cpi_coef=equation_9.Coefficients.Estimate;
    esi_mean=[1,phi_es_t]*cpi_coef;
    level_mean_history=[ones(size(esi_history,1),1),esi_history]*cpi_coef;
    
    %theta_0,2 and theta_1,2
    equation_10=fitlm(esg_history,Slope);
    ip_coef=equation_10.Coefficients.Estimate;
    esg_mean=[1,gamma_es_t]*ip_coef;
    slope_mean_history=[ones(size(esg_history,1),1),esg_history]*ip_coef;   
    
    % 
    Level_demean=[]; 
    Level_demean=Level-level_mean_history;
    [phi_level_orig,~,~,~,~]=my_ols(Level_demean(1:end-1,1),Level_demean(2:end,1));
    phi_level=phi_level_orig(1,1);

    % 
    Slope_demean=[]; 
    Slope_demean=Slope-slope_mean_history;
    [phi_slope_orig,~,~,~,~]=my_ols(Slope_demean(1:end-1,1),Slope_demean(2:end,1));
    phi_slope=phi_slope_orig(1,1);    
    
    % 
    Level_forecast=zeros(60,1);Slope_forecast=zeros(60,1); Curvature_forecast=zeros(60,1);
     
    %
    Level_forecast(1,1)=esi_mean+phi_level*(Level(end,1)-esi_mean);
    Slope_forecast(1,1)=esg_mean+phi_slope*(Slope(end,1)-esg_mean);
    
    for ii=2:60
        Level_forecast(ii,1)=esi_mean+phi_level*(Level_forecast(ii-1,1)-esi_mean);
        Slope_forecast(ii,1)=esg_mean+phi_slope*(Slope_forecast(ii-1,1)-esg_mean);
    end
    
    % 
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
    
         if i <193 % h=12M
            y_h12(i,:)=CC*forecast_LSC(12,:)';
         end
         
end

%  RMSFE RZIG: Mat=[3,6,9,12,15,18,21,24,30,36,48,60,72,84,96,108,120];
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
% rmsfe_display_RZIG_h12=[Mat;rmsfe_h12_display] %

%% RZIG h=24M 
y_h24=zeros(192,17); yield_actual=yield_original(290:481,1:18);
alpha=0.01;% monthly inflation and growth are quite noisy,set the exponential smoothing parameter to 0.01

for i=1:192
    
    Level=[];Slope=[];Curvature=[];
    Level=NS_h24(1:end-192+i,2); Slope=NS_h24(1:end-192+i,3); Curvature=NS_h24(1:end-192+i,4); % 1992M1开始
    
    % real-time exponentially smoothed realized inflation
    esi_history=[];
    esi_history=exp_smooth(RLZcpi(3:96+i,1+i),alpha); % 1st sample: vintage 1992M1, 1984M2-1991M12
    esi_history=esi_history(12:end,1); %1985M1
    phi_es_t=alpha*RLZcpi(96+i,1+i)+(1-alpha)*esi_history(end,1); % phi^ES
    esi_history=[esi_history; phi_es_t];
    
   % real-time exponentially smoothed realized IP growth
    esg_history=[];
    esg_history=exp_smooth(RLZip(3:96+i,1+i),alpha); % 1st sample: vintage 1992M1, 1984M2-1991M12
    esg_history=esg_history(12:end,1); %1985M1
    gamma_es_t=alpha*RLZip(96+i,1+i)+(1-alpha)*esg_history(end,1); % gamma^ES
    esg_history=[esg_history; gamma_es_t];
    
    %theta_0,1 and theta_1,1
    equation_9=fitlm(esi_history,Level);
    cpi_coef=equation_9.Coefficients.Estimate;
    esi_mean=[1,phi_es_t]*cpi_coef;
    level_mean_history=[ones(size(esi_history,1),1),esi_history]*cpi_coef;
    
    %简单ols计算式子（10）中的theta_0,2和theta_1,2
    equation_10=fitlm(esg_history,Slope);
    ip_coef=equation_10.Coefficients.Estimate;
    esg_mean=[1,gamma_es_t]*ip_coef;
    slope_mean_history=[ones(size(esg_history,1),1),esg_history]*ip_coef;   
    
    % phi_level
    Level_demean=[]; 
    Level_demean=Level-level_mean_history;
    [phi_level_orig,~,~,~,~]=my_ols(Level_demean(1:end-1,1),Level_demean(2:end,1));
    phi_level=phi_level_orig(1,1);

    % slope_level
    Slope_demean=[]; 
    Slope_demean=Slope-slope_mean_history;
    [phi_slope_orig,~,~,~,~]=my_ols(Slope_demean(1:end-1,1),Slope_demean(2:end,1));
    phi_slope=phi_slope_orig(1,1);    
    
    %
    Level_forecast=zeros(60,1);Slope_forecast=zeros(60,1); Curvature_forecast=zeros(60,1);
     
    %
    Level_forecast(1,1)=esi_mean+phi_level*(Level(end,1)-esi_mean);
    Slope_forecast(1,1)=esg_mean+phi_slope*(Slope(end,1)-esg_mean);
    
    for ii=2:60
        Level_forecast(ii,1)=esi_mean+phi_level*(Level_forecast(ii-1,1)-esi_mean);
        Slope_forecast(ii,1)=esg_mean+phi_slope*(Slope_forecast(ii-1,1)-esg_mean);
    end
    
    % Curvature
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
    
         if i <193 % h=24M
            y_h24(i,:)=CC*forecast_LSC(24,:)';
         end
         
end


%  RMSFE RZIG: Mat=[3,6,9,12,15,18,21,24,30,36,48,60,72,84,96,108,120];
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
% rmsfe_display_RZIG_h24=[Mat;rmsfe_h24_display] %
%% Save the results
Rec_RZIG_JAE=For_result_save_JAE(y_h6,y_h12,y_h24);
save('.\Results\Rec_RZIG_JAE','Rec_RZIG_JAE');