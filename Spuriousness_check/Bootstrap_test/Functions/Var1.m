% By Martin M. Andreasen, summer 2006
% This function estimates a VAR(1) model by OLS
% OUTPUT
%  B        The coefficient matrix. 
%           B = [Y(:,1)_1 Y(:,2)_1 ... Y(:,g)_1 Constant ;
%                Y(:,1)_1 Y(:,2)_1 ... Y(:,g)_1 Constant ;
%                ....
%                Y(:,1)_1 Y(:,2)_1 ... Y(:,g)_1 Constant];
%  OMEGA    The variance matrix of the error terms
%  B_se     The standard errors for B 
%  OMEGA_se The standard errors for vech(OMEGA)

function [B,OMEGA,B_se,OMEGA_se] = Var1(Y);

% The length of the time series (T) and the number of observables (G)
[T,G] = size(Y);

% Constructs the lagged matrices
Y1 = Y(1:T-1,:);                        %Reads from the first row of Y until the second last row

% Deletes the first observations due to constructing lags
Y   = Y(2:T,:); 

% Constructing the regressor matrix 
NOBS           = size(Y,1);
X              = [Y1 ones(NOBS,1)];

% The OLS estimate of the VAR(1)-model
B = (X'*X)\X'*Y;

% The OLS estimate of the Co-Variance matrix
eps   = Y-X*B;
OMEGA = eps'*eps/(NOBS-(G+1));    

% Standard errors for B (See Hamilton 1994 page 299)
Q = X'*X;
invQ = inv(Q);
for i=1:G
    B_se(:,i) = sqrt(OMEGA(i,i)*diag(invQ));
end

% The standard errors for the covariance matrix
D        = DublicationMatrix(G);
Dplus    = inv(D'*D)*D';
SIGMA22  = 2*Dplus*kron(OMEGA,OMEGA)*Dplus'/(NOBS-(G+1));
OMEGA_se = sqrt(diag(SIGMA22));

% Transposing output for B
B = B';
B_se = B_se';
%**************************************************************************

% This function computes the dublication matrix as stated in Hamilton 1994
% page 301. That is we compute the matrix D such that: 
% D*vech(OMEGA) = vec(OMEGA) where OMEGA is a symmetric co-variance matrix

function D = DublicationMatrix(n)

D = zeros(n^2,n*(n-1)/2);
index1 = 0;
index2 = 0;
index_cov = zeros(n);
for i=1:n
   index_cov(i) = n-i;
end

for i=1:n
    for j=1:n
        index1 = index1 + 1;
        if j<i
            if j == 1
               index3 = i;
            else
               index3 = index3 + index_cov(j-1);
            end
            D(index1,index3) = 1; 
        else
           index2 = index2 + 1;
           D(index1,index2) = 1;            
        end
    end
end

