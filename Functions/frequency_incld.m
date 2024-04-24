function [fre_inc] = frequency_incld(mcs_all)
%mcs_all: k by mat, e.g., 6 by 6
%   fre_inc: k by 1
[kk,matt]=size(mcs_all);
fre_inc=zeros(kk,1);
for ii=1:kk
fre_inc(ii,1)=sum(str2double(mcs_all(ii,:))>ones(1,matt)*0.1);
end
end

