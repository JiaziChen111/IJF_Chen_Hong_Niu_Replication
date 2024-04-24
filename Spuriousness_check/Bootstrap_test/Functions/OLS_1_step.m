function X = OLS_1_step(Y,B)
X = (B'*B)\(B'*(Y));% 3 by T matrix