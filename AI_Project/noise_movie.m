clc;
clear all;
close all;   
faceIm = imread('E:\CSE 5524\HW1_pictures\1.jpg');
        for sigma=20:-1.5:0.5
            G = fspecial('gaussian', 2*ceil(3*sigma)+1, sigma);
            plot(G);
%            faceIm=double(imread('E:\CSE 5524\HW1_pictures\1.jpg'));
            gIm =(imfilter(faceIm, G, 'replicate'));
            imwrite(uint8(gIm), 'gIm.bmp');
            imshow('gIm.bmp');
            pause(1);
        end
