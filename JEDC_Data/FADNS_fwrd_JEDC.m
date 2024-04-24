%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% Forecasting the yield curve with FADNS_fwrd (only forward-looking principal components)
%%%%%%%%%%%%%%% DNS model for Nelson-Siegel factors given lambda = 0.0609 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Forecast horizions: h = 1, 2, 4, 8, 12, 16, 20 quarters ahead
% For h = 1 quarter, 2003Q1-2022Q2, total 78 quarters
% For h = 2 quarters, 2003Q2-2022Q2, total 77 quarters
% For h = 4 quarters, 2003Q4-2022Q2, total 75 quarters
% For h = 8 quarters, 2004Q4-2022Q2, total 71 quarters
% For h = 12 quarters, 2005Q4-2022Q2, total 67 quarters
% For h = 16 quarters, 2006Q4-2022Q2, total 63 quarters
% For h = 20 quarters, 2007Q4-2022Q2, total 59 quarters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;
% cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JEDC_Data'
% 
% addpath(genpath('./Data'));
% addpath(genpath('./Functions'));

%% Quarterly averages of daily zero coupon yields released by Bloomberg: IYC
data_yield=xlsread('Yield_Curve_Bloomberg','quarter_ave','A14:Q135');  % 1992Q1-2022Q2,3M,6M,12M,24M,36M,48M,60M,72M,84M,96M,108M,120M,180M,240M,360M
dates=1992+1/4:1/4:2022+2/4; 
yield = data_yield(:,3:end);
maturities = [3;6;12;24;36;48;60;72;84;96;108;120;180;240;360];  % Cast to a column vector
%% DNS estimation with two-step method
lambda0 = 0.0609; % 0.0609 as in Fernandes and Vieira (2019,JEDC)
Loading = [ones(size(maturities)) (1-exp(-lambda0*maturities))./(lambda0*maturities) ...
    ((1-exp(-lambda0*maturities))./(lambda0*maturities)-exp(-lambda0*maturities))];

NS = zeros(size(yield,1),3);

for i = 1:size(yield,1)
    EstMdlOLS = fitlm(Loading,yield(i,:),'Intercept',false);
    NS(i,:) = EstMdlOLS.Coefficients.Estimate';
end


%% Forward looking variables loading

% Forward data: mainly Survey of Professional Forecasts (SPF)
SPF_Financial = xlsread('Data_all_forward','Financial'); % 1992Q1-2023Q4: Detrend
SPF_Inflation = xlsread('Data_all_forward','Inflation'); % 1991Q4-2023Q4
SPF_Real = xlsread('Data_all_forward','Real activity');  % 1989Q1-2023Q4, two dngdp6: column 18 and 25


%% Recursive window
y_h1 = zeros(78,15); % 2003Q1-2022Q2, 3M,6M,12M,24M,36M,48M,60M,72M,84M,96M,108M,120M,180M,240M,360M
y_h2 = zeros(77,15); % 2003Q2-2022Q2, 3M,6M,12M,24M,36M,48M,60M,72M,84M,96M,108M,120M,180M,240M,360M
y_h4 = zeros(75,15); % 2003Q4-2022Q2, 3M,6M,12M,24M,36M,48M,60M,72M,84M,96M,108M,120M,180M,240M,360M
y_h8 = zeros(71,15); % 2004Q4-2022Q2, 3M,6M,12M,24M,36M,48M,60M,72M,84M,96M,108M,120M,180M,240M,360M
y_h12 = zeros(67,15); % 2005Q4-2022Q2, 3M,6M,12M,24M,36M,48M,60M,72M,84M,96M,108M,120M,180M,240M,360M
y_h16 = zeros(63,15); % 2006Q4-2022Q2, 3M,6M,12M,24M,36M,48M,60M,72M,84M,96M,108M,120M,180M,240M,360M
y_h20 = zeros(59,15); % 2007Q4-2022Q2, 3M,6M,12M,24M,36M,48M,60M,72M,84M,96M,108M,120M,180M,240M,360M


