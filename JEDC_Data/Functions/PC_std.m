function [pc_std] = PC_std(XX,kk)
% Input: (1) XX, score,  T by 118(3,4,...,120 months)
%        (2) the number of PCs
% Output: pc_std, standardized PC components
[srow scol]=size(XX);
pc_std=NaN(srow,kk);
for i=1:kk
    pc_std(:,i)=standarized_series(XX(:,i));
end

end

