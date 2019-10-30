clc
close all;
clear all;

%generate 2-dimensional syntheic dataset having a total of 1,000 points
%distributed among 4 clusters

total_no_of_points=1000
clusters=4
odds_matrix=ceil(clusters*rand(1,clusters));

colors1=colormap;
colors=zeros(clusters,3);
for i=1:clusters
    colors(i,:)=colors1(ceil(length(colors1)*i/clusters),:);
end

[data_matrix_with_lables,mean_matrix,var_matrix] = data_generate(clusters,odds_matrix,total_no_of_points);

figure;
for i=1:clusters
    cluster_index=find(data_matrix_with_lables(:,end)==i);
    plot(data_matrix_with_lables(cluster_index,1),data_matrix_with_lables(cluster_index,2),'.','color',colors(i,:));
    hold on;
end
axis equal
title('ground truth scatterplot (different colors represent different clusters)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% VAT %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x=data_matrix_with_lables;
[n,p]=size(x);
tic

Pitrue=x(:,end);
x=x(:,1:end-1);

rs = distance2(x,x);
[rv,C,I,ri,cut]=VAT(rs);

[cuts,ind]=sort(cut,'descend');
ind=sort(ind(1:clusters-1));

Pi=zeros(n,1);
Pi(I(1:ind(1)-1))=1;
Pi(I(ind(end):end))=clusters;
for k=2:clusters-1,
    Pi(I(ind(k-1):ind(k)-1))=k;
end;

[RiV,RV,reordering_mat]=iVAT(rv,1);

figure;
imagesc(rv); colormap(gray); axis image; axis off;
title('VAT reordered dissimilarity matrix image')

figure;
imagesc(RiV); colormap(gray); axis image; axis off;
title('iVAT dissimilarity matrix image')

figure;
for i=1:length(I)-1
    x_cor=[x(I(i),1) x(I(C(i)),1)];
    y_cor=[x(I(i),2) x(I(C(i)),2)];
    plot(x_cor,y_cor,'b');
    hold on
end
for i=1:length(ind)
    x_cor=[x(I(ind(i)),1) x(I(C(ind(i))),1)];
    y_cor=[x(I(ind(i)),2) x(I(C(ind(i))),2)];
    plot(x_cor,y_cor,'g');
    hold on
end
plot(x(I,1),x(I,2),'r.');
axis equal
title('MST of the dataset (longest 3 edges are shown in green)')

cluster_matrix_mod=zeros(1,total_no_of_points);
length_partition=zeros(1,clusters);
    for i=1:clusters
        length_partition(i)=length(find(Pi==i));
    end
[length_partition_sort,length_partition_sort_idx]=sort(length_partition,'descend');
index_remaining=1:clusters;
for i=1:clusters
    original_idx=length_partition_sort_idx(i);
    partition=find(Pi==original_idx);
    proposed_idx=mode(Pitrue(partition));
    if(sum(index_remaining==proposed_idx)~=0)
        proposed_idx;
        cluster_matrix_mod(find(Pi==original_idx))=proposed_idx;
    else
        index_remaining(1);
        cluster_matrix_mod(find(Pi==original_idx))=index_remaining(1);
    end
    index_remaining(index_remaining==proposed_idx)=[];
end

figure;
for i=1:clusters
    i;
    if(i==1)
        partition=I(1:ind(i));
    else if(i==(clusters))
            partition=I(ind(i-1):length(I));
        else
        partition=I(ind(i-1):ind(i)-1);
        end
    end
    plot(x(partition,1),x(partition,2),'.','color',colors(i,:));
    hold on;
end
axis equal;
title('VAT generated partition of the dataset (different colors represent different clusters)');

crct_prct_clusivat=((length(x)-length(find((Pitrue-cluster_matrix_mod'~=0))))/(length(x)))*100

