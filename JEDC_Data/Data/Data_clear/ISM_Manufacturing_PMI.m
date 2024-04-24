%% Yahoo Finance: https://ycharts.com/indicators/us_pmi

cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JEDC_Data\Data\Data_clear'
clear all; close all; clc;

addpath(genpath('./Functions'));
addpath(genpath('./Raw_data'));


%%

data_all_raw=xlsread('US ISM Manufacturing PMI','Monthly'); % 

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

