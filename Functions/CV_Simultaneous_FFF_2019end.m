function [CV_result] = CV_Simultaneous_FFF_2019end(yield,zz)
%   yield: dependent variable, e.g. 269*6 by 1;
%   zz: demographic distribution, e.g. 269*6 by 13;
[n,~]=size(yield);
n=n/6;
h = floor(n/6);%block size的大小，向下取整数
yy=yield;
CV_result=zeros(2,7);CV_result1=zeros(2,6);
for ii=[2,3:2:13]
zz_case1 = zz(:,1:ii);
zz_case1_0 = zz(:,1:ii); 
y_0 = yy;% e.g., 时间从1952年2季度到2019年2季度
y_1 = yy;% e.g., 时间从1952年2季度到2019年2季度
hcv_case1_0 = zeros(1,n-h-h);
mhcv_case1_0 = zeros(n,n-h-h);
mhcv_case1_1 = zeros(1,n);
warning off
for i=h+1:n-h
    zz_case1(6*(i-1)+1-6*h:6*(i-1)+6+6*h,:)=[];
    y_1(6*(i-1)+1-6*h:6*(i-1)+6+6*h,:)=[];
   hcv_case_0(1,i-h)=pdist2(y_0(6*(i-1)+1:6*(i-1)+6,1)',(zz_case1_0(6*(i-1)+1:6*(i-1)+6,:)*(inv(zz_case1'*zz_case1)*zz_case1'*y_1))');
    for j = 1:n
       mhcv_case1_0(j,i-h) = pdist2(y_0(6*(j-1)+1:6*(j-1)+6,1)',(zz_case1_0(6*(j-1)+1:6*(j-1)+6,:)*(inv(zz_case1'*zz_case1)*zz_case1'*y_1))'); 
   end 
    zz_case1 = zz(:,1:ii);
    y_1 = yy(:,1);
end
for j = 1:n
    mhcv_case1_1(1,j) = pdist2(y_0(6*(j-1)+1:6*(j-1)+6,1)',(zz_case1_0(6*(j-1)+1:6*(j-1)+6,:)*(inv(zz_case1_0'*zz_case1_0)*zz_case1_0'*y_0))');
end 
if ii == 2; 
    CV_result(1,1)=sum(hcv_case_0)/n;
    CV_result(2,1)=CV_result(1,1)+sum(mhcv_case1_1)/n+sum(sum(mhcv_case1_0))/n/n;
else
CV_result1(1,(ii-1)/2)=sum(hcv_case_0)/n;
CV_result1(2,(ii-1)/2)=CV_result(1,(ii-1)/2)+sum(mhcv_case1_1)/n+sum(sum(mhcv_case1_0))/n/n;
end

end
CV_result(:,2:7)=CV_result1;
end
