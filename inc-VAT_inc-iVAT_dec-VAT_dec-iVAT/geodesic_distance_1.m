function [dist,edge] = geodesic_distance_1(I,C,d,dat1,dat2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    distance=zeros(length(C),1);
    index=zeros(length(C),1);
    a1=1;
    while(dat1~=dat2)
        if(dat1>dat2)
            distance(a1) = d(dat1-1);
            index(a1) = dat1;
            a1=a1+1;
            dat1=C(dat1);
        else
            distance(a1) = d(dat2-1);
            index(a1) = dat2;
            a1=a1+1;
            dat2=C(dat2);
        end
    end
    
    [dist,idx]=max(distance);
    edge=index(idx);

end

