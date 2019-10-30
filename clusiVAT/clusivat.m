function [ rv,C,I,ri,cut,smp ] = clusivat( x, cp, ns )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[n,p]=size(x);



[m,rp]=samplePlus(x,cp);

[~,i]=min(rp,[],2);

smp=[];
for t=1:cp,
    s = find(i==t);
    nt = ceil(ns*length(s)/n);
    ind = ceil(rand(nt,1)*length(s));
    smp=[smp; s(ind)];
end;
rs = distance2(x(smp,:),x(smp,:));
[rv,C,I,ri,cut]=VAT(rs);


%
%     figure;
%     plot(x(smp,1),x(smp,2),'.');

end

