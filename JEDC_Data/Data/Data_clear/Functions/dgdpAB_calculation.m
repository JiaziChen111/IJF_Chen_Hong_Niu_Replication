%% Calculate: (1) Nominal GDP growth, average of current year (annual rate, sa) : NGDPA
%               (2) Real GDP growth, average of next year (annual rate, sa): RGDPA
%               (3) Nominal GDP growth, average of next year (annual rate,sa): NGDPB
% Method: Annual-Average Over Annual-Average Growth Rates (page 28 of the SDF documentation)
cd 'E:\Chen_Hong_Niu_IJF_DNS_FD\JEDC_Replication\Data\Raw'
clear all; close all; clc;
%%

ngdp_raw=xlsread('meanLevel','NGDP'); % Nominal GDP in level

rgdp_raw=xlsread('meanLevel','RGDP'); % Real GDP in level

 %% 
% % (1) Nominal GDP growth, average of current year (annual rate, sa): dngdpA
% ngdp_current_growth=zeros((2023-1983+1)*4,3);
% ngdp_current_growth(:,1:2)=ngdp_raw(58:end,1:2);
% for i =1:(2023-1983+1)
%     annual_med=ngdp_raw(53+4*(i-1)+1:53+4*(i-1)+8,9);
%     annual_growth_med= annual_growth_quarter(annual_med);
%     ngdp_current_growth(4*(i-1)+1:4*i,3)=annual_growth_med; 
% end
% 
% % (2) Nominal GDP growth, average of next year (annual rate, sa): dngdpB
% ngdp_next_growth=zeros((2023-1983+1)*4,3);
% ngdp_next_growth(:,1:2)=ngdp_raw(58:end,1:2);
% for i =1:(2023-1983+1)
%     annual_med=ngdp_raw(53+4*(i-1)+1:53+4*(i-1)+8,10);
%     annual_growth_med= annual_growth_quarter(annual_med);
%     ngdp_next_growth(4*(i-1)+1:4*i,3)=annual_growth_med; 
% end
% 
% % (3) Real GDP growth, average of next year (annual rate, sa): drgdpB
% rgdp_next_growth=zeros((2023-1983+1)*4,3);
% rgdp_next_growth(:,1:2)=rgdp_raw(58:end,1:2);
% for i =1:(2023-1983+1)
%     annual_med=rgdp_raw(53+4*(i-1)+1:53+4*(i-1)+8,10);
%     annual_growth_med= annual_growth_quarter(annual_med);
%     rgdp_next_growth(4*(i-1)+1:4*i,3)=annual_growth_med; 
% end

%% 
% (1) Nominal GDP growth, average of current year (annual rate, sa): dngdpA
ngdp_current_growth=zeros((2023-1983+1)*4,3);
ngdp_current_growth(:,1:2)=ngdp_raw(58:end,1:2);
for i =1:(2023-1983+1)
    annual_med=ngdp_raw(53+4*(i-1)+1:53+4*(i-1)+8,9);
    annual_growth_med= annual_growth_quarter_yoy(annual_med);
    ngdp_current_growth(4*(i-1)+1:4*i,3)=annual_growth_med; 
end

% (2) Nominal GDP growth, average of next year (annual rate, sa): dngdpB
ngdp_next_growth=zeros((2023-1983+1)*4,3);
ngdp_next_growth(:,1:2)=ngdp_raw(58:end,1:2);
for i =1:(2023-1983+1)
    annual_med=ngdp_raw(53+4*(i-1)+1:53+4*(i-1)+8,10);
    annual_growth_med= annual_growth_quarter_yoy(annual_med);
    ngdp_next_growth(4*(i-1)+1:4*i,3)=annual_growth_med; 
end

% (3) Real GDP growth, average of next year (annual rate, sa): drgdpB
rgdp_next_growth=zeros((2023-1983+1)*4,3);
rgdp_next_growth(:,1:2)=rgdp_raw(58:end,1:2);
for i =1:(2023-1983+1)
    annual_med=rgdp_raw(53+4*(i-1)+1:53+4*(i-1)+8,10);
    annual_growth_med= annual_growth_quarter_yoy(annual_med);
    rgdp_next_growth(4*(i-1)+1:4*i,3)=annual_growth_med; 
end