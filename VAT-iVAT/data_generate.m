function [data_matrix_with_lables,mean_matrix,var_matrix] = data_generate(no_of_clusters,odds_matrix,total_no_of_points)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    mean_x_matrix=500*randn(1,no_of_clusters);
    mean_y_matrix=500*randn(1,no_of_clusters);
    var_x_matrix=40*abs(randn(1,no_of_clusters));
    var_y_matrix=40*abs(randn(1,no_of_clusters));
    
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
    
    mean_matrix=[mean_x_matrix;mean_y_matrix];
    var_matrix=[var_x_matrix;var_y_matrix];

end

