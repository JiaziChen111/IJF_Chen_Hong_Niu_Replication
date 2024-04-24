% (Naive) Random Walk(RWY): Recursive 
% 1st subsample is 1952:M6-2014:M7, last subsample is 1952:M6-2021:M12
clear all; close all; clc;
% cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\Spuriousness_check\2019M7_2022M6'
% 
% addpath(genpath('./Data'));
% addpath(genpath('./Functions'));
%% load data
% yield data
data_CRSP=xlsread('CRSP_monthly_2022','Monthly');
yield=data_CRSP(1:841,:); % 3M,12M,24M,36M,48M,60M, 1952M6-2022M6

%%
y_h6=zeros(36,6); y_h12=zeros(36,6); y_h24=zeros(36,6);
y_h36=zeros(36,6); y_h48=zeros(36,6); y_h60=zeros(36,6);

y_h6=yield(800:end-6,:); y_h12=yield(794:end-12,:);  y_h24=yield(782:end-24,:);

y_h36=yield(770:end-36,:);  y_h48=yield(758:end-48,:);  y_h60=yield(746:end-60,:); 
%%  Save the results
Rec_RW=For_result_save(y_h6,y_h12,y_h24,y_h36,y_h48,y_h60);
save('.\Results\Rec_RW','Rec_RW');

%% Actual values
actual_h6=zeros(36,6); actual_h12=zeros(36,6); actual_h24=zeros(36,6);
actual_h36=zeros(36,6); actual_h48=zeros(36,6); actual_h60=zeros(36,6);

actual_h6=yield(end-35:end,:);  actual_h12=yield(end-35:end,:); 
actual_h24=yield(end-35:end,:);  actual_h36=yield(end-35:end,:); actual_h48=yield(end-35:end,:); 
actual_h60=yield(end-35:end,:); 

%% Save the results
Rec_Actual=For_result_save(actual_h6,actual_h12,actual_h24,actual_h36,actual_h48,actual_h60);
save('.\Results\Rec_Actual','Rec_Actual');
%% Figure: Yield_2014M7_2022M6
% yield=[[1952+6/12:1/12:2022+6/12]',yield];
% figure('Name','CRSP_month','Color',[1 1 1],'NumberTitle','off','position',[100,100,1200,700]);
% m3=plot(2014+7/12:1/12:2022+6/12,yield(746:841,2)','r--','LineWidth',1.5);
% hold on
% m12=plot(2014+7/12:1/12:2022+6/12,yield(746:841,3)','k','LineWidth',1.5);
% m24=plot(2014+7/12:1/12:2022+6/12,yield(746:841,4)','y-.','LineWidth',1.5);
% m36=plot(2014+7/12:1/12:2022+6/12,yield(746:841,5)','r:','LineWidth',1.5);
% m48=plot(2014+7/12:1/12:2022+6/12,yield(746:841,6)','g','LineWidth',1.5);
% m60=plot(2014+7/12:1/12:2022+6/12,yield(746:841,7)','m:','LineWidth',1.5);
% grid on
% ylabel ('\bf Percent (%)','FontSize',12)
% xlabel ('\bf Time: 2014M7-2022M6','FontSize',12);
% title('\bf Yield to maturity: CRSP','FontSize',12);
% h=legend([m3 m12 m24 m36 m48 m60],'\bf 3m','\bf 12m','\bf 24m','\bf 36','\bf 48m','\bf 60','Location','best');
% set(h,'FontSize',15);
% set(gca,'FontSize',12)       
% saveTightFigure('Yield_2014M7_2022M6.pdf')