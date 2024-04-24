function [factorBoot] = bootstrapVAR(factors,h0OLS,hxOLS,sigmaOLS,numBoot,seedNum)

% Resampling
rng(seedNum,'twister')
[nx,T]   = size(factors);

% The residuals
residuals       = zeros(nx,T);
for t=2:T
    residuals(:,t) =  factors(:,t) - (h0OLS + hxOLS*factors(:,t-1));
end

% Setting dimensions
factorBoot = zeros(nx,T,numBoot);

for s=1:numBoot
    indexBoot         = randi(T,1,T); % 1 by T vector of random numbers of {1,2,...,T}
    factors_mc        = zeros(nx,T);
%     factors_mc(:,1)   = factors(:,indexBoot(1,1));
    factors_mc(:,1)   = factors(:,1);  % as in Bauer and Hamilton(2018,RFS) R code, but the results are very similar  
    for t=2:T
        factors_mc(:,t)   = h0OLS + hxOLS*factors_mc(:,t-1) + residuals(:,indexBoot(1,t));
    end
    factorBoot(:,:,s) = factors_mc;

end

end

