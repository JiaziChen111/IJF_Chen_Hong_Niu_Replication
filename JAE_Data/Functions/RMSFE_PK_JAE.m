function [Z] = RMSFE_PK_JAE(X,Y)
%caculate RMSFE of two competitive models
% Forecasting horizon: h = 6M, 12M, 24M, 3 columns
% Maturities: 3M,6M, 9M, 12M, 15M, 18M, 24M, 30M, 36M, 48M, 60M, 72M, 84M, 96M, 108M, 120M. 17 rows
Z=zeros(17,3); % maturity by horizon 

% Column 1: h=6M
Z(1,1)=sqrt(sum((X.h6.m3-Y.h6.m3).^2)/size(X.h6.m3,1));
Z(2,1)=sqrt(sum((X.h6.m6-Y.h6.m6).^2)/size(X.h6.m6,1));
Z(3,1)=sqrt(sum((X.h6.m9-Y.h6.m9).^2)/size(X.h6.m9,1));
Z(4,1)=sqrt(sum((X.h6.m12-Y.h6.m12).^2)/size(X.h6.m12,1));
Z(5,1)=sqrt(sum((X.h6.m15-Y.h6.m15).^2)/size(X.h6.m15,1));
Z(6,1)=sqrt(sum((X.h6.m18-Y.h6.m18).^2)/size(X.h6.m18,1));
Z(7,1)=sqrt(sum((X.h6.m21-Y.h6.m21).^2)/size(X.h6.m21,1));
Z(8,1)=sqrt(sum((X.h6.m24-Y.h6.m24).^2)/size(X.h6.m24,1));
Z(9,1)=sqrt(sum((X.h6.m30-Y.h6.m30).^2)/size(X.h6.m30,1));
Z(10,1)=sqrt(sum((X.h6.m36-Y.h6.m36).^2)/size(X.h6.m36,1));
Z(11,1)=sqrt(sum((X.h6.m48-Y.h6.m48).^2)/size(X.h6.m48,1));
Z(12,1)=sqrt(sum((X.h6.m60-Y.h6.m60).^2)/size(X.h6.m60,1));
Z(13,1)=sqrt(sum((X.h6.m72-Y.h6.m72).^2)/size(X.h6.m72,1));
Z(14,1)=sqrt(sum((X.h6.m84-Y.h6.m84).^2)/size(X.h6.m84,1));
Z(15,1)=sqrt(sum((X.h6.m96-Y.h6.m96).^2)/size(X.h6.m96,1));
Z(16,1)=sqrt(sum((X.h6.m108-Y.h6.m108).^2)/size(X.h6.m108,1));
Z(17,1)=sqrt(sum((X.h6.m120-Y.h6.m120).^2)/size(X.h6.m120,1));


% Column 2: h=12M
Z(1,2)=sqrt(sum((X.h12.m3-Y.h12.m3).^2)/size(X.h12.m3,1));
Z(2,2)=sqrt(sum((X.h12.m6-Y.h12.m6).^2)/size(X.h12.m6,1));
Z(3,2)=sqrt(sum((X.h12.m9-Y.h12.m9).^2)/size(X.h12.m9,1));
Z(4,2)=sqrt(sum((X.h12.m12-Y.h12.m12).^2)/size(X.h12.m12,1));
Z(5,2)=sqrt(sum((X.h12.m15-Y.h12.m15).^2)/size(X.h12.m15,1));
Z(6,2)=sqrt(sum((X.h12.m18-Y.h12.m18).^2)/size(X.h12.m18,1));
Z(7,2)=sqrt(sum((X.h12.m21-Y.h12.m21).^2)/size(X.h12.m21,1));
Z(8,2)=sqrt(sum((X.h12.m24-Y.h12.m24).^2)/size(X.h12.m24,1));
Z(9,2)=sqrt(sum((X.h12.m30-Y.h12.m30).^2)/size(X.h12.m30,1));
Z(10,2)=sqrt(sum((X.h12.m36-Y.h12.m36).^2)/size(X.h12.m36,1));
Z(11,2)=sqrt(sum((X.h12.m48-Y.h12.m48).^2)/size(X.h12.m48,1));
Z(12,2)=sqrt(sum((X.h12.m60-Y.h12.m60).^2)/size(X.h12.m60,1));
Z(13,2)=sqrt(sum((X.h12.m72-Y.h12.m72).^2)/size(X.h12.m72,1));
Z(14,2)=sqrt(sum((X.h12.m84-Y.h12.m84).^2)/size(X.h12.m84,1));
Z(15,2)=sqrt(sum((X.h12.m96-Y.h12.m96).^2)/size(X.h12.m96,1));
Z(16,2)=sqrt(sum((X.h12.m108-Y.h12.m108).^2)/size(X.h12.m108,1));
Z(17,2)=sqrt(sum((X.h12.m120-Y.h12.m120).^2)/size(X.h12.m120,1));


% Column 3: h=24M
Z(1,3)=sqrt(sum((X.h24.m3-Y.h24.m3).^2)/size(X.h24.m3,1));
Z(2,3)=sqrt(sum((X.h24.m6-Y.h24.m6).^2)/size(X.h24.m6,1));
Z(3,3)=sqrt(sum((X.h24.m9-Y.h24.m9).^2)/size(X.h24.m9,1));
Z(4,3)=sqrt(sum((X.h24.m12-Y.h24.m12).^2)/size(X.h24.m12,1));
Z(5,3)=sqrt(sum((X.h24.m15-Y.h24.m15).^2)/size(X.h24.m15,1));
Z(6,3)=sqrt(sum((X.h24.m18-Y.h24.m18).^2)/size(X.h24.m18,1));
Z(7,3)=sqrt(sum((X.h24.m21-Y.h24.m21).^2)/size(X.h24.m21,1));
Z(8,3)=sqrt(sum((X.h24.m24-Y.h24.m24).^2)/size(X.h24.m24,1));
Z(9,3)=sqrt(sum((X.h24.m30-Y.h24.m30).^2)/size(X.h24.m30,1));
Z(10,3)=sqrt(sum((X.h24.m36-Y.h24.m36).^2)/size(X.h24.m36,1));
Z(11,3)=sqrt(sum((X.h24.m48-Y.h24.m48).^2)/size(X.h24.m48,1));
Z(12,3)=sqrt(sum((X.h24.m60-Y.h24.m60).^2)/size(X.h24.m60,1));
Z(13,3)=sqrt(sum((X.h24.m72-Y.h24.m72).^2)/size(X.h24.m72,1));
Z(14,3)=sqrt(sum((X.h24.m84-Y.h24.m84).^2)/size(X.h24.m84,1));
Z(15,3)=sqrt(sum((X.h24.m96-Y.h24.m96).^2)/size(X.h24.m96,1));
Z(16,3)=sqrt(sum((X.h24.m108-Y.h24.m108).^2)/size(X.h24.m108,1));
Z(17,3)=sqrt(sum((X.h24.m120-Y.h24.m120).^2)/size(X.h24.m120,1));

end

