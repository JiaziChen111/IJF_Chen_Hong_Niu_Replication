%% (Naive) Random Walk: Recursive 
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
% 
% addpath(genpath('./Data'));
% addpath(genpath('./Functions'));
%% Quarterly averages of daily zero coupon yields released by Bloomberg: IYC

data_yield=xlsread('Yield_Curve_Bloomberg','quarter_ave','A14:Q135');  % 1992Q1-2022Q2,3M,6M,12M,24M,36M,48M,60M,72M,84M,96M,108M,120M,180M,240M,360M
dates=1992+1/4:1/4:2022+2/4; 

%%
y_h1 = zeros(78,15); % 2003Q1-2022Q2, 3M,6M,12M,24M,36M,48M,60M,72M,84M,96M,108M,120M,180M,240M,360M
y_h2 = zeros(77,15); % 2003Q2-2022Q2, 3M,6M,12M,24M,36M,48M,60M,72M,84M,96M,108M,120M,180M,240M,360M
y_h4 = zeros(75,15); % 2003Q4-2022Q2, 3M,6M,12M,24M,36M,48M,60M,72M,84M,96M,108M,120M,180M,240M,360M
y_h8 = zeros(71,15); % 2004Q4-2022Q2, 3M,6M,12M,24M,36M,48M,60M,72M,84M,96M,108M,120M,180M,240M,360M
y_h12 = zeros(67,15); % 2005Q4-2022Q2, 3M,6M,12M,24M,36M,48M,60M,72M,84M,96M,108M,120M,180M,240M,360M
y_h16 = zeros(63,15); % 2006Q4-2022Q2, 3M,6M,12M,24M,36M,48M,60M,72M,84M,96M,108M,120M,180M,240M,360M
y_h20 = zeros(59,15); % 2007Q4-2022Q2, 3M,6M,12M,24M,36M,48M,60M,72M,84M,96M,108M,120M,180M,240M,360M

y_h1 = data_yield(44:end-1,3:end);

y_h2 = data_yield(44:end-2,3:end);

y_h4 = data_yield(44:end-4,3:end);

y_h8 = data_yield(44:end-8,3:end);

y_h12 = data_yield(44:end-12,3:end);

y_h16 = data_yield(44:end-16,3:end);

y_h20 = data_yield(44:end-20,3:end);

%% 
Rec_RW=For_result_save(y_h1,y_h2,y_h4,y_h8,y_h12,y_h16,y_h20);
save('.\Results\Rec_RW','Rec_RW');

%% Actual values
actual_h1 = zeros(78,15); % 2003Q1-2022Q2, 3M,6M,12M,24M,36M,48M,60M,72M,84M,96M,108M,120M,180M,240M,360M
actual_h2 = zeros(77,15); % 2003Q2-2022Q2, 3M,6M,12M,24M,36M,48M,60M,72M,84M,96M,108M,120M,180M,240M,360M
actual_h4 = zeros(75,15); % 2003Q4-2022Q2, 3M,6M,12M,24M,36M,48M,60M,72M,84M,96M,108M,120M,180M,240M,360M
actual_h8 = zeros(71,15); % 2004Q4-2022Q2, 3M,6M,12M,24M,36M,48M,60M,72M,84M,96M,108M,120M,180M,240M,360M
actual_h12 = zeros(67,15); % 2005Q4-2022Q2, 3M,6M,12M,24M,36M,48M,60M,72M,84M,96M,108M,120M,180M,240M,360M
actual_h16 = zeros(63,15); % 2006Q4-2022Q2, 3M,6M,12M,24M,36M,48M,60M,72M,84M,96M,108M,120M,180M,240M,360M
actual_h20 = zeros(59,15); % 2007Q4-2022Q2, 3M,6M,12M,24M,36M,48M,60M,72M,84M,96M,108M,120M,180M,240M,360M


actual_h1 = data_yield(45:end,3:end);

actual_h2 = data_yield(46:end,3:end);

actual_h4 = data_yield(48:end,3:end);

actual_h8 = data_yield(52:end,3:end);

actual_h12 = data_yield(56:end,3:end);

actual_h16 = data_yield(60:end,3:end);

actual_h20 = data_yield(64:end,3:end);

%%
Rec_Actual=For_result_save(actual_h1,actual_h2,actual_h4,actual_h8,actual_h12,actual_h16,actual_h20);
save('.\Results\Rec_Actual','Rec_Actual');