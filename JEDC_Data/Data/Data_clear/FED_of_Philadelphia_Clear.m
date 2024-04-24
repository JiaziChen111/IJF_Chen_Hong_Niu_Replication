%% FED of Philadelphia: Data clearing
% Following the appendix (Quarterly macroeconomic indicators) of the JEDC paper
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JEDC_Data\Data\Data_clear'
clear all; close all; clc;

addpath(genpath('./Functions'));
addpath(genpath('./Raw_data'));
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JEDC_Data\Data\Data_clear'
clear all; close all; clc;

addpath(genpath('./Functions'));
addpath(genpath('./Raw_data'));
%% (1) GNP/GDP Price Index (QoQ, sa): PQvQd
% 2002Q4-2024Q1
data_raw=xlsread('FED_of_Philadelphia','PQvQd'); % 

data_save_med=nan(307,86); % 2002Q4-2024Q1,1947Q2:2023Q4

for i=1:86
    data_save_med(1:i+221,i)=QoQ_cal(data_raw(1:222+i,i)); %1947Q1-2002Q3, 2002Q4
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JEDC_Data\Data\Data_clear'
clear all; close all; clc;

addpath(genpath('./Functions'));
addpath(genpath('./Raw_data'));
%% (2) Consumer Price Index Monthly (QoQ,sa): cpiQvMd
% 2002Q4-2023Q4
data_raw=xlsread('FED_of_Philadelphia','cpiQvMd'); % 2002Q4-2023Q4, 1947M1-2023M10

data_raw_ave_quarter=nan(307,85); % 1947Q1:2023Q3,2002Q4-2023Q4
for i=1:85
    data_raw_ave_quarter(:,i)=M_to_Q_ave(data_raw(:,i)); %
end


data_save_med=nan(306,85); % 1947Q2:2023Q3,2002Q4-2023Q4

for i=1:85
    data_save_med(1:i+221,i)=QoQ_cal(data_raw_ave_quarter(1:222+i,i)); %1947Q1-2002Q4, 2002Q4
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JEDC_Data\Data\Data_clear'
clear all; close all; clc;

addpath(genpath('./Functions'));
addpath(genpath('./Raw_data'));
%% (3) Core Consumer Price Index (QoQ,sa): pcpixMvMd
% 2002M12-2024M1
data_raw=xlsread('FED_of_Philadelphia','pcpixMvMd'); % 1957M1-2023M12, 2002M12-2024M1


data_raw_ave_quarter=nan(267+1,85); % 1957Q1:2023Q4,2002Q4-2023Q4
for i=1:85
    data_raw_ave_quarter(:,i)=M_to_Q_ave(data_raw(:,3*(i-1)+1)); %
end


data_save_med=nan(266,85); % 1957Q2:2023Q3,2002Q4-2023Q4

for i=1:85
    data_save_med(1:i+181,i)=QoQ_cal(data_raw_ave_quarter(1:182+i,i)); %1957Q1-2002Q3, 2002Q4
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JEDC_Data\Data\Data_clear'
clear all; close all; clc;

addpath(genpath('./Functions'));
addpath(genpath('./Raw_data'));
%% (4) Producer Price Index, Finished Goods (QoQ, sa): pppiMvMd
% 2002M12-2024M1
data_raw=xlsread('FED_of_Philadelphia','pppiMvMd'); % 1947M4-2023M12, 2002M12-2024M1


data_raw_ave_quarter=nan(307,85); % 1947Q2:2023Q4,2002Q4-2023Q4
for i=1:85
    data_raw_ave_quarter(:,i)=M_to_Q_ave(data_raw(:,3*(i-1)+1)); %
end


data_save_med=nan(305,85); % 1947Q3:2023Q3,2002Q4-2023Q4

for i=1:85
    data_save_med(1:i+220,i)=QoQ_cal(data_raw_ave_quarter(1:221+i,i)); %1947Q2-2002Q3, 2002Q4
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JEDC_Data\Data\Data_clear'
clear all; close all; clc;

addpath(genpath('./Functions'));
addpath(genpath('./Raw_data'));
%% (5) Core Producer Price Index, Finished Goods (QoQ,sa): pppixMvMd
% 2002M12-2024M1
data_raw=xlsread('FED_of_Philadelphia','pppixMvMd'); % 1974M1-2023M12, 2002M12-2024M1


