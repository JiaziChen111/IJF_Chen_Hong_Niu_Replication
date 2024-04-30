                                                     Replication Notes

Jiazi Chen, Zhiwu Hong, and Linlin Niu, 2024, "Forecasting Interest Rates with Shifting Endpoints: The Role of the Functional Demographic Age Distribution", Accepted at International Journal of Forecasting.

These files contain codes and data for replicating empirical results outlined in the paper using Matlab. All codes were run on a high-performance computer (HPC) located at Xiamen University, utilizing the Matlab R2018b version. Kindly cite our paper in your research if you make use of these materials.


%%%%%%%%%%%%% Data folder %%%%%%%%%%%

The folder contains the yield curve, the demographic age distribution, and macroeconomic data illustrated in the data section.

(1) The yield data (CRSP_monthly.xlsx, which is empty due to access restrictions) can be found in the Center for Research in Security Prices (CRSP) database and is accessed via the Wharton Research Data Services (WRDS). Specifically, we use the 3-month risk-free rate and 1- to 5-year Fama-Bliss zero-coupon equivalent Treasury yields, and their corresponding unique identifiers in the CRSP database are 2000002, 2000047, 2000048, 2000049, 2000050, and 2000051, respectively. Monthly data from 1962M6 to 2019M6. We also add two excel files in the CRSP_raw folder to show the raw files download from the CRSP database, and the exact column we used is marked gray. 

(2) The demographic age distribution (US_Age_Distribution_2019.xlsx) can be found at the United States Census Bureau website: https://www.census.gov/en.html.

(3) The macro data is sourced from multiple repositories, such as the Federal Reserve Bank of Philadelphia.


%%%%%%%%%% Functions folder %%%%%%%%

The folder contains the relevant functions used for the main programs.


%%%%%%%%%% JAE_Data folder %%%%%%%%%

The folder contains the programs and data to be used to replicate our empirical exercise of Section 4.3.2 in the paper.


%%%%%%%%% JEDC_Data folder %%%%%%%%%


The folder contains the programs and data to be used to replicate our empirical exercise of Section 4.2.5 in the paper.


%%%%%%% Results folder %%%%%%%%%%%%

The folder contains the forecasting results produced by the main programs.


%%%%%%% Spuriousness_check folder %%%%%%%

The folder contains the programs and data to be used to replicate our empirical exercise of Section 4.2.4 in the paper.


%%%%%%%  Main programs %%%%%%%%%

(1)	Table1.m: This file produces the summary statistics of the yield curve shown in Table 1 of our paper, and the related results are stored in Table1.xlsx.

(2)	Table2_to_5.m: This file produces the relevant results of Table 2 to Table 5 in the paper. To be specific, the file first runs the six models (DNS_FD_L_u, RZIG, RW, DNS, DNS_MY_L_u, DNS_MA_u) using recursive windows, then it generates the RMSFE results in Table 2, the MCS results in Table 3 and Table 4, and the results in Table 5, respectively. All the results are stored in Table2_to_5.xlsx (Note: Before you run the DNS_FD_L_u model, please run the H_Block_CV_Recursive.m file first to get the MHCV results, which took 34.0335 hours using our machine. The CV results are stored in the results folder.). 

(3)	Table6.m: This file is in the Spuriousness_check folder (please check the 2019M7_2022M6 subfolder). This file produces the results for Table 6 in the paper, which first runs the six models (DNS_FD_L_u, RZIG, RW, DNS, DNS_MY_L_u, DNS_MA_u) using new samples, then generates the RMSFE results of Table 6 and stored in Table6.xlsx in the same folder (Note: Before you run the DNS_FD_L_u model, please run the DNS_FD_L_u_CV_new_sample.m file to get the MHCV results, which took 6.7624 hours in our machine, and the CV results are stored in the Results folder). What’s more, the DNS_FD_L_u_Bootstrap.m file ( stored in the Bootstrap_test folder, a subfolder of the Spurious_check folder) implements the Bauer and Hamilton(2018, RFS) bootstrap test. The results are corresponding to the Section 4.2.4 in the paper.

