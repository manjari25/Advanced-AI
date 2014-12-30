function [ match ] = evaluate( predicted, actual)
% Returns incorrectly classified instances as percentage
t = abs(predicted-actual);
match = (nnz(t)/size(t,1))*100;
end

