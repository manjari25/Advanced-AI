clc;
clear all;
close all;
load ('w.mat');
load ('b.mat');
% Load data file
te = load('Q2/game_attrdata_test_Q2.txt');
% Seperate out the input and target vectors
x = te(:,1:16);
t = te(:,17:20);
%Testing
for i=1:size(x,1)
   for k=1:size(w,1)
       yin(1,k) = b(1,k) + sum(x(i,:).*w(k,:));
   end
   [~,idx] = max(abs(yin));
   for k=1:size(w,1)
       if(k==idx)
           y(1,k) = 1;
       else
           y(1,k) = 0;
       end
   end
   output(i,:) = y;
end
mismatch = evalute_multi_class(output,t);