function [Loss_h6,Loss_h12,Loss_h24] = Loss_SFE_Arrangement_JAE(DNS_FD_L, RZIG, RW, DNS, DNS_MY_L, DNS_MA)

%% h=6M
   Loss_h6=[];
   Loss_h6_3M =[DNS_FD_L.h6.m3,RZIG.h6.m3,RW.h6.m3,DNS.h6.m3,...
       DNS_MY_L.h6.m3,DNS_MA.h6.m3];
   Loss_h6_6M =[DNS_FD_L.h6.m6,RZIG.h6.m6,RW.h6.m6,DNS.h6.m6,...
       DNS_MY_L.h6.m6,DNS_MA.h6.m6]; 
   Loss_h6_9M =[DNS_FD_L.h6.m9,RZIG.h6.m9,RW.h6.m9,DNS.h6.m9,...
       DNS_MY_L.h6.m9,DNS_MA.h6.m9];   
    Loss_h6_12M =[DNS_FD_L.h6.m12,RZIG.h6.m12,RW.h6.m12,DNS.h6.m12,...
       DNS_MY_L.h6.m12,DNS_MA.h6.m12];  
   Loss_h6_15M =[DNS_FD_L.h6.m15,RZIG.h6.m15,RW.h6.m15,DNS.h6.m15,...
       DNS_MY_L.h6.m15,DNS_MA.h6.m15]; 
   Loss_h6_18M =[DNS_FD_L.h6.m18,RZIG.h6.m18,RW.h6.m18,DNS.h6.m18,...
       DNS_MY_L.h6.m18,DNS_MA.h6.m18];    
   Loss_h6_21M =[DNS_FD_L.h6.m21,RZIG.h6.m21,RW.h6.m21,DNS.h6.m21,...
       DNS_MY_L.h6.m21,DNS_MA.h6.m21]; 
   Loss_h6_24M =[DNS_FD_L.h6.m24,RZIG.h6.m24,RW.h6.m24,DNS.h6.m24,...
       DNS_MY_L.h6.m24,DNS_MA.h6.m24];   
   Loss_h6_30M =[DNS_FD_L.h6.m30,RZIG.h6.m30,RW.h6.m30,DNS.h6.m30,...
       DNS_MY_L.h6.m30,DNS_MA.h6.m30];   
   Loss_h6_36M =[DNS_FD_L.h6.m36,RZIG.h6.m36,RW.h6.m36,DNS.h6.m36,...
       DNS_MY_L.h6.m36,DNS_MA.h6.m36];    
   Loss_h6_48M =[DNS_FD_L.h6.m48,RZIG.h6.m48,RW.h6.m48,DNS.h6.m48,...
       DNS_MY_L.h6.m48,DNS_MA.h6.m48];   
   Loss_h6_60M =[DNS_FD_L.h6.m60,RZIG.h6.m60,RW.h6.m60,DNS.h6.m60,...
       DNS_MY_L.h6.m60,DNS_MA.h6.m60]; 
   Loss_h6_72M =[DNS_FD_L.h6.m72,RZIG.h6.m72,RW.h6.m72,DNS.h6.m72,...
       DNS_MY_L.h6.m72,DNS_MA.h6.m72];   
   Loss_h6_84M =[DNS_FD_L.h6.m84,RZIG.h6.m84,RW.h6.m84,DNS.h6.m84,...
       DNS_MY_L.h6.m84,DNS_MA.h6.m84];   
   Loss_h6_96M =[DNS_FD_L.h6.m96,RZIG.h6.m96,RW.h6.m96,DNS.h6.m96,...
       DNS_MY_L.h6.m96,DNS_MA.h6.m96];     
   Loss_h6_108M =[DNS_FD_L.h6.m108,RZIG.h6.m108,RW.h6.m108,DNS.h6.m108,...
       DNS_MY_L.h6.m108,DNS_MA.h6.m108];     
    Loss_h6_120M =[DNS_FD_L.h6.m120,RZIG.h6.m120,RW.h6.m120,DNS.h6.m120,...
       DNS_MY_L.h6.m120,DNS_MA.h6.m120];     
   
 Loss_h6=[Loss_h6_3M,Loss_h6_6M,Loss_h6_9M,Loss_h6_12M,Loss_h6_15M,Loss_h6_18M,Loss_h6_21M,...
  Loss_h6_24M,Loss_h6_30M,Loss_h6_36M,Loss_h6_48M,Loss_h6_60M,Loss_h6_72M,Loss_h6_84M,... 
  Loss_h6_96M,Loss_h6_108M,Loss_h6_120M];
