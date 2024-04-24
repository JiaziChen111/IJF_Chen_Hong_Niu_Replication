%% This file produces the results for Table 12 to Table 14 in the paper.
clear all; close all; clc;
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JAE_Data'

addpath(genpath('./Data'));
addpath(genpath('./Functions'));

%% H-block cross-validation

tic
DNS_FD_L_u_Recursive_CV_JAE;
toc % 57.925 mins

%% Run the five models in Table 7 

DNS_FD_L_u_JAE; % Note: Since the MHCV typically chooses Kappa=2 in most cases, we directly set Kappa=2.
                % Using the exact Kappa value chosen by MHCV yields very similar forecasting results and 
                % does not significantly impact our forecasting outcomes of Table 12 to 14.
RZIG_JAE
RW_JAE
DNS_JAE
DNS_MY_L_u_JAE
DNS_MA_u_JAE

%% load forecasting results
clear all;
addpath(genpath('./Results'));

load Rec_DNS_FD_L_JAE.mat
load Rec_RZIG_JAE.mat
load Rec_RW_JAE.mat
load Rec_DNS_JAE.mat                                                                                        
load Rec_DNS_MY_L_JAE.mat
load Rec_DNS_MA_u_JAE.mat
load Rec_Actual_JAE.mat

%% RMSFE
DNS_FD_L=RMSFE_PK_JAE(Rec_DNS_FD_L_JAE,Rec_Actual_JAE);
RZIG=RMSFE_PK_JAE(Rec_RZIG_JAE,Rec_Actual_JAE);
RW=RMSFE_PK_JAE(Rec_RW_JAE,Rec_Actual_JAE);
DNS=RMSFE_PK_JAE(Rec_DNS_JAE,Rec_Actual_JAE);
DNS_MY_L=RMSFE_PK_JAE(Rec_DNS_MY_L_JAE,Rec_Actual_JAE);
DNS_MA=RMSFE_PK_JAE(Rec_DNS_MA_u_JAE,Rec_Actual_JAE);

%% RMSFE: Table 12 
Mat=[3,6,9,12,15,18,21,24,30,36,48,60,72,84,96,108,120];

% h=6M
RMSFE_h6=zeros(17,6);
RMSFE_h6(:,1)=DNS_FD_L(:,1); RMSFE_h6(:,2)=RZIG(:,1); RMSFE_h6(:,3)=RW(:,1);
RMSFE_h6(:,4)=DNS(:,1); RMSFE_h6(:,5)=DNS_MY_L(:,1); RMSFE_h6(:,6)=DNS_MA(:,1);

Table12_RMSFE_h6=[Mat',RMSFE_h6]' %
xlswrite('Table12_to_14.xlsx',Table12_RMSFE_h6(2:end,:),'Table12_RMSFE',strcat("B",num2str(4)));

% h=12M
RMSFE_h12=zeros(17,6);
RMSFE_h12(:,1)=DNS_FD_L(:,2); RMSFE_h12(:,2)=RZIG(:,2); RMSFE_h12(:,3)=RW(:,2);
RMSFE_h12(:,4)=DNS(:,2); RMSFE_h12(:,5)=DNS_MY_L(:,2); RMSFE_h12(:,6)=DNS_MA(:,2);

Table12_RMSFE_h12=[Mat',RMSFE_h12]' %
xlswrite('Table12_to_14.xlsx',Table12_RMSFE_h12(2:end,:),'Table12_RMSFE',strcat("B",num2str(11)));


% h=24M
RMSFE_h24=zeros(17,6);
RMSFE_h24(:,1)=DNS_FD_L(:,3); RMSFE_h24(:,2)=RZIG(:,3); RMSFE_h24(:,3)=RW(:,3);
RMSFE_h24(:,4)=DNS(:,3); RMSFE_h24(:,5)=DNS_MY_L(:,3); RMSFE_h24(:,6)=DNS_MA(:,3);

Table12_RMSFE_h24=[Mat',RMSFE_h24]' %
xlswrite('Table12_to_14.xlsx',Table12_RMSFE_h24(2:end,:),'Table12_RMSFE',strcat("B",num2str(18)));


%%   Squared forecast errors
DNS_FD_L=Loss_SFE_JAE(Rec_DNS_FD_L_JAE,Rec_Actual_JAE);

RZIG=Loss_SFE_JAE(Rec_RZIG_JAE,Rec_Actual_JAE);

RW=Loss_SFE_JAE(Rec_RW_JAE,Rec_Actual_JAE);

DNS=Loss_SFE_JAE(Rec_DNS_JAE,Rec_Actual_JAE);

DNS_MY_L=Loss_SFE_JAE(Rec_DNS_MY_L_JAE,Rec_Actual_JAE);

DNS_MA=Loss_SFE_JAE(Rec_DNS_MA_u_JAE,Rec_Actual_JAE);


% Competing Models: DNS_FD_L, RZIG, RW, DNS, DNS_MY_L, DNS_MA, total 6 models
 [Loss_h6,Loss_h12,Loss_h24] = Loss_SFE_Arrangement_JAE(DNS_FD_L, RZIG, RW, DNS, DNS_MY_L, DNS_MA);

%
names=["DNS_FD_L", "RZIG", "RW", "DNS", "DNS_MY_L", "DNS_MA"];

alpha=0.1; B=10000; w=12; boot='BLOCK';

Mat=[3,6,9,12,15,18,21,24,30,36,48,60,72,84,96,108,120];
%% h=6M
seed=888;
rng(seed) 
MCS_h6_all=MCS_Arrangement_JAE(Loss_h6,alpha,B,w,boot,names);
Table14_MCS_p_h6 = [Mat;MCS_h6_all]   %  Table 14: Panel A
xlswrite('Table12_to_14.xlsx',Table14_MCS_p_h6(2:end,:),'Table14_MCS_p',strcat("B",num2str(4)));

% h=12M
seed=888;
rng(seed) 
MCS_h12_all=MCS_Arrangement_JAE(Loss_h12,alpha,B,w,boot,names);
Table14_MCS_p_h12 = [Mat;MCS_h12_all]   %  Table 14: Panel B
xlswrite('Table12_to_14.xlsx',Table14_MCS_p_h12(2:end,:),'Table14_MCS_p',strcat("B",num2str(11)));

% h=24M
seed=888;
rng(seed) 
MCS_h24_all=MCS_Arrangement_JAE(Loss_h24,alpha,B,w,boot,names);
Table14_MCS_p_h24 = [Mat;MCS_h24_all]   %  Table 14: Panel C
xlswrite('Table12_to_14.xlsx',Table14_MCS_p_h24(2:end,:),'Table14_MCS_p',strcat("B",num2str(18)));

%% Frequency of inclusion in the 90% MCSs across 17 different maturities: Table 13
fre_h6=frequency_incld_JAE(MCS_h6_all);
fre_h12=frequency_incld_JAE(MCS_h12_all);
fre_h24=frequency_incld_JAE(MCS_h24_all);
Table13_MCS_freq=[fre_h6,fre_h12,fre_h24]'

xlswrite('Table12_to_14.xlsx',Table13_MCS_freq,'Table13_MCS_freq',strcat("B",num2str(3)));

