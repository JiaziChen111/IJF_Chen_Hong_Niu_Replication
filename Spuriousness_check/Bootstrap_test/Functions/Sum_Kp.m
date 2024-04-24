function Sum_Kp = Sum_Kp(K,p)
% sum_{h=1}^{K} h^{p}/K

Sum_Kp=0;
for h=1:K
    Sum_Kp=Sum_Kp+(h^p)/K;
end

end