%% h=12M
   Loss_h12=[];
   Loss_h12_3M =[DNS_FD_L.h12.m3,RZIG.h12.m3,RW.h12.m3,DNS.h12.m3,...
       DNS_MY_L.h12.m3,DNS_MA.h12.m3];
   Loss_h12_6M =[DNS_FD_L.h12.m6,RZIG.h12.m6,RW.h12.m6,DNS.h12.m6,...
       DNS_MY_L.h12.m6,DNS_MA.h12.m6]; 
   Loss_h12_9M =[DNS_FD_L.h12.m9,RZIG.h12.m9,RW.h12.m9,DNS.h12.m9,...
       DNS_MY_L.h12.m9,DNS_MA.h12.m9];   
    Loss_h12_12M =[DNS_FD_L.h12.m12,RZIG.h12.m12,RW.h12.m12,DNS.h12.m12,...
       DNS_MY_L.h12.m12,DNS_MA.h12.m12];  
   Loss_h12_15M =[DNS_FD_L.h12.m15,RZIG.h12.m15,RW.h12.m15,DNS.h12.m15,...
       DNS_MY_L.h12.m15,DNS_MA.h12.m15]; 
   Loss_h12_18M =[DNS_FD_L.h12.m18,RZIG.h12.m18,RW.h12.m18,DNS.h12.m18,...
       DNS_MY_L.h12.m18,DNS_MA.h12.m18];    
   Loss_h12_21M =[DNS_FD_L.h12.m21,RZIG.h12.m21,RW.h12.m21,DNS.h12.m21,...
       DNS_MY_L.h12.m21,DNS_MA.h12.m21]; 
   Loss_h12_24M =[DNS_FD_L.h12.m24,RZIG.h12.m24,RW.h12.m24,DNS.h12.m24,...
       DNS_MY_L.h12.m24,DNS_MA.h12.m24];   
   Loss_h12_30M =[DNS_FD_L.h12.m30,RZIG.h12.m30,RW.h12.m30,DNS.h12.m30,...
       DNS_MY_L.h12.m30,DNS_MA.h12.m30];   
   Loss_h12_36M =[DNS_FD_L.h12.m36,RZIG.h12.m36,RW.h12.m36,DNS.h12.m36,...
       DNS_MY_L.h12.m36,DNS_MA.h12.m36];    
   Loss_h12_48M =[DNS_FD_L.h12.m48,RZIG.h12.m48,RW.h12.m48,DNS.h12.m48,...
       DNS_MY_L.h12.m48,DNS_MA.h12.m48];   
   Loss_h12_60M =[DNS_FD_L.h12.m60,RZIG.h12.m60,RW.h12.m60,DNS.h12.m60,...
       DNS_MY_L.h12.m60,DNS_MA.h12.m60]; 
   Loss_h12_72M =[DNS_FD_L.h12.m72,RZIG.h12.m72,RW.h12.m72,DNS.h12.m72,...
       DNS_MY_L.h12.m72,DNS_MA.h12.m72];   
   Loss_h12_84M =[DNS_FD_L.h12.m84,RZIG.h12.m84,RW.h12.m84,DNS.h12.m84,...
       DNS_MY_L.h12.m84,DNS_MA.h12.m84];   
   Loss_h12_96M =[DNS_FD_L.h12.m96,RZIG.h12.m96,RW.h12.m96,DNS.h12.m96,...
       DNS_MY_L.h12.m96,DNS_MA.h12.m96];     
   Loss_h12_108M =[DNS_FD_L.h12.m108,RZIG.h12.m108,RW.h12.m108,DNS.h12.m108,...
       DNS_MY_L.h12.m108,DNS_MA.h12.m108];     
    Loss_h12_120M =[DNS_FD_L.h12.m120,RZIG.h12.m120,RW.h12.m120,DNS.h12.m120,...
       DNS_MY_L.h12.m120,DNS_MA.h12.m120];     
  
  Loss_h12=[Loss_h12_3M,Loss_h12_6M,Loss_h12_9M,Loss_h12_12M,Loss_h12_15M,Loss_h12_18M,...
      Loss_h12_21M,Loss_h12_24M,Loss_h12_30M,Loss_h12_36M,Loss_h12_48M,Loss_h12_60M,...
      Loss_h12_72M,Loss_h12_84M,Loss_h12_96M,Loss_h12_108M,Loss_h12_120M]; 
