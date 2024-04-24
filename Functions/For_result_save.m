function [For_result] = For_result_save(y_H3,y_H6,y_H12,y_H24,y_H36,y_H48,y_H60)

%将预测结果整合在一起

For_result=struct('h3',{},'h6',{},'h12',{},'h24',{},'h36',{},'h48',{},'h60',{});

% h=3M
For_result(1).('h3')(1).('m3')=y_H3(:,1);
For_result(1).('h3')(1).('m12')=y_H3(:,2);
For_result(1).('h3')(1).('m24')=y_H3(:,3);
For_result(1).('h3')(1).('m36')=y_H3(:,4);
For_result(1).('h3')(1).('m48')=y_H3(:,5);
For_result(1).('h3')(1).('m60')=y_H3(:,6);


% h=6M
For_result(1).('h6')(1).('m3')=y_H6(:,1);
For_result(1).('h6')(1).('m12')=y_H6(:,2);
For_result(1).('h6')(1).('m24')=y_H6(:,3);
For_result(1).('h6')(1).('m36')=y_H6(:,4);
For_result(1).('h6')(1).('m48')=y_H6(:,5);
For_result(1).('h6')(1).('m60')=y_H6(:,6);

% h=12M
For_result(1).('h12')(1).('m3')=y_H12(:,1);
For_result(1).('h12')(1).('m12')=y_H12(:,2);
For_result(1).('h12')(1).('m24')=y_H12(:,3);
For_result(1).('h12')(1).('m36')=y_H12(:,4);
For_result(1).('h12')(1).('m48')=y_H12(:,5);
For_result(1).('h12')(1).('m60')=y_H12(:,6);

% h=24M
For_result(1).('h24')(1).('m3')=y_H24(:,1);
For_result(1).('h24')(1).('m12')=y_H24(:,2);
For_result(1).('h24')(1).('m24')=y_H24(:,3);
For_result(1).('h24')(1).('m36')=y_H24(:,4);
For_result(1).('h24')(1).('m48')=y_H24(:,5);
For_result(1).('h24')(1).('m60')=y_H24(:,6);

% h=36M
For_result(1).('h36')(1).('m3')=y_H36(:,1);
For_result(1).('h36')(1).('m12')=y_H36(:,2);
For_result(1).('h36')(1).('m24')=y_H36(:,3);
For_result(1).('h36')(1).('m36')=y_H36(:,4);
For_result(1).('h36')(1).('m48')=y_H36(:,5);
For_result(1).('h36')(1).('m60')=y_H36(:,6);

% h=48M
For_result(1).('h48')(1).('m3')=y_H48(:,1);
For_result(1).('h48')(1).('m12')=y_H48(:,2);
For_result(1).('h48')(1).('m24')=y_H48(:,3);
For_result(1).('h48')(1).('m36')=y_H48(:,4);
For_result(1).('h48')(1).('m48')=y_H48(:,5);
For_result(1).('h48')(1).('m60')=y_H48(:,6);

% h=60M
For_result(1).('h60')(1).('m3')=y_H60(:,1);
For_result(1).('h60')(1).('m12')=y_H60(:,2);
For_result(1).('h60')(1).('m24')=y_H60(:,3);
For_result(1).('h60')(1).('m36')=y_H60(:,4);
For_result(1).('h60')(1).('m48')=y_H60(:,5);
For_result(1).('h60')(1).('m60')=y_H60(:,6);
end

