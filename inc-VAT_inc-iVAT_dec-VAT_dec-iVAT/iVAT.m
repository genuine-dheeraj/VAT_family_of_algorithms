% updated 10.11.2010

function [RiV]=iVAT(RV)
% Example function call: [RiV] = iVAT(RV);
%
% *** Input Parameters ***
% @param R (n*n double): dissimilarity data input
% @param VATflag (boolean): TRUE - R is VAT-reordered
%
% *** Output Values ***
% @value RV (n*n double): VAT-reordered dissimilarity data
% @value RiV (n*n double): iVAT-transformed dissimilarity data

N=length(RV);

    RiV=zeros(N);
    for r=2:N,
        c=1:r-1;
        [y,i]=min(RV(r,1:r-1));
        RiV(r,c)=y;
        cnei=c(c~=i);
        a=[RiV(r,cnei); RiV(i,cnei)];
        RiV(r,cnei)=max(a,[],1);
        RiV(c,r)=RiV(r,c)';
    end;

end