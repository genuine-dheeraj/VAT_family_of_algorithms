% updated 10.11.2010

function [RiV]=inciVAT_1(RV,RiV_old,new_point_location)
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
    RiV(1:new_point_location-1,1:new_point_location-1)=RiV_old(1:new_point_location-1,1:new_point_location-1);
    for r=new_point_location:N,
        c=1:r-1;
        [y,i]=min(RV(r,1:r-1));
        RiV(r,c)=y;
        cnei=c(c~=i);
        a=[RiV(r,cnei); RiV(i,cnei)];
        [RiV(r,cnei),j]=max(a,[],1);
        RiV(c,r)=RiV(r,c)';
    end;

end