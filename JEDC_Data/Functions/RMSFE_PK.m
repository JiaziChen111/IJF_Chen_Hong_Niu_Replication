function [Z] = RMSFE_PK(X,Y)
%caculate RMSFE of two competitive models
% Forecasting horizon: h = 1Q, 2Q, 4Q, 8Q, 12Q, 16Q, 20Q, 7 columns
% Maturities: 3M, 6M, 12M, 24M, 36M, 48M, 60M, 72M, 84M, 96M, 108M, 120M, 180M, 240M, 360M, 15 rows

Z=zeros(15,7); % maturity by horizon 

% Column 1: h=1Q
Z(1,1)=sqrt(sum((X.h1.m3-Y.h1.m3).^2)/size(X.h1.m3,1));
Z(2,1)=sqrt(sum((X.h1.m6-Y.h1.m6).^2)/size(X.h1.m6,1));
Z(3,1)=sqrt(sum((X.h1.m12-Y.h1.m12).^2)/size(X.h1.m12,1));
Z(4,1)=sqrt(sum((X.h1.m24-Y.h1.m24).^2)/size(X.h1.m24,1));
Z(5,1)=sqrt(sum((X.h1.m36-Y.h1.m36).^2)/size(X.h1.m36,1));
Z(6,1)=sqrt(sum((X.h1.m48-Y.h1.m48).^2)/size(X.h1.m48,1));
Z(7,1)=sqrt(sum((X.h1.m60-Y.h1.m60).^2)/size(X.h1.m60,1));
Z(8,1)=sqrt(sum((X.h1.m72-Y.h1.m72).^2)/size(X.h1.m72,1));
Z(9,1)=sqrt(sum((X.h1.m84-Y.h1.m84).^2)/size(X.h1.m84,1));
Z(10,1)=sqrt(sum((X.h1.m96-Y.h1.m96).^2)/size(X.h1.m96,1));
Z(11,1)=sqrt(sum((X.h1.m108-Y.h1.m108).^2)/size(X.h1.m108,1));
Z(12,1)=sqrt(sum((X.h1.m120-Y.h1.m120).^2)/size(X.h1.m120,1));
Z(13,1)=sqrt(sum((X.h1.m180-Y.h1.m180).^2)/size(X.h1.m180,1));
Z(14,1)=sqrt(sum((X.h1.m240-Y.h1.m240).^2)/size(X.h1.m240,1));
Z(15,1)=sqrt(sum((X.h1.m360-Y.h1.m360).^2)/size(X.h1.m360,1));


% Column 2: h=2Q
Z(1,2)=sqrt(sum((X.h2.m3-Y.h2.m3).^2)/size(X.h2.m3,1));
Z(2,2)=sqrt(sum((X.h2.m6-Y.h2.m6).^2)/size(X.h2.m6,1));
Z(3,2)=sqrt(sum((X.h2.m12-Y.h2.m12).^2)/size(X.h2.m12,1));
Z(4,2)=sqrt(sum((X.h2.m24-Y.h2.m24).^2)/size(X.h2.m24,1));
Z(5,2)=sqrt(sum((X.h2.m36-Y.h2.m36).^2)/size(X.h2.m36,1));
Z(6,2)=sqrt(sum((X.h2.m48-Y.h2.m48).^2)/size(X.h2.m48,1));
Z(7,2)=sqrt(sum((X.h2.m60-Y.h2.m60).^2)/size(X.h2.m60,1));
Z(8,2)=sqrt(sum((X.h2.m72-Y.h2.m72).^2)/size(X.h2.m72,1));
Z(9,2)=sqrt(sum((X.h2.m84-Y.h2.m84).^2)/size(X.h2.m84,1));
Z(10,2)=sqrt(sum((X.h2.m96-Y.h2.m96).^2)/size(X.h2.m96,1));
Z(11,2)=sqrt(sum((X.h2.m108-Y.h2.m108).^2)/size(X.h2.m108,1));
Z(12,2)=sqrt(sum((X.h2.m120-Y.h2.m120).^2)/size(X.h2.m120,1));
Z(13,2)=sqrt(sum((X.h2.m180-Y.h2.m180).^2)/size(X.h2.m180,1));
Z(14,2)=sqrt(sum((X.h2.m240-Y.h2.m240).^2)/size(X.h2.m240,1));
Z(15,2)=sqrt(sum((X.h2.m360-Y.h2.m360).^2)/size(X.h2.m360,1));


