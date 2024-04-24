%% DNS Macroeconomics variable(unspanned): lambda is estimated by MLE method
%  Rolling scheme
% 1st subsample is 1978:M12-1998:M11, last subsample is 1999:M4-2019:M3
clear all; close all; clc;
% cd 'Z:\User\IJF_Chen_Hong_Niu_Replication'
% 
% addpath(genpath('./Data'));
% addpath(genpath('./Functions'));

%% yield data
data_CRSP=xlsread('CRSP_monthly','Monthly');
yield=data_CRSP(1:805,:); % 3M,12M,24M,36M,48M,60M
Y=yield;
[T,N] = size(Y); % 805 by 6
%% IP growth rate, CPI inflation data
% Percentage: (ln(index_t)-ln(index_t-12))*100
data_macro_original=xlsread('Macro_variables','IPG_CPI','B2:D806');
data_cpi=data_macro_original(:,3);
data_ipg=data_macro_original(:,2);

%%
y_h3=zeros(245,6); y_h6=zeros(242,6); y_h12=zeros(236,6); y_h24=zeros(224,6);
y_h36=zeros(212,6); y_h48=zeros(200,6); y_h60=zeros(188,6);
lambda_mle_save=zeros(245,1);

for i=1:245
    i
   bdraw0=[0.0609 0.0001]';
   Mt=[3,12,24,36,48,60];
   
   X_mle=[]; Phi=[];mu=[];Phi_Q_mle=[];B_1_mle=[];
   [bdraw_mle,mu,Phi,Omiga,Phi_Q_mle,B_1_mle,sigma,X_mle,VCV,Y_bar_mle,mu_std,Phi_std] = step_3_Q(Y(318+i:i+557,:)',Mt,bdraw0);
   lambda_mle_save(i,1)=bdraw_mle(1,1);
   
   b = factorloading(Mt,Phi_Q_mle,B_1_mle); % 3 by length(Mt)
   b = b.b';                                % b is length(Mt) by 3 matrix,i.e., 6 by 3
    
    
    Level=[];Slope=[];Curvature=[];
    Level=X_mle(1,:)'; Slope=X_mle(2,:)'; Curvature=X_mle(3,:)'; % ´Ó1998M11¿ªÊ¼
    
    factor_all=[Level,Slope,Curvature,data_cpi(318+i:557+i,1),data_ipg(318+i:557+i,1)];
    
    [mu_all,phi_all]=VAR_1_ALL(factor_all);
    
         if i <246 % h=3M
            forecast_h3_all=mu_all+(phi_all+phi_all^2)*mu_all+(phi_all^3)*factor_all(end,:)';
            y_h3(i,:)=b*forecast_h3_all(1:3,1);
         end

         if i <243 % h=6M
            forecast_h6_all=mu_all+(phi_all+phi_all^2+phi_all^3+phi_all^4+phi_all^5)*mu_all+(phi_all^6)*factor_all(end,:)'; 
            y_h6(i,:)=b*forecast_h6_all(1:3,1);
         end
         
         if i<237 % h=12M
            forecast_h12_all=mu_all+(phi_all+phi_all^2+phi_all^3+phi_all^4+phi_all^5+phi_all^6+...
            +phi_all^7+phi_all^8+phi_all^9+phi_all^10+phi_all^11)*mu_all+(phi_all^12)*factor_all(end,:)'; 
            y_h12(i,:)=b*forecast_h12_all(1:3,1);             
         end
         
         
         if i<225 % h=24M
            forecast_h24_all=mu_all+(phi_all+phi_all^2+phi_all^3+phi_all^4+phi_all^5+phi_all^6+...
            +phi_all^7+phi_all^8+phi_all^9+phi_all^10+phi_all^11+phi_all^12+phi_all^13+phi_all^14+...
            +phi_all^15+phi_all^16+phi_all^17+phi_all^18+phi_all^19+phi_all^20+phi_all^21+...
           +phi_all^22+phi_all^23)*mu_all+(phi_all^24)*factor_all(end,:)'; 
            y_h24(i,:)=b*forecast_h24_all(1:3,1);                
         end
         
         if i<213 % h=36M
            forecast_h36_all=mu_all+(phi_all+phi_all^2+phi_all^3+phi_all^4+phi_all^5+phi_all^6+...
            +phi_all^7+phi_all^8+phi_all^9+phi_all^10+phi_all^11+phi_all^12+phi_all^13+phi_all^14+...
            +phi_all^15+phi_all^16+phi_all^17+phi_all^18+phi_all^19+phi_all^20+phi_all^21+...
           +phi_all^22+phi_all^23+phi_all^24+phi_all^25+phi_all^26+phi_all^27+phi_all^28+phi_all^29+...
           +phi_all^30+phi_all^31+phi_all^32+phi_all^33+phi_all^34+phi_all^35)*mu_all+(phi_all^36)*factor_all(end,:)';              
             y_h36(i,:)=b*forecast_h36_all(1:3,1);    
         end
         
         if i<201 % h=48M
            forecast_h48_all=mu_all+(phi_all+phi_all^2+phi_all^3+phi_all^4+phi_all^5+phi_all^6+...
            +phi_all^7+phi_all^8+phi_all^9+phi_all^10+phi_all^11+phi_all^12+phi_all^13+phi_all^14+...
            +phi_all^15+phi_all^16+phi_all^17+phi_all^18+phi_all^19+phi_all^20+phi_all^21+...
           +phi_all^22+phi_all^23+phi_all^24+phi_all^25+phi_all^26+phi_all^27+phi_all^28+phi_all^29+...
           +phi_all^30+phi_all^31+phi_all^32+phi_all^33+phi_all^34+phi_all^35+phi_all^36+phi_all^37+...
          +phi_all^38+phi_all^39+phi_all^40+phi_all^41+phi_all^42+phi_all^43+phi_all^44+phi_all^45+...
          +phi_all^46+phi_all^47)*mu_all+(phi_all^48)*factor_all(end,:)';              
              y_h48(i,:)=b*forecast_h48_all(1:3,1);                 
         end
         
          if i<189 % h=60M
            forecast_h60_all=mu_all+(phi_all+phi_all^2+phi_all^3+phi_all^4+phi_all^5+phi_all^6+...
            +phi_all^7+phi_all^8+phi_all^9+phi_all^10+phi_all^11+phi_all^12+phi_all^13+phi_all^14+...
            +phi_all^15+phi_all^16+phi_all^17+phi_all^18+phi_all^19+phi_all^20+phi_all^21+...
           +phi_all^22+phi_all^23+phi_all^24+phi_all^25+phi_all^26+phi_all^27+phi_all^28+phi_all^29+...
           +phi_all^30+phi_all^31+phi_all^32+phi_all^33+phi_all^34+phi_all^35+phi_all^36+phi_all^37+...
          +phi_all^38+phi_all^39+phi_all^40+phi_all^41+phi_all^42+phi_all^43+phi_all^44+phi_all^45+...
          +phi_all^46+phi_all^47+phi_all^48+phi_all^49+phi_all^50+phi_all^51+phi_all^52+phi_all^53+...
          +phi_all^54+phi_all^55+phi_all^56+phi_all^57+phi_all^58+phi_all^59)*mu_all+(phi_all^60)*factor_all(end,:)';              
              y_h60(i,:)=b*forecast_h60_all(1:3,1);                     
          end       
end

%% Save the results
Rol_DNS_MA_u=For_result_save(y_h3,y_h6,y_h12,y_h24,y_h36,y_h48,y_h60);
save('.\Results\Rol_DNS_MA_u','Rol_DNS_MA_u');
