Jiazi Chen, Zhiwu Hong, and Linlin Niu, 2024, "Forecasting Interest Rates with Shifting Endpoints: 
The Role of the Functional Demographic Age Distribution", Accepted at International Journal of Forecasting.

These files can be used to replicate our empirical exercise of Section 4.2.5 in the paper using Matlab. They can be used to replicate Table 7-8 in the paper.
Kindly cite our paper in your research if you make use of these materials.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%   Data  %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

The folder contains the yield curve, the demographic age distribution, and macroeconomic data illustrated in the data section.

(1) The yield data (Yield_Curve_Bloomberg.xlsx, which is empty due to access restrictions)  can be found at Bloomberg with tickers: I02503M, I02506M, I02501Y, I02502Y, I0253Y, I02504Y, I02505Y, I02506Y, I02507Y, I02508Y, I02509Y, I02510Y, I02515Y, I02520Y, I02530Y. Daily data from 1989/1/3 to 2023/12/29 (see Yield_Curve_Bloomberg_Raw.xlsx file in the Raw_data folder, which is empty due to access restrictions). You can use the Yiled_Curve_Bloomberg_Clear.m to get the quarterly average yield data if you fill the Yield_Curve_Bloomberg_Raw.xlsx file and stored the results in Yield_Curve_Bloomberg.xlsx and get the file Yield_quarter_ave.pdf.

(2) The demographic age distribution (US_Population..xlsx) can be found at the United States Census Bureau website: https://www.census.gov/en.html

(3) The macro data is from multiple data repositories. We got the final data used in our empirical analysis in two files after data clearing, that is Data_all_forward.xlsx and Data_all_non_forward_new.xlsx. Please refer to the specific data sources in the Macro_data_used_note.xlsx for more details. For the data downloaded from Bloomberg (see "Source (Ours)" column in Macro_data_used_note.xlsx) we empty these data in the above two files, and the related tickers are shown in the "Note" column in Macro_data_used_note.xlsx.

(4) The Data_clear folder contains the raw data and codes used to clear the raw data.

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

(1)  Table7_to_8.m: This file produces the relevant results of Table 7 and Table 8 in the paper.
     To be specific, the file first runs the five models (RW, FADNS_nfwrd, FADNS_whole, FADNS_fwrd, DNS_FD_L_u) 
     using empirical samples similar in Fernandes and Vieira (2019, JEDC),
     then it generates the RMSFE results in Table 7 and the MCS results in Table 8, respectively. 
     All the results are stored in Table7_to_8.xlsx. 

     Note: Before you run the DNS_FD_L_u model, please run the DNS_FD_L_u_CV_JEDC.m file first to get the MHCV results, 
     which took 4.05 mins using our machine, and the CV results are stored in the Results folder.


If you find any mistakes in the code and data, please contact chenjz20@163.com.
