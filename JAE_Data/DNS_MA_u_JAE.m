% DNS_MA
clear all; close all; clc;
% cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JAE_Data'
% 
% addpath(genpath('./Data'));
% addpath(genpath('./Functions'));
%% Load data
yield_original=importdata("UnsmFB_70-09.txt");

%% IP growth rate, CPI inflation data
% Percentage: (ln(index_t)-ln(index_t-12))*100
data_macro_original=xlsread('Macro_variables','IPG_CPI','B2:D806');
data_cpi=data_macro_original(:,3);
data_ipg=data_macro_original(:,2);

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

%% DNS_MA h=6M
y_h6=zeros(192,17); yield_actual=yield_original(290:481,1:18);

for i=1:192
    
    Level=[];Slope=[];Curvature=[];
    Level=NS_h6(1:end-192+i,2); Slope=NS_h6(1:end-192+i,3); Curvature=NS_h6(1:end-192+i,4); % 1993M7开始
    
    
    factor_all=[Level,Slope,Curvature,data_cpi(392:493+i,1),data_ipg(392:493+i,1)];
    
    [mu_all,phi_all]=VAR_1_ALL(factor_all);
    

         if i <193 % h=6M
            forecast_h6_all=mu_all+(phi_all+phi_all^2+phi_all^3+phi_all^4+phi_all^5)*mu_all+(phi_all^6)*factor_all(end,:)'; 
            y_h6(i,:)=CC*forecast_h6_all(1:3,:);
         end
end


%  RMSFE DNS_MA: Mat=[3,6,9,12,15,18,21,24,30,36,48,60,72,84,96,108,120];
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
% rmsfe_display_DNS_MA_h6=[Mat;rmsfe_h6_display]


%% DNS_MA h=12M  
y_h12=zeros(192,17); yield_actual=yield_original(290:481,1:18);

for i=1:192
    
    Level=[];Slope=[];Curvature=[];
    Level=NS_h12(1:end-192+i,2); Slope=NS_h12(1:end-192+i,3); Curvature=NS_h12(1:end-192+i,4); % 1993M1开始
    
    factor_all=[Level,Slope,Curvature,data_cpi(392:487+i,1),data_ipg(392:487+i,1)];
    
    [mu_all,phi_all]=VAR_1_ALL(factor_all);
    
         if i <193 % h=12M
             
            forecast_h12_all=mu_all+(phi_all+phi_all^2+phi_all^3+phi_all^4+phi_all^5+phi_all^6+...
            +phi_all^7+phi_all^8+phi_all^9+phi_all^10+phi_all^11)*mu_all+(phi_all^12)*factor_all(end,:)';              
            y_h12(i,:)=CC*forecast_h12_all(1:3,1);
         end
end


%  RMSFE DNS_MA: Mat=[3,6,9,12,15,18,21,24,30,36,48,60,72,84,96,108,120];
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
% rmsfe_display_DNS_MA_h12=[Mat;rmsfe_h12_display] 

%% DNS_MA h=24M  
y_h24=zeros(192,17); yield_actual=yield_original(290:481,1:18);

for i=1:192
    
    Level=[];Slope=[];Curvature=[];
    Level=NS_h24(1:end-192+i,2); Slope=NS_h24(1:end-192+i,3); Curvature=NS_h24(1:end-192+i,4); % 1992M1开始
    
    
    factor_all=[Level,Slope,Curvature,data_cpi(392:475+i,1),data_ipg(392:475+i,1)];
    
    [mu_all,phi_all]=VAR_1_ALL(factor_all);
    

         if i <193 % h=24M
            forecast_h12_all=mu_all+(phi_all+phi_all^2+phi_all^3+phi_all^4+phi_all^5+phi_all^6+...
            +phi_all^7+phi_all^8+phi_all^9+phi_all^10+phi_all^11)*mu_all+(phi_all^12)*factor_all(end,:)';              
            y_h24(i,:)=CC*forecast_h12_all(1:3,1);
         end
end

%  RMSFE DNS_MA: Mat=[3,6,9,12,15,18,21,24,30,36,48,60,72,84,96,108,120];
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
% rmsfe_display_DNS_MA_h24=[Mat;rmsfe_h24_display] 

%% Save the results
Rec_DNS_MA_u_JAE=For_result_save_JAE(y_h6,y_h12,y_h24);
save('.\Results\Rec_DNS_MA_u_JAE','Rec_DNS_MA_u_JAE');