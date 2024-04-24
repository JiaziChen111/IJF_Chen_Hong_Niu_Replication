function [mcs_mat_order_all] = MCS_order(Loss,alpha,B,w,boot,names)
%  

% 3M
[inR_3M,pR_3M,exR_3M,~,~,~]=mcs(Loss(:,1:6),alpha,B,w,boot); 
inR_3M_name=names(inR_3M); 
mcs_3M=[names([exR_3M;inR_3M])',pR_3M];

mcs_index_3M=[exR_3M;inR_3M];
mcs_3M_order=[names',names'];
for i=1:6
    inde=find(i==mcs_index_3M);
    mcs_3M_order(i,2)=pR_3M(inde);
end
%% 12M
[inR_12M,pR_12M,exR_12M,~,~,~]=mcs(Loss(:,1+6:6*2),alpha,B,w,boot); 
inR_12M_name=names(inR_12M); 
mcs_12M=[names([exR_12M;inR_12M])',pR_12M];

mcs_index_12M=[exR_12M;inR_12M];
mcs_12M_order=[names',names'];
for i=1:6
    inde=find(i==mcs_index_12M);
    mcs_12M_order(i,2)=pR_12M(inde);
end
%% 24M
[inR_24M,pR_24M,exR_24M,~,~,~]=mcs(Loss(:,1+6*2:6*3),alpha,B,w,boot); 
inR_24M_name=names(inR_24M); 
mcs_24M=[names([exR_24M;inR_24M])',pR_24M];

mcs_index_24M=[exR_24M;inR_24M];
mcs_24M_order=[names',names'];
for i=1:6
    inde=find(i==mcs_index_24M);
    mcs_24M_order(i,2)=pR_24M(inde);
end
%% 36M
[inR_36M,pR_36M,exR_36M,~,~,~]=mcs(Loss(:,1+6*3:6*4),alpha,B,w,boot); 
inR_36M_name=names(inR_36M); 
mcs_36M=[names([exR_36M;inR_36M])',pR_36M];

mcs_index_36M=[exR_36M;inR_36M];
mcs_36M_order=[names',names'];
for i=1:6
    inde=find(i==mcs_index_36M);
    mcs_36M_order(i,2)=pR_36M(inde);
end
%% 48M
[inR_48M,pR_48M,exR_48M,~,~,~]=mcs(Loss(:,1+6*4:6*5),alpha,B,w,boot); 
inR_48M_name=names(inR_48M); 
mcs_48M=[names([exR_48M;inR_48M])',pR_48M];

mcs_index_48M=[exR_48M;inR_48M];
mcs_48M_order=[names',names'];
for i=1:6
    inde=find(i==mcs_index_48M);
    mcs_48M_order(i,2)=pR_48M(inde);
end
%% 60M
[inR_60M,pR_60M,exR_60M,~,~,~]=mcs(Loss(:,1+6*5:6*6),alpha,B,w,boot); 
inR_60M_name=names(inR_60M); 
mcs_60M=[names([exR_60M;inR_60M])',pR_60M];

mcs_index_60M=[exR_60M;inR_60M];
mcs_60M_order=[names',names'];
for i=1:6
    inde=find(i==mcs_index_60M);
    mcs_60M_order(i,2)=pR_60M(inde);
end

mcs_mat_order_all=[];
mcs_mat_order_all=[mcs_3M_order(:,2),mcs_12M_order(:,2),mcs_24M_order(:,2),...
    mcs_36M_order(:,2),mcs_48M_order(:,2),mcs_60M_order(:,2)];

end

