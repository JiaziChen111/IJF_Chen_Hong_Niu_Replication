% This function transforms daily data to monthly average data
% Daily data should have its first column as a format of "yyyymmdd". 

function [monthdata_ave]=dayarrange(daydata)

format='yyyymmdd';
date=cellstr(num2str(daydata(:,1)));
date=datenum(date,format);

daydata=[date datevec(date) daydata];
miny=min(daydata(:,2));
maxy=max(daydata(:,2));
monthdata_ave=[];

for year=miny:maxy
    for month=1:12
        datatem=daydata(daydata(:,2)==year,:);
        datatem=datatem(datatem(:,3)==month,:);
        
        aved = mean(datatem(:,end)); % average of monthly data
        monthdata_ave=[monthdata_ave;aved];
    end
end