%% h=24M
   Loss_h24=[];
   Loss_h24_3M =[DNS_FD_L.h24.m3,RZIG.h24.m3,RW.h24.m3,DNS.h24.m3,...
       DNS_MY_L.h24.m3,DNS_MA.h24.m3];
   Loss_h24_6M =[DNS_FD_L.h24.m6,RZIG.h24.m6,RW.h24.m6,DNS.h24.m6,...
       DNS_MY_L.h24.m6,DNS_MA.h24.m6]; 
   Loss_h24_9M =[DNS_FD_L.h24.m9,RZIG.h24.m9,RW.h24.m9,DNS.h24.m9,...
       DNS_MY_L.h24.m9,DNS_MA.h24.m9];   
    Loss_h24_12M =[DNS_FD_L.h24.m12,RZIG.h24.m12,RW.h24.m12,DNS.h24.m12,...
       DNS_MY_L.h24.m12,DNS_MA.h24.m12];  
   Loss_h24_15M =[DNS_FD_L.h24.m15,RZIG.h24.m15,RW.h24.m15,DNS.h24.m15,...
       DNS_MY_L.h24.m15,DNS_MA.h24.m15]; 
   Loss_h24_18M =[DNS_FD_L.h24.m18,RZIG.h24.m18,RW.h24.m18,DNS.h24.m18,...
       DNS_MY_L.h24.m18,DNS_MA.h24.m18];    
   Loss_h24_21M =[DNS_FD_L.h24.m21,RZIG.h24.m21,RW.h24.m21,DNS.h24.m21,...
       DNS_MY_L.h24.m21,DNS_MA.h24.m21]; 
   Loss_h24_24M =[DNS_FD_L.h24.m24,RZIG.h24.m24,RW.h24.m24,DNS.h24.m24,...
       DNS_MY_L.h24.m24,DNS_MA.h24.m24];   
   Loss_h24_30M =[DNS_FD_L.h24.m30,RZIG.h24.m30,RW.h24.m30,DNS.h24.m30,...
       DNS_MY_L.h24.m30,DNS_MA.h24.m30];   
   Loss_h24_36M =[DNS_FD_L.h24.m36,RZIG.h24.m36,RW.h24.m36,DNS.h24.m36,...
       DNS_MY_L.h24.m36,DNS_MA.h24.m36];    
   Loss_h24_48M =[DNS_FD_L.h24.m48,RZIG.h24.m48,RW.h24.m48,DNS.h24.m48,...
       DNS_MY_L.h24.m48,DNS_MA.h24.m48];   
   Loss_h24_60M =[DNS_FD_L.h24.m60,RZIG.h24.m60,RW.h24.m60,DNS.h24.m60,...
       DNS_MY_L.h24.m60,DNS_MA.h24.m60]; 
   Loss_h24_72M =[DNS_FD_L.h24.m72,RZIG.h24.m72,RW.h24.m72,DNS.h24.m72,...
       DNS_MY_L.h24.m72,DNS_MA.h24.m72];   
   Loss_h24_84M =[DNS_FD_L.h24.m84,RZIG.h24.m84,RW.h24.m84,DNS.h24.m84,...
       DNS_MY_L.h24.m84,DNS_MA.h24.m84];   
   Loss_h24_96M =[DNS_FD_L.h24.m96,RZIG.h24.m96,RW.h24.m96,DNS.h24.m96,...
       DNS_MY_L.h24.m96,DNS_MA.h24.m96];     
   Loss_h24_108M =[DNS_FD_L.h24.m108,RZIG.h24.m108,RW.h24.m108,DNS.h24.m108,...
       DNS_MY_L.h24.m108,DNS_MA.h24.m108];     
    Loss_h24_120M =[DNS_FD_L.h24.m120,RZIG.h24.m120,RW.h24.m120,DNS.h24.m120,...
       DNS_MY_L.h24.m120,DNS_MA.h24.m120];   
   
   Loss_h24=[Loss_h24_3M,Loss_h24_6M,Loss_h24_9M,Loss_h24_12M,Loss_h24_15M,Loss_h24_18M,...
       Loss_h24_21M,Loss_h24_24M,Loss_h24_30M,Loss_h24_36M,Loss_h24_48M,Loss_h24_60M,...
       Loss_h24_72M,Loss_h24_84M,Loss_h24_96M,Loss_h24_108M,Loss_h24_120M];

end

