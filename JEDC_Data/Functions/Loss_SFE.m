function [Z] = Loss_SFE(X,Y)
%Loss: squared forecasting error, 
% Forecasting horizon: h = 1Q, 2Q, 4Q, 8Q, 12Q, 16Q, 20Q, 7 columns
% Maturities: 3M, 6M, 12M, 24M, 36M, 48M, 60M, 72M, 84M, 96M, 108M, 120M, 180M, 240M, 360M, 15 rows
Z=struct('h1',{},'h2',{},'h4',{},'h8',{},'h12',{},'h16',{},'h20',{});

% h=1Q
Z(1).('h1')(1).('m3')=(X.h1.m3(:,1)-Y.h1.m3(:,1)).^2;
Z(1).('h1')(1).('m6')=(X.h1.m6(:,1)-Y.h1.m6(:,1)).^2;
Z(1).('h1')(1).('m12')=(X.h1.m12(:,1)-Y.h1.m12(:,1)).^2;
Z(1).('h1')(1).('m24')=(X.h1.m24(:,1)-Y.h1.m24(:,1)).^2;
Z(1).('h1')(1).('m36')=(X.h1.m36(:,1)-Y.h1.m36(:,1)).^2;
Z(1).('h1')(1).('m48')=(X.h1.m48(:,1)-Y.h1.m48(:,1)).^2;
Z(1).('h1')(1).('m60')=(X.h1.m60(:,1)-Y.h1.m60(:,1)).^2;
Z(1).('h1')(1).('m72')=(X.h1.m72(:,1)-Y.h1.m72(:,1)).^2;
Z(1).('h1')(1).('m84')=(X.h1.m84(:,1)-Y.h1.m84(:,1)).^2;
Z(1).('h1')(1).('m96')=(X.h1.m96(:,1)-Y.h1.m96(:,1)).^2;
Z(1).('h1')(1).('m108')=(X.h1.m108(:,1)-Y.h1.m108(:,1)).^2;
Z(1).('h1')(1).('m120')=(X.h1.m120(:,1)-Y.h1.m120(:,1)).^2;
Z(1).('h1')(1).('m180')=(X.h1.m180(:,1)-Y.h1.m180(:,1)).^2;
Z(1).('h1')(1).('m240')=(X.h1.m240(:,1)-Y.h1.m240(:,1)).^2;
Z(1).('h1')(1).('m360')=(X.h1.m360(:,1)-Y.h1.m360(:,1)).^2;


% h=2Q
Z(1).('h2')(1).('m3')=(X.h2.m3(:,1)-Y.h2.m3(:,1)).^2;
Z(1).('h2')(1).('m6')=(X.h2.m6(:,1)-Y.h2.m6(:,1)).^2;
Z(1).('h2')(1).('m12')=(X.h2.m12(:,1)-Y.h2.m12(:,1)).^2;
Z(1).('h2')(1).('m24')=(X.h2.m24(:,1)-Y.h2.m24(:,1)).^2;
Z(1).('h2')(1).('m36')=(X.h2.m36(:,1)-Y.h2.m36(:,1)).^2;
Z(1).('h2')(1).('m48')=(X.h2.m48(:,1)-Y.h2.m48(:,1)).^2;
Z(1).('h2')(1).('m60')=(X.h2.m60(:,1)-Y.h2.m60(:,1)).^2;
Z(1).('h2')(1).('m72')=(X.h2.m72(:,1)-Y.h2.m72(:,1)).^2;
Z(1).('h2')(1).('m84')=(X.h2.m84(:,1)-Y.h2.m84(:,1)).^2;
Z(1).('h2')(1).('m96')=(X.h2.m96(:,1)-Y.h2.m96(:,1)).^2;
Z(1).('h2')(1).('m108')=(X.h2.m108(:,1)-Y.h2.m108(:,1)).^2;
Z(1).('h2')(1).('m120')=(X.h2.m120(:,1)-Y.h2.m120(:,1)).^2;
Z(1).('h2')(1).('m180')=(X.h2.m180(:,1)-Y.h2.m180(:,1)).^2;
Z(1).('h2')(1).('m240')=(X.h2.m240(:,1)-Y.h2.m240(:,1)).^2;
Z(1).('h2')(1).('m360')=(X.h2.m360(:,1)-Y.h2.m360(:,1)).^2;


