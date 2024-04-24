%% This file produces the results for Table 9 to Table 11 in the paper.
clear all; close all; clc;
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication'

addpath(genpath('./Data'));
addpath(genpath('./Functions'));
%% Run the six models in Table 9 using rolling windows

DNS_FD_L_u_Rolling; % Note: Before you run it, please run the DNS_FD_LS_u_Rolling_CV.m first to get the MHCV results
RZIG_Rolling; 
RW_Rolling;
DNS_Rolling;
DNS_MY_L_u_Rolling;
DNS_MA_u_Rolling;

%% Load the forecasting results
clear all;
addpath(genpath('./Results'));
load Rol_DNS_FD_L_u.mat
load Rol_RZIG.mat
load Rol_RW.mat
load Rol_DNS.mat
load Rol_DNS_MY_L_u.mat
load Rol_DNS_MA_u.mat
load Rol_Actual.mat
%% Caculate the RMSFE
DNS_FD_L_u = RMSFE_PK(Rol_DNS_FD_L_u,Rol_Actual);
RZIG = RMSFE_PK(Rol_RZIG,Rol_Actual);
RW = RMSFE_PK(Rol_RW,Rol_Actual);
DNS = RMSFE_PK(Rol_DNS,Rol_Actual);
DNS_MY_L_u = RMSFE_PK(Rol_DNS_MY_L_u,Rol_Actual);
DNS_MA_u = RMSFE_PK(Rol_DNS_MA_u,Rol_Actual);

% Table 9 in the paper: DNS_FD_L_u, RZIG, RW, DNS, DNS_MY_L_u, DNS_MA_u
% Save the RMSFE results in Table9_to_11.xlsx
% h=6M
RMSFE_h6=zeros(6,6);
RMSFE_h6(1,:)=DNS_FD_L_u(:,2)';
RMSFE_h6(2,:)=RZIG(:,2)'; 
RMSFE_h6(3,:)=RW(:,2)';
RMSFE_h6(4,:)=DNS(:,2)'; 
RMSFE_h6(5,:)=DNS_MY_L_u(:,2)'; 
RMSFE_h6(6,:)=DNS_MA_u(:,2)';
Table9_RMSFE_h6 = RMSFE_h6
xlswrite('Table9_to_11.xlsx',Table9_RMSFE_h6,'Table9_RMSFE',strcat("B",num2str(4)));

% h=12M
RMSFE_h12=zeros(6,6);
RMSFE_h12(1,:)=DNS_FD_L_u(:,3)';
RMSFE_h12(2,:)=RZIG(:,3)'; 
RMSFE_h12(3,:)=RW(:,3)';
RMSFE_h12(4,:)=DNS(:,3)'; 
RMSFE_h12(5,:)=DNS_MY_L_u(:,3)'; 
RMSFE_h12(6,:)=DNS_MA_u(:,3)';
Table9_RMSFE_h12 = RMSFE_h12
xlswrite('Table9_to_11.xlsx',Table9_RMSFE_h12,'Table9_RMSFE',strcat("I",num2str(4)));

% h=24M
RMSFE_h24=zeros(6,6);
RMSFE_h24(1,:)=DNS_FD_L_u(:,4)';
RMSFE_h24(2,:)=RZIG(:,4)'; 
RMSFE_h24(3,:)=RW(:,4)';
RMSFE_h24(4,:)=DNS(:,4)'; 
RMSFE_h24(5,:)=DNS_MY_L_u(:,4)'; 
RMSFE_h24(6,:)=DNS_MA_u(:,4)';
Table9_RMSFE_h24 = RMSFE_h24
xlswrite('Table9_to_11.xlsx',Table9_RMSFE_h24,'Table9_RMSFE',strcat("B",num2str(11)));

% h=36M
RMSFE_h36=zeros(6,6);
RMSFE_h36(1,:)=DNS_FD_L_u(:,5)';
RMSFE_h36(2,:)=RZIG(:,5)'; 
RMSFE_h36(3,:)=RW(:,5)';
RMSFE_h36(4,:)=DNS(:,5)'; 
RMSFE_h36(5,:)=DNS_MY_L_u(:,5)'; 
RMSFE_h36(6,:)=DNS_MA_u(:,5)';
Table9_RMSFE_h36 = RMSFE_h36
xlswrite('Table9_to_11.xlsx',Table9_RMSFE_h36,'Table9_RMSFE',strcat("I",num2str(11)));

% h=48M
RMSFE_h48=zeros(6,6);
RMSFE_h48(1,:)=DNS_FD_L_u(:,6)';
RMSFE_h48(2,:)=RZIG(:,6)'; 
RMSFE_h48(3,:)=RW(:,6)';
RMSFE_h48(4,:)=DNS(:,6)'; 
RMSFE_h48(5,:)=DNS_MY_L_u(:,6)'; 
RMSFE_h48(6,:)=DNS_MA_u(:,6)';
Table9_RMSFE_h48 = RMSFE_h48
xlswrite('Table9_to_11.xlsx',Table9_RMSFE_h48,'Table9_RMSFE',strcat("B",num2str(18)));

