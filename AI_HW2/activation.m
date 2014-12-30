function [ y,dy ] = activation( n )
%Logistic (Log) Sigmoid Activation function and derivative(0 1)
y = 1./(1+exp(-n));
dy = y.*(1-y);
end