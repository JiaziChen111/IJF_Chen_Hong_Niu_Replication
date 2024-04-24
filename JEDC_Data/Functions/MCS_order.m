function [mcs_mat_order_all] = MCS_order(Loss,alpha,B,w,boot,names)
%  

% 3M
[inR_3M,pR_3M,exR_3M,~,~,~]=mcs(Loss(:,1:5),alpha,B,w,boot); 
inR_3M_name=names(inR_3M); 
mcs_3M=[names([exR_3M;inR_3M])',pR_3M];

mcs_index_3M=[exR_3M;inR_3M];
mcs_3M_order=[names',names'];
for i=1:5
    inde=find(i==mcs_index_3M);
    mcs_3M_order(i,2)=pR_3M(inde);
end

%% 6M
[inR_6M,pR_6M,exR_6M,~,~,~]=mcs(Loss(:,1+5:5*2),alpha,B,w,boot); 
inR_6M_name=names(inR_6M); 
mcs_6M=[names([exR_6M;inR_6M])',pR_6M];

mcs_index_6M=[exR_6M;inR_6M];
mcs_6M_order=[names',names'];
for i=1:5
    inde=find(i==mcs_index_6M);
    mcs_6M_order(i,2)=pR_6M(inde);
end


%% 12M
[inR_12M,pR_12M,exR_12M,~,~,~]=mcs(Loss(:,1+5*2:5*3),alpha,B,w,boot); 
inR_12M_name=names(inR_12M); 
mcs_12M=[names([exR_12M;inR_12M])',pR_12M];

mcs_index_12M=[exR_12M;inR_12M];
mcs_12M_order=[names',names'];
for i=1:5
    inde=find(i==mcs_index_12M);
    mcs_12M_order(i,2)=pR_12M(inde);
end

%% 24M
[inR_24M,pR_24M,exR_24M,~,~,~]=mcs(Loss(:,1+5*3:5*4),alpha,B,w,boot); 
inR_24M_name=names(inR_24M); 
mcs_24M=[names([exR_24M;inR_24M])',pR_24M];

mcs_index_24M=[exR_24M;inR_24M];
mcs_24M_order=[names',names'];
for i=1:5
    inde=find(i==mcs_index_24M);
    mcs_24M_order(i,2)=pR_24M(inde);
end

%% 36M
[inR_36M,pR_36M,exR_36M,~,~,~]=mcs(Loss(:,1+5*4:5*5),alpha,B,w,boot); 
inR_36M_name=names(inR_36M); 
mcs_36M=[names([exR_36M;inR_36M])',pR_36M];

mcs_index_36M=[exR_36M;inR_36M];
mcs_36M_order=[names',names'];
for i=1:5
    inde=find(i==mcs_index_36M);
    mcs_36M_order(i,2)=pR_36M(inde);
end


%% 48M
[inR_48M,pR_48M,exR_48M,~,~,~]=mcs(Loss(:,1+5*5:5*6),alpha,B,w,boot); 
inR_48M_name=names(inR_48M); 
mcs_48M=[names([exR_48M;inR_48M])',pR_48M];

mcs_index_48M=[exR_48M;inR_48M];
mcs_48M_order=[names',names'];
for i=1:5
    inde=find(i==mcs_index_48M);
    mcs_48M_order(i,2)=pR_48M(inde);
end


%% 60M
[inR_60M,pR_60M,exR_60M,~,~,~]=mcs(Loss(:,1+5*6:5*7),alpha,B,w,boot); 
inR_60M_name=names(inR_60M); 
mcs_60M=[names([exR_60M;inR_60M])',pR_60M];

mcs_index_60M=[exR_60M;inR_60M];
mcs_60M_order=[names',names'];
for i=1:5
    inde=find(i==mcs_index_60M);
    mcs_60M_order(i,2)=pR_60M(inde);
end

%% 72M
[inR_72M,pR_72M,exR_72M,~,~,~]=mcs(Loss(:,1+5*7:5*8),alpha,B,w,boot); 
inR_72M_name=names(inR_72M); 
mcs_72M=[names([exR_72M;inR_72M])',pR_72M];

mcs_index_72M=[exR_72M;inR_72M];
mcs_72M_order=[names',names'];
for i=1:5
    inde=find(i==mcs_index_72M);
    mcs_72M_order(i,2)=pR_72M(inde);
end

%% 84M
[inR_84M,pR_84M,exR_84M,~,~,~]=mcs(Loss(:,1+5*8:5*9),alpha,B,w,boot); 
inR_84M_name=names(inR_84M); 
mcs_84M=[names([exR_84M;inR_84M])',pR_84M];

mcs_index_84M=[exR_84M;inR_84M];
mcs_84M_order=[names',names'];
for i=1:5
    inde=find(i==mcs_index_84M);
    mcs_84M_order(i,2)=pR_84M(inde);
end


%% 96M
[inR_96M,pR_96M,exR_96M,~,~,~]=mcs(Loss(:,1+5*9:5*10),alpha,B,w,boot); 
inR_96M_name=names(inR_96M); 
mcs_96M=[names([exR_96M;inR_96M])',pR_96M];

mcs_index_96M=[exR_96M;inR_96M];
mcs_96M_order=[names',names'];
for i=1:5
    inde=find(i==mcs_index_96M);
    mcs_96M_order(i,2)=pR_96M(inde);
end

%% 108M
[inR_108M,pR_108M,exR_108M,~,~,~]=mcs(Loss(:,1+5*10:5*11),alpha,B,w,boot); 
inR_108M_name=names(inR_108M); 
mcs_108M=[names([exR_108M;inR_108M])',pR_108M];

mcs_index_108M=[exR_108M;inR_108M];
mcs_108M_order=[names',names'];
for i=1:5
    inde=find(i==mcs_index_108M);
    mcs_108M_order(i,2)=pR_108M(inde);
end

%% 120M
[inR_120M,pR_120M,exR_120M,~,~,~]=mcs(Loss(:,1+5*11:5*12),alpha,B,w,boot); 
inR_120M_name=names(inR_120M); 
mcs_120M=[names([exR_120M;inR_120M])',pR_120M];

mcs_index_120M=[exR_120M;inR_120M];
mcs_120M_order=[names',names'];
for i=1:5
    inde=find(i==mcs_index_120M);
    mcs_120M_order(i,2)=pR_120M(inde);
end

%% 180M
[inR_180M,pR_180M,exR_180M,~,~,~]=mcs(Loss(:,1+5*12:5*13),alpha,B,w,boot); 
inR_180M_name=names(inR_180M); 
mcs_180M=[names([exR_180M;inR_180M])',pR_180M];

mcs_index_180M=[exR_180M;inR_180M];
mcs_180M_order=[names',names'];
for i=1:5
    inde=find(i==mcs_index_180M);
    mcs_180M_order(i,2)=pR_180M(inde);
end

%% 240M
[inR_240M,pR_240M,exR_240M,~,~,~]=mcs(Loss(:,1+5*13:5*14),alpha,B,w,boot); 
inR_240M_name=names(inR_240M); 
mcs_240M=[names([exR_240M;inR_240M])',pR_240M];

mcs_index_240M=[exR_240M;inR_240M];
mcs_240M_order=[names',names'];
for i=1:5
    inde=find(i==mcs_index_240M);
    mcs_240M_order(i,2)=pR_240M(inde);
end

%% 360M
[inR_360M,pR_360M,exR_360M,~,~,~]=mcs(Loss(:,1+5*14:5*15),alpha,B,w,boot); 
inR_360M_name=names(inR_360M); 
mcs_360M=[names([exR_360M;inR_360M])',pR_360M];

mcs_index_360M=[exR_360M;inR_360M];
mcs_360M_order=[names',names'];
for i=1:5
    inde=find(i==mcs_index_360M);
    mcs_360M_order(i,2)=pR_360M(inde);
end


mcs_mat_order_all=[];
mcs_mat_order_all=[mcs_3M_order(:,2),mcs_6M_order(:,2),mcs_12M_order(:,2),mcs_24M_order(:,2),...
    mcs_36M_order(:,2),mcs_48M_order(:,2),mcs_60M_order(:,2),mcs_72M_order(:,2),mcs_84M_order(:,2),...
    mcs_96M_order(:,2),mcs_108M_order(:,2),mcs_120M_order(:,2),mcs_180M_order(:,2),mcs_240M_order(:,2),mcs_360M_order(:,2)];

end