% h=4Q
Z(1).('h4')(1).('m3')=(X.h4.m3(:,1)-Y.h4.m3(:,1)).^2;
Z(1).('h4')(1).('m6')=(X.h4.m6(:,1)-Y.h4.m6(:,1)).^2;
Z(1).('h4')(1).('m12')=(X.h4.m12(:,1)-Y.h4.m12(:,1)).^2;
Z(1).('h4')(1).('m24')=(X.h4.m24(:,1)-Y.h4.m24(:,1)).^2;
Z(1).('h4')(1).('m36')=(X.h4.m36(:,1)-Y.h4.m36(:,1)).^2;
Z(1).('h4')(1).('m48')=(X.h4.m48(:,1)-Y.h4.m48(:,1)).^2;
Z(1).('h4')(1).('m60')=(X.h4.m60(:,1)-Y.h4.m60(:,1)).^2;
Z(1).('h4')(1).('m72')=(X.h4.m72(:,1)-Y.h4.m72(:,1)).^2;
Z(1).('h4')(1).('m84')=(X.h4.m84(:,1)-Y.h4.m84(:,1)).^2;
Z(1).('h4')(1).('m96')=(X.h4.m96(:,1)-Y.h4.m96(:,1)).^2;
Z(1).('h4')(1).('m108')=(X.h4.m108(:,1)-Y.h4.m108(:,1)).^2;
Z(1).('h4')(1).('m120')=(X.h4.m120(:,1)-Y.h4.m120(:,1)).^2;
Z(1).('h4')(1).('m180')=(X.h4.m180(:,1)-Y.h4.m180(:,1)).^2;
Z(1).('h4')(1).('m240')=(X.h4.m240(:,1)-Y.h4.m240(:,1)).^2;
Z(1).('h4')(1).('m360')=(X.h4.m360(:,1)-Y.h4.m360(:,1)).^2;


% h=4Q
Z(1).('h8')(1).('m3')=(X.h8.m3(:,1)-Y.h8.m3(:,1)).^2;
Z(1).('h8')(1).('m6')=(X.h8.m6(:,1)-Y.h8.m6(:,1)).^2;
Z(1).('h8')(1).('m12')=(X.h8.m12(:,1)-Y.h8.m12(:,1)).^2;
Z(1).('h8')(1).('m24')=(X.h8.m24(:,1)-Y.h8.m24(:,1)).^2;
Z(1).('h8')(1).('m36')=(X.h8.m36(:,1)-Y.h8.m36(:,1)).^2;
Z(1).('h8')(1).('m48')=(X.h8.m48(:,1)-Y.h8.m48(:,1)).^2;
Z(1).('h8')(1).('m60')=(X.h8.m60(:,1)-Y.h8.m60(:,1)).^2;
Z(1).('h8')(1).('m72')=(X.h8.m72(:,1)-Y.h8.m72(:,1)).^2;
Z(1).('h8')(1).('m84')=(X.h8.m84(:,1)-Y.h8.m84(:,1)).^2;
Z(1).('h8')(1).('m96')=(X.h8.m96(:,1)-Y.h8.m96(:,1)).^2;
Z(1).('h8')(1).('m108')=(X.h8.m108(:,1)-Y.h8.m108(:,1)).^2;
Z(1).('h8')(1).('m120')=(X.h8.m120(:,1)-Y.h8.m120(:,1)).^2;
Z(1).('h8')(1).('m180')=(X.h8.m180(:,1)-Y.h8.m180(:,1)).^2;
Z(1).('h8')(1).('m240')=(X.h8.m240(:,1)-Y.h8.m240(:,1)).^2;
Z(1).('h8')(1).('m360')=(X.h8.m360(:,1)-Y.h8.m360(:,1)).^2;


% h=12Q
Z(1).('h12')(1).('m3')=(X.h12.m3(:,1)-Y.h12.m3(:,1)).^2;
Z(1).('h12')(1).('m6')=(X.h12.m6(:,1)-Y.h12.m6(:,1)).^2;
Z(1).('h12')(1).('m12')=(X.h12.m12(:,1)-Y.h12.m12(:,1)).^2;
Z(1).('h12')(1).('m24')=(X.h12.m24(:,1)-Y.h12.m24(:,1)).^2;
Z(1).('h12')(1).('m36')=(X.h12.m36(:,1)-Y.h12.m36(:,1)).^2;
Z(1).('h12')(1).('m48')=(X.h12.m48(:,1)-Y.h12.m48(:,1)).^2;
Z(1).('h12')(1).('m60')=(X.h12.m60(:,1)-Y.h12.m60(:,1)).^2;
Z(1).('h12')(1).('m72')=(X.h12.m72(:,1)-Y.h12.m72(:,1)).^2;
Z(1).('h12')(1).('m84')=(X.h12.m84(:,1)-Y.h12.m84(:,1)).^2;
Z(1).('h12')(1).('m96')=(X.h12.m96(:,1)-Y.h12.m96(:,1)).^2;
Z(1).('h12')(1).('m108')=(X.h12.m108(:,1)-Y.h12.m108(:,1)).^2;
Z(1).('h12')(1).('m120')=(X.h12.m120(:,1)-Y.h12.m120(:,1)).^2;
Z(1).('h12')(1).('m180')=(X.h12.m180(:,1)-Y.h12.m180(:,1)).^2;
Z(1).('h12')(1).('m240')=(X.h12.m240(:,1)-Y.h12.m240(:,1)).^2;
Z(1).('h12')(1).('m360')=(X.h12.m360(:,1)-Y.h12.m360(:,1)).^2;


