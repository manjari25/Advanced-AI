function [ y ] = binaryActivation( yin )
%BINARYACTIVATION Summary of this function goes here
%   Detailed explanation goes here
y(yin>0)=1;
y(yin<=0)=0;
end

