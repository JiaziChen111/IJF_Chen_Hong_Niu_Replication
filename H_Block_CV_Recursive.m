%% H-block cross-validation

clear all; close all; clc;
cd 'Z:\User\IJF_Chen_Hong_Niu_Replication'

addpath(genpath('./Data'));
addpath(genpath('./Functions'));

tic
DNS_FD_LS_u_Recursive_CV;
toc  % 34.0335 hours