data_raw_ave_quarter=nan(200,85); % 1974Q1:2023Q4,2002Q4-2023Q4
for i=1:85
    data_raw_ave_quarter(:,i)=M_to_Q_ave(data_raw(:,3*(i-1)+1)); %
end


data_save_med=nan(198,85); % 1974Q2:2023Q3,2002Q4-2023Q4

for i=1:85
    data_save_med(1:i+113,i)=QoQ_cal(data_raw_ave_quarter(1:114+i,i)); %1974Q1-2002Q3, 2002Q4
end


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JEDC_Data\Data\Data_clear'
clear all; close all; clc;

addpath(genpath('./Functions'));
addpath(genpath('./Raw_data'));
%% (6) Real GNP/GDP (QoQ,sa): ROUTPUTQvQd
% 2002Q4-2024Q1
data_raw=xlsread('FED_of_Philadelphia','ROUTPUTQvQd'); % 1947Q1-2023Q4, 2002Q4-2024Q1

data_save_med=nan(306,85); % 1947Q2:2023Q3, 2002Q4-2023Q4,

for i=1:85
    data_save_med(1:i+221,i)=QoQ_cal(data_raw(1:222+i,i)); %1947Q1-2002Q3, 2002Q4
end


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JEDC_Data\Data\Data_clear'
clear all; close all; clc;

addpath(genpath('./Functions'));
addpath(genpath('./Raw_data'));
%% (7) Real Personal Consumption Expenditure (QoQ,sa): RCONQvQd
% 2002Q4-2024Q1
data_raw=xlsread('FED_of_Philadelphia','RCONQvQd'); % 1947Q1-2023Q4, 2002Q4-2024Q1

data_save_med=nan(306,85); % 1947Q2:2023Q3, 2002Q4-2023Q4,

for i=1:85
    data_save_med(1:i+221,i)=QoQ_cal(data_raw(1:222+i,i)); %1947Q1-2002Q3, 2002Q4
end


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JEDC_Data\Data\Data_clear'
clear all; close all; clc;

addpath(genpath('./Functions'));
addpath(genpath('./Raw_data'));
%% (8) Nonresidential Domestic Investment (QoQ,sa): rinvbfQvQd
% 2002Q4-2024Q1
data_raw=xlsread('FED_of_Philadelphia','rinvbfQvQd'); % 1947Q1-2023Q4, 2002Q4-2024Q1

data_save_med=nan(306,85); % 1947Q2:2023Q3, 2002Q4-2023Q4,

for i=1:85
    data_save_med(1:i+221,i)=QoQ_cal(data_raw(1:222+i,i)); %1947Q1-2002Q3, 2002Q4
end



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JEDC_Data\Data\Data_clear'
clear all; close all; clc;

addpath(genpath('./Functions'));
addpath(genpath('./Raw_data'));
%% (9) Residential Domestic Investment (QoQ, sa): rinvresidQvQd
% 2002Q4-2024Q1
data_raw=xlsread('FED_of_Philadelphia','rinvresidQvQd'); % 1947Q1-2023Q4, 2002Q4-2024Q1

data_save_med=nan(306,85); % 1947Q2:2023Q3, 2002Q4-2023Q4,

for i=1:85
    data_save_med(1:i+221,i)=QoQ_cal(data_raw(1:222+i,i)); %1947Q1-2002Q3, 2002Q4
end


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JEDC_Data\Data\Data_clear'
clear all; close all; clc;

addpath(genpath('./Functions'));
addpath(genpath('./Raw_data'));
%% (10) Change in Inventories to GDP (pp, sa): rinvchiQvQd
% 2002Q4-2024Q1
data_rinvchi_raw=xlsread('FED_of_Philadelphia','rinvchiQvQd'); % 1947Q1-2023Q4, 2002Q4-2024Q1
data_routput_raw=xlsread('FED_of_Philadelphia','ROUTPUTQvQd'); % 1947Q1-2023Q4, 2002Q4-2024Q1

data_save_med=(data_rinvchi_raw(1:end-1,1:end-1)*100)./data_routput_raw(1:end-1,1:end-1); % 1947Q1:2023Q3, 2002Q4-2023Q4, pp


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JEDC_Data\Data\Data_clear'
clear all; close all; clc;

addpath(genpath('./Functions'));
addpath(genpath('./Raw_data'));
%% (11) Real Exports of Goods and Services (QoQ,sa): REXQvQd
% 2002Q4-2024Q1
data_raw=xlsread('FED_of_Philadelphia','REXQvQd'); % 1947Q1-2023Q4, 2002Q4-2024Q1

