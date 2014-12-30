clc;
clear all;
close all;
data = load ('data/movies_data');
train = data(1:2500,:);
test = data(2501:end,:);
kdtreeNS = KDTreeSearcher(train);
ran = randi(2,276);
new_point = ran(:,1)';
tic
for j=1:276
    if(new_point(1,j)==1)
        new_point(1,j)==0;
    elseif(new_point(1,j)==2)
        new_point(1,j)==1;
    end
end
toc
tic
new_point(new_point==0) = 1;
new_point(new_point==1) = 2;
toc
