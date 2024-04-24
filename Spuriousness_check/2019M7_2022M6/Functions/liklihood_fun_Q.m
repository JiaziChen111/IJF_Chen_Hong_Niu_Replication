function [f,ftn] = liklihood_fun_Q(bdraw,y_star,Mt);

% y = xlsread('data_1961','monthly_end of month','C2:K646')'/1200;%US bond yield 196106-201502
% y = y(:,1:3:end);%quarterly data
% y_star = y;
N = length(Mt);


sigma = bdraw(end);
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


b = factorloading(Mt,Phi_Q_draw,B_1_draw);
bb = b.b';
Y = y_star;

X_bar = OLS_1_step(Y,bb);
[mu_hat,Phi_hat,Omiga_hat]=VAR_2_step(X_bar);

fgamma_star = bb*X_bar;


A = (y_star-fgamma_star).*(y_star-fgamma_star);
for i = 1:T;
    for j = 1:N;
        ftn(i+(j-1)*N) = A(j,i)/sigma^2/2+log(sqrt(2*pi)*sigma);
    end
end
f = size(Y,1)*size(Y,2)*log(sqrt(2*pi)*sigma)+...
   trace((y_star-fgamma_star)*(y_star-fgamma_star)')/sigma^2/2;
%f = trace(([y_star;y_1;y_2]-[fgamma_star;fgamma_1;fgamma_2])*([y_star;y_1;y_2]-[fgamma_star;fgamma_1;fgamma_2])')/3/T;