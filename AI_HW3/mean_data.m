function [ m ] = mean_data( D )
%Compute mean of the data
s=sum(D);
m=s/size(D,1);
end
