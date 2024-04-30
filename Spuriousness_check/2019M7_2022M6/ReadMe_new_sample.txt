Jiazi Chen, Zhiwu Hong, and Linlin Niu, 2024, "Forecasting Interest Rates with Shifting Endpoints: 
The Role of the Functional Demographic Age Distribution", Accepted at International Journal of Forecasting.

These files can be used to replicate our empirical exercise of Section 4.2.4 in the paper using Matlab. They can be used to replicate Table 6 in the paper.
Kindly cite our paper in your research if you make use of these materials.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%   Data  %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

The folder contains the yield curve, the demographic age distribution, and macroeconomic data illustrated in the data section.

(1) The yield data (CRSP_monthly_2022.xlsx, which is empty due to access restrictions) can be found in the Center for Research in Security Prices (CRSP) database and is accessed via the Wharton Research Data Services (WRDS). Specifically, we use the 3-month risk-free rate and 1- to 5-year Fama-Bliss zero-coupon equivalent Treasury yields, and their corresponding unique identifiers in the CRSP database are 2000002, 2000047, 2000048, 2000049, 2000050, and 2000051, respectively. Monthly data from 1962M6 to 2022M6. We also add two excel files in the Raw_data folder to show the raw files download from the CRSP database (see the CRSP folder), and the exact column we used is marked gray. 

(2) The demographic age distribution (US_Age_Distribution_2022.xlsx) can be found at the United States Census Bureau website: https://www.census.gov/en.html.

(3) The macro data is sourced from multiple data repositories, such as the Federal Reserve Bank of Philadelphia.

(4) The Raw_data folder contains the raw data.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%  Functions %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

The folder contains the relevant functions used for the main program.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%  Results %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

The folder contains the forecasting results produced by the main programs.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%  Main programs  %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

(1) Table6.m: This file produces the results for Table 6 in the paper, which first runs the six models (DNS_FD_L_u, RZIG, RW, DNS, DNS_MY_L_u, DNS_MA_u) 
    using new samples, then it generates the RMSFE results of Table 6 and stored in Table6.xlsx. 

   Note: Before you run the DNS_FD_L_u model, please run the DNS_FD_L_u_CV_new_sample.m file to get the MHCV results, 
   which took 6.7624 hours using our machine, and the CV results are stored in the Results folder.

If you find any mistakes in the code and data, please contact chenjz20@163.com.
