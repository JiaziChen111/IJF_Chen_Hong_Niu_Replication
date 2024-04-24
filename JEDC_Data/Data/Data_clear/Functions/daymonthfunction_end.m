% This function transforms daily data to monthly data.
% Daily data should have its first column as a format of "yyyymmdd". 

function [monthdata]=dayarrange(daydata)

format='yyyymmdd';
date=cellstr(num2str(daydata(:,1)));
date=datenum(date,format);

daydata=[date datevec(date) daydata];
miny=min(daydata(:,2));
maxy=max(daydata(:,2));
monthdata=[];

for year=miny:maxy
    for month=1:12
        datatem=daydata(daydata(:,2)==year,:);
        datatem=datatem(datatem(:,3)==month,:);
        maxd=max(datatem(:,4));
        datatem=datatem(datatem(:,4)==maxd,end); % to get end of the month data use maxd. can use min to get the beginning data.
        monthdata=[monthdata;datatem];
    end
end

% dates=monthdata(:,1); 
% dates_clear=monthdata(:,2:8);
% monthdata=monthdata(:,9:end);
