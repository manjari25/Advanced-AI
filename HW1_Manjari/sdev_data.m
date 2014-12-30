function [ s ] = sdev_data( mean, D )
%Compute standard deviation
s = [0 0];
for i=1:size(D,1)
    s(1,1) = s(1,1) + ((D(i,1)-mean(1,1))^2);
    s(1,2) = s(1,2) + ((D(i,2)-mean(1,2))^2);
end
s = s./(size(D,1)-1);
s = sqrt(s);
end