data_save_med=nan(306,85); % 1947Q2:2023Q3, 2002Q4-2023Q4,

for i=1:85
    data_save_med(1:i+221,i)=QoQ_cal(data_raw(1:222+i,i)); %1947Q1-2002Q3, 2002Q4
end


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JEDC_Data\Data\Data_clear'
clear all; close all; clc;

addpath(genpath('./Functions'));
addpath(genpath('./Raw_data'));
%% (12) Real Imports of Goods and Services (QoQ,sa): RIMPQvQd
% 2002Q4-2024Q1
data_raw=xlsread('FED_of_Philadelphia','RIMPQvQd'); % 1947Q1-2023Q4, 2002Q4-2024Q1

data_save_med=nan(306,85); % 1947Q2:2023Q3, 2002Q4-2023Q4,

for i=1:85
    data_save_med(1:i+221,i)=QoQ_cal(data_raw(1:222+i,i)); %1947Q1-2002Q3, 2002Q4
end


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JEDC_Data\Data\Data_clear'
clear all; close all; clc;

addpath(genpath('./Functions'));
addpath(genpath('./Raw_data'));
%% (13) Real Government Consumption Expenditures & Gross Investments (QoQ,sa): RGQvQd
% 2002Q4-2024Q1
data_raw=xlsread('FED_of_Philadelphia','RGQvQd'); % 1947Q1-2023Q4, 2002Q4-2024Q1

data_save_med=nan(306,85); % 1947Q2:2023Q3, 2002Q4-2023Q4,

for i=1:85
    data_save_med(1:i+221,i)=QoQ_cal(data_raw(1:222+i,i)); %1947Q1-2002Q3, 2002Q4
end



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JEDC_Data\Data\Data_clear'
clear all; close all; clc;

addpath(genpath('./Functions'));
addpath(genpath('./Raw_data'));
%% (14) Nominal GNP/GDP (QoQ,sa): NOUTPUTQvQd
% 2002Q4-2024Q1
data_raw=xlsread('FED_of_Philadelphia','NOUTPUTQvQd'); % 1947Q1-2023Q4, 2002Q4-2024Q1

data_save_med=nan(306,85); % 1947Q2:2023Q3, 2002Q4-2023Q4,

for i=1:85
    data_save_med(1:i+221,i)=QoQ_cal(data_raw(1:222+i,i)); %1947Q1-2002Q3, 2002Q4
end


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JEDC_Data\Data\Data_clear'
clear all; close all; clc;

addpath(genpath('./Functions'));
addpath(genpath('./Raw_data'));
%% (15) Nominal Personal Consumption Expenditures (QoQ,sa): nconQvQd
% 2002Q4-2024Q1
data_raw=xlsread('FED_of_Philadelphia','nconQvQd'); % 1947Q1-2023Q4, 2002Q4-2024Q1

data_save_med=nan(306,85); % 1947Q2:2023Q3, 2002Q4-2023Q4,

for i=1:85
    data_save_med(1:i+221,i)=QoQ_cal(data_raw(1:222+i,i)); %1947Q1-2002Q3, 2002Q4
end


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JEDC_Data\Data\Data_clear'
clear all; close all; clc;

addpath(genpath('./Functions'));
addpath(genpath('./Raw_data'));
%% (16) Wage and Salary Disbursements (QoQ, sa): wsdQvQd
% 2002Q4-2024Q1
data_raw=xlsread('FED_of_Philadelphia','wsdQvQd'); % 1947Q1-2023Q4, 2002Q4-2024Q1

data_save_med=nan(306,85); % 1947Q2:2023Q3, 2002Q4-2023Q4,

for i=1:85
    data_save_med(1:i+221,i)=QoQ_cal(data_raw(1:222+i,i)); %1947Q1-2002Q3, 2002Q4
end

data_save_med(1:191,28) = data_save_med(1:191,27);
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JEDC_Data\Data\Data_clear'
clear all; close all; clc;

addpath(genpath('./Functions'));
addpath(genpath('./Raw_data'));
%% (17) Other Labor Income/Supplements to Wages ans Sal (QoQ, sa): oliQvQd
% 2002Q4-2024Q1
data_raw=xlsread('FED_of_Philadelphia','oliQvQd'); % 1947Q1-2023Q4, 2002Q4-2024Q1