% Column 3: h=4Q
Z(1,3)=sqrt(sum((X.h4.m3-Y.h4.m3).^2)/size(X.h4.m3,1));
Z(2,3)=sqrt(sum((X.h4.m6-Y.h4.m6).^2)/size(X.h4.m6,1));
Z(3,3)=sqrt(sum((X.h4.m12-Y.h4.m12).^2)/size(X.h4.m12,1));
Z(4,3)=sqrt(sum((X.h4.m24-Y.h4.m24).^2)/size(X.h4.m24,1));
Z(5,3)=sqrt(sum((X.h4.m36-Y.h4.m36).^2)/size(X.h4.m36,1));
Z(6,3)=sqrt(sum((X.h4.m48-Y.h4.m48).^2)/size(X.h4.m48,1));
Z(7,3)=sqrt(sum((X.h4.m60-Y.h4.m60).^2)/size(X.h4.m60,1));
Z(8,3)=sqrt(sum((X.h4.m72-Y.h4.m72).^2)/size(X.h4.m72,1));
Z(9,3)=sqrt(sum((X.h4.m84-Y.h4.m84).^2)/size(X.h4.m84,1));
Z(10,3)=sqrt(sum((X.h4.m96-Y.h4.m96).^2)/size(X.h4.m96,1));
Z(11,3)=sqrt(sum((X.h4.m108-Y.h4.m108).^2)/size(X.h4.m108,1));
Z(12,3)=sqrt(sum((X.h4.m120-Y.h4.m120).^2)/size(X.h4.m120,1));
Z(13,3)=sqrt(sum((X.h4.m180-Y.h4.m180).^2)/size(X.h4.m180,1));
Z(14,3)=sqrt(sum((X.h4.m240-Y.h4.m240).^2)/size(X.h4.m240,1));
Z(15,3)=sqrt(sum((X.h4.m360-Y.h4.m360).^2)/size(X.h4.m360,1));


% Column 4: h=8Q
Z(1,4)=sqrt(sum((X.h8.m3-Y.h8.m3).^2)/size(X.h8.m3,1));
Z(2,4)=sqrt(sum((X.h8.m6-Y.h8.m6).^2)/size(X.h8.m6,1));
Z(3,4)=sqrt(sum((X.h8.m12-Y.h8.m12).^2)/size(X.h8.m12,1));
Z(4,4)=sqrt(sum((X.h8.m24-Y.h8.m24).^2)/size(X.h8.m24,1));
Z(5,4)=sqrt(sum((X.h8.m36-Y.h8.m36).^2)/size(X.h8.m36,1));
Z(6,4)=sqrt(sum((X.h8.m48-Y.h8.m48).^2)/size(X.h8.m48,1));
Z(7,4)=sqrt(sum((X.h8.m60-Y.h8.m60).^2)/size(X.h8.m60,1));
Z(8,4)=sqrt(sum((X.h8.m72-Y.h8.m72).^2)/size(X.h8.m72,1));
Z(9,4)=sqrt(sum((X.h8.m84-Y.h8.m84).^2)/size(X.h8.m84,1));
Z(10,4)=sqrt(sum((X.h8.m96-Y.h8.m96).^2)/size(X.h8.m96,1));
Z(11,4)=sqrt(sum((X.h8.m108-Y.h8.m108).^2)/size(X.h8.m108,1));
Z(12,4)=sqrt(sum((X.h8.m120-Y.h8.m120).^2)/size(X.h8.m120,1));
Z(13,4)=sqrt(sum((X.h8.m180-Y.h8.m180).^2)/size(X.h8.m180,1));
Z(14,4)=sqrt(sum((X.h8.m240-Y.h8.m240).^2)/size(X.h8.m240,1));
Z(15,4)=sqrt(sum((X.h8.m360-Y.h8.m360).^2)/size(X.h8.m360,1));


% Column 5: h=12Q
Z(1,5)=sqrt(sum((X.h12.m3-Y.h12.m3).^2)/size(X.h12.m3,1));
Z(2,5)=sqrt(sum((X.h12.m6-Y.h12.m6).^2)/size(X.h12.m6,1));
Z(3,5)=sqrt(sum((X.h12.m12-Y.h12.m12).^2)/size(X.h12.m12,1));
Z(4,5)=sqrt(sum((X.h12.m24-Y.h12.m24).^2)/size(X.h12.m24,1));
Z(5,5)=sqrt(sum((X.h12.m36-Y.h12.m36).^2)/size(X.h12.m36,1));
Z(6,5)=sqrt(sum((X.h12.m48-Y.h12.m48).^2)/size(X.h12.m48,1));
Z(7,5)=sqrt(sum((X.h12.m60-Y.h12.m60).^2)/size(X.h12.m60,1));
Z(8,5)=sqrt(sum((X.h12.m72-Y.h12.m72).^2)/size(X.h12.m72,1));
Z(9,5)=sqrt(sum((X.h12.m84-Y.h12.m84).^2)/size(X.h12.m84,1));
Z(10,5)=sqrt(sum((X.h12.m96-Y.h12.m96).^2)/size(X.h12.m96,1));
Z(11,5)=sqrt(sum((X.h12.m108-Y.h12.m108).^2)/size(X.h12.m108,1));
Z(12,5)=sqrt(sum((X.h12.m120-Y.h12.m120).^2)/size(X.h12.m120,1));
Z(13,5)=sqrt(sum((X.h12.m180-Y.h12.m180).^2)/size(X.h12.m180,1));
Z(14,5)=sqrt(sum((X.h12.m240-Y.h12.m240).^2)/size(X.h12.m240,1));
Z(15,5)=sqrt(sum((X.h12.m360-Y.h12.m360).^2)/size(X.h12.m360,1));


