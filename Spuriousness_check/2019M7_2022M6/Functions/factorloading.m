function b =  factorloading(Mt,Phi_Q,B_1)
N = max(Mt); 
B = zeros(length(B_1),N);
B(:,1) = B_1;
for i = 2:N;
    B(:,i) = Phi_Q'*B(:,i-1)+B_1;
end
b.b = zeros(length(B_1),length(Mt));
b.b_all = zeros(size(B_1,1),N);
for j = 1:N;
    b.b_all(:,j) = -B(:,j)/j;
end
b.b = b.b_all(:,Mt); % 3 by length(Mt) 7
