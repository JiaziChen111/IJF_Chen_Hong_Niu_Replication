%% University of Michigan: Inflation Expectation, Percent, Monthly, Not Seasonally Adjusted
cd 'E:\Chen_Hong_Niu_IJF_DNS_FD\JEDC_Replication\Data\Raw'
clear all; close all; clc;

%% monthly data transform to quarterly by taking quarterly average
data_raw=xlsread('MICH'); % 1978M1-2023M12

mich_q_ave=nan(552/3,1); % 1978Q1-2023Q4

for i=1:552/3
    mich_q_ave(i,1)=mean(data_raw(3*(i-1)+1:3*i,1));
end



