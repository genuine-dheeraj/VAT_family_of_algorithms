function [m,Rp] = samplePlus(X,cp)

[n,p]=size(X);

m=ones(cp,1);
d=distance2(X(1,:),X)';
Rp(:,1)=d;
for t=2:cp,
    d=min(d,Rp(:,t-1));
    [~,m(t)]=max(d);
    Rp(:,t)=distance2(X(m(t),:),X)';
end;