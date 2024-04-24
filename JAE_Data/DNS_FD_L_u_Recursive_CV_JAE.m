%% DNS factors: nonparametric regression: recursive CV
% JAE  DNS_FD_L_u
clear all; close all; clc;
% cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JAE_Data'
% 
% addpath(genpath('./Data'));
% addpath(genpath('./Functions'));
%% load data
% yield data
yield_original=importdata("UnsmFB_70-09.txt");
Mat=[3,6,9,12,15,18,21,24,30,36,48,60,72,84,96,108,120];
yield_original(1,2:18)=Mat;

%demographic data
data_pop=xlsread('US_Population','actualpopulation','A2:CI81'); % Age distribution, annully number, 1940.5-2019.5, 0-1,1-2,...,84-85,85+
pop_ann_num_dis = data_pop(1:80,1:87);%
time_ann = 1940.5:2019.5 ;% annually 
time_mon = 1940+6/12:1/12:2019+6/12;
for i= 1:86 %0-1,1-2,...,84-85,85+, total number: 86
pop_mon_num_dis(:,i) = interp1(time_ann,pop_ann_num_dis(:,1+i),time_mon); % linear interpolation
end
pop_mon_num_dis = [time_mon',pop_mon_num_dis];

for i=1:86
    for j=1:949
        pop_mon_dis(j,i)=pop_mon_num_dis(j,i+1)./sum(pop_mon_num_dis(j,2:end),2);
    end
end

%% integral approximation
s_86 = 0.5:1:85.5; % Middle age for each age interval,e.g.,0-1 is 0.5,...,84-85 is 84.5, and 85.5 for 85+
s_star_86 = s_86./85.5; %Park£¬Shin and Whang(2010,JoE), s_star in [0,1]
ss_star_86 = s_star_86.^2; %s_star_square
cos_s_star_86 = cos(s_star_86);
sin_s_star_86 = sin(s_star_86);
cos_2s_star_86 = cos(2*s_star_86);
sin_2s_star_86 = sin(2*s_star_86);
cos_3s_star_86 = cos(3*s_star_86);
sin_3s_star_86 = sin(3*s_star_86);
cos_4s_star_86 = cos(4*s_star_86);
sin_4s_star_86 = sin(4*s_star_86);
cos_5s_star_86 = cos(5*s_star_86);
sin_5s_star_86 = sin(5*s_star_86);
phi_86 = [ones(1,86); s_star_86;ss_star_86;cos_s_star_86;sin_s_star_86;...
   cos_2s_star_86;sin_2s_star_86;cos_3s_star_86;sin_3s_star_86;cos_4s_star_86;...
   sin_4s_star_86;cos_5s_star_86;sin_5s_star_86]; % 13 by 86

z_86=pop_mon_dis*phi_86';

z_86=[time_mon',z_86]; 
z_86_1985=z_86(536:829,:);% 1985:M1-2009:M6


%% Calculate Nelson-Siegel factor loadings, given lamda=0.0609, Diebold and Li(2006,JoE)
lamda=0.0609;
mat = 1:1:120; 
pNS1 = ones(1,120); 
pNS2 = zeros(1,120); 
pNS3 = zeros(1,120);
for imat = 1:120
    pNS2(imat) = (1 - exp(-lamda*imat))/(lamda*imat);
    pNS3(imat) = pNS2(imat) - exp(-lamda*imat);
end

% Nelson-Siegle Coefficients for yields:
Mat=[3,6,9,12,15,18,21,24,30,36,48,60,72,84,96,108,120];
yield_original(1,2:18)=Mat;
CCw = [pNS1; pNS2; pNS3]'; %Coefficient matrix for all maturity 1:120
CC = CCw(Mat',:);

% Extract (Estimate) Nelson-Siegel factors for yields by OLS.
yield=yield_original(2:481,2:18);
NS = ((CC'*CC)\eye(size(CC,2)))*CC'*yield';
NS=NS';
NS=[yield_original(2:end,1),NS];

%% HCV and MHCV  
% Level factor
% tic
CV_L=zeros(210*2,7); CV_L_med=zeros(2,7);
for i=1:210
    i
CV_L_med=CV_Single_FFF(NS(181:264+i,2),z_86_1985(1:84+i,2:end));
CV_L(2*(i-1)+1:2*i,:)=CV_L_med;
end
% toc % about 32.5 mins

% Find the positions of the smallest values in HCV and MHCV, in columns 1, 2, 3, 4, 5, 6, and 7.
for i=1:210*2
    location_CV_L(i,1)=find(CV_L(i,:)==min(CV_L(i,:)));
end

Rec_CV_Level_JAE = [CV_L,location_CV_L];
save('.\Results\Rec_CV_Level_JAE','Rec_CV_Level_JAE');
%% Find out the Kappa represented by the smallest value in both HCV and MHCV. 
% The possible values for Kappa are 2, 4, 6, 8, 10, or 12. Calculate the corresponding frequencies of each.
optimal_kappa_L=zeros(210*2,1);
num_L_hcv_ka2=0;
num_L_hcv_ka3=0;
num_L_hcv_ka5=0;
for i=1:2:210*2
    if location_CV_L(i,1)==1
        num_L_hcv_ka2=num_L_hcv_ka2+1;
        optimal_kappa_L(i,1)=2;
    elseif location_CV_L(i,1)==2
        num_L_hcv_ka3=num_L_hcv_ka3+1;
        optimal_kappa_L(i,1)=3;
    else
        num_L_hcv_ka5=num_L_hcv_ka5+1;
        optimal_kappa_L(i,1)=5; 
    end
end
num_L_mhcv_ka2=0;
num_L_mhcv_ka3=0;
num_L_mhcv_ka5=0;
for i=2:2:210*2
    if location_CV_L(i,1)==1
        num_L_mhcv_ka2=num_L_mhcv_ka2+1;
        optimal_kappa_L(i,1)=2;
    elseif location_CV_L(i,1)==2
        num_L_mhcv_ka3=num_L_mhcv_ka3+1;
        optimal_kappa_L(i,1)=3;
    else
        num_L_mhcv_ka5=num_L_mhcv_ka5+1;
        optimal_kappa_L(i,1)=5; 
    end
end
num_L=[num_L_hcv_ka2,num_L_hcv_ka3,num_L_hcv_ka5;num_L_mhcv_ka2,num_L_mhcv_ka3,num_L_mhcv_ka5]