data_save_med=nan(306,85); % 1947Q2:2023Q3, 2002Q4-2023Q4,

for i=1:85
    data_save_med(1:i+221,i)=QoQ_cal(data_raw(1:222+i,i)); %1947Q1-2002Q3, 2002Q4
end

data_save_med(1:192,28) = data_save_med(1:192,27);
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JEDC_Data\Data\Data_clear'
clear all; close all; clc;

addpath(genpath('./Functions'));
addpath(genpath('./Raw_data'));
%% (18) Nominal Personal Saving (QoQ,sa): npsavQvQd
% 2002Q4-2024Q1
data_raw=xlsread('FED_of_Philadelphia','npsavQvQd'); % 1947Q1-2023Q4, 2002Q4-2024Q1

data_save_med=nan(306,85); % 1947Q2:2023Q3, 2002Q4-2023Q4,

for i=1:85
    data_save_med(1:i+221,i)=QoQ_cal(data_raw(1:222+i,i)); %1947Q1-2002Q3, 2002Q4
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JEDC_Data\Data\Data_clear'
clear all; close all; clc;

addpath(genpath('./Functions'));
addpath(genpath('./Raw_data'));
%% (19) Personal Saving Rate to Disposable Personal Income (pp, sa): ratesavQvQd
% 2002Q4-2024Q1
% data_raw=xlsread('FED_of_Philadelphia','ratesavQvQd'); % 1947Q1-2023Q4, 2002Q4-2024Q1
% 
% data_save_med=nan(306,85); % 1947Q2:2023Q3, 2002Q4-2023Q4,
% 
% for i=1:85
%     data_save_med(1:i+221,i)=QoQ_cal(data_raw(1:222+i,i)); %1947Q1-2002Q3, 2002Q4
% end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JEDC_Data\Data\Data_clear'
clear all; close all; clc;

addpath(genpath('./Functions'));
addpath(genpath('./Raw_data'));
%% (20) Output Per Hour of All Persons: Business Sector (QoQ, sa): OPHQvQd
% 2002Q4-2024Q1
data_raw=xlsread('FED_of_Philadelphia','OPHQvQd'); % 1947Q1-2023Q4, 2002Q4-2023Q4

data_save_med=nan(306,85); % 1947Q2:2023Q3, 2002Q4-2023Q4,

for i=1:85
    data_save_med(1:i+221,i)=QoQ_cal(data_raw(1:222+i,i)); %1947Q1-2002Q3, 2002Q4
end


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JEDC_Data\Data\Data_clear'
clear all; close all; clc;

addpath(genpath('./Functions'));
addpath(genpath('./Raw_data'));
%% (21) Civilian Rate of Unemployment (pp, quarterly average): rucQvMd
% 2002Q4-2023Q4
data_raw=xlsread('FED_of_Philadelphia','rucQvMd'); % 1948M1-2023M10, 2002Q4-2023Q4, 

data_raw_ave_quarter=nan(303,85); % 1948Q1:2023Q3,2002Q4-2023Q4
for i=1:85
    data_raw_ave_quarter(:,i)=M_to_Q_ave(data_raw(:,i)); %
end

% Demean
data_save_demean=nan(303,85); % 1948Q1:2023Q3,2002Q4-2023Q4

for i=1:85
    data_save_demean(1:218+i,i)=data_raw_ave_quarter(1:218+i,i)-ones(218+i,1)*mean(data_raw_ave_quarter(1:218+i,i)); %1947Q1-2002Q3, 2002Q4
end


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JEDC_Data\Data\Data_clear'
clear all; close all; clc;

addpath(genpath('./Functions'));
addpath(genpath('./Raw_data'));
%% (22) Civilian Labor Force, 16+ （QoQ,sa): lfcMvMd
% 2002M12-2024M1
data_raw=xlsread('FED_of_Philadelphia','lfcMvMd'); % 1948M1-2023M12, 2002M12-2024M1


data_raw_ave_quarter=nan(304,85); % 1948Q1:2023Q4,2002Q4-2023Q4
for i=1:85
    data_raw_ave_quarter(:,i)=M_to_Q_ave(data_raw(:,3*(i-1)+1)); %
end


data_save_med=nan(302,85); % 1948Q2:2023Q3,2002Q4-2023Q4

