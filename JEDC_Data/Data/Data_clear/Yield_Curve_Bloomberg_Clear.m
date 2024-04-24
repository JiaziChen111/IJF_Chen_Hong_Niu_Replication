%% Data clear: quarterly average of the daily data

clear all; close all; clc;

cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JEDC_Data\Data\Data_clear'

addpath(genpath('./Functions'));
addpath(genpath('./Raw_data'));
%% load the data 
data_all_raw=xlsread('Yield_Curve_Bloomberg_Raw','raw','B68:P8759'); % 1989/4/3-2023/12/29, 3M, 6M,1Y, 2Y, 3Y, 4Y, 5Y, 6Y, 7Y,8Y,9Y,10Y,15Y,20Y,30Y
data_used = data_all_raw;
data_all_raw_1989Q1 = xlsread('Yield_Curve_Bloomberg_Raw','raw','B66:P67'); 
%% 
filename = 'Yield_Curve_Bloomberg_Raw.xlsx';  %
sheet = 'raw';  % 
range = 'A68:A8759';  %

% 
[dateValues,~,raw] = xlsread(filename, sheet, range);

%
dateValues = datetime(raw, 'InputFormat', 'yyyy/MM/dd');

[year month day] = datevec(dateValues);
date_daily=(year).*10000+month.*100+day;
%% total 420 months: 1989M1-2023M12

data_month_used = zeros(420,16); % 1989M1-2023M12
data_month_used(:,1)=[1989+1/12:1/12:2023+12/12]';
for i=1:15
    data_use_med = [date_daily,data_all_raw(:,i)];
    monthdata_med=daymonthfunction_ave(data_use_med);
    data_month_used(:,i+1) = monthdata_med;
end

%% 1989Q1-2023Q4

data_quarter = zeros(140,16);
data_quarter(:,1)=[1989+1/4:1/4:2023+4/4]';
data_quarter(1,2:end)= mean(data_all_raw_1989Q1); % 1989Q1
for i=2:140
    data_quarter(i,2:end)= mean(data_month_used(3*(i-1)+1:3*i,2:end));
end

%% 3D plot
X=[3,6,12,24,36,48,60,72,84,96,108,120,180,240,360]';
Y=1989+1/4:1/4:2023+4/4;
figure('Name','Average','Color',[1 1 1],'NumberTitle','off','position',[100,100,1000,800]);
surf(Y,X,data_quarter(:,2:end)') % 1989Q1-2023Q4, total 140 quarters
ylabel ('\bf Maturity: 3M-360M','FontSize',15)
xlabel ('\bf Time: 1989Q1-2023Q4','FontSize',15);
zlabel ('\bf Percent (%)','FontSize',15);
title('\bf Yield curve:Quarterly average','FontSize',15);
view([8.30000000000003 38])
 %set(gca, 'LooseInset', [0,0,0.09,0]);
 saveTightFigure('Yield_quarter_ave.pdf')

