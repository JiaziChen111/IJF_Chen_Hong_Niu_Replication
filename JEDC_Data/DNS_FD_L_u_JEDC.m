%%  DNS_FD_L^u: lamda=0.0609
%   Level factor for semiparametric regression, Recursive scheme
%   1st subsample is 1992Q1-2002Q4, last subsample is 1992Q1-2022Q1
% clear all; close all; clc;
% cd 'D:\IJF_Chen_Hong_Niu_Replication\JEDC_Data'
% 
% addpath(genpath('./Data'));
% addpath(genpath('./Functions'));

%% load data
% Quarterly averages of daily zero coupon yields released by Bloomberg: IYC
data_yield=xlsread('Yield_Curve_Bloomberg','quarter_ave','A14:Q135');  % 1992Q1-2022Q2,3M,6M,12M,24M,36M,48M,60M,72M,84M,96M,108M,120M,180M,240M,360M
dates=1992+1/4:1/4:2022+2/4; 
yield = data_yield(:,3:end);
maturities = [3;6;12;24;36;48;60;72;84;96;108;120;180;240;360];  % Cast to a column vector

%demographic data
data_pop=xlsread('US_Age_Distribution_2022','actualpopulation_2022','A2:CI84'); % Age distribution, annully number, 1940.5-2022.5, 0-1,1-2,...,84-85,85+
pop_ann_num_dis = data_pop(1:83,1:87);%
time_ann = 1940.5:2022.5 ;% annually 
time_qua = 1940+2/4:1/4:2022+2/4;
for i= 1:86 %0-1,1-2,...,84-85,85+, total number: 86
pop_qua_num_dis(:,i) = interp1(time_ann,pop_ann_num_dis(:,1+i),time_qua); % linear interpolation
end
pop_qua_num_dis = [time_qua',pop_qua_num_dis];

for i=1:86
    for j=1:329
        pop_qua_dis(j,i)=pop_qua_num_dis(j,i+1)./sum(pop_qua_num_dis(j,2:end),2);
    end
end
%% CV results 
addpath(genpath('./Results'));
load 'Rec_CV_Level_JEDC.mat'
MHCV_L_DL=zeros(78,8);
for i=1:78
    MHCV_L_DL(i,:)=Rec_CV_Level_JEDC(2*i,:);
end

% CV_L_DL=xlsread('CV_selection_recursive_quarterly','Level_DL');
% MHCV_L_DL=zeros(78,8);
% for i=1:78
%     MHCV_L_DL(i,:)=CV_L_DL(2*i,4:11);
% end

%% integral approximation
s_86 = 0.5:1:85.5; % Middle age for each age interval,e.g.,0-1 is 0.5,...,84-85 is 84.5, and 85.5 for 85+
s_star_86 = s_86./85.5; %Park，Shin and Whang(2010,JoE), s_star in [0,1]
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

z_86=pop_qua_dis*phi_86';

z_86=[time_qua',z_86]; 
z_86_1992=z_86(208:end,:);% 1992Q1-2022Q2

%% Calculate Nelson-Siegel factor loadings, given lamda.
lamda=0.0609;
mat = 1:1:360; 
pNS1 = ones(1,360); 
pNS2 = zeros(1,360); 
pNS3 = zeros(1,360);
for imat = 1:360
    pNS2(imat) = (1 - exp(-lamda*imat))/(lamda*imat);
    pNS3(imat) = pNS2(imat) - exp(-lamda*imat);
end

% Nelson-Siegle Coefficients for yields:
Mat=[3,6,12,24,36,48,60,72,84,96,108,120,180,240,360];
CCw = [pNS1; pNS2; pNS3]'; %Coefficient matrix for all maturity 1:360
CC = CCw(Mat',:);

% Extract (Estimate) Nelson-Siegel factors for yields by OLS.
NS = ((CC'*CC)\eye(size(CC,2)))*CC'*yield';
NS=NS';
%%

y_h1 = zeros(78,15); % 2003Q1-2022Q2, 3M,6M,12M,24M,36M,48M,60M,72M,84M,96M,108M,120M,180M,240M,360M
y_h2 = zeros(77,15); % 2003Q2-2022Q2, 3M,6M,12M,24M,36M,48M,60M,72M,84M,96M,108M,120M,180M,240M,360M
y_h4 = zeros(75,15); % 2003Q4-2022Q2, 3M,6M,12M,24M,36M,48M,60M,72M,84M,96M,108M,120M,180M,240M,360M
y_h8 = zeros(71,15); % 2004Q4-2022Q2, 3M,6M,12M,24M,36M,48M,60M,72M,84M,96M,108M,120M,180M,240M,360M
y_h12 = zeros(67,15); % 2005Q4-2022Q2, 3M,6M,12M,24M,36M,48M,60M,72M,84M,96M,108M,120M,180M,240M,360M
y_h16 = zeros(63,15); % 2006Q4-2022Q2, 3M,6M,12M,24M,36M,48M,60M,72M,84M,96M,108M,120M,180M,240M,360M
y_h20 = zeros(59,15); % 2007Q4-2022Q2, 3M,6M,12M,24M,36M,48M,60M,72M,84M,96M,108M,120M,180M,240M,360M

for i=1:78
    i
    Level=[];Slope=[];Curvature=[];
    Level=NS(1:43+i,1); Slope=NS(1:43+i,2); Curvature=NS(1:43+i,3);
    
    
    % Level factor
    SP_L=[]; SP_L_trend=[];
     if MHCV_L_DL(i,8)==1; % Kappa=2
         SP_L=fitlm(z_86_1992(1:43+i,3),Level);
         SP_L_trend=SP_L.Fitted;
     elseif MHCV_L_DL(i,8)==2; % Kappa=3
         SP_L=fitlm(z_86_1992(1:43+i,3:4),Level);
         SP_L_trend=SP_L.Fitted;
         else MHCV_L_DL(i,8)==3; % Kappa=5
         SP_L=fitlm(z_86_1992(1:43+i,3:6),Level);
         SP_L_trend=SP_L.Fitted;   
     end

    Level_forecast=zeros(20,1);Slope_forecast=zeros(20,1); Curvature_forecast=zeros(20,1);
    L_demean=Level-SP_L_trend;
    L_phi_orig=my_ols(L_demean(1:end-1,1),L_demean(2:end,1));
    L_phi=L_phi_orig(1,1);

    Level_forecast(1,1)=SP_L_trend(end,1)+L_phi*(Level(end,1)-SP_L_trend(end,1));
    
    for ii=2:20
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
    
    for ii=2:20
        Slope_forecast(ii,1)=uncondi_mean_slope+phi_slope*(Slope_forecast(ii-1,1)-uncondi_mean_slope);
        Curvature_forecast(ii,1)=uncondi_mean_curvature+phi_curvature*(Curvature_forecast(ii-1,1)-uncondi_mean_curvature);
    end   
    
    forecast_LSC=[Level_forecast,Slope_forecast,Curvature_forecast];
   
         if i <79 % h=1Q
            y_h1(i,:)=CC*forecast_LSC(1,:)';
         end

         
          if i <78 % h=2Q
            y_h2(i,:)=CC*forecast_LSC(2,:)';
          end        
         

          if i <76 % h=4
            y_h4(i,:)=CC*forecast_LSC(4,:)';
          end   


          if i <72 % h=8
            y_h8(i,:)=CC*forecast_LSC(8,:)';
          end          
          

          if i <68 % h=12
            y_h12(i,:)=CC*forecast_LSC(12,:)';
          end          
          

          if i <64 % h=16
            y_h16(i,:)=CC*forecast_LSC(16,:)';
          end          
          

          if i <60 % h=20
            y_h20(i,:)=CC*forecast_LSC(20,:)';
          end          
                   
end


%%
Rec_DNS_FD_L_u=For_result_save(y_h1,y_h2,y_h4,y_h8,y_h12,y_h16,y_h20);
save('.\Results\Rec_DNS_FD_L_u','Rec_DNS_FD_L_u');
