%% This file produces the results for Table 15 to Table 16 in the paper.
clear all; close all; clc;
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication'

addpath(genpath('./Data'));
addpath(genpath('./Functions'));
%% Run the six models in Table 15 using recursive windows

DNS_FD_LS_u_Recursive;     % Note: Before you run it, please run the DNS_FD_LS_u_Recursive.m first to get the MHCV results
DNS_FD_s_Recursive;        % Note: we follow the MHCS results of DNS_FD_LS_u_Recursive.m, and set Kappa = 5 directly.
DNS_FD_L_u_RZG_Recursive;  % Note: Before you run it, please run the DNS_FD_LS_u_Recursive.m first to get the MHCV results
DNS_FD_L_u_RZIG_Recursive; % Note: Before you run it, please run the DNS_FD_LS_u_Recursive.m first to get the MHCV results
DNS_FD_L_u_Recursive;      % Note: Before you run it, please run the DNS_FD_LS_u_Recursive.m first to get the MHCV results
RZIG_Recursive;

%% load the results
clear all;
addpath(genpath('./Results'));

load Rec_DNS_FD_LS_u.mat
load Rec_DNS_FD_s.mat
load Rec_DNS_FD_L_u_RZG.mat
load Rec_DNS_FD_L_u_RZIG.mat
load Rec_DNS_FD_L_u.mat
load Rec_RZIG.mat
load Rec_Actual.mat

%% Caculate the RMSFE
DNS_FD_LS_u = RMSFE_PK(Rec_DNS_FD_LS_u,Rec_Actual);
DNS_FD_s = RMSFE_PK(Rec_DNS_FD_s,Rec_Actual);
DNS_FD_L_u_RZG = RMSFE_PK(Rec_DNS_FD_L_u_RZG,Rec_Actual);
DNS_FD_L_u_RZIG = RMSFE_PK(Rec_DNS_FD_L_u_RZIG,Rec_Actual);
DNS_FD_L_u = RMSFE_PK(Rec_DNS_FD_L_u,Rec_Actual);
RZIG = RMSFE_PK(Rec_RZIG,Rec_Actual);
%% Table 15 in the paper: DNS_FD_LS_u, DNS_FD_s, DNS_FD_L_u_RZG, DNS_FD_L_u_RZIG, 
% DNS_FD_L_u, RZIG

% h=6M
RMSFE_h6=zeros(6,6);
RMSFE_h6(1,:)=DNS_FD_LS_u(:,2)';
RMSFE_h6(2,:)=DNS_FD_s(:,2)'; 
RMSFE_h6(3,:)=DNS_FD_L_u_RZG(:,2)';
RMSFE_h6(4,:)=DNS_FD_L_u_RZIG(:,2)'; 
RMSFE_h6(5,:)=DNS_FD_L_u(:,2)'; 
RMSFE_h6(6,:)=RZIG(:,2)';
Table15_RMSFE_h6 = RMSFE_h6
xlswrite('Table15_to_16.xlsx',Table15_RMSFE_h6,'Table15_RMSFE_Recursive',strcat("B",num2str(4)));

% h=12M
RMSFE_h12=zeros(6,6);
RMSFE_h12(1,:)=DNS_FD_LS_u(:,3)';
RMSFE_h12(2,:)=DNS_FD_s(:,3)'; 
RMSFE_h12(3,:)=DNS_FD_L_u_RZG(:,3)';
RMSFE_h12(4,:)=DNS_FD_L_u_RZIG(:,3)'; 
RMSFE_h12(5,:)=DNS_FD_L_u(:,3)'; 
RMSFE_h12(6,:)=RZIG(:,3)';
Table15_RMSFE_h12 = RMSFE_h12
xlswrite('Table15_to_16.xlsx',Table15_RMSFE_h12,'Table15_RMSFE_Recursive',strcat("I",num2str(4)));

% h=24M
RMSFE_h24=zeros(6,6);
RMSFE_h24(1,:)=DNS_FD_LS_u(:,4)';
RMSFE_h24(2,:)=DNS_FD_s(:,4)'; 
RMSFE_h24(3,:)=DNS_FD_L_u_RZG(:,4)';
RMSFE_h24(4,:)=DNS_FD_L_u_RZIG(:,4)'; 
RMSFE_h24(5,:)=DNS_FD_L_u(:,4)'; 
RMSFE_h24(6,:)=RZIG(:,4)';
Table15_RMSFE_h24 = RMSFE_h24
xlswrite('Table15_to_16.xlsx',Table15_RMSFE_h24,'Table15_RMSFE_Recursive',strcat("B",num2str(11)));

