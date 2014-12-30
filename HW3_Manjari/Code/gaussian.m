function [ G ] = gaussian( x,m,s )
%GAUSSIAN Summary of this function goes here
%   Detailed explanation goes here
G = (1/s*(sqrt(2*pi)))*(exp(-((x-m)^2)/(2*(s^2))));
end

