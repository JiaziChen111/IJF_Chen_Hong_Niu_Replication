% Replication of Van Dijk et al.(2014, JAE): FORECASTING INTEREST RATES WITH SHIFTING ENDPOINTS
% RWY
clear all; close all; clc;
% cd 'Z:\User\IJF_Chen_Hong_Niu_Replication\JAE_Data'
% 
% addpath(genpath('./Data'));
% addpath(genpath('./Functions'));
%% Load data
yield_original=importdata("UnsmFB_70-09.txt");

Mat=[3,6,9,12,15,18,21,24,30,36,48,60,72,84,96,108,120];
%%  RWY h=6M 
RW_h6=yield_original(284:475,1:18); % 1985M1-1993M7,..., 1985M1-2009M6
yield_actual=yield_original(290:481,1:18); % forecast:1994M1-2009M12
%  RMSFE: Mat=[3,6,9,12,15,18,21,24,30,36,48,60,72,84,96,108,120];
y_forecast=RW_h6(:,2:end);
rmsfe_3m=sqrt(sum((y_forecast(:,1)-yield_actual(:,2)).^2)/192);
rmsfe_6m=sqrt(sum((y_forecast(:,2)-yield_actual(:,3)).^2)/192);
rmsfe_9m=sqrt(sum((y_forecast(:,3)-yield_actual(:,4)).^2)/192);
rmsfe_12m=sqrt(sum((y_forecast(:,4)-yield_actual(:,5)).^2)/192);
rmsfe_15m=sqrt(sum((y_forecast(:,5)-yield_actual(:,6)).^2)/192);
rmsfe_18m=sqrt(sum((y_forecast(:,6)-yield_actual(:,7)).^2)/192);
rmsfe_21m=sqrt(sum((y_forecast(:,7)-yield_actual(:,8)).^2)/192);
rmsfe_24m=sqrt(sum((y_forecast(:,8)-yield_actual(:,9)).^2)/192);
rmsfe_30m=sqrt(sum((y_forecast(:,9)-yield_actual(:,10)).^2)/192);
rmsfe_36m=sqrt(sum((y_forecast(:,10)-yield_actual(:,11)).^2)/192);
rmsfe_48m=sqrt(sum((y_forecast(:,11)-yield_actual(:,12)).^2)/192);
rmsfe_60m=sqrt(sum((y_forecast(:,12)-yield_actual(:,13)).^2)/192);
rmsfe_72m=sqrt(sum((y_forecast(:,13)-yield_actual(:,14)).^2)/192);
rmsfe_84m=sqrt(sum((y_forecast(:,14)-yield_actual(:,15)).^2)/192);
rmsfe_96m=sqrt(sum((y_forecast(:,15)-yield_actual(:,16)).^2)/192);
rmsfe_108m=sqrt(sum((y_forecast(:,16)-yield_actual(:,17)).^2)/192);
rmsfe_120m=sqrt(sum((y_forecast(:,17)-yield_actual(:,18)).^2)/192);
%%% Mat=[3,6,9,12,15,18,21,24,30,36,48,60,72,84,96,108,120];
rmsfe_h6_display=[rmsfe_3m,rmsfe_6m,rmsfe_9m,rmsfe_12m,...
   rmsfe_15m, rmsfe_18m, rmsfe_21m, rmsfe_24m,...
   rmsfe_30m,rmsfe_36m,rmsfe_48m, rmsfe_60m, rmsfe_72m,...
   rmsfe_84m,rmsfe_96m, rmsfe_108m, rmsfe_120m];
% rmsfe_display_RWY_h6=[Mat;rmsfe_h6_display] %
%%  RWY h=12M 
RW_h12=yield_original(278:469,1:18); % 1985M1-1993M1,..., 1985M1-2008M12
yield_actual=yield_original(290:481,1:18); % forecast:1994M1-2009M12
%  RMSFE : Mat=[3,6,9,12,15,18,21,24,30,36,48,60,72,84,96,108,120];
y_forecast=RW_h12(:,2:end);
rmsfe_3m=sqrt(sum((y_forecast(:,1)-yield_actual(:,2)).^2)/192);
rmsfe_6m=sqrt(sum((y_forecast(:,2)-yield_actual(:,3)).^2)/192);
rmsfe_9m=sqrt(sum((y_forecast(:,3)-yield_actual(:,4)).^2)/192);
rmsfe_12m=sqrt(sum((y_forecast(:,4)-yield_actual(:,5)).^2)/192);
rmsfe_15m=sqrt(sum((y_forecast(:,5)-yield_actual(:,6)).^2)/192);
rmsfe_18m=sqrt(sum((y_forecast(:,6)-yield_actual(:,7)).^2)/192);
rmsfe_21m=sqrt(sum((y_forecast(:,7)-yield_actual(:,8)).^2)/192);
rmsfe_24m=sqrt(sum((y_forecast(:,8)-yield_actual(:,9)).^2)/192);
rmsfe_30m=sqrt(sum((y_forecast(:,9)-yield_actual(:,10)).^2)/192);
rmsfe_36m=sqrt(sum((y_forecast(:,10)-yield_actual(:,11)).^2)/192);
rmsfe_48m=sqrt(sum((y_forecast(:,11)-yield_actual(:,12)).^2)/192);
rmsfe_60m=sqrt(sum((y_forecast(:,12)-yield_actual(:,13)).^2)/192);
rmsfe_72m=sqrt(sum((y_forecast(:,13)-yield_actual(:,14)).^2)/192);
rmsfe_84m=sqrt(sum((y_forecast(:,14)-yield_actual(:,15)).^2)/192);
rmsfe_96m=sqrt(sum((y_forecast(:,15)-yield_actual(:,16)).^2)/192);
rmsfe_108m=sqrt(sum((y_forecast(:,16)-yield_actual(:,17)).^2)/192);
rmsfe_120m=sqrt(sum((y_forecast(:,17)-yield_actual(:,18)).^2)/192);
%%% Mat=[3,6,9,12,15,18,21,24,30,36,48,60,72,84,96,108,120];
rmsfe_h12_display=[rmsfe_3m,rmsfe_6m,rmsfe_9m,rmsfe_12m,...
   rmsfe_15m, rmsfe_18m, rmsfe_21m, rmsfe_24m,...
   rmsfe_30m,rmsfe_36m,rmsfe_48m, rmsfe_60m, rmsfe_72m,...
   rmsfe_84m,rmsfe_96m, rmsfe_108m, rmsfe_120m];
