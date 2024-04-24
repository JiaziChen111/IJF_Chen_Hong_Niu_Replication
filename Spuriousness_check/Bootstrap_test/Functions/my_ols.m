% estimation OLS
function [RES,cov_beta,R2,AIC,y_hat] = my_ols(X,y)
n = length(y);
beta = inv(X'*X)*(X'*y);
k = length(beta);
y_hat = X*beta;
ep = y -y_hat;
R2 = sum((y-y_hat).^2)/sum((y-mean(y)).^2);
adjR2 = 1-((n-1)/(n-k-1))*(1-R2);
AIC = log(ep'*ep/(n-k))+2*k/n;
BIC = log(ep'*ep/(n-k))+log(n)*k/n;
s2 = ep'*ep/(n-k);
cov_beta = s2*inv(X'*X);
s_beta = sqrt(diag(s2*inv(X'*X)));

RES = [beta s_beta beta./s_beta normpdf(-abs(beta./s_beta))];
R2 = [R2;adjR2];
AIC = [AIC;BIC];

