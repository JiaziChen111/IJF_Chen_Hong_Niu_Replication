function [For_result] = For_result_save_JAE(y_H6,y_H12,y_H24)

%将预测结果整合在一起

For_result=struct('h6',{},'h12',{},'h24',{});


% h=6M
For_result(1).('h6')(1).('m3')=y_H6(:,1);
For_result(1).('h6')(1).('m6')=y_H6(:,2);
For_result(1).('h6')(1).('m9')=y_H6(:,3);
For_result(1).('h6')(1).('m12')=y_H6(:,4);
For_result(1).('h6')(1).('m15')=y_H6(:,5);
For_result(1).('h6')(1).('m18')=y_H6(:,6);
For_result(1).('h6')(1).('m21')=y_H6(:,7);
For_result(1).('h6')(1).('m24')=y_H6(:,8);
For_result(1).('h6')(1).('m30')=y_H6(:,9);
For_result(1).('h6')(1).('m36')=y_H6(:,10);
For_result(1).('h6')(1).('m48')=y_H6(:,11);
For_result(1).('h6')(1).('m60')=y_H6(:,12);
For_result(1).('h6')(1).('m72')=y_H6(:,13);
For_result(1).('h6')(1).('m84')=y_H6(:,14);
For_result(1).('h6')(1).('m96')=y_H6(:,15);
For_result(1).('h6')(1).('m108')=y_H6(:,16);
For_result(1).('h6')(1).('m120')=y_H6(:,17);


% h=12M
For_result(1).('h12')(1).('m3')=y_H12(:,1);
For_result(1).('h12')(1).('m6')=y_H12(:,2);
For_result(1).('h12')(1).('m9')=y_H12(:,3);
For_result(1).('h12')(1).('m12')=y_H12(:,4);
For_result(1).('h12')(1).('m15')=y_H12(:,5);
For_result(1).('h12')(1).('m18')=y_H12(:,6);
For_result(1).('h12')(1).('m21')=y_H12(:,7);
For_result(1).('h12')(1).('m24')=y_H12(:,8);
For_result(1).('h12')(1).('m30')=y_H12(:,9);
For_result(1).('h12')(1).('m36')=y_H12(:,10);
For_result(1).('h12')(1).('m48')=y_H12(:,11);
For_result(1).('h12')(1).('m60')=y_H12(:,12);
For_result(1).('h12')(1).('m72')=y_H12(:,13);
For_result(1).('h12')(1).('m84')=y_H12(:,14);
For_result(1).('h12')(1).('m96')=y_H12(:,15);
For_result(1).('h12')(1).('m108')=y_H12(:,16);
For_result(1).('h12')(1).('m120')=y_H12(:,17);

% h=24M
For_result(1).('h24')(1).('m3')=y_H24(:,1);
For_result(1).('h24')(1).('m6')=y_H24(:,2);
For_result(1).('h24')(1).('m9')=y_H24(:,3);
For_result(1).('h24')(1).('m12')=y_H24(:,4);
For_result(1).('h24')(1).('m15')=y_H24(:,5);
For_result(1).('h24')(1).('m18')=y_H24(:,6);
For_result(1).('h24')(1).('m21')=y_H24(:,7);
For_result(1).('h24')(1).('m24')=y_H24(:,8);
For_result(1).('h24')(1).('m30')=y_H24(:,9);
For_result(1).('h24')(1).('m36')=y_H24(:,10);
For_result(1).('h24')(1).('m48')=y_H24(:,11);
For_result(1).('h24')(1).('m60')=y_H24(:,12);
For_result(1).('h24')(1).('m72')=y_H24(:,13);
For_result(1).('h24')(1).('m84')=y_H24(:,14);
For_result(1).('h24')(1).('m96')=y_H24(:,15);
For_result(1).('h24')(1).('m108')=y_H24(:,16);
For_result(1).('h24')(1).('m120')=y_H24(:,17);



end