% Column 6: h=16Q
Z(1,6)=sqrt(sum((X.h16.m3-Y.h16.m3).^2)/size(X.h16.m3,1));
Z(2,6)=sqrt(sum((X.h16.m6-Y.h16.m6).^2)/size(X.h16.m6,1));
Z(3,6)=sqrt(sum((X.h16.m12-Y.h16.m12).^2)/size(X.h16.m12,1));
Z(4,6)=sqrt(sum((X.h16.m24-Y.h16.m24).^2)/size(X.h16.m24,1));
Z(5,6)=sqrt(sum((X.h16.m36-Y.h16.m36).^2)/size(X.h16.m36,1));
Z(6,6)=sqrt(sum((X.h16.m48-Y.h16.m48).^2)/size(X.h16.m48,1));
Z(7,6)=sqrt(sum((X.h16.m60-Y.h16.m60).^2)/size(X.h16.m60,1));
Z(8,6)=sqrt(sum((X.h16.m72-Y.h16.m72).^2)/size(X.h16.m72,1));
Z(9,6)=sqrt(sum((X.h16.m84-Y.h16.m84).^2)/size(X.h16.m84,1));
Z(10,6)=sqrt(sum((X.h16.m96-Y.h16.m96).^2)/size(X.h16.m96,1));
Z(11,6)=sqrt(sum((X.h16.m108-Y.h16.m108).^2)/size(X.h16.m108,1));
Z(12,6)=sqrt(sum((X.h16.m120-Y.h16.m120).^2)/size(X.h16.m120,1));
Z(13,6)=sqrt(sum((X.h16.m180-Y.h16.m180).^2)/size(X.h16.m180,1));
Z(14,6)=sqrt(sum((X.h16.m240-Y.h16.m240).^2)/size(X.h16.m240,1));
Z(15,6)=sqrt(sum((X.h16.m360-Y.h16.m360).^2)/size(X.h16.m360,1));


% Column 7: h=20Q
Z(1,7)=sqrt(sum((X.h20.m3-Y.h20.m3).^2)/size(X.h20.m3,1));
Z(2,7)=sqrt(sum((X.h20.m6-Y.h20.m6).^2)/size(X.h20.m6,1));
Z(3,7)=sqrt(sum((X.h20.m12-Y.h20.m12).^2)/size(X.h20.m12,1));
Z(4,7)=sqrt(sum((X.h20.m24-Y.h20.m24).^2)/size(X.h20.m24,1));
Z(5,7)=sqrt(sum((X.h20.m36-Y.h20.m36).^2)/size(X.h20.m36,1));
Z(6,7)=sqrt(sum((X.h20.m48-Y.h20.m48).^2)/size(X.h20.m48,1));
Z(7,7)=sqrt(sum((X.h20.m60-Y.h20.m60).^2)/size(X.h20.m60,1));
Z(8,7)=sqrt(sum((X.h20.m72-Y.h20.m72).^2)/size(X.h20.m72,1));
Z(9,7)=sqrt(sum((X.h20.m84-Y.h20.m84).^2)/size(X.h20.m84,1));
Z(10,7)=sqrt(sum((X.h20.m96-Y.h20.m96).^2)/size(X.h20.m96,1));
Z(11,7)=sqrt(sum((X.h20.m108-Y.h20.m108).^2)/size(X.h20.m108,1));
Z(12,7)=sqrt(sum((X.h20.m120-Y.h20.m120).^2)/size(X.h20.m120,1));
Z(13,7)=sqrt(sum((X.h20.m180-Y.h20.m180).^2)/size(X.h20.m180,1));
Z(14,7)=sqrt(sum((X.h20.m240-Y.h20.m240).^2)/size(X.h20.m240,1));
Z(15,7)=sqrt(sum((X.h20.m360-Y.h20.m360).^2)/size(X.h20.m360,1));



end

