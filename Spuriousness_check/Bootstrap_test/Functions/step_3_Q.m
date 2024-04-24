function [bdraw,mu_bar,Phi_bar,Omiga_bar,Phi_Q_draw,B_1_draw,sigma,X_bar,VCV,y_bar,mu_std,Phi_std,Omiga_std] = step_3_Q(y_star,Mt,bdraw0)

lb = [0.01*3;eps];
ub = [0.1*9;0.5];
bdraw = fmincon(@(bdraw)liklihood_fun_Q(bdraw,y_star,Mt),bdraw0,[],[],[],[],lb,ub);
VCV = robustvcv(@(bdraw)liklihood_fun_Q(bdraw,y_star,Mt),bdraw,0);
T = size(y_star,2);
lambda_draw = bdraw(1);
Phi_Q_star_draw = [1 0 0;
   0 exp(-lambda_draw) lambda_draw*exp(-lambda_draw);
   0 0 exp(-lambda_draw)];
B_1_star_draw = -[1;
(1-exp(-lambda_draw))/lambda_draw;
(1-exp(-lambda_draw))/lambda_draw-exp(-lambda_draw)];

Phi_Q_draw = zeros(3,3);
Phi_Q_draw(1:3,1:3)= Phi_Q_star_draw;

B_1_draw = zeros(3,1);
B_1_draw(1:3,1) = B_1_star_draw;

b = factorloading(Mt,Phi_Q_draw,B_1_draw); % 3 by length(Mt)
bb = b.b'; % bb is length(Mt) by 3 matrix
Y = y_star;
X_bar = OLS_1_step(Y,bb); % 3 by T matrix

% [mu_bar,Phi_bar,Omiga_bar]=VAR_2_step(X_bar);

[mu_bar,Phi_bar,Omiga_bar,mu_std,Phi_std]=VAR_2_step_2(X_bar');%using vgxvarx

y_star_mean = bb*X_bar;

y_bar = y_star_mean;

yn = length(Mt);

sigma = 0;
for j = 1:yn;
sigma = sigma + var((y_star(j,:)-y_star_mean(j,:)));
end
sigma = mean(sigma)*ones(1,yn);