% h=60M
RMSFE_h60=zeros(6,6);
RMSFE_h60(1,:)=DNS_FD_L_u(:,7)';
RMSFE_h60(2,:)=RZIG(:,7)'; 
RMSFE_h60(3,:)=RW(:,7)';
RMSFE_h60(4,:)=DNS(:,7)'; 
RMSFE_h60(5,:)=DNS_MY_L_u(:,7)'; 
RMSFE_h60(6,:)=DNS_MA_u(:,7)';
Table9_RMSFE_h60 = RMSFE_h60
xlswrite('Table9_to_11.xlsx',Table9_RMSFE_h60,'Table9_RMSFE',strcat("I",num2str(18)));

%% Loss: Square forecast error
DNS_FD_L_u=Loss_SFE(Rol_DNS_FD_L_u,Rol_Actual);
RZIG=Loss_SFE(Rol_RZIG,Rol_Actual);
RW=Loss_SFE(Rol_RW,Rol_Actual);
DNS=Loss_SFE(Rol_DNS,Rol_Actual);
DNS_MY_L_u=Loss_SFE(Rol_DNS_MY_L_u,Rol_Actual);
DNS_MA_u=Loss_SFE(Rol_DNS_MA_u,Rol_Actual);

% Competing Models: DNS_FD_L_u, RZIG, RW, DNS, DNS_MY_L_u, DNS_MA_u. total 6 models
 [Loss_h3,Loss_h6,Loss_h12,Loss_h24,Loss_h36,Loss_h48,Loss_h60] = Loss_SFE_order(DNS_FD_L_u,RZIG,...
    RW, DNS, DNS_MY_L_u, DNS_MA_u);
 

names=["DNS_FD_L_u","RZIG","RW","DNS","DNS_MY_L_u","DNS_MA_u"];

alpha=0.1; B=10000; w=12; boot='BLOCK';

% Table 4 in the paper: The MCS p-value of each model

% h=6M
seed=888;
rng(seed) 
MCS_h6_all=MCS_order(Loss_h6,alpha,B,w,boot,names);
Table11_MCS_p_h6 = MCS_h6_all
xlswrite('Table9_to_11.xlsx',Table11_MCS_p_h6,'Table11_MCS_p',strcat("B",num2str(4)));

% h=12M
seed=888;
rng(seed) 
MCS_h12_all=MCS_order(Loss_h12,alpha,B,w,boot,names);
Table11_MCS_p_h12 = MCS_h12_all
xlswrite('Table9_to_11.xlsx',Table11_MCS_p_h12,'Table11_MCS_p',strcat("I",num2str(4)));

% h=24M
seed=888;
rng(seed) 
MCS_h24_all=MCS_order(Loss_h24,alpha,B,w,boot,names);
Table11_MCS_p_h24 = MCS_h24_all
xlswrite('Table9_to_11.xlsx',Table11_MCS_p_h24,'Table11_MCS_p',strcat("B",num2str(11)));

% h=36M
seed=888;
rng(seed) 
MCS_h36_all=MCS_order(Loss_h36,alpha,B,w,boot,names);
Table11_MCS_p_h36 = MCS_h36_all
xlswrite('Table9_to_11.xlsx',Table11_MCS_p_h36,'Table11_MCS_p',strcat("I",num2str(11)));

% h=48M
seed=888;
rng(seed) 
MCS_h48_all=MCS_order(Loss_h48,alpha,B,w,boot,names);
Table11_MCS_p_h48 = MCS_h48_all
xlswrite('Table9_to_11.xlsx',Table11_MCS_p_h48,'Table11_MCS_p',strcat("B",num2str(18)));

% h=60M
seed=888;
rng(seed) 
MCS_h60_all=MCS_order(Loss_h60,alpha,B,w,boot,names);
Table11_MCS_p_h60 = MCS_h60_all
xlswrite('Table9_to_11.xlsx',Table11_MCS_p_h60,'Table11_MCS_p',strcat("I",num2str(18)));
%% Table 10 in the paper: Frequency of inclusion in the 90% MCSs across maturities
fre_h6=frequency_incld(MCS_h6_all);
fre_h12=frequency_incld(MCS_h12_all);
fre_h24=frequency_incld(MCS_h24_all);
fre_h36=frequency_incld(MCS_h36_all);
fre_h48=frequency_incld(MCS_h48_all);
fre_h60=frequency_incld(MCS_h60_all);
fre_all=[fre_h6,fre_h12,fre_h24,fre_h36,fre_h48,fre_h60];
Table10_MCS_freq = fre_all
xlswrite('Table9_to_11.xlsx',Table10_MCS_freq,'Table10_MCS_freq',strcat("B",num2str(3)));

