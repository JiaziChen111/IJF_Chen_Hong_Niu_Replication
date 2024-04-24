function [mcs_mat_order_all] = MCS_Arrangement_JAE_L(Loss,alpha,B,w,boot,names)
%  Loss£¬6 models for each maturity 
%% 3M
[inR_3M,pR_3M,exR_3M,~,~,~]=mcs(Loss(:,1:6),alpha,B,w,boot); 
inR_3M_name=names(inR_3M); 
mcs_3M=[names([exR_3M;inR_3M])',pR_3M];

mcs_index_3M=[exR_3M;inR_3M];
mcs_3M_order=[names',names'];
for i=1:6
    inde=find(i==mcs_index_3M);
    mcs_3M_order(i,2)=pR_3M(inde);
end
%% 6M

[inR_6M,pR_6M,exR_6M,~,~,~]=mcs(Loss(:,1+6:6*2),alpha,B,w,boot); 
inR_6M_name=names(inR_6M); 
mcs_6M=[names([exR_6M;inR_6M])',pR_6M];

mcs_index_6M=[exR_6M;inR_6M];
mcs_6M_order=[names',names'];
for i=1:6
    inde=find(i==mcs_index_6M);
    mcs_6M_order(i,2)=pR_6M(inde);
end
%% 9M
[inR_9M,pR_9M,exR_9M,~,~,~]=mcs(Loss(:,1+6*2:6*3),alpha,B,w,boot); 
inR_9M_name=names(inR_9M); 
mcs_9M=[names([exR_9M;inR_9M])',pR_9M];

mcs_index_9M=[exR_9M;inR_9M];
mcs_9M_order=[names',names'];
for i=1:6
    inde=find(i==mcs_index_9M);
    mcs_9M_order(i,2)=pR_9M(inde);
end

%% 12M
[inR_12M,pR_12M,exR_12M,~,~,~]=mcs(Loss(:,1+6*3:6*4),alpha,B,w,boot); 
inR_12M_name=names(inR_12M); 
mcs_12M=[names([exR_12M;inR_12M])',pR_12M];

mcs_index_12M=[exR_12M;inR_12M];
mcs_12M_order=[names',names'];
for i=1:6
    inde=find(i==mcs_index_12M);
    mcs_12M_order(i,2)=pR_12M(inde);
end
%% 15M
[inR_15M,pR_15M,exR_15M,~,~,~]=mcs(Loss(:,1+6*4:6*5),alpha,B,w,boot); 
inR_15M_name=names(inR_15M); 
mcs_15M=[names([exR_15M;inR_15M])',pR_15M];

mcs_index_15M=[exR_15M;inR_15M];
mcs_15M_order=[names',names'];
for i=1:6
    inde=find(i==mcs_index_15M);
    mcs_15M_order(i,2)=pR_15M(inde);
end
%% 18M
[inR_18M,pR_18M,exR_18M,~,~,~]=mcs(Loss(:,1+6*5:6*6),alpha,B,w,boot); 
inR_18M_name=names(inR_18M); 
mcs_18M=[names([exR_18M;inR_18M])',pR_18M];

mcs_index_18M=[exR_18M;inR_18M];
mcs_18M_order=[names',names'];
for i=1:6
    inde=find(i==mcs_index_18M);
    mcs_18M_order(i,2)=pR_18M(inde);
end
%% 21M
[inR_21M,pR_21M,exR_21M,~,~,~]=mcs(Loss(:,1+6*6:6*7),alpha,B,w,boot); 
inR_21M_name=names(inR_21M); 
mcs_21M=[names([exR_21M;inR_21M])',pR_21M];

mcs_index_21M=[exR_21M;inR_21M];
mcs_21M_order=[names',names'];
for i=1:6
    inde=find(i==mcs_index_21M);
    mcs_21M_order(i,2)=pR_21M(inde);
end

%% 24M
[inR_24M,pR_24M,exR_24M,~,~,~]=mcs(Loss(:,1+6*7:6*8),alpha,B,w,boot); 
inR_24M_name=names(inR_24M); 
mcs_24M=[names([exR_24M;inR_24M])',pR_24M];

mcs_index_24M=[exR_24M;inR_24M];
mcs_24M_order=[names',names'];
for i=1:6
    inde=find(i==mcs_index_24M);
    mcs_24M_order(i,2)=pR_24M(inde);
end
%% 30M
[inR_30M,pR_30M,exR_30M,~,~,~]=mcs(Loss(:,1+6*8:6*9),alpha,B,w,boot); 
inR_30M_name=names(inR_30M); 
mcs_30M=[names([exR_30M;inR_30M])',pR_30M];

mcs_index_30M=[exR_30M;inR_30M];
mcs_30M_order=[names',names'];
for i=1:6
    inde=find(i==mcs_index_30M);
    mcs_30M_order(i,2)=pR_30M(inde);
end

%% 36M
[inR_36M,pR_36M,exR_36M,~,~,~]=mcs(Loss(:,1+6*9:6*10),alpha,B,w,boot); 
inR_36M_name=names(inR_36M); 
mcs_36M=[names([exR_36M;inR_36M])',pR_36M];

mcs_index_36M=[exR_36M;inR_36M];
mcs_36M_order=[names',names'];
for i=1:6
    inde=find(i==mcs_index_36M);
    mcs_36M_order(i,2)=pR_36M(inde);
end
%% 48M
[inR_48M,pR_48M,exR_48M,~,~,~]=mcs(Loss(:,1+6*10:6*11),alpha,B,w,boot); 
inR_48M_name=names(inR_48M); 
mcs_48M=[names([exR_48M;inR_48M])',pR_48M];

mcs_index_48M=[exR_48M;inR_48M];
mcs_48M_order=[names',names'];
for i=1:6
    inde=find(i==mcs_index_48M);
    mcs_48M_order(i,2)=pR_48M(inde);
end
%% 60M

[inR_60M,pR_60M,exR_60M,~,~,~]=mcs(Loss(:,1+6*11:6*12),alpha,B,w,boot); 
inR_60M_name=names(inR_60M); 
mcs_60M=[names([exR_60M;inR_60M])',pR_60M];

mcs_index_60M=[exR_60M;inR_60M];
mcs_60M_order=[names',names'];
for i=1:6
    inde=find(i==mcs_index_60M);
    mcs_60M_order(i,2)=pR_60M(inde);
end

%% 72M
[inR_72M,pR_72M,exR_72M,~,~,~]=mcs(Loss(:,1+6*12:6*13),alpha,B,w,boot); 
inR_72M_name=names(inR_72M); 
mcs_72M=[names([exR_72M;inR_72M])',pR_72M];

mcs_index_72M=[exR_72M;inR_72M];
mcs_72M_order=[names',names'];
for i=1:6
    inde=find(i==mcs_index_72M);
    mcs_72M_order(i,2)=pR_72M(inde);
end
%% 84M
[inR_84M,pR_84M,exR_84M,~,~,~]=mcs(Loss(:,1+6*13:6*14),alpha,B,w,boot); 
inR_84M_name=names(inR_84M); 
mcs_84M=[names([exR_84M;inR_84M])',pR_84M];

mcs_index_84M=[exR_84M;inR_84M];
mcs_84M_order=[names',names'];
for i=1:6
    inde=find(i==mcs_index_84M);
    mcs_84M_order(i,2)=pR_84M(inde);
end
%% 96M
[inR_96M,pR_96M,exR_96M,~,~,~]=mcs(Loss(:,1+6*14:6*15),alpha,B,w,boot); 
inR_96M_name=names(inR_96M); 
mcs_96M=[names([exR_96M;inR_96M])',pR_96M];

mcs_index_96M=[exR_96M;inR_96M];
mcs_96M_order=[names',names'];
for i=1:6
    inde=find(i==mcs_index_96M);
    mcs_96M_order(i,2)=pR_96M(inde);
end
%% 108M
[inR_108M,pR_108M,exR_108M,~,~,~]=mcs(Loss(:,1+6*15:6*16),alpha,B,w,boot); 
inR_108M_name=names(inR_108M); 
mcs_108M=[names([exR_108M;inR_108M])',pR_108M];

mcs_index_108M=[exR_108M;inR_108M];
mcs_108M_order=[names',names'];
for i=1:6
    inde=find(i==mcs_index_108M);
    mcs_108M_order(i,2)=pR_108M(inde);
end
%% 120M
[inR_120M,pR_120M,exR_120M,~,~,~]=mcs(Loss(:,1+6*16:6*17),alpha,B,w,boot); 
inR_120M_name=names(inR_120M); 
mcs_120M=[names([exR_120M;inR_120M])',pR_120M];

mcs_index_120M=[exR_120M;inR_120M];
mcs_120M_order=[names',names'];
for i=1:6
    inde=find(i==mcs_index_120M);
    mcs_120M_order(i,2)=pR_120M(inde);
end

%%
mcs_mat_order_all=[];
mcs_mat_order_all=[mcs_3M_order(:,2),mcs_6M_order(:,2),mcs_9M_order(:,2),mcs_12M_order(:,2),...
    mcs_15M_order(:,2),mcs_18M_order(:,2),mcs_21M_order(:,2),mcs_24M_order(:,2),...
    mcs_30M_order(:,2),mcs_36M_order(:,2),mcs_48M_order(:,2),mcs_60M_order(:,2),...
    mcs_72M_order(:,2),mcs_84M_order(:,2),mcs_96M_order(:,2),mcs_108M_order(:,2),...
    mcs_120M_order(:,2)];

end

