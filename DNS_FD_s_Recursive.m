%% DNS_FD_spanned: Recursive scheme   lambda is estimated by MLE method
% 1st subsample is 1952:M6-1998:M11, last subsample is 1952:M6-2019:M3
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
y_h3_trend=zeros(245,6); y_h6_trend=zeros(242,6); y_h12_trend=zeros(236,6); y_h24_trend=zeros(224,6);
y_h36_trend=zeros(212,6); y_h48_trend=zeros(200,6); y_h60_trend=zeros(188,6);
y_h3_cycle=zeros(245,6); y_h6_cycle=zeros(242,6); y_h12_cycle=zeros(236,6); y_h24_cycle=zeros(224,6);
y_h36_cycle=zeros(212,6); y_h48_cycle=zeros(200,6); y_h60_cycle=zeros(188,6);

for i=1:245
    i
    %Nonparametric regression, common
    YY=[];   zz_86_1952_common=[];
    %Nonparametric regression, Kappa=5, as in other model setup, e.g., DNS_FD_L_u and DNS_FD_LS_u
    YY=Y(1:557+i,:);  zz_86_1952_common=[z_86_1952(1:557+i,2:6);z_86_1952(1:557+i,2:6);z_86_1952(1:557+i,2:6);...
    z_86_1952(1:557+i,2:6);z_86_1952(1:557+i,2:6);z_86_1952(1:557+i,2:6)];
    YY_common=[]; YY_common=YY(:);
    SP_common_DNS=[];
    SP_common_DNS= fitlm(zz_86_1952_common(:,2:5),YY_common); % common
    SP_common_DNS_trend=z_86_1952(1:557+i,2:6)*SP_common_DNS.Coefficients.Estimate; % 557+i by 1
    SP_common_DNS_residual=[];
    SP_common_DNS_residual=Y(1:557+i,:)-SP_common_DNS_trend*ones(1,6);

        

   bdraw0=[0.0609 0.0001]';
   Mt=[3,12,24,36,48,60];
   
   X_mle=[]; Phi=[];mu=[];Phi_Q_mle=[];B_1_mle=[];
   [bdraw_mle,mu,Phi,Omiga,Phi_Q_mle,B_1_mle,sigma,X_mle,VCV,Y_bar_mle,mu_std,Phi_std] = step_3_Q( SP_common_DNS_residual',Mt,bdraw0);
   b = factorloading(Mt,Phi_Q_mle,B_1_mle); % 3 by length(Mt)
   b = b.b';                                % b is length(Mt) by 3 matrix,i.e., 6 by 3
 
    Level=[]; Slope=[]; Curvature=[];
    Level=X_mle(1,:)'; Slope=X_mle(2,:)'; Curvature=X_mle(3,:)';
   
    Level_forecast=zeros(60,1); Slope_forecast=zeros(60,1); Curvature_forecast=zeros(60,1);
    
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
   
     if i <246 % h=3M
            y_forcycle_h3=[]; y_fortrend_h3=[];
            y_forcycle_h3=b*forecast_LSC(3,:)';
            y_fortrend_h3=SP_common_DNS_trend(end,1)*ones(1,6);
            y_h3(i,:)=y_fortrend_h3+y_forcycle_h3';
            y_h3_trend(i,:)=y_fortrend_h3; y_h3_cycle(i,:)=y_forcycle_h3';
     end
        
     if i <243 % h=6M
            y_forcycle_h6=[]; y_fortrend_h6=[];
            y_forcycle_h6=b*forecast_LSC(6,:)';
            y_fortrend_h6=SP_common_DNS_trend(end,1)*ones(1,6);
            y_h6(i,:)=y_fortrend_h6+y_forcycle_h6';
            y_h6_trend(i,:)=y_fortrend_h6; y_h6_cycle(i,:)=y_forcycle_h6';
     end  
        if i<237 % h=12M
            y_forcycle_h12=[]; y_fortrend_h12=[];           
            y_forcycle_h12=b*forecast_LSC(12,:)';
            y_fortrend_h12=SP_common_DNS_trend(end,1)*ones(1,6);
            y_h12(i,:)=y_fortrend_h12+y_forcycle_h12';
            y_h12_trend(i,:)=y_fortrend_h12'; y_h12_cycle(i,:)=y_forcycle_h12';
        end
        
         if i<225 % h=24M
            y_forcycle_h24=[]; y_fortrend_h24=[];          
            y_forcycle_h24=b*forecast_LSC(24,:)';
            y_fortrend_h24=SP_common_DNS_trend(end,1)*ones(1,6);
            y_h24(i,:)=y_fortrend_h24+y_forcycle_h24';
            y_h24_trend(i,:)=y_fortrend_h24'; y_h24_cycle(i,:)=y_forcycle_h24';
         end   
         
         if i<213 % h=36M
            y_forcycle_h36=[]; y_fortrend_h36=[];
            y_forcycle_h36=b*forecast_LSC(36,:)';
            y_fortrend_h36=SP_common_DNS_trend(end,1)*ones(1,6);
            y_h36(i,:)=y_fortrend_h36+y_forcycle_h36';
            y_h36_trend(i,:)=y_fortrend_h36'; y_h36_cycle(i,:)=y_forcycle_h36';
         end     
         
         if i<201 % h=48M
            y_forcycle_h48=[]; y_fortrend_h48=[];
            y_forcycle_h48=b*forecast_LSC(48,:)';
            y_fortrend_h48=SP_common_DNS_trend(end,1)*ones(1,6);
            y_h48(i,:)=y_fortrend_h48+y_forcycle_h48';
            y_h48_trend(i,:)=y_fortrend_h48'; y_h48_cycle(i,:)=y_forcycle_h48';
         end   
        
         if i<189 % h=60M
            y_forcycle_h60=[]; y_fortrend_h60=[];
            y_forcycle_h60=b*forecast_LSC(60,:)';
            y_fortrend_h60=SP_common_DNS_trend(end,1)*ones(1,6);
            y_h60(i,:)=y_fortrend_h60+y_forcycle_h60';
            y_h60_trend(i,:)=y_fortrend_h60'; y_h60_cycle(i,:)=y_forcycle_h60';
        end     
   
   
   

end
    

%% Save the results
Rec_DNS_FD_s=For_result_save(y_h3,y_h6,y_h12,y_h24,y_h36,y_h48,y_h60);
save('.\Results\Rec_DNS_FD_s','Rec_DNS_FD_s');
