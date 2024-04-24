%% DNS: Recursive scheme, lambda is estimated by MLE method
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
%%
y_h6=zeros(36,6); y_h12=zeros(36,6); y_h24=zeros(36,6);
y_h36=zeros(36,6); y_h48=zeros(36,6); y_h60=zeros(36,6);


for i=1:90
    i
   bdraw0=[0.0609 0.0001]';
   Mt=[3,12,24,36,48,60];
   
   X_mle=[]; Phi=[];mu=[];Phi_Q_mle=[];B_1_mle=[];
   [bdraw_mle,mu,Phi,Omiga,Phi_Q_mle,B_1_mle,sigma,X_mle,VCV,Y_bar_mle,mu_std,Phi_std] = step_3_Q(Y(1:745+i,:)',Mt,bdraw0);
   b = factorloading(Mt,Phi_Q_mle,B_1_mle); % 3 by length(Mt)
   b = b.b';                                % b is length(Mt) by 3 matrix,i.e., 6 by 3
   
    Level=[];Slope=[];Curvature=[];
    Level=X_mle(1,:)'; Slope=X_mle(2,:)'; Curvature=X_mle(3,:)';
   
    Level_forecast=zeros(60,1);Slope_forecast=zeros(60,1); Curvature_forecast=zeros(60,1);
    
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

%%  Save the results
Rec_DNS=For_result_save(y_h6,y_h12,y_h24,y_h36,y_h48,y_h60);
save('.\Results\Rec_DNS','Rec_DNS')  