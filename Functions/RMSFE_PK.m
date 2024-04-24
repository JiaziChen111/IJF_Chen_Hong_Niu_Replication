function [Z] = RMSFE_PK(X,Y)
%caculate RMSFE of two competitive models
% Forecasting horizon: h = 3M, 6M, 12M, 24M, 36M, 48M, 60M, 7 columns
% Maturities: 3M, 12M, 24M, 36M, 48M, 60M, 6 rows
Z=zeros(6,7); % maturity by horizon 
% Column 1: h=3M
Z(1,1)=sqrt(sum((X.h3.m3-Y.h3.m3).^2)/size(X.h3.m3,1));
Z(2,1)=sqrt(sum((X.h3.m12-Y.h3.m12).^2)/size(X.h3.m12,1));
Z(3,1)=sqrt(sum((X.h3.m24-Y.h3.m24).^2)/size(X.h3.m24,1));
Z(4,1)=sqrt(sum((X.h3.m36-Y.h3.m36).^2)/size(X.h3.m36,1));
Z(5,1)=sqrt(sum((X.h3.m48-Y.h3.m48).^2)/size(X.h3.m48,1));
Z(6,1)=sqrt(sum((X.h3.m60-Y.h3.m60).^2)/size(X.h3.m60,1));

% Column 2: h=6M
Z(1,2)=sqrt(sum((X.h6.m3-Y.h6.m3).^2)/size(X.h6.m3,1));
Z(2,2)=sqrt(sum((X.h6.m12-Y.h6.m12).^2)/size(X.h6.m12,1));
Z(3,2)=sqrt(sum((X.h6.m24-Y.h6.m24).^2)/size(X.h6.m24,1));
Z(4,2)=sqrt(sum((X.h6.m36-Y.h6.m36).^2)/size(X.h6.m36,1));
Z(5,2)=sqrt(sum((X.h6.m48-Y.h6.m48).^2)/size(X.h6.m48,1));
Z(6,2)=sqrt(sum((X.h6.m60-Y.h6.m60).^2)/size(X.h6.m60,1));

% Column 3: h=12M
Z(1,3)=sqrt(sum((X.h12.m3-Y.h12.m3).^2)/size(X.h12.m3,1));
Z(2,3)=sqrt(sum((X.h12.m12-Y.h12.m12).^2)/size(X.h12.m12,1));
Z(3,3)=sqrt(sum((X.h12.m24-Y.h12.m24).^2)/size(X.h12.m24,1));
Z(4,3)=sqrt(sum((X.h12.m36-Y.h12.m36).^2)/size(X.h12.m36,1));
Z(5,3)=sqrt(sum((X.h12.m48-Y.h12.m48).^2)/size(X.h12.m48,1));
Z(6,3)=sqrt(sum((X.h12.m60-Y.h12.m60).^2)/size(X.h12.m60,1));

% Column 4: h=24M
Z(1,4)=sqrt(sum((X.h24.m3-Y.h24.m3).^2)/size(X.h24.m3,1));
Z(2,4)=sqrt(sum((X.h24.m12-Y.h24.m12).^2)/size(X.h24.m12,1));
Z(3,4)=sqrt(sum((X.h24.m24-Y.h24.m24).^2)/size(X.h24.m24,1));
Z(4,4)=sqrt(sum((X.h24.m36-Y.h24.m36).^2)/size(X.h24.m36,1));
Z(5,4)=sqrt(sum((X.h24.m48-Y.h24.m48).^2)/size(X.h24.m48,1));
Z(6,4)=sqrt(sum((X.h24.m60-Y.h24.m60).^2)/size(X.h24.m60,1));

% Column 5: h=36M
Z(1,5)=sqrt(sum((X.h36.m3-Y.h36.m3).^2)/size(X.h36.m3,1));
Z(2,5)=sqrt(sum((X.h36.m12-Y.h36.m12).^2)/size(X.h36.m12,1));
Z(3,5)=sqrt(sum((X.h36.m24-Y.h36.m24).^2)/size(X.h36.m24,1));
Z(4,5)=sqrt(sum((X.h36.m36-Y.h36.m36).^2)/size(X.h36.m36,1));
Z(5,5)=sqrt(sum((X.h36.m48-Y.h36.m48).^2)/size(X.h36.m48,1));
Z(6,5)=sqrt(sum((X.h36.m60-Y.h36.m60).^2)/size(X.h36.m60,1));

% Column 6: h=48M
Z(1,6)=sqrt(sum((X.h48.m3-Y.h48.m3).^2)/size(X.h48.m3,1));
Z(2,6)=sqrt(sum((X.h48.m12-Y.h48.m12).^2)/size(X.h48.m12,1));
Z(3,6)=sqrt(sum((X.h48.m24-Y.h48.m24).^2)/size(X.h48.m24,1));
Z(4,6)=sqrt(sum((X.h48.m36-Y.h48.m36).^2)/size(X.h48.m36,1));
Z(5,6)=sqrt(sum((X.h48.m48-Y.h48.m48).^2)/size(X.h48.m48,1));
Z(6,6)=sqrt(sum((X.h48.m60-Y.h48.m60).^2)/size(X.h48.m60,1));

% Column 7: h=6M
Z(1,7)=sqrt(sum((X.h60.m3-Y.h60.m3).^2)/size(X.h60.m3,1));
Z(2,7)=sqrt(sum((X.h60.m12-Y.h60.m12).^2)/size(X.h60.m12,1));
Z(3,7)=sqrt(sum((X.h60.m24-Y.h60.m24).^2)/size(X.h60.m24,1));
Z(4,7)=sqrt(sum((X.h60.m36-Y.h60.m36).^2)/size(X.h60.m36,1));
Z(5,7)=sqrt(sum((X.h60.m48-Y.h60.m48).^2)/size(X.h60.m48,1));
Z(6,7)=sqrt(sum((X.h60.m60-Y.h60.m60).^2)/size(X.h60.m60,1));

end

