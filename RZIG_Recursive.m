%% RZIG: Shifting Endpoints from Realized Measures: lamda is estimated by MLE method
%   Level factor and Slope factor  Recursive scheme
% 1st subsample is 1952:M6-1998:M11, last subsample is 1952:M6-2019:M3
clear all; close all; clc;
% cd 'Z:\User\IJF_Chen_Hong_Niu_Replication'
% 
% addpath(genpath('./Data'));
% addpath(genpath('./Functions'));
%% yield data
data_CRSP=xlsread('CRSP_monthly','Monthly');
yield=data_CRSP(1:805,:); % 3M,12M,24M,36M,48M,60M
Y=yield;
[T,N] = size(Y); % 805 by 6
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

%%
y_h3=zeros(245,6); y_h6=zeros(242,6); y_h12=zeros(236,6); y_h24=zeros(224,6);
y_h36=zeros(212,6); y_h48=zeros(200,6); y_h60=zeros(188,6);
alpha=0.01;% monthly inflation and growth are quite noisy,set the exponential smoothing parameter to 0.01

for i=1:245
    i
   bdraw0=[0.0609 0.0001]';
   Mt=[3,12,24,36,48,60];
   
   X_mle=[]; Phi=[];mu=[];Phi_Q_mle=[];B_1_mle=[];
   [bdraw_mle,mu,Phi,Omiga,Phi_Q_mle,B_1_mle,sigma,X_mle,VCV,Y_bar_mle,mu_std,Phi_std] = step_3_Q(Y(1:i+557,:)',Mt,bdraw0);
   b = factorloading(Mt,Phi_Q_mle,B_1_mle); % 3 by length(Mt)
   b = b.b';                                % b is length(Mt) by 3 matrix,i.e., 6 by 3
    
    Level=[];Slope=[];Curvature=[];
    Level=X_mle(1,:)'; Slope=X_mle(2,:)'; Curvature=X_mle(3,:)'; % ��1998M11��ʼ
    
    % Level factor and Slope factor
    if i < 18
    esi_history_orig=[];
    esi_history_orig=exp_smooth(data_cpi_stand(14:621+i,i+1),alpha); % month on month growth
    esi_history=esi_history_orig(53:end,1);
    phi_es_t=alpha*data_cpi_stand(621+i,i+1)+(1-alpha)*esi_history(end,1);
    esi_history=[esi_history; phi_es_t];
    else
     esi_history_orig=exp_smooth(data_cpi_stand(2:621+i,i+1),alpha); % month on month growth
     esi_history=esi_history_orig(65:end,1);
     phi_es_t=alpha*data_cpi_stand(621+i,i+1)+(1-alpha)*esi_history(end,1);
     esi_history=[esi_history; phi_es_t];
    end

     esg_history_orig=exp_smooth(data_ip_stand(2:621+i,i+1),alpha); % month on month growth
     esg_history=esg_history_orig(65:end,1);
     gamma_es_t=alpha*data_ip_stand(621+i,i+1)+(1-alpha)*esg_history(end,1);
     esg_history=[esg_history; gamma_es_t];
    
    
    x_cpi=[];
    x_cpi=[ones(557+i,1),esi_history];
    [cpi_coe_orig,~,~,~,~]=my_ols(x_cpi,Level);
    cpi_coe=cpi_coe_orig(1:2,1); %theta_0,1 �� theta_1,1
    esi_mean=[1,phi_es_t]*cpi_coe;
    level_mean_history=[ones(size(esi_history,1),1),esi_history]*cpi_coe;
    
    x_ip=[];
    x_ip=[ones(557+i,1),esg_history];
    [ip_coe_orig,~,~,~,~]=my_ols(x_ip,Slope);
    ip_coe=ip_coe_orig(1:2,1); %theta_0,2 �� theta_1,2
    esg_mean=[1,gamma_es_t]*ip_coe;
    slope_mean_history=[ones(size(esg_history,1),1),esg_history]*ip_coe;
    
    
   % ˮƽ����ȥʱ���ֵ�����phi_level�� ��ʽ�ӣ�3��
    Level_demean=[]; 
    Level_demean=Level-level_mean_history;
    [phi_level_orig,~,~,~,~]=my_ols(Level_demean(1:end-1,1),Level_demean(2:end,1));
    phi_level=phi_level_orig(1,1);

   % б������ȥʱ���ֵ�����phi_slope�� ��ʽ�ӣ�3��
    Slope_demean=[]; 
    Slope_demean=Slope-slope_mean_history;
    [phi_slope_orig,~,~,~,~]=my_ols(Slope_demean(1:end-1,1),Slope_demean(2:end,1));
    phi_slope=phi_slope_orig(1,1);    
    
    Level_forecast=zeros(60,1);Slope_forecast=zeros(60,1); Curvature_forecast=zeros(60,1);
  
    Level_forecast(1,1)=esi_mean+phi_level*(Level(end,1)-esi_mean);
    Slope_forecast(1,1)=esg_mean+phi_slope*(Slope(end,1)-esg_mean);
    
    for ii=2:60
        Level_forecast(ii,1)=esi_mean+phi_level*(Level_forecast(ii-1,1)-esi_mean);
        Slope_forecast(ii,1)=esg_mean+phi_slope*(Slope_forecast(ii-1,1)-esg_mean);
    end
 
    % Curvature, ʽ�ӣ�2��
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

%% Save the results
Rec_RZIG=For_result_save(y_h3,y_h6,y_h12,y_h24,y_h36,y_h48,y_h60);
save('.\Results\Rec_RZIG','Rec_RZIG');
