%% Yahoo Finance: https://ycharts.com/indicators/us_ism_manufacturing_prices_index
% 
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JEDC_Data\Data\Data_clear'
clear all; close all; clc;

addpath(genpath('./Functions'));
addpath(genpath('./Raw_data'));
%%

data_all_raw=xlsread('US ISM Manufacturing Prices Paid Index','Monthly'); % 

%%
[r c]=size(data_all_raw);

save=zeros((r-1)*4/12,2);
for i=1:(r-1)*4/12
    save(i,:)=data_all_raw(3*i,:);
end

ism_q_ave=nan(432/3,1); % 1988Q1-2023Q4

for i=1:432/3
    ism_q_ave(i,1)=mean(data_all_raw(3*(i-1)+1:3*i,2));
end

%% Comparison of ISM Manufacturing PMI and ISM Manufacturing Prices Paid Index: Monthly data

pmi_month=xlsread('US ISM Manufacturing PMI','Monthly'); % 
ppi_month=xlsread('US ISM Manufacturing Prices Paid Index','Monthly'); % 

corr(pmi_month(:,2),ppi_month(:,2)); % correlation coefficient: 0.6453


figure('Name','ISM Manufacturing Prices: Monthly','Color',[1 1 1],'NumberTitle','off','position',[100,100,1000,800]);
pmi_month_fig=plot(pmi_month(:,1),pmi_month(:,2),'r--','LineWidth',2);
hold on
ppi_month_fig=plot(ppi_month(:,1),ppi_month(:,2),'k:','LineWidth',2);
grid on
xlabel ('\bf Time: 1988M1-2023M12','FontSize',15);
title('\bf US ISM Manufacturing','FontSize',15);
set(gca,'FontSize',12)       % ̶ȵ      С
hqqq=legend([pmi_month_fig ppi_month_fig],'\bf ISM Manufacturing PMI','\bf ISM Manufacturing Prices Paid Index','Location','best');
set(hqqq,'FontSize',10);

%% Comparison of ISM Manufacturing PMI and ISM Manufacturing Prices Paid Index: Quarterly data

pmi_quarter=xlsread('US ISM Manufacturing PMI','Quarterly'); % 
ppi_quarter=xlsread('US ISM Manufacturing Prices Paid Index','Quarterly'); % 

corr(pmi_quarter(:,2),ppi_quarter(:,2)); % correlation coefficient: 0.6430


figure('Name','ISM Manufacturing Prices: Quarterly','Color',[1 1 1],'NumberTitle','off','position',[100,100,1000,800]);
pmi_quarter_fig=plot(pmi_quarter(:,1),pmi_quarter(:,2),'r--','LineWidth',2);
hold on
ppi_quarter_fig=plot(ppi_quarter(:,1),ppi_quarter(:,2),'k:','LineWidth',2);
grid on
xlabel ('\bf Time: 1988Q1-2023Q4','FontSize',15);
title('\bf US ISM Manufacturing','FontSize',15);
set(gca,'FontSize',12)       % ̶ȵ      С
hqqq=legend([pmi_quarter_fig ppi_quarter_fig],'\bf ISM Manufacturing PMI','\bf ISM Manufacturing Prices Paid Index','Location','best');
set(hqqq,'FontSize',10);