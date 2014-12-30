function [ m ] = mean_data( D )
%Compute mean of the data
sum=[0,0];
for i=1:size(D,1)
    sum(1,1)=sum(1,1)+D(i,1);
    sum(1,2)=sum(1,2)+D(i,2);
end
m(1,1) = sum(1,1)/size(D,1);
m(1,2) = sum(1,2)/size(D,1);
