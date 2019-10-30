clc
close all
clear all

no_of_clusters=3
no_of_points=1000

DI=0;
while ((DI<0.2)||(DI>0.3))

   odds_matrix=ceil(no_of_clusters*rand(1,no_of_clusters));

   [data_matrix_with_lables,dist_matrix] = CS_data_generate(no_of_clusters,odds_matrix,no_of_points);
    
   DI=dunns(no_of_clusters,dist_matrix,data_matrix_with_lables(:,3))

end


colors1=colormap;
colors=zeros(no_of_clusters,3);
for i=1:no_of_clusters
    colors(i,:)=colors1(ceil(length(colors1)*i/no_of_clusters),:);
end

figure;
for i=1:no_of_clusters
    cluster_index=find(data_matrix_with_lables(:,3)==i);
    plot(data_matrix_with_lables(cluster_index,1),data_matrix_with_lables(cluster_index,2),'.','color',colors(i,:));
    hold on;
end
axis equal


[N,M]=size(dist_matrix);
I=[1 2];
RV=dist_matrix(1:2,1:2);
RiV=RV;
d=dist_matrix(1,2);
C=[1 1];
RI=[1 2];
RiV_index=[0 2;2 0];

time_incVAT=[];
time_inciVAT=[];
time_VAT=[];
time_iVAT=[];

for i=3:N
    i
    
    tic
    distance_previous_points=dist_matrix(i,I);
    [RV,C,I,RI,d,new_point_location] = incVAT(RV,C,I,RI,d,distance_previous_points);
    time_incVAT=[time_incVAT toc];
    
    RiV_old=RiV;
    tic
    [RiV] = inciVAT_1(RV,RiV_old,new_point_location);
    time_inciVAT=[time_inciVAT toc];
    
    tic
    [RV_vat,C_vat,I_vat,RI_vat,d_vat]=VAT(dist_matrix(1:i,1:i));
    time_VAT=[time_VAT toc];
    
    tic
    [RiV_vat]=iVAT(RV_vat);
    time_iVAT=[time_iVAT toc];
    
    
    
   if(sum(abs(I-I_vat)))>0
       break;
   end
   if(sum(abs(d-d_vat)))>0
       break;
   end
   if(sum(abs(C-C_vat)))>0
       break;
   end
   
   if(sum(sum(abs(RV-RV_vat))))>0
       break;
   end
   
   if(sum(sum(abs(RiV-RiV_vat))))>0
       break;
   end
   
end


figure;
imagesc(RV); colormap(gray); axis image; axis off;

figure;
plot(d);

figure;
imagesc(RiV); colormap(gray); axis image; axis off;

figure;
imagesc(RiV_vat); colormap(gray); axis image; axis off;




figure;
plot(1:length(time_incVAT),time_incVAT,'b',1:length(time_VAT),time_VAT,'r');

figure;
plot(1:length(time_inciVAT),time_inciVAT,'b',1:length(time_iVAT),time_iVAT,'r');

figure;
plot(1:length(time_incVAT),time_incVAT,'b',1:length(time_VAT),time_VAT,'r',1:length(time_inciVAT),time_inciVAT,'g',1:length(time_iVAT),time_iVAT,'m');

figure;
plot(1:length(time_incVAT),time_incVAT+time_inciVAT,'b',1:length(time_VAT),time_VAT+time_iVAT,'r');


    
    
    
    
    
    
    
    
    
    
    