for i=1:85
    data_save_med(1:i+217,i)=QoQ_cal(data_raw_ave_quarter(1:218+i,i)); %1948Q1-2002Q3, 2002Q4
end


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JEDC_Data\Data\Data_clear'
clear all; close all; clc;

addpath(genpath('./Functions'));
addpath(genpath('./Raw_data'));
%% (23) Civilian Labor Force Participation Rate to Noninstitutional Pop (pp,sa): lfpartMvMd
% 2002M12-2024M1
data_raw=xlsread('FED_of_Philadelphia','lfpartMvMd'); % 1948M1-2023M12, 2002M12-2024M1


data_raw_ave_quarter=nan(304,85); % 1948Q1:2023Q4,2002Q4-2023Q4
for i=1:85
    data_raw_ave_quarter(:,i)=M_to_Q_ave(data_raw(:,3*(i-1)+1)); %
end

% First difference
data_save_med=nan(302,85); % 1948Q2:2023Q3,2002Q4-2023Q4

for i=1:85
    data_save_med(1:i+217,i)=data_raw_ave_quarter(2:218+i,i)-data_raw_ave_quarter(1:217+i,i); %1948Q1-2002Q3, 2002Q4
end


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JEDC_Data\Data\Data_clear'
clear all; close all; clc;

addpath(genpath('./Functions'));
addpath(genpath('./Raw_data'));
%% (24) Change Nonfarm Payroll (quarterly average, sa): employMvMd
% 2002M12-2024M1
data_raw=xlsread('FED_of_Philadelphia','employMvMd'); % 1947M1-2023M12, 2002M12-2024M1


data_raw_ave_quarter=nan(308,85); % 1947Q1:2023Q4,2002Q4-2023Q4
for i=1:85
    data_raw_ave_quarter(:,i)=M_to_Q_ave(data_raw(:,3*(i-1)+1)); %
end


data_save_med=nan(306,85); % 1947Q2:2023Q3,2002Q4-2023Q4

for i=1:85
    data_save_med(1:i+221,i)=QoQ_cal(data_raw_ave_quarter(1:222+i,i)); %1947Q1-2002Q3, 2002Q4
end

% plot(data_save_med(:,end))  % 2020Q2, decline sharply

% demean
data_save_med_demean=nan(306,85); %1947Q2:2023Q3, 2002Q4-2023Q4
for i=1:85
    data_save_med_demean(1:i+221,i)=data_save_med(1:i+221,i)-ones(i+221,1)*mean(data_save_med(1:i+221,i));
end
% plot(data_save_med_demean(:,end)) 


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JEDC_Data\Data\Data_clear'
clear all; close all; clc;

addpath(genpath('./Functions'));
addpath(genpath('./Raw_data'));
%% (25) Total Aggregate Weekly Hours (QoQ, sa): hMvMd
% 2002M12-2024M1
data_raw=xlsread('FED_of_Philadelphia','hMvMd'); % 1964M1-2023M12, 2002M12-2024M1


data_raw_ave_quarter=nan(240,85); % 1964Q1:2023Q4,2002Q4-2023Q4
for i=1:85
    data_raw_ave_quarter(:,i)=M_to_Q_ave(data_raw(:,3*(i-1)+1)); %
end


data_save_med=nan(238,85); % 1964Q2:2023Q3,2002Q4-2023Q4

for i=1:85
    data_save_med(1:i+153,i)=QoQ_cal(data_raw_ave_quarter(1:154+i,i)); %1964Q1-2002Q3, 2002Q4
end


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JEDC_Data\Data\Data_clear'
clear all; close all; clc;

addpath(genpath('./Functions'));
addpath(genpath('./Raw_data'));
%% (26) Industrial Production Index (QoQ, sa): iptMvMd
% 2002M12-2024M1
data_raw=xlsread('FED_of_Philadelphia','iptMvMd'); % 1947M1-2023M12, 2002M12-2024M1


data_raw_ave_quarter=nan(308,85); % 1947Q1:2023Q4,2002Q4-2023Q4
for i=1:85
    data_raw_ave_quarter(:,i)=M_to_Q_ave(data_raw(:,3*(i-1)+1)); %
end


data_save_med=nan(306,85); % 1947Q2:2023Q3,2002Q4-2023Q4

for i=1:85
    data_save_med(1:i+221,i)=QoQ_cal(data_raw_ave_quarter(1:222+i,i)); %1947Q2-2002Q3, 2002Q4
