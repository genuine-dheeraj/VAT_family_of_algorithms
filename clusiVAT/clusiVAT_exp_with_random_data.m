clc
close all;
clear all;

%generate 2-dimensional syntheic dataset having a total of 1,000,000 points
%distributed among 4 clusters

total_no_of_points=1000000
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
%%%%%%%%%%%% CLUSIVAT %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


x=data_matrix_with_lables;
[n,p]=size(x);

tic

Pitrue=x(:,end);
x=x(:,1:end-1);

cp=10; ns=300;
[ rv,C,I,ri,cut,smp ] = clusivat( x, cp, ns );

[cuts,ind]=sort(cut,'descend');
ind=sort(ind(1:clusters-1));

Pi=zeros(n,1);
Pi(smp(I(1:ind(1)-1)))=1;
Pi(smp(I(ind(end):end)))=clusters;
for k=2:clusters-1,
    Pi(smp(I(ind(k-1):ind(k)-1)))=k;
end;

nsmp=setdiff(1:n,smp);
r=distance2(x(smp,:),x(nsmp,:));
[~,s]=min(r,[],1);
Pi(nsmp)=Pi(smp(s));

[RiV,RV,reordering_mat]=iVAT(rv,1);

toc

figure;
imagesc(rv); colormap(gray); axis image; axis off;
title('VAT reordered dissimilarity matrix image')

figure;
imagesc(RiV); colormap(gray); axis image; axis off;
title('iVAT dissimilarity matrix image')

figure;
for i=1:length(smp)-1
    x_cor=[x(smp(I(i)),1) x(smp(I(C(i))),1)];
    y_cor=[x(smp(I(i)),2) x(smp(I(C(i))),2)];
    plot(x_cor,y_cor,'b');
    hold on
end
for i=1:length(ind)
    x_cor=[x(smp(I(ind(i))),1) x(smp(I(C(ind(i)))),1)];
    y_cor=[x(smp(I(ind(i))),2) x(smp(I(C(ind(i)))),2)];
    plot(x_cor,y_cor,'g');
    hold on
end
plot(x(smp(I),1),x(smp(I),2),'r.');
axis equal
title('MST of the dataset (longest 3 edges are shown in green)')


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
    plot(x(smp(partition),1),x(smp(partition),2),'.','color',colors(i,:));
    hold on;
end
axis equal;
title('VAT generated partition of the sample points (different colors represent different clusters)');

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
    cluster_matrix_unique=unique(cluster_matrix_mod);
    cluster_index=find(cluster_matrix_mod==cluster_matrix_unique(i));
    plot(x(cluster_index,1),x(cluster_index,2),'.','color',colors(i,:));
    hold on;
end
axis equal;
title('VAT generated partition of the entire dataset (different colors represent different clusters)');

crct_prct_clusivat=((length(x)-length(find((Pitrue-(cluster_matrix_mod)'~=0))))/(length(x)))*100

