%% This file produces the results for Table 7 and Table 8 in the paper.
clear all; close all; clc;
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JEDC_Data'

addpath(genpath('./Data'));
addpath(genpath('./Functions'));

%% H-block cross-validation

tic
DNS_FD_L_u_CV_JEDC;
toc % 4.05 mins

%% Run the five models in Table 7 

RW_JEDC; 
FADNS_nfwrd_JEDC;
FADNS_whole_JEDC;
FADNS_fwrd_JEDC;
DNS_FD_L_u_JEDC;

%% Load the results
clear all;
addpath(genpath('./Results'));
load Rec_RW.mat
load Rec_FADNS_nfwrd.mat
load Rec_FADNS_whole.mat
load Rec_FADNS_fwrd.mat
load Rec_DNS_FD_L_u.mat
load Rec_Actual.mat

% Caculate RMSFEs
RW=RMSFE_PK(Rec_RW,Rec_Actual);
FADNS_nfwrd=RMSFE_PK(Rec_FADNS_nfwrd,Rec_Actual);
FADNS_whole=RMSFE_PK(Rec_FADNS_whole,Rec_Actual);
FADNS_fwrd=RMSFE_PK(Rec_FADNS_fwrd,Rec_Actual);
DNS_FD_L_u=RMSFE_PK(Rec_DNS_FD_L_u,Rec_Actual);

%% Table 7 in the paper

% h=2Q/6M
RMSFE_h2=zeros(15,5);
RMSFE_h2(:,1)=RW(:,2);
RMSFE_h2(:,2)=FADNS_nfwrd(:,2); 
RMSFE_h2(:,3)=FADNS_whole(:,2);
RMSFE_h2(:,4)=FADNS_fwrd(:,2); 
RMSFE_h2(:,5)=DNS_FD_L_u(:,2); 
Table7_RMSFE_h6m = RMSFE_h2
xlswrite('Table7_to_8.xlsx',Table7_RMSFE_h6m,'Table7_RMSFE',strcat("B",num2str(4)));

% h=4Q/12M
RMSFE_h4=zeros(15,5);
RMSFE_h4(:,1)=RW(:,3);
RMSFE_h4(:,2)=FADNS_nfwrd(:,3); 
RMSFE_h4(:,3)=FADNS_whole(:,3);
RMSFE_h4(:,4)=FADNS_fwrd(:,3); 
RMSFE_h4(:,5)=DNS_FD_L_u(:,3); 
Table7_RMSFE_h12m = RMSFE_h4
xlswrite('Table7_to_8.xlsx',Table7_RMSFE_h12m,'Table7_RMSFE',strcat("H",num2str(4)));

% h=8Q/24M
RMSFE_h8=zeros(15,5);
RMSFE_h8(:,1)=RW(:,4);
RMSFE_h8(:,2)=FADNS_nfwrd(:,4); 
RMSFE_h8(:,3)=FADNS_whole(:,4);
RMSFE_h8(:,4)=FADNS_fwrd(:,4); 
RMSFE_h8(:,5)=DNS_FD_L_u(:,4); 
Table7_RMSFE_h24m = RMSFE_h8
xlswrite('Table7_to_8.xlsx',Table7_RMSFE_h24m,'Table7_RMSFE',strcat("B",num2str(20)));

% h=12Q/36M
RMSFE_h12=zeros(15,5);
RMSFE_h12(:,1)=RW(:,5);
RMSFE_h12(:,2)=FADNS_nfwrd(:,5); 
RMSFE_h12(:,3)=FADNS_whole(:,5);
RMSFE_h12(:,4)=FADNS_fwrd(:,5); 
RMSFE_h12(:,5)=DNS_FD_L_u(:,5); 
Table7_RMSFE_h36m = RMSFE_h12
xlswrite('Table7_to_8.xlsx',Table7_RMSFE_h36m,'Table7_RMSFE',strcat("H",num2str(20)));

