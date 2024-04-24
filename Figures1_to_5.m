%% Figure 1: US Treasury bond yields and the inverted MY ratio
clear all; close all; clc;
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication'

addpath(genpath('./Data'));
addpath(genpath('./Functions'));
%% load data
% yield data
data_CRSP=xlsread('CRSP_monthly','Monthly');
yield=data_CRSP(1:805,:); % 3M,12M,24M,36M,48M,60M
Y=yield;
[T,N] = size(Y); % 805 by 6

%demographic data
data_pop=xlsread('US_Age_Distribution_2019','actualpopulation','A2:CI81'); % Age distribution, annully number, 1940.5-2019.5, 0-1,1-2,...,84-85,85+
pop_ann_num_dis = data_pop(1:80,1:87);%
time_ann = 1940.5:2019.5 ;% annually 
time_mon = 1940+6/12:1/12:2019+6/12;
for i= 1:86 %0-1,1-2,...,84-85,85+, total number: 86
pop_mon_num_dis(:,i) = interp1(time_ann,pop_ann_num_dis(:,1+i),time_mon); 
end
pop_mon_num_dis = [time_mon',pop_mon_num_dis];

for i=1:86
    for j=1:949
        pop_mon_dis(j,i)=pop_mon_num_dis(j,i+1)./sum(pop_mon_num_dis(j,2:end),2);
    end
end

%% MY ratio, 40-49/20-29
MY_1952=zeros(805,2); %1952:M6-2019:M6
MY_1952(:,1)=time_mon(1,145:end)';
for i=1:805
    MY_1952(i,2)=sum(pop_mon_dis(144+i,41:50))/sum(pop_mon_dis(144+i,21:30));
end
%% Figure 1 in the paper
figure('Name','MY_plot','Color',[1 1 1],'NumberTitle','off','position',[100,100,1200,700]);
yyaxis left
yield_3m=plot(1952.5:1/12:2019.5,yield(:,1),'b--','LineWidth',2);
hold on
yield_36m=plot(1952.5:1/12:2019.5,yield(:,4),'k-.','LineWidth',2);
yield_60m=plot(1952.5:1/12:2019.5,yield(:,6),'m-.','LineWidth',2);
ylabel('\bf Percent (%)','FontSize',15)
xlabel('\bf Time: 1952M6-2019M6','FontSize',15)

yyaxis right
my_plot=plot(1952.5:1/12:2019.5,1./MY_1952(:,2),'r','LineWidth',2);
ylabel('\bf The inverted MY ratio','FontSize',15)
grid on
hqq=legend([yield_3m yield_36m yield_60m my_plot], '\bf y_{3M} (left)','\bf y_{3Y} (left)','\bf y_{5Y} (left)','\bf the inverted MY ratio (right)')
set(hqq,'FontSize',12);
set(gca,'FontSize',12)    

saveTightFigure('Figure1_paper.pdf')



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Figure 2: U.S. Treasury yield curve
% clear all; close all; clc;
% cd 'Z:\User\IJF_Chen_Hong_Niu_Replication'

% addpath(genpath('./Data'));
% addpath(genpath('./Functions'));

%% yield data
data_CRSP=xlsread('CRSP_monthly','Monthly');
yield=data_CRSP(1:805,:); % 3M,12M,24M,36M,48M,60M

%%   CRSP yield 3D plot   Figure 2 in the paper
X=[3,12,24,36,48,60]; % 1Y-5Y
Y=1952+6/12:1/12:2019+6/12;
figure('Name','CRSP_month','Color',[1 1 1],'NumberTitle','off','position',[100,100,1200,700]);
surf(Y,X,(data_CRSP(1:805,:))')
ylabel ('\bf Maturity: 3M-60M','FontSize',12)
xlabel ('\bf Time: 1952M6-2019M6','FontSize',12);
zlabel ('\bf Percent (%)','FontSize',12);
title('\bf U.S. treasury yield curve','FontSize',12);
view([7.30000000000003 38])
set(gca,'FontSize',12)      

saveTightFigure('Figure2_paper.pdf')


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Figure 3: The age distribution of the U.S. population at different times
% clear all; close all; clc;
% cd 'Z:\User\IJF_Chen_Hong_Niu_Replication'

% addpath(genpath('./Data'));
% addpath(genpath('./Functions'));
%% load data
data_pop=xlsread('US_Age_Distribution_2019','actualpopulation','A2:CI81'); % Age distribution, annully number, 1940.5-2019.5, 0-1,1-2,...,84-85,85+
pop_ann_num_dis = data_pop(1:80,1:87);
time_ann = 1940.5:2019.5 ;% annually 
time_mon = 1940+6/12:1/12:2019+6/12;
for i= 1:86 %0-1,1-2,...,84-85,85+, total number: 86
pop_mon_num_dis(:,i) = interp1(time_ann,pop_ann_num_dis(:,1+i),time_mon); 
end
pop_mon_num_dis = [time_mon',pop_mon_num_dis];

for i=1:86
    for j=1:949
        pop_mon_dis(j,i)=pop_mon_num_dis(j,i+1)./sum(pop_mon_num_dis(j,2:end),2);
    end
end

%% Figure 3 
figure('Name','Age distribution: 2D','Color',[1 1 1],'NumberTitle','off','position',[100,100,1200,700]);
subplot(2,1,1)
y1950m6=plot(0:84,pop_mon_dis(121,1:end-1).*100,'b','LineWidth',2);
hold on
y1951m6=plot(0:84,pop_mon_dis(133,1:end-1).*100,'c-.','LineWidth',2);
y1952m6=plot(0:84,pop_mon_dis(145,1:end-1).*100,'r--','LineWidth',2);
y1953m6=plot(0:84,pop_mon_dis(157,1:end-1).*100,'k:','LineWidth',2);
ylabel('\bf Percent (%)','FontSize',12)
xlabel('\bf Age: 0-84','FontSize',12)
title('\bf Short-term evoluton of the age distribution of population','FontSize',12)
haa=legend([y1950m6, y1951m6, y1952m6, y1953m6],'\bf 1950M6','\bf 1951M6','\bf 1952M6','\bf 1953M6')
set(haa,'FontSize',12);
xlim([0,85])
grid on

subplot(2,1,2)
y1950m6=plot(0:84,pop_mon_dis(121,1:end-1).*100,'b','LineWidth',2);
hold on
y1970m6=plot(0:84,pop_mon_dis(361,1:end-1).*100,'c-.','LineWidth',2);
y1990m6=plot(0:84,pop_mon_dis(601,1:end-1).*100,'r--','LineWidth',2);
y2010m6=plot(0:84,pop_mon_dis(841,1:end-1).*100,'k:','LineWidth',2);
hold on
grid on
xlim([0,85])
title('\bf Long-term evoluton of the age distribution of population','FontSize',15)
ylabel('\bf Percent (%)','FontSize',12)
xlabel('\bf Age: 0-84','FontSize',12)
haa=legend([y1950m6, y1970m6, y1990m6, y2010m6],'\bf 1950M6','\bf 1970M6','\bf 1990M6','\bf 2010M6')
set(haa,'FontSize',12);
set(gca,'FontSize',12)     
saveTightFigure('Figure3_paper.pdf')

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Figure 4: The exponential smoothing of the realised inflation and IP growth in vintage 2019M6
% clear all; close all; clc;
% cd 'Z:\User\IJF_Chen_Hong_Niu_Replication'
% 
% addpath(genpath('./Data'));
% addpath(genpath('./Functions'));

%% real-time CPI inflation data from the dataset of 
%   the Federal Reserve Bank of Philadelphia (month t vintage data) 
data_cpi_original=xlsread('real_time_CPI_inflation_vintage','pcpi');
data_cpi_date=xlsread('real_time_CPI_inflation_vintage','date');
data_cpi_mon=NaN(894,274);
for i=1:274
    if i<18
        data_cpi_mon(13:620+i,i)=(log(data_cpi_original(14:621+i,i))-log(data_cpi_original(13:620+i,i)))*100;
    else
        data_cpi_mon(1:620+i,i)=(log(data_cpi_original(2:621+i,i))-log(data_cpi_original(1:620+i,i)))*100;
    end
end

data_cpi_stand=NaN(894,274);
for i=1:274
    if i<18
        data_cpi_stand(13:620+i,i)=standarized_mon(data_cpi_mon(13:620+i,i));
    else
        data_cpi_stand(1:620+i,i)=standarized_mon(data_cpi_mon(1:620+i,i));
    end
end
data_cpi_stand=[data_cpi_date(2:end,1),data_cpi_stand];
data_cpi_stand=[NaN(1,275);data_cpi_stand];
data_cpi_stand(1,2:end)=[data_cpi_date(623:end,1)',202108];
%% Real-time data IP data  from the Federal Reserve Bank of Philadelphia (month t vintage)
data_ip_original=xlsread('real_time_IP_vintage','ipt','PR338:AAE1232');
data_ip_date=xlsread('real_time_IP_vintage','date');
data_ip_mon=NaN(894,274);
for i=1:274
    data_ip_mon(1:620+i,i)=(log(data_ip_original(2:621+i,i))-log(data_ip_original(1:620+i,i)))*100;
end

data_ip_stand=NaN(894,274);
for i=1:274
    data_ip_stand(1:620+i,i)=standarized_mon(data_ip_mon(1:620+i,i));
end
data_ip_stand=[data_ip_date(2:end,1),data_ip_stand];
data_ip_stand=[NaN(1,275);data_ip_stand];
data_ip_stand(1,2:end)=[data_ip_date(623:end,1)',202108];

%% exponential smooth of standardized month-on-month inflation and IP growth rate
% Vintage: 2019M6 
es_pi_orig=exp_smooth(data_cpi_stand(2:869,249),0.01);
es_ip_orig=exp_smooth(data_ip_stand(2:869,249),0.01);
es_pi_2019m6=zeros(869,1); es_ip_2019m6=zeros(869,1);
es_pi_2019m6(1:end-1,1)=es_pi_orig; es_ip_2019m6(1:end-1,1)=es_ip_orig;
es_pi_2019m6(end,1)=0.01*data_cpi_stand(869,249)+(1-0.01)*es_pi_orig(end,1);
es_ip_2019m6(end,1)=0.01*data_ip_stand(869,249)+(1-0.01)*es_ip_orig(end,1);

%% Figure 4 
figure('Name','Vintage_2019M6','Color',[1 1 1],'NumberTitle','off','position',[100,100,1200,700]);
subplot(2,2,1)
h1=plot(1947+2/12:1/12:2019+5/12,data_cpi_stand(2:869,249),'r','LineWidth',2);
grid on
xlabel('\bf Time: 1947M2-2019M5','FontSize',12)
ylabel('\bf Percent (%)','FontSize',12)
xlim([1945 2020])
title('\bf Standarized CPI inflation','FontSize',12)
set(gca,'FontSize',12)     

subplot(2,2,2)
h1=plot(1947+2/12:1/12:2019+6/12,es_pi_2019m6,'r','LineWidth',2);
grid on
xlabel('\bf Time: 1947M2-2019M6','FontSize',12)
ylabel('\bf Percent (%)','FontSize',12)
xlim([1945 2020])
title('\bf Exponentially smoothed of the CPI inflation','FontSize',12)
set(gca,'FontSize',12)     

subplot(2,2,3)
h2=plot(1947+2/12:1/12:2019+5/12,data_ip_stand(2:869,249),'b','LineWidth',2);
grid on
ylabel('\bf Percent (%)','FontSize',12)
xlabel('\bf Time: 1947M2-2019M5','FontSize',12)
xlim([1945 2020])
title('\bf Standarized IP growth rate','FontSize',12)
set(gca,'FontSize',12)     

subplot(2,2,4)
h2=plot(1947+2/12:1/12:2019+6/12,es_ip_2019m6,'b','LineWidth',2);
grid on
ylabel('\bf Percent (%)','FontSize',12)
xlabel('\bf Time: 1947M2-2019M6','FontSize',12)
xlim([1945 2020])
title('\bf Exponentially smoothed of the IP growth rate','FontSize',12)
set(gca,'FontSize',12)     
saveTightFigure('Figure4_paper.pdf')



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Figure 5: Comparison of trends
% clear all; close all; clc;
% cd 'Z:\User\IJF_Chen_Hong_Niu_Replication'
% 
% addpath(genpath('./Data'));
% addpath(genpath('./Functions'));
%% Insample analysis: Run the DNS_FD_L_u, RZIG, DNS_MY_L_u model using full samples 

Insample_analysis;   % stored results in Insample_results.xlsx

%% yield data
data_CRSP=xlsread('CRSP_monthly','Monthly');
yield=data_CRSP(1:805,:); % 3M,12M,24M,36M,48M,60M

%% load the insample estimation results
DNS_FD_L_u = xlsread('Insample_results','DNS_FD_L_u');
RZIG = xlsread('Insample_results','RZIG','D2:F806');
DNS_MY_L_u = xlsread('Insample_results','DNS_MY_L_u');
DNS_factors = xlsread('Insample_results','DNS_factors');
%% Figure 5 in the paper
figure('Name','trends','Color',[1 1 1],'NumberTitle','off','position',[100,100,1200,700]);
actual=plot(1952.5:1/12:2019.5,yield(:,6),'k:','LineWidth',2);
hold on
grid on
[RZI]=shadedplot(1952.5:1/12:2019.5,RZIG(:,1)',RZIG(:,3)',[0/255 255/255 255/255]);
RZI_plot=plot(1952.5:1/12:2019.5,RZIG(:,2),'c--','LineWidth',2);
[dns_fd_u_trend_ci]=shadedplot(1952.5:1/12:2019.5,DNS_FD_L_u(:,1)',DNS_FD_L_u(:,3)',[255/255 1/255 255/255]);
dns_fd_u_trend_plot=plot(1952.5:1/12:2019.5,DNS_FD_L_u(:,2),'m','LineWidth',2);
[dns_my_u_trend_ci]=shadedplot(1952.5:1/12:2019.5,DNS_MY_L_u(:,1)',DNS_MY_L_u(:,3)',[0/255 255/255 0/255]);
dns_my_u_trend_plot=plot(1952.5:1/12:2019.5,DNS_MY_L_u(:,2),'g-.','LineWidth',2);
dns_l=plot(1952.5:1/12:2019.5,DNS_factors(:,1),'r-.','LineWidth',2);
ylabel('\bf Percent (%)','FontSize',15);
h=legend([dns_fd_u_trend_plot,RZI_plot, dns_my_u_trend_plot,dns_l,actual],...
    '\bf DNS-FD-L^{u}','\bf RZIG','\bf DNS-MY-L^{u}','\bf DNS level factor ',...
    '\bf Actual yield: 60 months','Location','ne');
set(h,'FontSize',13);
xlabel('\bf Time: 1952M6-2019M6','FontSize',15);
ylabel('\bf Percent (%)','FontSize',15);
title('\bf Unspanned trends in the level factor','FontSize',15);
set(h,'FontSize',13);
ylim([0,16]);
set(gca,'FontSize',12);      

saveTightFigure('Figure5_paper.pdf')