% h=36M
RMSFE_h36=zeros(6,6);
RMSFE_h36(1,:)=DNS_FD_LS_u(:,5)';
RMSFE_h36(2,:)=DNS_FD_s(:,5)'; 
RMSFE_h36(3,:)=DNS_FD_L_u_RZG(:,5)';
RMSFE_h36(4,:)=DNS_FD_L_u_RZIG(:,5)'; 
RMSFE_h36(5,:)=DNS_FD_L_u(:,5)'; 
RMSFE_h36(6,:)=RZIG(:,5)';
Table15_RMSFE_h36 = RMSFE_h36
xlswrite('Table15_to_16.xlsx',Table15_RMSFE_h36,'Table15_RMSFE_Recursive',strcat("I",num2str(11)));

% h=48M
RMSFE_h48=zeros(6,6);
RMSFE_h48(1,:)=DNS_FD_LS_u(:,6)';
RMSFE_h48(2,:)=DNS_FD_s(:,6)'; 
RMSFE_h48(3,:)=DNS_FD_L_u_RZG(:,6)';
RMSFE_h48(4,:)=DNS_FD_L_u_RZIG(:,6)'; 
RMSFE_h48(5,:)=DNS_FD_L_u(:,6)'; 
RMSFE_h48(6,:)=RZIG(:,6)';
Table15_RMSFE_h48 = RMSFE_h48
xlswrite('Table15_to_16.xlsx',Table15_RMSFE_h48,'Table15_RMSFE_Recursive',strcat("B",num2str(18)));

% h=60M
RMSFE_h60=zeros(6,6);
RMSFE_h60(1,:)=DNS_FD_LS_u(:,7)';
RMSFE_h60(2,:)=DNS_FD_s(:,7)'; 
RMSFE_h60(3,:)=DNS_FD_L_u_RZG(:,7)';
RMSFE_h60(4,:)=DNS_FD_L_u_RZIG(:,7)'; 
RMSFE_h60(5,:)=DNS_FD_L_u(:,7)'; 
RMSFE_h60(6,:)=RZIG(:,7)';
Table15_RMSFE_h60 = RMSFE_h60
xlswrite('Table15_to_16.xlsx',Table15_RMSFE_h60,'Table15_RMSFE_Recursive',strcat("I",num2str(18)));

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Run the six models in Table 16 using recursive windows

DNS_FD_LS_u_Rolling;     % Note: Before you run it, please run the DNS_FD_LS_u_Rolling.m first to get the MHCV results
DNS_FD_s_Rolling;        % Note: we follow the MHCS results of DNS_FD_LS_u_Rolling.m, and set Kappa = 2 directly.
DNS_FD_L_u_RZG_Rolling;  % Note: Before you run it, please run the DNS_FD_LS_u_Rolling.m first to get the MHCV results
DNS_FD_L_u_RZIG_Rolling; % Note: Before you run it, please run the DNS_FD_LS_u_Rolling.m first to get the MHCV results
DNS_FD_L_u_Rolling;      % Note: Before you run it, please run the DNS_FD_LS_u_Rolling.m first to get the MHCV results
RZIG_Rolling;


%% load the results
clear all;
addpath(genpath('./Results'));
load Rol_DNS_FD_LS_u.mat
load Rol_DNS_FD_s.mat
load Rol_DNS_FD_L_u_RZG.mat
load Rol_DNS_FD_L_u_RZIG.mat
load Rol_DNS_FD_L_u.mat
load Rol_RZIG.mat
load Rol_Actual.mat

%% Caculate the RMSFE
DNS_FD_LS_u = RMSFE_PK(Rol_DNS_FD_LS_u,Rol_Actual);
DNS_FD_s = RMSFE_PK(Rol_DNS_FD_s,Rol_Actual);
DNS_FD_L_u_RZG = RMSFE_PK(Rol_DNS_FD_L_u_RZG,Rol_Actual);
DNS_FD_L_u_RZIG = RMSFE_PK(Rol_DNS_FD_L_u_RZIG,Rol_Actual);
DNS_FD_L_u = RMSFE_PK(Rol_DNS_FD_L_u,Rol_Actual);
RZIG = RMSFE_PK(Rol_RZIG,Rol_Actual);
%% Table 16 in the paper: DNS_FD_LS_u, DNS_FD_s, DNS_FD_L_u_RZG, DNS_FD_L_u_RZIG, 
% DNS_FD_L_u, RZIG