% h=16Q
Z(1).('h16')(1).('m3')=(X.h16.m3(:,1)-Y.h16.m3(:,1)).^2;
Z(1).('h16')(1).('m6')=(X.h16.m6(:,1)-Y.h16.m6(:,1)).^2;
Z(1).('h16')(1).('m12')=(X.h16.m12(:,1)-Y.h16.m12(:,1)).^2;
Z(1).('h16')(1).('m24')=(X.h16.m24(:,1)-Y.h16.m24(:,1)).^2;
Z(1).('h16')(1).('m36')=(X.h16.m36(:,1)-Y.h16.m36(:,1)).^2;
Z(1).('h16')(1).('m48')=(X.h16.m48(:,1)-Y.h16.m48(:,1)).^2;
Z(1).('h16')(1).('m60')=(X.h16.m60(:,1)-Y.h16.m60(:,1)).^2;
Z(1).('h16')(1).('m72')=(X.h16.m72(:,1)-Y.h16.m72(:,1)).^2;
Z(1).('h16')(1).('m84')=(X.h16.m84(:,1)-Y.h16.m84(:,1)).^2;
Z(1).('h16')(1).('m96')=(X.h16.m96(:,1)-Y.h16.m96(:,1)).^2;
Z(1).('h16')(1).('m108')=(X.h16.m108(:,1)-Y.h16.m108(:,1)).^2;
Z(1).('h16')(1).('m120')=(X.h16.m120(:,1)-Y.h16.m120(:,1)).^2;
Z(1).('h16')(1).('m180')=(X.h16.m180(:,1)-Y.h16.m180(:,1)).^2;
Z(1).('h16')(1).('m240')=(X.h16.m240(:,1)-Y.h16.m240(:,1)).^2;
Z(1).('h16')(1).('m360')=(X.h16.m360(:,1)-Y.h16.m360(:,1)).^2;


% h=20Q
Z(1).('h20')(1).('m3')=(X.h20.m3(:,1)-Y.h20.m3(:,1)).^2;
Z(1).('h20')(1).('m6')=(X.h20.m6(:,1)-Y.h20.m6(:,1)).^2;
Z(1).('h20')(1).('m12')=(X.h20.m12(:,1)-Y.h20.m12(:,1)).^2;
Z(1).('h20')(1).('m24')=(X.h20.m24(:,1)-Y.h20.m24(:,1)).^2;
Z(1).('h20')(1).('m36')=(X.h20.m36(:,1)-Y.h20.m36(:,1)).^2;
Z(1).('h20')(1).('m48')=(X.h20.m48(:,1)-Y.h20.m48(:,1)).^2;
Z(1).('h20')(1).('m60')=(X.h20.m60(:,1)-Y.h20.m60(:,1)).^2;
Z(1).('h20')(1).('m72')=(X.h20.m72(:,1)-Y.h20.m72(:,1)).^2;
Z(1).('h20')(1).('m84')=(X.h20.m84(:,1)-Y.h20.m84(:,1)).^2;
Z(1).('h20')(1).('m96')=(X.h20.m96(:,1)-Y.h20.m96(:,1)).^2;
Z(1).('h20')(1).('m108')=(X.h20.m108(:,1)-Y.h20.m108(:,1)).^2;
Z(1).('h20')(1).('m120')=(X.h20.m120(:,1)-Y.h20.m120(:,1)).^2;
Z(1).('h20')(1).('m180')=(X.h20.m180(:,1)-Y.h20.m180(:,1)).^2;
Z(1).('h20')(1).('m240')=(X.h20.m240(:,1)-Y.h20.m240(:,1)).^2;
Z(1).('h20')(1).('m360')=(X.h20.m360(:,1)-Y.h20.m360(:,1)).^2;

end

