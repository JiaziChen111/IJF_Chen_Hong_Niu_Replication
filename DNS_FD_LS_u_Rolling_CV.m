%% DNS Level and Slope factors: nonparametric regression: 20 Year Rolling window CV
clear all; close all; clc;
% cd 'Z:\User\IJF_Chen_Hong_Niu_Replication'
% 
% addpath(genpath('./Data'));
% addpath(genpath('./Functions'));
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
z_86_1952=z_86(145:end,:);% 1952:M6-2019:M6

%% HCV and MHCV  
% Level factor

CV_L=zeros(245*2,7); CV_L_med=zeros(2,7);
for i=1:245
    i
 bdraw0 = [0.0609, 0.0001]';
Mt=[3,12,24,36,48,60];
% warning('off')
Y_med=Y(i+318:i+557,:);
[bdraw_mle,mu,Phi,Omiga,Phi_Q_mle,B_1_mle,sigma,X_mle,VCV,Y_bar_mle,mu_std,Phi_std] = step_3_Q(Y_med',Mt,bdraw0);
 NS=[];
 NS=X_mle';   
CV_L_med=CV_Single_FFF(NS(:,1),z_86_1952(i+318:i+557,2:end));
CV_L(2*(i-1)+1:2*i,:)=CV_L_med;
end



%%  Find the positions of the smallest values in HCV and MHCV, in columns 1, 2, 3, 4, 5, 6, and 7.
for i=1:245*2
    location_CV_L(i,1)=find(CV_L(i,:)==min(CV_L(i,:)));
end

Rol_CV_Level = [CV_L, location_CV_L];
save('.\Results\Rol_CV_Level','Rol_CV_Level');
%% Find out the Kappa represented by the smallest value in both HCV and MHCV. 
% The possible values for Kappa are 2, 4, 6, 8, 10, or 12. Calculate the corresponding frequencies of each.
optimal_kappa_L=zeros(245*2,1);
num_L_hcv_ka2=0;
num_L_hcv_ka3=0;
num_L_hcv_ka5=0;
for i=1:2:245*2
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
for i=2:2:245*2
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


%% Slope factor

CV_S=zeros(245*2,7); CV_S_med=zeros(2,7);
for i=1:245
    i
   bdraw0 = [0.0609, 0.0001]';
Mt=[3,12,24,36,48,60];
% warning('off')
Y_med=Y(i+318:i+557,:);
[bdraw_mle,mu,Phi,Omiga,Phi_Q_mle,B_1_mle,sigma,X_mle,VCV,Y_bar_mle,mu_std,Phi_std] = step_3_Q(Y_med',Mt,bdraw0);
 NS=[];
NS=X_mle';   
CV_S_med=CV_Single_FFF(NS(:,2),z_86_1952(i+318:i+557,2:end));
CV_S(2*(i-1)+1:2*i,:)=CV_S_med;
end


%%  Find the positions of the smallest values in HCV and MHCV, in columns 1, 2, 3, 4, 5, 6, and 7.
for i=1:245*2
    location_CV_S(i,1)=find(CV_S(i,:)==min(CV_S(i,:)));
end

Rol_CV_Slope = [CV_S, location_CV_S];
save('.\Results\Rol_CV_Slope','Rol_CV_Slope');
%% Find out the Kappa represented by the smallest value in both HCV and MHCV. 
% The possible values for Kappa are 2, 4, 6, 8, 10, or 12. Calculate the corresponding frequencies of each.
optimal_kappa_S=zeros(245*2,1);
num_S_hcv_ka2=0;
num_S_hcv_ka3=0;
num_S_hcv_ka5=0;
for i=1:2:245*2
    if location_CV_S(i,1)==1
        num_S_hcv_ka2=num_S_hcv_ka2+1;
        optimal_kappa_S(i,1)=2;
    elseif location_CV_S(i,1)==2
        num_S_hcv_ka3=num_S_hcv_ka3+1;
        optimal_kappa_S(i,1)=3;
    else
        num_S_hcv_ka5=num_S_hcv_ka5+1;
        optimal_kappa_S(i,1)=5; 
    end
end
num_S_mhcv_ka2=0;
num_S_mhcv_ka3=0;
num_S_mhcv_ka5=0;
for i=2:2:245*2
    if location_CV_S(i,1)==1
        num_S_mhcv_ka2=num_S_mhcv_ka2+1;
        optimal_kappa_S(i,1)=2;
    elseif location_CV_S(i,1)==2
        num_S_mhcv_ka3=num_S_mhcv_ka3+1;
        optimal_kappa_S(i,1)=3;
    else
        num_S_mhcv_ka5=num_S_mhcv_ka5+1;
        optimal_kappa_S(i,1)=5; 
    end
end
num_S=[num_S_hcv_ka2,num_S_hcv_ka3,num_S_hcv_ka5;num_S_mhcv_ka2,num_S_mhcv_ka3,num_S_mhcv_ka5]