end


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JEDC_Data\Data\Data_clear'
clear all; close all; clc;

addpath(genpath('./Functions'));
addpath(genpath('./Raw_data'));
%% (27) Manufacturing Capacity Utilization Rate (pp, sa): cumMvMd
% 2002M12-2024M1
data_raw=xlsread('FED_of_Philadelphia','cumMvMd'); % 1948M1-2023M12, 2002M12-2024M1


data_raw_ave_quarter=nan(304,85); % 1948Q1:2023Q4,2002Q4-2023Q4
for i=1:85
    data_raw_ave_quarter(:,i)=M_to_Q_ave(data_raw(:,3*(i-1)+1)); %
end

% First difference
data_save_med=nan(302,85); % 1948Q2:2023Q3,2002Q4-2023Q4

for i=1:85
    data_save_med(1:i+217,i)=data_raw_ave_quarter(2:218+i,i)-data_raw_ave_quarter(1:217+i,i); %1948Q1-2002Q3, 2002Q4
end


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JEDC_Data\Data\Data_clear'
clear all; close all; clc;

addpath(genpath('./Functions'));
addpath(genpath('./Raw_data'));
%% (28) Housing Starts (QoQ, sa): hstartsMvMd
% 2002M12-2024M1
data_raw=xlsread('FED_of_Philadelphia','hstartsMvMd'); % 1959M1-2023M12, 2002M12-2024M1


data_raw_ave_quarter=nan(260,85); % 1959Q1:2023Q4,2002Q4-2023Q4
for i=1:85
    data_raw_ave_quarter(:,i)=M_to_Q_ave(data_raw(:,3*(i-1)+1)); %
end


data_save_med=nan(258,85); % 1959Q2:2023Q3,2002Q4-2023Q4

for i=1:85
    data_save_med(1:i+173,i)=QoQ_cal(data_raw_ave_quarter(1:174+i,i)); %1959Q2-2002Q3, 2002Q4
end




%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JEDC_Data\Data\Data_clear'
clear all; close all; clc;

addpath(genpath('./Functions'));
addpath(genpath('./Raw_data'));
%% (29) M1 Measure of the Money Stock (YoY): m1QvMd
% 2002Q4-2023Q4
data_raw=xlsread('FED_of_Philadelphia','m1QvMd'); % 1959M1-2023M9, 2002Q4-2023Q4


data_raw_ave_quarter=nan(259,85); % 1959Q1:2023Q3,2002Q4-2023Q4
for i=1:85
    data_raw_ave_quarter(:,i)=M_to_Q_ave(data_raw(:,i)); %
end


data_save_med=nan(255,85); % 1960Q1:2023Q3,2002Q4-2023Q4

for i=1:85
    data_save_med(1:i+170,i)=YoY_cal(data_raw_ave_quarter(1:174+i,i)); %1959Q1-2002Q3, 2002Q4
end

% Demean
data_save_demean=nan(255,85); % 1960Q1:2023Q3,2002Q4-2023Q4
for i=1:85
    data_save_demean(1:i+170,i)=data_save_med(1:i+170,i)-ones(170+i,1)*mean(data_save_med(1:i+170,i));
end


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JEDC_Data\Data\Data_clear'
clear all; close all; clc;

addpath(genpath('./Functions'));
addpath(genpath('./Raw_data'));
%% (30) M2 Measure of the Money Stock (YoY): m2QvMd
% 2002Q4-2023Q4
data_raw=xlsread('FED_of_Philadelphia','m2QvMd'); % 1959M1-2023M9, 2002Q4-2023Q4


data_raw_ave_quarter=nan(259,85); % 1959Q1:2023Q3,2002Q4-2023Q4
for i=1:85
    data_raw_ave_quarter(:,i)=M_to_Q_ave(data_raw(:,i)); %
end


data_save_med=nan(255,85); % 1960Q1:2023Q3,2002Q4-2023Q4

for i=1:85
    data_save_med(1:i+170,i)=YoY_cal(data_raw_ave_quarter(1:174+i,i)); %1959Q1-2002Q3, 2002Q4
end

% Demean
data_save_demean=nan(255,85); % 1960Q1:2023Q3,2002Q4-2023Q4
for i=1:85
    data_save_demean(1:i+170,i)=data_save_med(1:i+170,i)-ones(170+i,1)*mean(data_save_med(1:i+170,i));
end