for i=1:78
    i
    
    %% 
        % Detrend
        SPF_Financial_whole = nan(43+i,8);  %1992Q1-2002Q4
        for j=1:4
            SPF_Financial_whole(:,j)=detrend_linear(SPF_Financial(94:136+i,j+2)); %1992Q1-2002Q4
        end

       for j=5:8
            SPF_Financial_med=detrend_linear(SPF_Financial(52:136+i,j+2)); % 1981Q3-2002Q4
            SPF_Financial_whole(:,j)=SPF_Financial_med(43:end,:); % 1992Q1-2022Q2
       end

      % Demean
         SPF_Inflation_med = SPF_Inflation(1:136+i,3:end)- nanmean(SPF_Inflation(1:136+i,3:end)); % 1968Q4-2002Q4
         SPF_Inflation_whole = SPF_Inflation_med(94:end,:); % 1992Q1-2002Q4

     % Real activity
      SPF_Real_whole = nan(43+i,27); % 1992Q1-2002Q4

      % Demean
      SPF_Real_med_1=SPF_Real(1:136+i,[3:9,11,14:16,18:21,23,27:30])-nanmean(SPF_Real(1:136+i,[3:9,11,14:16,18:21,23,27:30])); % 1968Q4-2002Q4

      % First difference
      SPF_Real_med_2=nan(43+i,2); % 1992Q1-2002Q4
      SPF_Real_med_2(:,1) = SPF_Real(94:136+i,10)-SPF_Real(93:135+i,10); % Unemployment rate, 4-quarter ahead (pp, sa): UNEMP6
      SPF_Real_med_2(:,2) = SPF_Real(94:136+i,12)-SPF_Real(93:135+i,12); % Unemployment rate, 3-quarter ahead (pp, sa): UNEMP5

      % Detrend 
      SPF_Real_med_3=detrend_linear(SPF_Real(58:136+i,13)); % Nominal GDP growth, average of current year (annual rate, sa): dngdpA
      SPF_Real_med_4=detrend_linear(SPF_Real(1:136+i,24)); % Nominal GDP growth, 3-quarter ahead (QoQ, sa): dngdp5


    SPF_Real_whole=[SPF_Real(94:136+i,[17,22,26]),SPF_Real_med_1(94:end,:),SPF_Real_med_2,SPF_Real_med_3(37:end,1),SPF_Real_med_4(94:end,1)];

    
   %%  extract the first two principal components of the forward-looking variables with pca 
    In_sample_whole = [SPF_Financial_whole,SPF_Inflation_whole,SPF_Real_whole]; % 1992Q1-2002Q4
    
    %
    In_sample_whole_std=PC_std(In_sample_whole,46);

    mcov=In_sample_whole_std*In_sample_whole_std';
    [V{43+i},D{43+i}] = eig(mcov);
    if D{43+i}(end,end)-D{43+i}(1,1)>0;
       Vhat=[V{43+i}(:,43+i) V{43+i}(:,43+i-1) ];
    else
        Vhat=V{43+i}(:,1:2);
    end
    Fhat=((43+i)^(0.5))*Vhat;
    Dhat=((43+i)^(0.5))*In_sample_whole_std'*Vhat;
       
        
    [pc,score] = pca(In_sample_whole_std);
    pc=((43+i)^(0.5))*pc;
    score=((43+i)^(0.5))*score;

    for ii=1:2;
        if (score(1,ii)/Fhat(1,ii))>0;
        Fhat(:,ii)=1*Fhat(:,ii);
        else
            Fhat(:,ii)=-1*Fhat(:,ii);
        end
    end
    
    
     
    factor_all=[NS(1:43+i,:),Fhat(:,[1,2])]; % Nelson-Siegel factor and the first two principal components
    
   %% VAR(1) estimation with quasi-maximum likelihood method
   md1 = varm(5,1);
   [EstMdl, EstStdErrors, LLF, Innovations]= estimate(md1,factor_all,'Display', 'off');
%    disp('Estimated AR Coefficients:');
%    disp(EstMdl.AR{1,1});
%    disp('Estimated Constant:')
%    disp(EstMdl.Constant)
   
    mu_all=EstMdl.Constant;
    phi_all=EstMdl.AR{1,1};
    
    %%
    
    if i <79 % h=1
        forecast_h1_all=mu_all+phi_all*factor_all(end,:)';
        y_h1(i,:)=Loading*forecast_h1_all(1:3,1);
    end
        
    
    if i <78 % h=2
        forecast_h2_all=mu_all+phi_all*mu_all+(phi_all^2)*factor_all(end,:)';
        y_h2(i,:)=Loading*forecast_h2_all(1:3,1);
    end    
    
    
    if i <76 % h=4
        forecast_h4_all=mu_all+(phi_all+phi_all^2+phi_all^3)*mu_all+(phi_all^4)*factor_all(end,:)';
        y_h4(i,:)=Loading*forecast_h4_all(1:3,1);
    end     
    
    
    if i <72 % h=8
        forecast_h8_all=mu_all+(phi_all+phi_all^2+phi_all^3+phi_all^4+phi_all^5+phi_all^6+phi_all^7)*mu_all+(phi_all^8)*factor_all(end,:)';
        y_h8(i,:)=Loading*forecast_h8_all(1:3,1);
    end 
    
    
    if i <68 % h=12
        forecast_h12_all=mu_all+(phi_all+phi_all^2+phi_all^3+phi_all^4+phi_all^5+phi_all^6+...
            +phi_all^7+phi_all^8+phi_all^9+phi_all^10+phi_all^11)*mu_all+(phi_all^12)*factor_all(end,:)'; 
        y_h12(i,:)=Loading*forecast_h12_all(1:3,1);
    end     
    
    
    if i <64 % h=16
        forecast_h16_all=mu_all+(phi_all+phi_all^2+phi_all^3+phi_all^4+phi_all^5+phi_all^6+...
            +phi_all^7+phi_all^8+phi_all^9+phi_all^10+phi_all^11+phi_all^12+phi_all^13+phi_all^14+...
            phi_all^15)*mu_all+(phi_all^16)*factor_all(end,:)'; 
        y_h16(i,:)=Loading*forecast_h16_all(1:3,1);
    end  
    
    
    if i <60 % h=20
        forecast_h20_all=mu_all+(phi_all+phi_all^2+phi_all^3+phi_all^4+phi_all^5+phi_all^6+...
            +phi_all^7+phi_all^8+phi_all^9+phi_all^10+phi_all^11+phi_all^12+phi_all^13+phi_all^14+...
            phi_all^15+phi_all^16+phi_all^17+phi_all^18+phi_all^19)*mu_all+(phi_all^20)*factor_all(end,:)'; 
        y_h20(i,:)=Loading*forecast_h20_all(1:3,1);
    end     
    
    
end


%%  Forecasting results
Rec_FADNS_fwrd=For_result_save(y_h1,y_h2,y_h4,y_h8,y_h12,y_h16,y_h20);
save('.\Results\Rec_FADNS_fwrd','Rec_FADNS_fwrd');
