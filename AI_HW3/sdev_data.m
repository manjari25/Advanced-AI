function [ s ] = sdev_data( mean, D )
%Compute standard deviation
s=sqrt(sum((D-(ones(size(D,1),1).*mean)).^2))/(size(D,1)-1);
end