% rmsfe_display_RWY_h12=[Mat;rmsfe_h12_display] %

%%  RWY h=24M 
RW_h24=yield_original(266:457,1:18); % 1985M1-1992M1,..., 1985M1-2007M12
yield_actual=yield_original(290:481,1:18); % forecast:1994M1-2009M12
%  RMSFE : Mat=[3,6,9,12,15,18,21,24,30,36,48,60,72,84,96,108,120];
y_forecast=RW_h24(:,2:end);
rmsfe_3m=sqrt(sum((y_forecast(:,1)-yield_actual(:,2)).^2)/192);
rmsfe_6m=sqrt(sum((y_forecast(:,2)-yield_actual(:,3)).^2)/192);
rmsfe_9m=sqrt(sum((y_forecast(:,3)-yield_actual(:,4)).^2)/192);
rmsfe_12m=sqrt(sum((y_forecast(:,4)-yield_actual(:,5)).^2)/192);
rmsfe_15m=sqrt(sum((y_forecast(:,5)-yield_actual(:,6)).^2)/192);
rmsfe_18m=sqrt(sum((y_forecast(:,6)-yield_actual(:,7)).^2)/192);
rmsfe_21m=sqrt(sum((y_forecast(:,7)-yield_actual(:,8)).^2)/192);
rmsfe_24m=sqrt(sum((y_forecast(:,8)-yield_actual(:,9)).^2)/192);
rmsfe_30m=sqrt(sum((y_forecast(:,9)-yield_actual(:,10)).^2)/192);
rmsfe_36m=sqrt(sum((y_forecast(:,10)-yield_actual(:,11)).^2)/192);
rmsfe_48m=sqrt(sum((y_forecast(:,11)-yield_actual(:,12)).^2)/192);
rmsfe_60m=sqrt(sum((y_forecast(:,12)-yield_actual(:,13)).^2)/192);
rmsfe_72m=sqrt(sum((y_forecast(:,13)-yield_actual(:,14)).^2)/192);
rmsfe_84m=sqrt(sum((y_forecast(:,14)-yield_actual(:,15)).^2)/192);
rmsfe_96m=sqrt(sum((y_forecast(:,15)-yield_actual(:,16)).^2)/192);
rmsfe_108m=sqrt(sum((y_forecast(:,16)-yield_actual(:,17)).^2)/192);
rmsfe_120m=sqrt(sum((y_forecast(:,17)-yield_actual(:,18)).^2)/192);
%%% Mat=[3,6,9,12,15,18,21,24,30,36,48,60,72,84,96,108,120];
rmsfe_h24_display=[rmsfe_3m,rmsfe_6m,rmsfe_9m,rmsfe_12m,...
   rmsfe_15m, rmsfe_18m, rmsfe_21m, rmsfe_24m,...
   rmsfe_30m,rmsfe_36m,rmsfe_48m, rmsfe_60m, rmsfe_72m,...
   rmsfe_84m,rmsfe_96m, rmsfe_108m, rmsfe_120m];
% rmsfe_display_RWY_h24=[Mat;rmsfe_h24_display] %


%% Save the results
Rec_RW_JAE=For_result_save_JAE(RW_h6(:,2:end),RW_h12(:,2:end),RW_h24(:,2:end));
save('.\Results\Rec_RW_JAE','Rec_RW_JAE');

%%  Save the results for the actual yields 
Rec_Actual_JAE = For_result_save_JAE(yield_actual(:,2:18),yield_actual(:,2:18),yield_actual(:,2:18));
save('.\Results\Rec_Actual_JAE','Rec_Actual_JAE');

