function [data_matrix_with_lables,dist_matrix] = CS_data_generate(no_of_clusters,odds_matrix,total_no_of_points)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    mean_x_matrix=500*randn(1,no_of_clusters);
    mean_y_matrix=500*randn(1,no_of_clusters);
    var_x_matrix=60*abs(randn(1,no_of_clusters));
    var_y_matrix=60*abs(randn(1,no_of_clusters));
    
    data_matrix_with_lables=zeros((ceil(total_no_of_points/sum(odds_matrix)))*sum(odds_matrix),3);
    
    l=1;
    while l<=length(data_matrix_with_lables)
        for j=1:no_of_clusters
            for k=1:odds_matrix(j)
                data_matrix_with_lables(l,:)=[mean_x_matrix(j)+var_x_matrix(j)*randn(1) mean_y_matrix(j)+var_y_matrix(j)*randn(1) j];
                l=l+1;
            end
        end
    end
    
    random_permutation=randperm(length(data_matrix_with_lables));
    data_matrix_with_lables=data_matrix_with_lables(random_permutation,:);
    
%     colors=['r.';'b.';'g.';'c.';'m.';'y.';'k.'];
%     figure;
%     for i=1:no_of_clusters
%         cluster_index=find(data_matrix_with_lables(:,3)==i);
%         plot(data_matrix_with_lables(cluster_index,1),data_matrix_with_lables(cluster_index,2),colors(i,:));
%         hold on;
%     end
%     h=gcf;
%     saveas(h,'gmm_3_data_plot.bmp','bmp');
% 
%     save('gmm_3_data.mat','data_matrix_with_lables');

%     tic
    dist_matrix=zeros(length(data_matrix_with_lables),length(data_matrix_with_lables));
    [len wid]=size(dist_matrix);

    for l=1:len
        diff_vector=data_matrix_with_lables(:,1:2)-[data_matrix_with_lables(l,1).*ones(len,1) data_matrix_with_lables(l,2).*ones(len,1)];
        dist_matrix(l,:)=abs(diff_vector(:,1)+1i*diff_vector(:,2));
    end
%     toc

%     figure;
%     imshow(dist_matrix,[min(min(dist_matrix)) max(max(dist_matrix))]);
%     h=gcf;
%     saveas(h,'distance_matrix_image.bmp','bmp');
% 
%     save('dist_matrix.mat','dist_matrix');

end