% h=6M
RMSFE_h6=zeros(6,6);
RMSFE_h6(1,:)=DNS_FD_LS_u(:,2)';
RMSFE_h6(2,:)=DNS_FD_s(:,2)'; 
RMSFE_h6(3,:)=DNS_FD_L_u_RZG(:,2)';
RMSFE_h6(4,:)=DNS_FD_L_u_RZIG(:,2)'; 
RMSFE_h6(5,:)=DNS_FD_L_u(:,2)'; 
RMSFE_h6(6,:)=RZIG(:,2)';
Table16_RMSFE_h6 = RMSFE_h6
xlswrite('Table15_to_16.xlsx',Table16_RMSFE_h6,'Table16_RMSFE_Rolling',strcat("B",num2str(4)));

% h=12M
RMSFE_h12=zeros(6,6);
RMSFE_h12(1,:)=DNS_FD_LS_u(:,3)';
RMSFE_h12(2,:)=DNS_FD_s(:,3)'; 
RMSFE_h12(3,:)=DNS_FD_L_u_RZG(:,3)';
RMSFE_h12(4,:)=DNS_FD_L_u_RZIG(:,3)'; 
RMSFE_h12(5,:)=DNS_FD_L_u(:,3)'; 
RMSFE_h12(6,:)=RZIG(:,3)';
Table16_RMSFE_h12 = RMSFE_h12
xlswrite('Table15_to_16.xlsx',Table16_RMSFE_h12,'Table16_RMSFE_Rolling',strcat("I",num2str(4)));

% h=24M
RMSFE_h24=zeros(6,6);
RMSFE_h24(1,:)=DNS_FD_LS_u(:,4)';
RMSFE_h24(2,:)=DNS_FD_s(:,4)'; 
RMSFE_h24(3,:)=DNS_FD_L_u_RZG(:,4)';
RMSFE_h24(4,:)=DNS_FD_L_u_RZIG(:,4)'; 
RMSFE_h24(5,:)=DNS_FD_L_u(:,4)'; 
RMSFE_h24(6,:)=RZIG(:,4)';
Table16_RMSFE_h24 = RMSFE_h24
xlswrite('Table15_to_16.xlsx',Table16_RMSFE_h24,'Table16_RMSFE_Rolling',strcat("B",num2str(11)));

% h=36M
RMSFE_h36=zeros(6,6);
RMSFE_h36(1,:)=DNS_FD_LS_u(:,5)';
RMSFE_h36(2,:)=DNS_FD_s(:,5)'; 
RMSFE_h36(3,:)=DNS_FD_L_u_RZG(:,5)';
RMSFE_h36(4,:)=DNS_FD_L_u_RZIG(:,5)'; 
RMSFE_h36(5,:)=DNS_FD_L_u(:,5)'; 
RMSFE_h36(6,:)=RZIG(:,5)';
Table16_RMSFE_h36 = RMSFE_h36
xlswrite('Table15_to_16.xlsx',Table16_RMSFE_h36,'Table16_RMSFE_Rolling',strcat("I",num2str(11)));

% h=48M
RMSFE_h48=zeros(6,6);
RMSFE_h48(1,:)=DNS_FD_LS_u(:,6)';
RMSFE_h48(2,:)=DNS_FD_s(:,6)'; 
RMSFE_h48(3,:)=DNS_FD_L_u_RZG(:,6)';
RMSFE_h48(4,:)=DNS_FD_L_u_RZIG(:,6)'; 
RMSFE_h48(5,:)=DNS_FD_L_u(:,6)'; 
RMSFE_h48(6,:)=RZIG(:,6)';
Table16_RMSFE_h48 = RMSFE_h48
xlswrite('Table15_to_16.xlsx',Table16_RMSFE_h48,'Table16_RMSFE_Rolling',strcat("B",num2str(18)));

% h=60M
RMSFE_h60=zeros(6,6);
RMSFE_h60(1,:)=DNS_FD_LS_u(:,7)';
RMSFE_h60(2,:)=DNS_FD_s(:,7)'; 
RMSFE_h60(3,:)=DNS_FD_L_u_RZG(:,7)';
RMSFE_h60(4,:)=DNS_FD_L_u_RZIG(:,7)'; 
RMSFE_h60(5,:)=DNS_FD_L_u(:,7)'; 
RMSFE_h60(6,:)=RZIG(:,7)';
Table16_RMSFE_h60 = RMSFE_h60
xlswrite('Table15_to_16.xlsx',Table16_RMSFE_h60,'Table16_RMSFE_Rolling',strcat("I",num2str(18)));


