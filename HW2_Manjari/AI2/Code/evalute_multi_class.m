function [ mismatch ] = evalute_multi_class( predicted, actual )
%EVALUTE_MULTI_CLASS Summary of this function goes here
%   Detailed explanation goes here
count=0;
t = abs(predicted-actual);
    for i=1:size(t,1)
        if(any(t(i,:)~=0))
            count=count+1;
        end
    end
mismatch = (count/size(t,1))*100;
end

