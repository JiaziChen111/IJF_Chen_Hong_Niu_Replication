function [CV_result] = CV_Single_FFF(yield,zz)
%   yield: dependent variable, e.g. 269 by 1 or T by 1;
%   zz: demographic distribution, 269 by 13 or T by 13;
[yrow,ycol]=size(yield);
[zzrow,zzcol]=size(zz);
n=yrow;
h=floor(n/6);
CV_result=zeros(2,7);  CV_result1=zeros(2,6);
for ii=[2,3:2:13];
z_case1 = zz(:,1:ii);
z_case1_0 = zz(:,1:ii); 
hcv_case1_0 = zeros(1,n-h-h);
mhcv_case1_0 = zeros(n,n-h-h);
mhcv_case1_1 = zeros(1,n);
yield_0 = yield;
yield_1 = yield;
warning('off');
for i = h+1:n-h
    z_case1([i-h:i+h],:)=[];
    yield_1([i-h:i+h],:)=[];
    hcv_case1_0(1,i-h) = yield_0(i,1)-z_case1_0(i,:)*(((z_case1'*z_case1)\eye(size(z_case1'*z_case1)))*z_case1'*yield_1);
   for j = 1:n
       mhcv_case1_0(j,i-h) = (yield_0(j,1)-z_case1_0(j,:)*(((z_case1'*z_case1)\eye(size(z_case1'*z_case1)))*z_case1'*yield_1))^2; 
   end 
    z_case1 = zz(:,1:ii);
    yield_1 = yield;
end
for j = 1:n
    mhcv_case1_1(1,j) = (yield_0(j,1)-z_case1_0(j,:)*(((z_case1_0'*z_case1_0)\eye(size((z_case1_0'*z_case1_0))))*z_case1_0'*yield_0))^2;
end 
if ii == 2; 
    CV_result(1,1)=hcv_case1_0*hcv_case1_0'/n;
    CV_result(2,1)=CV_result(1,1)+sum(mhcv_case1_1)/n+sum(sum(mhcv_case1_0))/n/n;
else
CV_result1(1,(ii-1)/2) = hcv_case1_0*hcv_case1_0'/n;
CV_result1(2,(ii-1)/2) =CV_result1(1,(ii-1)/2)+sum(mhcv_case1_1)/n+sum(sum(mhcv_case1_0))/n/n;
end
end
CV_result(:,2:7)=CV_result1;
end