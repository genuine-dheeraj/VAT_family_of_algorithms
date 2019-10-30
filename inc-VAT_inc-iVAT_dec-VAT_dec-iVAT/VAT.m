% updated 10.11.2010

function [RV,C,I,RI,d]=VAT(R);
% Example function call: [DV,I] = VAT(D);
%
% *** Input Parameters ***
% @param R (n*n double): Dissimilarity data input
% 
% *** Output Values ***
% @value RV (n*n double): VAT-reordered dissimilarity data
% @value C (n int): Connection indexes of MST
% @value I (n int): Reordered indexes of R, the input data

[N,M]=size(R);

K=1:N;
J=K;
d=zeros(1,N-1);
%P=zeros(1,N);

%[y,i]=max(R);
%[y,j]=max(y);
I=1;
J(I)=[];
[y,j]=min(R(I,J));
d(1)=y;
I=[I J(j)];
J(J==J(j))=[];
C(1:2)=1;

for r=3:N-1,
    [y,i]=min(R(I,J));
    [y,j]=min(y);
    d(r-1)=y;
    I=[I J(j)];
    J(J==J(j))=[];
    C(r)=i(j);
end;
[y,i]=min(R(I,J));
d(N-1)=y;
I=[I J];
C(N)=i;

for r=1:N,
    RI(I(r))=r;
end;

RV=R(I,I);