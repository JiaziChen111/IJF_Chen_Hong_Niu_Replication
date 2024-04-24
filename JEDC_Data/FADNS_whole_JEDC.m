%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% Forecasting the yield curve with FADNS_Whole (whole macro-fin principal components)
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

%% Whole variables loading

% Forward data: mainly Survey of Professional Forecasts (SPF)
SPF_Financial = xlsread('Data_all_forward','Financial'); % 1992Q1-2023Q4: Detrend
SPF_Inflation = xlsread('Data_all_forward','Inflation'); % 1991Q4-2023Q4
SPF_Real = xlsread('Data_all_forward','Real activity');  % 1989Q1-2023Q4, two dngdp6: column 18 and 25

% Non forward data
non_fed = xlsread('Data_all_non_forward_new','Non_FED'); % 1968Q4-2023Q4

% GNP/GDP Price Index (QoQ, sa)
P = xlsread('Data_all_non_forward_new','P'); % 1947Q2-2023Q4, 2002Q4-2024Q1 

% Consumer Price Index Monthly (QoQ,sa)
cpi = xlsread('Data_all_non_forward_new','cpi'); % 1947Q2-2023Q3, 2002Q4-2023Q4

% Core Consumer Price Index (QoQ,sa)
pcpix = xlsread('Data_all_non_forward_new','pcpix'); % 1957Q2-2023Q3, 2002Q4-2023Q4

% Producer Price Index, Finished Goods (QoQ, sa)
pppi = xlsread('Data_all_non_forward_new','pppi'); % 1947Q3-2023Q3, 2002Q4-2023Q4

% Core Producer Price Index, Finished Goods (QoQ,sa)
pppix = xlsread('Data_all_non_forward_new','pppix'); % 1974Q2-2023Q3, 2002Q4-2023Q4

% Real GNP/GDP (QoQ,sa)
ROUTPUT = xlsread('Data_all_non_forward_new','ROUTPUT'); % 1947Q2-2023Q3, 2002Q4-2023Q4

% Real Personal Consumption Expenditure (QoQ,sa)
RCON = xlsread('Data_all_non_forward_new','RCON'); % 1947Q2-2023Q3, 2002Q4-2023Q4

% Nonresidential Domestic Investment (QoQ,sa)
rinvbf = xlsread('Data_all_non_forward_new','rinvbf'); % 1947Q2-2023Q3, 2002Q4-2023Q4

% Residential Domestic Investment (QoQ, sa)
rinvresid = xlsread('Data_all_non_forward_new','rinvresid'); % 1947Q2-2023Q3, 2002Q4-2023Q4

% Change in Inventories to GDP (pp, sa)
rinvchi = xlsread('Data_all_non_forward_new','rinvchi'); % 1947Q1-2023Q3, 2002Q4-2023Q4

% Real Exports of Goods and Services (QoQ,sa)
REX = xlsread('Data_all_non_forward_new','REX'); % 1947Q2-2023Q3, 2002Q4-2023Q4

% Real Imports of Goods and Services (QoQ,sa)
RIMP = xlsread('Data_all_non_forward_new','RIMP'); % 1947Q2-2023Q3, 2002Q4-2023Q4

% Real Government Consumption Expenditures & Gross Investments (QoQ,sa)
RG = xlsread('Data_all_non_forward_new','RG'); % 1947Q2-2023Q3, 2002Q4-2023Q4

% Nominal GNP/GDP (QoQ,sa)
NOUTPUT = xlsread('Data_all_non_forward_new','NOUTPUT'); % 1947Q2-2023Q3, 2002Q4-2023Q4

% Nominal Personal Consumption Expenditures (QoQ,sa)
ncon = xlsread('Data_all_non_forward_new','ncon'); % 1947Q2-2023Q3, 2002Q4-2023Q4

% Wage and Salary Disbursements (QoQ, sa)
wsd = xlsread('Data_all_non_forward_new','wsd'); % 1947Q2-2023Q3, 2002Q4-2023Q4

% Other Labor Income/Supplements to Wages ans Sal (QoQ, sa)
oli = xlsread('Data_all_non_forward_new','oli'); % 1947Q2-2023Q3, 2002Q4-2023Q4

% Nominal Personal Saving (QoQ,sa)
npsav = xlsread('Data_all_non_forward_new','npsav'); % 1947Q2-2023Q3, 2002Q4-2023Q4

% Personal Saving Rate to Disposable Personal Income (pp, sa)
ratesav = xlsread('Data_all_non_forward_new','ratesav'); % 1947Q2-2023Q3, 2002Q4-2024Q1

