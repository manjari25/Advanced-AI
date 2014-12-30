function [ d_degIm ] = discretize( degIm )
%DISCRETIZE Summary of this function goes here
%   Detailed explanation goes here
    d_degIm = zeros(size(degIm,1),size(degIm,2));
    for i=1:size(degIm,1)
        for j=1:size(degIm,2)
            if(((degIm(i,j)>=0)&&(degIm(i,j)<=22.5))||((degIm(i,j)>157.5)&&(degIm(i,j)<=180))||((degIm(i,j)>-22.5)&&(degIm(i,j)<0))||((degIm(i,j)>=-180)&&(degIm(i,j)<-157.5)))
                d_degIm(i,j)=0;
            elseif(((degIm(i,j)>22.5)&&(degIm(i,j)<=67.5))||((degIm(i,j)>=-157.5)&&(degIm(i,j)<-112.5)))
                d_degIm(i,j)=45;
            elseif(((degIm(i,j)>112.5)&&(degIm(i,j)<=157.5))||((degIm(i,j)>-67.5)&&(degIm(i,j)<=-22.5)))
                d_degIm(i,j)=135;
            elseif(((degIm(i,j)>67.5)&&(degIm(i,j)<=112.5))||((degIm(i,j)>=-112.5)&&(degIm(i,j)<=-67.5)))
                d_degIm(i,j)=90;
            end
        end
    end
end

