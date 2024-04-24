% (Naive) Random Walk(RWY): Recursive 
% 1st subsample is 1952:M6-1998:M11, last subsample is 1952:M6-2019:M3
clear all; close all; clc;
% cd 'Z:\User\IJF_Chen_Hong_Niu_Replication'
% 
% addpath(genpath('./Data'));
% addpath(genpath('./Functions'));
%% load data
% yield data
data_CRSP=xlsread('CRSP_monthly','Monthly');
yield=data_CRSP(1:805,:); % 3M,12M,24M,36M,48M,60M

%%
y_h3=zeros(245,6); y_h6=zeros(242,6); y_h12=zeros(236,6); y_h24=zeros(224,6);
y_h36=zeros(212,6); y_h48=zeros(200,6); y_h60=zeros(188,6);

y_h3=yield(558:end-3,:);   y_h6=yield(558:end-6,:); y_h12=yield(558:end-12,:);  y_h24=yield(558:end-24,:);

y_h36=yield(558:end-36,:);  y_h48=yield(558:end-48,:);  y_h60=yield(558:end-60,:); 
%% Save the results
Rec_RW=For_result_save(y_h3,y_h6,y_h12,y_h24,y_h36,y_h48,y_h60);
save('.\Results\Rec_RW','Rec_RW');

%% Actual values
actual_h3=zeros(245,6); actual_h6=zeros(242,6); actual_h12=zeros(236,6); actual_h24=zeros(224,6);
actual_h36=zeros(212,6); actual_h48=zeros(200,6); actual_h60=zeros(188,6);

actual_h3=yield(805-245+1:end,:);  actual_h6=yield(805-242+1:end,:);  actual_h12=yield(805-236+1:end,:); 
actual_h24=yield(805-224+1:end,:);  actual_h36=yield(805-212+1:end,:); actual_h48=yield(805-200+1:end,:); 
actual_h60=yield(805-188+1:end,:); 

%% Save the results
Rec_Actual=For_result_save(actual_h3,actual_h6,actual_h12,actual_h24,actual_h36,actual_h48,actual_h60);
save('.\Results\Rec_Actual','Rec_Actual');
