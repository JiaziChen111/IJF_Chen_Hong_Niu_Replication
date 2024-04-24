function [For_result] = For_result_save(y_H1,y_H2,y_H4,y_H8,y_H12,y_H16,y_H20)

% combine all forecasting results for various forecast horizons (quarters)
% and time to maturity (months)

For_result=struct('h1',{},'h2',{},'h4',{},'h8',{},'h12',{},'h16',{},'h20',{});

% h=1Q
For_result(1).('h1')(1).('m3')=y_H1(:,1);
For_result(1).('h1')(1).('m6')=y_H1(:,2);
For_result(1).('h1')(1).('m12')=y_H1(:,3);
For_result(1).('h1')(1).('m24')=y_H1(:,4);
For_result(1).('h1')(1).('m36')=y_H1(:,5);
For_result(1).('h1')(1).('m48')=y_H1(:,6);
For_result(1).('h1')(1).('m60')=y_H1(:,7);
For_result(1).('h1')(1).('m72')=y_H1(:,8);
For_result(1).('h1')(1).('m84')=y_H1(:,9);
For_result(1).('h1')(1).('m96')=y_H1(:,10);
For_result(1).('h1')(1).('m108')=y_H1(:,11);
For_result(1).('h1')(1).('m120')=y_H1(:,12);
For_result(1).('h1')(1).('m180')=y_H1(:,13);
For_result(1).('h1')(1).('m240')=y_H1(:,14);
For_result(1).('h1')(1).('m360')=y_H1(:,15);



% h=2Q
For_result(1).('h2')(1).('m3')=y_H2(:,1);
For_result(1).('h2')(1).('m6')=y_H2(:,2);
For_result(1).('h2')(1).('m12')=y_H2(:,3);
For_result(1).('h2')(1).('m24')=y_H2(:,4);
For_result(1).('h2')(1).('m36')=y_H2(:,5);
For_result(1).('h2')(1).('m48')=y_H2(:,6);
For_result(1).('h2')(1).('m60')=y_H2(:,7);
For_result(1).('h2')(1).('m72')=y_H2(:,8);
For_result(1).('h2')(1).('m84')=y_H2(:,9);
For_result(1).('h2')(1).('m96')=y_H2(:,10);
For_result(1).('h2')(1).('m108')=y_H2(:,11);
For_result(1).('h2')(1).('m120')=y_H2(:,12);
For_result(1).('h2')(1).('m180')=y_H2(:,13);
For_result(1).('h2')(1).('m240')=y_H2(:,14);
For_result(1).('h2')(1).('m360')=y_H2(:,15);


% h=4Q
For_result(1).('h4')(1).('m3')=y_H4(:,1);
For_result(1).('h4')(1).('m6')=y_H4(:,2);
For_result(1).('h4')(1).('m12')=y_H4(:,3);
For_result(1).('h4')(1).('m24')=y_H4(:,4);
For_result(1).('h4')(1).('m36')=y_H4(:,5);
For_result(1).('h4')(1).('m48')=y_H4(:,6);
For_result(1).('h4')(1).('m60')=y_H4(:,7);
For_result(1).('h4')(1).('m72')=y_H4(:,8);
For_result(1).('h4')(1).('m84')=y_H4(:,9);
For_result(1).('h4')(1).('m96')=y_H4(:,10);
For_result(1).('h4')(1).('m108')=y_H4(:,11);
For_result(1).('h4')(1).('m120')=y_H4(:,12);
For_result(1).('h4')(1).('m180')=y_H4(:,13);
For_result(1).('h4')(1).('m240')=y_H4(:,14);
For_result(1).('h4')(1).('m360')=y_H4(:,15);



