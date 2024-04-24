Jiazi Chen, Zhiwu Hong, and Linlin Niu, 2024, "Forecasting Interest Rates with Shifting Endpoints: 
The Role of the Functional Demographic Age Distribution", Accepted at International Journal of Forecasting.

These files can be used to replicate our empirical exercise of Section 4.3.2 in the paper using Matlab. They can be used to replicate Table 12-14 of the paper.
Kindly cite our paper in your research if you make use of these materials.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%   Data  %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

The folder contains the yield curve, the demographic age distribution, and macroeconomic data illustrated in the data section.

(1) The yield data (UnsmFB_70-09.txt) and the real-time data (RLZcpi.txt and RLZip.txt) can be found at the Journal of Applied Econometrics Data Archive website: http://qed.econ.queensu.ca/jae/2014-v29.5/van_dijk-et-al/ 

(2) The demographic age distribution (US_Population..xlsx) can be found at the United States Census Bureau website: https://www.census.gov/en.html

(3) The macroeconomic data (CPIAUCNS.xls, INDPRO.xls, and Macro_variables.xlsx) can be found at the Federal Reserve Bank of St. Louis website: https://fred.stlouisfed.org/


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%  Functions %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

The folder contains the relevant functions used for the main program.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%  Results %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

The folder contains the forecasting resluts produced by the main programs.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%  Main programs  %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

(1) Table12_to_14.m: This file produces the relevant results of Table 12 to Table 14 in the paper. 
    To be specific, the file first runs the six models (DNS_FD_L_u, RZIG, RW, DNS, DNS_MY_L_u, DNS_MA_u) 
    using empirical samples same as in van Dijk et al. (2014, JAE), 
    then it generates the RMSFE results in Table 12 and the MCS results in Table 13 and Table 14, respectively.
     All the results are stored in Table12_to_14.xlsx. 

    Note: Before you run the DNS_FD_L_u model, please run the DNS_FD_L_u_Recursive_CV_JAE.m file first to get the MHCV results, 
    which took 57.925 mins using our machine, and the CV results are stored in the Results folder.
    Since the MHCV typically chooses Kappa=2 in most cases, we directly set Kappa=2. 
    Using the exact Kappa value chosen by MHCV yields very similar forecasting results and does not change conclusions in the paper.



If you find any mistakes in the code and data, please contact chenjz20@163.com.