% Output Per Hour of All Persons: Business Sector (QoQ, sa)
OPH = xlsread('Data_all_non_forward_new','OPH'); % 1947Q2-2023Q3, 2002Q4-2023Q4

% Civilian Rate of Unemployment (pp, quarterly average)
ruc = xlsread('Data_all_non_forward_new','ruc'); % 1948Q1-2023Q3, 2002Q4-2023Q4

% Civilian Labor Force, 16+ （QoQ,sa)
lfc = xlsread('Data_all_non_forward_new','lfc'); % 1948Q2-2023Q3, 2002Q4-2023Q4

% Civilian Labor Force Participation Rate to Noninstitutional Pop (pp,sa)
lfpart = xlsread('Data_all_non_forward_new','lfpart'); % 1948Q2-2023Q3, 2002Q4-2023Q4

% Change Nonfarm Payroll (quarterly average, sa): 
employ = xlsread('Data_all_non_forward_new','employ'); % 1948Q1-2023Q3, 2002Q4-2023Q4

% Total Aggregate Weekly Hours (QoQ, sa)
h = xlsread('Data_all_non_forward_new','h'); % 1964Q2-2023Q3, 2002Q4-2023Q4

% Industrial Production Index (QoQ, sa)
ipt = xlsread('Data_all_non_forward_new','ipt'); % 1947Q2-2023Q3, 2002Q4-2023Q4

% Manufacturing Capacity Utilization Rate (pp, sa)
cum = xlsread('Data_all_non_forward_new','cum'); % 1948Q2-2023Q3, 2002Q4-2023Q4

% Housing Starts (QoQ, sa)
hstarts = xlsread('Data_all_non_forward_new','hstarts'); % 1959Q2-2023Q3, 2002Q4-2023Q4

% M1 Measure of the Money Stock (YoY)
m1 = xlsread('Data_all_non_forward_new','m1'); % 1960Q1-2023Q3, 2002Q4-2023Q4

% M2 Measure of the Money Stock (YoY)
m2 = xlsread('Data_all_non_forward_new','m2'); % 1960Q1-2023Q3, 2002Q4-2023Q4


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
            SPF_Financial_whole(:,j)=SPF_Financial_med(43:end,:); % 1992Q1-2002Q4
       end

      % Demean
         %SPF_Inflation_whole = nan(43+i,11); % 1992Q1-2002Q4
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

    % demean
    non_fed_med_1 = non_fed(1:136+i,7:8)-nanmean(non_fed(1:136+i,7:8));
    % first difference
    non_fed_med_2 = non_fed(94:136+i,9:11)-non_fed(93:135+i,9:11);

    non_fed_whole = [non_fed(94:136+i,3:6),non_fed_med_1(94:136+i,:),non_fed_med_2(:,[1,2]),non_fed_med_2(:,3)/1000]; % Initial Jobless Claims ( thousands)


   FED_whole = [P(180:222+i,i+1),cpi(180:222+i,i+1),pcpix(140:182+i,i+1),pppi(179:221+i,i+1),pppix(72:114+i,i+1),ROUTPUT(180:222+i,i+1),RCON(180:222+i,i+1),...
        rinvbf(180:222+i,i+1),rinvresid(180:222+i,i+1),rinvchi(181:223+i,i+1),REX(180:222+i,i+1),RIMP(180:222+i,i+1),RG(180:222+i,i+1),...
        NOUTPUT(180:222+i,i+1),ncon(180:222+i,i+1),wsd(180:222+i,i+1),oli(180:222+i,i+1),npsav(180:222+i,i+1),ratesav(180:222+i,i+1),...
        OPH(180:222+i,i+1),ruc(177:219+i,i+1),lfc(176:218+i,i+1), lfpart(176:218+i,i+1),employ(177:219+i,i+1),h(112:154+i,i+1),...
        ipt(180:222+i,i+1),cum(176:218+i,i+1),hstarts(132:174+i,i+1),m1(129:171+i,i+1),m2(129:171+i,i+1)]; % 1992Q1-2002Q4   
    
   %%  extract the first two principal components of the forward-looking variables with pca 
    In_sample_whole = [SPF_Financial_whole,SPF_Inflation_whole,SPF_Real_whole,non_fed_whole,FED_whole]; % 1992Q1-2002Q4
    
    %
    In_sample_whole_std=PC_std(In_sample_whole,85);

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
Rec_FADNS_whole=For_result_save(y_h1,y_h2,y_h4,y_h8,y_h12,y_h16,y_h20);
save('.\Results\Rec_FADNS_whole','Rec_FADNS_whole');