% h=8Q
For_result(1).('h8')(1).('m3')=y_H8(:,1);
For_result(1).('h8')(1).('m6')=y_H8(:,2);
For_result(1).('h8')(1).('m12')=y_H8(:,3);
For_result(1).('h8')(1).('m24')=y_H8(:,4);
For_result(1).('h8')(1).('m36')=y_H8(:,5);
For_result(1).('h8')(1).('m48')=y_H8(:,6);
For_result(1).('h8')(1).('m60')=y_H8(:,7);
For_result(1).('h8')(1).('m72')=y_H8(:,8);
For_result(1).('h8')(1).('m84')=y_H8(:,9);
For_result(1).('h8')(1).('m96')=y_H8(:,10);
For_result(1).('h8')(1).('m108')=y_H8(:,11);
For_result(1).('h8')(1).('m120')=y_H8(:,12);
For_result(1).('h8')(1).('m180')=y_H8(:,13);
For_result(1).('h8')(1).('m240')=y_H8(:,14);
For_result(1).('h8')(1).('m360')=y_H8(:,15);



% h=12Q
For_result(1).('h12')(1).('m3')=y_H12(:,1);
For_result(1).('h12')(1).('m6')=y_H12(:,2);
For_result(1).('h12')(1).('m12')=y_H12(:,3);
For_result(1).('h12')(1).('m24')=y_H12(:,4);
For_result(1).('h12')(1).('m36')=y_H12(:,5);
For_result(1).('h12')(1).('m48')=y_H12(:,6);
For_result(1).('h12')(1).('m60')=y_H12(:,7);
For_result(1).('h12')(1).('m72')=y_H12(:,8);
For_result(1).('h12')(1).('m84')=y_H12(:,9);
For_result(1).('h12')(1).('m96')=y_H12(:,10);
For_result(1).('h12')(1).('m108')=y_H12(:,11);
For_result(1).('h12')(1).('m120')=y_H12(:,12);
For_result(1).('h12')(1).('m180')=y_H12(:,13);
For_result(1).('h12')(1).('m240')=y_H12(:,14);
For_result(1).('h12')(1).('m360')=y_H12(:,15);


% h=16Q
For_result(1).('h16')(1).('m3')=y_H16(:,1);
For_result(1).('h16')(1).('m6')=y_H16(:,2);
For_result(1).('h16')(1).('m12')=y_H16(:,3);
For_result(1).('h16')(1).('m24')=y_H16(:,4);
For_result(1).('h16')(1).('m36')=y_H16(:,5);
For_result(1).('h16')(1).('m48')=y_H16(:,6);
For_result(1).('h16')(1).('m60')=y_H16(:,7);
For_result(1).('h16')(1).('m72')=y_H16(:,8);
For_result(1).('h16')(1).('m84')=y_H16(:,9);
For_result(1).('h16')(1).('m96')=y_H16(:,10);
For_result(1).('h16')(1).('m108')=y_H16(:,11);
For_result(1).('h16')(1).('m120')=y_H16(:,12);
For_result(1).('h16')(1).('m180')=y_H16(:,13);
For_result(1).('h16')(1).('m240')=y_H16(:,14);
For_result(1).('h16')(1).('m360')=y_H16(:,15);


% h=2Q
For_result(1).('h20')(1).('m3')=y_H20(:,1);
For_result(1).('h20')(1).('m6')=y_H20(:,2);
For_result(1).('h20')(1).('m12')=y_H20(:,3);
For_result(1).('h20')(1).('m24')=y_H20(:,4);
For_result(1).('h20')(1).('m36')=y_H20(:,5);
For_result(1).('h20')(1).('m48')=y_H20(:,6);
For_result(1).('h20')(1).('m60')=y_H20(:,7);
For_result(1).('h20')(1).('m72')=y_H20(:,8);
For_result(1).('h20')(1).('m84')=y_H20(:,9);
For_result(1).('h20')(1).('m96')=y_H20(:,10);
For_result(1).('h20')(1).('m108')=y_H20(:,11);
For_result(1).('h20')(1).('m120')=y_H20(:,12);
For_result(1).('h20')(1).('m180')=y_H20(:,13);
For_result(1).('h20')(1).('m240')=y_H20(:,14);
For_result(1).('h20')(1).('m360')=y_H20(:,15);

end

