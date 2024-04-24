%% This file produces the results for Table 6 in the paper.
clear all; close all; clc;
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\Spuriousness_check\2019M7_2022M6'

addpath(genpath('./Data'));
addpath(genpath('./Functions'));

%% H-block cross-validation

tic
DNS_FD_L_u_CV_new_sample;
toc % 6.7624 hours, MHCV Results: Kappa=5

%% Run the five models in Table 6 using new samples

DNS_FD_L_u_new_sample; 
RZIG_new_sample
RW_new_sample
DNS_new_sample
DNS_MY_L_u_new_sample
DNS_MA_u_new_sample

%% load forecasting results
clear all;
addpath(genpath('./Results'));

load Rec_DNS_FD_L_u.mat
load Rec_RZIG.mat
load Rec_RW.mat
load Rec_DNS.mat                                                                                        
load Rec_DNS_MY_L_u.mat
load Rec_DNS_MA_u.mat
load Rec_Actual.mat

%% caculate the RMSFE of each model and their ratios with respect to the RW model
DNS_FD_L_u=RMSFE_PK_new(Rec_DNS_FD_L_u,Rec_Actual);
RZIG=RMSFE_PK_new(Rec_RZIG,Rec_Actual);
DNS=RMSFE_PK_new(Rec_DNS,Rec_Actual);
DNS_MY_L_u=RMSFE_PK_new(Rec_DNS_MY_L_u,Rec_Actual);
DNS_MA_u=RMSFE_PK_new(Rec_DNS_MA_u,Rec_Actual);
RW=RMSFE_PK_new(Rec_RW,Rec_Actual);

DNS_FD_L_u_RW = DNS_FD_L_u./RW;
RZIG_RW = RZIG./RW;
DNS_RW = DNS./RW;
DNS_MY_L_u_RW = DNS_MY_L_u./RW;
DNS_MA_u_RW = DNS_MA_u./RW;

%% Table 6: RMSFE ratio with respective to the RW model
% h=6M
RMSFE_ratio_h6=zeros(5,6);
RMSFE_ratio_h6(1,:)=DNS_FD_L_u_RW(:,1)';
RMSFE_ratio_h6(2,:)=RZIG_RW(:,1)'; 
RMSFE_ratio_h6(3,:)=DNS_RW(:,1)';
RMSFE_ratio_h6(4,:)=DNS_MY_L_u_RW(:,1)'; 
RMSFE_ratio_h6(5,:)=DNS_MA_u_RW(:,1)'; 
Table6_rRMSFE_h6 = RMSFE_ratio_h6
xlswrite('Table6.xlsx',Table6_rRMSFE_h6,'Table6_rRMSFE',strcat("B",num2str(4)));

% h=12M
RMSFE_ratio_h12=zeros(5,6);
RMSFE_ratio_h12(1,:)=DNS_FD_L_u_RW(:,2)';
RMSFE_ratio_h12(2,:)=RZIG_RW(:,2)'; 
RMSFE_ratio_h12(3,:)=DNS_RW(:,2)';
RMSFE_ratio_h12(4,:)=DNS_MY_L_u_RW(:,2)'; 
RMSFE_ratio_h12(5,:)=DNS_MA_u_RW(:,2)'; 
Table6_rRMSFE_h12 = RMSFE_ratio_h12
xlswrite('Table6.xlsx',Table6_rRMSFE_h12,'Table6_rRMSFE',strcat("I",num2str(4)));

% h=24M
RMSFE_ratio_h24=zeros(5,6);
RMSFE_ratio_h24(1,:)=DNS_FD_L_u_RW(:,3)';
RMSFE_ratio_h24(2,:)=RZIG_RW(:,3)'; 
RMSFE_ratio_h24(3,:)=DNS_RW(:,3)';
RMSFE_ratio_h24(4,:)=DNS_MY_L_u_RW(:,3)'; 
RMSFE_ratio_h24(5,:)=DNS_MA_u_RW(:,3)'; 
Table6_rRMSFE_h24 = RMSFE_ratio_h24
xlswrite('Table6.xlsx',Table6_rRMSFE_h24,'Table6_rRMSFE',strcat("B",num2str(10)));

% h=36M
RMSFE_ratio_h36=zeros(5,6);
RMSFE_ratio_h36(1,:)=DNS_FD_L_u_RW(:,4)';
RMSFE_ratio_h36(2,:)=RZIG_RW(:,4)'; 
RMSFE_ratio_h36(3,:)=DNS_RW(:,4)';
RMSFE_ratio_h36(4,:)=DNS_MY_L_u_RW(:,4)'; 
RMSFE_ratio_h36(5,:)=DNS_MA_u_RW(:,4)'; 
Table6_rRMSFE_h36 = RMSFE_ratio_h36
xlswrite('Table6.xlsx',Table6_rRMSFE_h36,'Table6_rRMSFE',strcat("I",num2str(10)));

% h=48M
RMSFE_ratio_h48=zeros(5,6);
RMSFE_ratio_h48(1,:)=DNS_FD_L_u_RW(:,5)';
RMSFE_ratio_h48(2,:)=RZIG_RW(:,5)'; 
RMSFE_ratio_h48(3,:)=DNS_RW(:,5)';
RMSFE_ratio_h48(4,:)=DNS_MY_L_u_RW(:,5)'; 
RMSFE_ratio_h48(5,:)=DNS_MA_u_RW(:,5)'; 
Table6_rRMSFE_h48 = RMSFE_ratio_h48
xlswrite('Table6.xlsx',Table6_rRMSFE_h48,'Table6_rRMSFE',strcat("B",num2str(16)));

% h=60M
RMSFE_ratio_h60=zeros(5,6);
RMSFE_ratio_h60(1,:)=DNS_FD_L_u_RW(:,6)';
RMSFE_ratio_h60(2,:)=RZIG_RW(:,6)'; 
RMSFE_ratio_h60(3,:)=DNS_RW(:,6)';
RMSFE_ratio_h60(4,:)=DNS_MY_L_u_RW(:,6)'; 
RMSFE_ratio_h60(5,:)=DNS_MA_u_RW(:,6)'; 
Table6_rRMSFE_h60 = RMSFE_ratio_h60
xlswrite('Table6.xlsx',Table6_rRMSFE_h60,'Table6_rRMSFE',strcat("I",num2str(16)));
