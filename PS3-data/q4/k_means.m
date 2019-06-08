function [clusters, centroids] = k_means(X, k)

%%% K-mean clustering algorithm, takes X - data to cluste and k - number of clusters

%% we get m: number of samples and n: the number of dimensions
[m,n] = size(X);

%% we pick random datapoint as the initial centroids
for i = 1:k
  centroids(i,:) = X(randi([1,m]),:);
endfor
old_centroids = ones(k,n); 
newcentroids = zeros(k,n);
clustsize = zeros(k,1);
while (max(vecnorm(centroids - old_centroids, 2 ,2))) > 0.001
  old_centroids = centroids;
%% in this loop we check for each datapoint which centroid is closest to it, and accordingly we assign it to the cluster
  for i = 1:m
    xi = X(i,:);
%% we check which centroid is the closest, and write its index on clust
    [dist, clust] = min(vecnorm(centroids - repmat(xi, k, 1), 2 ,2));
%% we assigned cluster is stored in clusters vector
    clusters(i) = clust;
%% we on flight update the centroid, by adding the appropriete points and storing also the size of clusters
    newcentroids(clust,:) += xi; 
    clustsize(clust) += 1;  
  endfor
%% we update the centroids as a mean of points in cluster (ie. sum of points' coordinates divided by the cluster size
  centroids = newcentroids ./ clustsize;
  draw_clusters(X, clusters, centroids);
  pause(0.01);
endwhile