(4)	Table7_to_8.m: This file (stored in the JEDC_Data folder) produces the relevant results of Table 7 and Table 8 in the paper. To be specific, the file first runs the five models (RW, FADNS_nfwrd, FADNS_whole, FADNS_fwrd, DNS_FD_L_u) using empirical samples similar to Fernandes and Vieira (2019, JEDC). It generates the RMSFE results in Table 7 and the MCS results in Table 8, respectively. All the results are stored in Table7_to_8.xlsx in the same folder (Note: Before you run the DNS_FD_L_u model, please run the DNS_FD_L_u_CV_JEDC.m file first to get the MHCV results, which took 4.05 mins using our machine, and the CV results are stored in the Results folder).

(5)	Table9_to_11.m: This file produces the related results of Table 9 to Table 11 in the paper. To be specific, the file first runs the six models (DNS_FD_L_u, RZIG, RW, DNS, DNS_MY_L_u, DNS_MA_u) using rolling windows, then it generates the RMSFE results in Table 9 and the MCS results in Table 10 and Table 11, respectively. All the results are stored in Table9_to_11.xlsx in the same folder (Note: Before you run the the DNS_FD_L_u model, please run the H_Block_CV_Rolling.m file to get the MHCV results, which took 4.0364 hours using our machine, and the CV results are stored in the Results folder.).

(6)	Table12_to_14.m: This file (stored in the JAE_Data folder) produces the relevant results of Table 12 to Table 14 in the paper. To be specific, the file first runs the six models (DNS_FD_L_u, RZIG, RW, DNS, DNS_MY_L_u, DNS_MA_u) using empirical samples same as in van Dijk et al. (2014, JAE), then it generates the RMSFE results in Table 12 and the MCS results in Table 13 and Table 14, respectively. All the results are stored in Table12_to_14.xlsx in the same folder (Note: Before you run the DNS_FD_L_u model, please run the DNS_FD_L_u_Recursive_CV_JAE.m file first to get the MHCV results, which took 57.925 mins using our machine, and the CV results are stored in the Results folder. Since the MHCV typically chooses Kappa=2 in most cases, we directly set Kappa=2. Using the exact Kappa value chosen by MHCV yields very similar forecasting results and does not change conclusions in the paper).

(7)	Table15_to_16.m: This file produces the related results of Table 15 and Table 16 in the paper. To be specific, the file first runs the six models (DNS_FD_LS_u, DNS_FD_s, DNS_FD_L_u_RZG, DNS_FD_L_u_RZIG, DNS_FD_L_u, RZIG) using recursive windows as in Table 2 of the paper and rolling windows as in Table 9 of the paper, then it generates the RMSFE results in Table 15 and Table 16, respectively. All the results are stored in Table15_to_16.xlsx (Note: Since you may have run the H_Block_CV_Recursive.m and H_Block_CV_Rolling.m earlier, you may not need to run these two files again here. If you are not, please run these two files first to get the MHCV results before you run the DNS_FD_L models. For the DNS_FD_s model, we directly set the Kappa equal to their counterparts, i.e., the DNS_FD_L models, that is, we set Kappa=5 when recursive windows is used, and Kappa=2 when rolling windows is used.).

(8)	Figures1_to_5.m: This file generates all the figures (Figure 1 to Figure 5) in the paper. Specifically, you should run the Insample_analysis.m first to get the in-sample results of four models (DNS_FD_L_u, RZIG, DNS_MY_L_u, and DNS) using full samples, and the results are stored in Insample_results.xlsx, then you can get the Figure 5. All the figures are stored in the same folder, named as Figure1_paper.pdf, Figure2_paper.pdf, …, Figure5_paper.pdf.

If you find any mistakes in the code and data, please contact chenjz20@163.com.
