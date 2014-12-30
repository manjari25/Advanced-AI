clc;
clear all;
close all;
data = load ('data/movies_data');
train = data(1:2500,:);
test = data(2501:end,:);
tic
kdtreeNS = KDTreeSearcher(train);
toc
ran = randi(2,276);
new_point = ran(:,1)';
for j=1:276
    if(new_point(1,j)==1)
        new_point(1,j)==0;
    elseif(new_point(1,j)==2)
        new_point(1,j)==1;
    end
end
new_point(new_point==1) = 0;
new_point(new_point==2) = 1;
disp('cosine');
tic
idx=knnsearch(kdtreeNS,new_point,'k',1,'Distance','minkowski');
toc
disp('euclidean');
tic
idx=knnsearch(kdtreeNS,new_point,'k',1,'Distance','euclidean');
toc
disp('cityblock/manhattan');
tic
idx=knnsearch(kdtreeNS,new_point,'k',1,'Distance','cityblock');
toc