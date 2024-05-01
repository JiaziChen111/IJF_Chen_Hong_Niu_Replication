Jiazi Chen, Zhiwu Hong, and Linlin Niu, 2024, "Forecasting Interest Rates with Shifting Endpoints: 
The Role of the Functional Demographic Age Distribution", Accepted at International Journal of Forecasting.

These files can be used to replicate our empirical exercise of Section 4.2.4 in the paper. 
Kindly cite our paper in your research if you make use of these materials.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%   Data  %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

The folder contains the yield curve and the demographic age distribution illustrated in the data section.

(1) The yield data (CRSP_monthly.xlsx, which is empty due to access restrictions) can be found in the Center for Research in Security Prices (CRSP) database accessed via the Wharton Research Data Services (WRDS). Specifically, we use the 3-month risk-free rate and 1- to 5-year Fama-Bliss zero-coupon equivalent Treasury yields. The corresponding unique identifiers in the CRSP database are 2000002, 2000047, 2000048, 2000049, 2000050, and 2000051, respectively. The sample period is from June 1952 to June 2019. 


(2) The demographic age distribution (US_Age_Distribution_2019.xlsx) can be found at the United States Census Bureau website: https://www.census.gov/en.html

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%  Functions %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

The folder contains the relevant functions used for the main program.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%  Main programs  %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

(1) DNS_FD_L_u_Bootstrap.m:  This file performs the Bauer and Hamilton's (2018,RFS) bootstap analysis to test whether the functional demographic age distribution are significantly affect the level factor. 


If you find any mistakes in the code and data, please contact chenjz20@163.com.