% h=16Q/48M
RMSFE_h16=zeros(15,5);
RMSFE_h16(:,1)=RW(:,6);
RMSFE_h16(:,2)=FADNS_nfwrd(:,6); 
RMSFE_h16(:,3)=FADNS_whole(:,6);
RMSFE_h16(:,4)=FADNS_fwrd(:,6); 
RMSFE_h16(:,5)=DNS_FD_L_u(:,6); 
Table7_RMSFE_h48m = RMSFE_h16
xlswrite('Table7_to_8.xlsx',Table7_RMSFE_h48m,'Table7_RMSFE',strcat("B",num2str(36)));

% h=20Q/60M
RMSFE_h20=zeros(15,5);
RMSFE_h20(:,1)=RW(:,7);
RMSFE_h20(:,2)=FADNS_nfwrd(:,7); 
RMSFE_h20(:,3)=FADNS_whole(:,7);
RMSFE_h20(:,4)=FADNS_fwrd(:,7); 
RMSFE_h20(:,5)=DNS_FD_L_u(:,7); 
Table7_RMSFE_h60m = RMSFE_h20
xlswrite('Table7_to_8.xlsx',Table7_RMSFE_h60m,'Table7_RMSFE',strcat("H",num2str(36)));

%%   MCS caculation

% Loss
RW=Loss_SFE(Rec_RW,Rec_Actual);
FADNS_nfwrd=Loss_SFE(Rec_FADNS_nfwrd,Rec_Actual);
FADNS_whole=Loss_SFE(Rec_FADNS_whole,Rec_Actual);
FADNS_fwrd=Loss_SFE(Rec_FADNS_fwrd,Rec_Actual);
DNS_FD_L_u=Loss_SFE(Rec_DNS_FD_L_u,Rec_Actual);

%
% Competing Models: RW,FADNS_nfwrd, FADNS_whole, FADNS_fwrd, DNS_FD_L^u, total 5 models
 [Loss_h1,Loss_h2,Loss_h4,Loss_h8,Loss_h12,Loss_h16,Loss_h20] = Loss_SFE_order(RW,FADNS_nfwrd,FADNS_whole,...
     FADNS_fwrd,DNS_FD_L_u);
 

names=["RW","FADNS_nfwrd","FADNS_whole","FADNS_fwrd","DNS_FD_L_u"];

alpha=0.1; B=10000; w=12; boot='BLOCK';


% h=2Q/6M
seed=888;
rng(seed) 
MCS_h2_all=MCS_order(Loss_h2,alpha,B,w,boot,names);
MCS_h2_all_transpose=MCS_h2_all';

% h=4Q/12M
seed=888;
rng(seed) 
MCS_h4_all=MCS_order(Loss_h4,alpha,B,w,boot,names);
MCS_h4_all_transpose=MCS_h4_all';

% h=8Q/24M
seed=888;
rng(seed) 
MCS_h8_all=MCS_order(Loss_h8,alpha,B,w,boot,names);
MCS_h8_all_transpose=MCS_h8_all';

% h=12Q/36M
seed=888;
rng(seed) 
MCS_h12_all=MCS_order(Loss_h12,alpha,B,w,boot,names);
MCS_h12_all_transpose=MCS_h12_all';

% h=16Q/48M
seed=888;
rng(seed) 
MCS_h16_all=MCS_order(Loss_h16,alpha,B,w,boot,names);
MCS_h16_all_transpose=MCS_h16_all';

% h=20Q/60M
seed=888;
rng(seed) 
MCS_h20_all=MCS_order(Loss_h20,alpha,B,w,boot,names);
MCS_h20_all_transpose=MCS_h20_all';

% Frequency of inclusion in the 90% MCSs across 15 different maturities
fre_h2=frequency_incld(MCS_h2_all);
fre_h4=frequency_incld(MCS_h4_all);
fre_h8=frequency_incld(MCS_h8_all);
fre_h12=frequency_incld(MCS_h12_all);
fre_h16=frequency_incld(MCS_h16_all);
fre_h20=frequency_incld(MCS_h20_all);
Table8_MCS_freq=[fre_h2,fre_h4,fre_h8,fre_h12,fre_h16,fre_h20]
xlswrite('Table7_to_8.xlsx',Table8_MCS_freq,'Table8_MCS_freq',strcat("B",num2str(3)));

