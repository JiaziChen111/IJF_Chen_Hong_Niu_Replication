%% Table 1: Summary statistics: U.S. government bond yields from the CRSP database
clear all; close all; clc;
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication'

addpath(genpath('./Data'));
addpath(genpath('./Functions'));
%% load data
% yield data
data_CRSP=xlsread('CRSP_monthly','Monthly');
yield=data_CRSP(1:805,:); % 3M,12M,24M,36M,48M,60M
%%
Table = nan(6,8); % 6 maturity and 8 statistics
for i=1:6
    Table(i,1) = mean(yield(:,i)); % mean
    Table(i,2) = std(yield(:,i)); % sd
    Table(i,3) = min(yield(:,i)); % min
    Table(i,4) = max(yield(:,i)); % max
    [acf,lags,bounds] = autocorr(yield(:,i),30);
    Table(i,5:7) = acf([2,13,31],1)'; % autocorrelation coefficients
    Table(i,8)=log(0.5)/log(acf(2));  % half-life
end
Table1_sum = Table
xlswrite('Table1.xlsx',Table1_sum,'Table1',strcat("B",num2str(3)));
