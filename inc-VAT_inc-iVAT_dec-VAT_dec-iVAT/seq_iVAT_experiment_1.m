clc
close all
clear all

no_of_clusters=3
no_of_points=100

DI=0;
while (DI<1)

   odds_matrix=ceil(no_of_clusters*rand(1,no_of_clusters));

   [data_matrix_with_lables,dist_matrix] = CS_data_generate(no_of_clusters,odds_matrix,no_of_points);
    
   DI=dunns(no_of_clusters,dist_matrix,data_matrix_with_lables(:,3))

end


colors = distinguishable_colors(no_of_clusters);

figure;
for i=1:no_of_clusters
    cluster_index=find(data_matrix_with_lables(:,3)==i);
    plot(data_matrix_with_lables(cluster_index,1),data_matrix_with_lables(cluster_index,2),'.','color',colors(i,:),'MarkerSize',30);
    hold on;
end
axis equal

outputVideo = VideoWriter('ivat_image_movie_1','MPEG-4');
outputVideo.FrameRate = 10;
open(outputVideo);


[N,M]=size(dist_matrix);
I=[1 2];
RV=dist_matrix(1:2,1:2);
RiV=RV;
d=dist_matrix(1,2);
C=[1 1];
RI=[1 2];
RiV_index=[0 2;2 0];

fig=figure;
subplot(1,2,1);
for j=1:no_of_clusters
    cluster_index=find(data_matrix_with_lables(sort(I),3)==j);
    plot(data_matrix_with_lables(cluster_index,1),data_matrix_with_lables(cluster_index,2),'.','color',colors(j,:),'MarkerSize',30);
    hold on;
end
axis equal
subplot(1,2,2);
imagesc(RiV);colormap gray; axis off; axis equal;
F = getframe(fig);
writeVideo(outputVideo,F);
close(fig);

for i=3:N
    
    distance_previous_points=dist_matrix(i,I);
    [RV,C,I,RI,d,new_point_location] = incVAT(RV,C,I,RI,d,distance_previous_points);
    
    [RiV] = inciVAT_1(RV,RiV,new_point_location);
    
    fig=figure;
    subplot(1,2,1);
    for j=1:no_of_clusters
        cluster_index=find(data_matrix_with_lables(sort(I),3)==j);
        plot(data_matrix_with_lables(cluster_index,1),data_matrix_with_lables(cluster_index,2),'.','color',colors(j,:),'MarkerSize',30);
        hold on;
    end
    axis equal
    subplot(1,2,2);
    imagesc(RiV);colormap gray; axis off; axis equal;
    F = getframe(fig);
    writeVideo(outputVideo,F);
    close(fig);
    
end



while(length(I)>3)
    
    point_to_remove=I(randi(length(I)));
    iVAT_point_to_remove_index=find(I==point_to_remove);
    
    data_matrix_with_lables(iVAT_point_to_remove_index,:)=[];
    
    [RV,C,I,RI,d] = decVAT(RV,C,I,RI,d,point_to_remove);
        
    [RiV] = deciVAT(RV,RiV,iVAT_point_to_remove_index);
    
    fig=figure;
    subplot(1,2,1);
    for j=1:no_of_clusters
        cluster_index=find(data_matrix_with_lables(:,3)==j);
        plot(data_matrix_with_lables(cluster_index,1),data_matrix_with_lables(cluster_index,2),'.','color',colors(j,:),'MarkerSize',30);
        hold on;
    end
    axis equal
    subplot(1,2,2);
    imagesc(RiV);colormap gray; axis off; axis equal;
    F = getframe(fig);
    writeVideo(outputVideo,F);
    close(fig);
    
end

close(outputVideo);