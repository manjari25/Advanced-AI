%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 1
clc;
clear all;
close all;
mkdir('Output');
% Define filter length and sigma, rows and columns and names of the images
sigma = 3;
hsize = 2*ceil(3*sigma)+1;
r = [167,186,300];
c = [143,102,150]; 
pics = {'dreese.raw','num.raw','shapes.raw'};
for itr=1:size(pics,2)
    close all;
    %% Load image
    Im = load_image(strcat('given_pics/',pics{1,itr}),r(1,itr),c(1,itr));
    % Display original image
    figure('Name','Original Image','NumberTitle','off'),display_image(Im);
    axis('image');
    colormap('gray');
    %% PART I: Smooth image with 2D filter
    % Define 2D gaussian filter
    G = fspecial('gaussian',hsize,sigma);
%     G = fspecial('gaussian',10,2);
%     G = fspecial('gaussian',19,2);
%     G = fspecial('gaussian',10,3);
%     G = fspecial('gaussian',19,3);
    ImSmooth = imfilter(Im,G,'replicate');
    % Display smoothed image
    figure('Name','Smoothed Image','NumberTitle','off'),display_image(ImSmooth);
    axis('image');
    colormap('gray');
    filename = strcat('Output/smooth_',pics{1,itr},'.jpg');
    print ('-djpeg',filename);
    %% PART II: Implement a vertical line detector
    [Gx,Gy] = gaussDeriv2D(sigma);
    gxIm = imfilter(Im,Gx,'replicate');
    figure('Name','x-gradient','NumberTitle','off'),display_image(gxIm);
    axis('image');
    colormap('gray');
    filename = strcat('Output/xgrad_',pics{1,itr},'.jpg');
    print ('-djpeg',filename);
    %% PART III: Implement a horizontal line detector
    gyIm = imfilter(Im,Gy,'replicate');
    figure('Name','y-gradient','NumberTitle','off'),display_image(gyIm);
    axis('image'); 
    colormap('gray');
    filename = strcat('Output/ygrad_',pics{1,itr},'.jpg');
    print ('-djpeg',filename);
    %% PART IV: Compute the any-orientation edge detection
    magIm = sqrt(gxIm.^2+gyIm.^2);
    degIm = atan2d(gyIm,gxIm);
    d_degIm = discretize(degIm);
    figure('Name','Gradient Magnitude','NumberTitle','off'),display_image(magIm);
    axis('image');
    colormap('gray');
    filename = strcat('Output/gradMag_',pics{1,itr},'.jpg');
    print ('-djpeg',filename);
    %% PART V: Threshold the image
    max_val = max(max(magIm));
    tIm = magIm>(0.3*max_val);
%     tIm = magIm>(0.1*max_val);
%     tIm = magIm>(0.5*max_val);
    figure('Name','Threshold of Gradient Magnitude','NumberTitle','off'),imagesc(tIm);
    axis('image');
    colormap('gray');
    filename = strcat('Output/threshold_',pics{1,itr},'.jpg');
    print ('-djpeg',filename);
    %% Extra Credit 
    % Non-maximal Suppression 
    nmmagIm  = nonMaxSupp(magIm,d_degIm);
    figure('Name','Non-maximal supression','NumberTitle','off'),display_image(nmmagIm);
    axis('image');
    colormap('gray');
    filename = strcat('Output/nonMaxSupp_',pics{1,itr},'.jpg');
    print ('-djpeg',filename);
    % Hystersis Thresholding
    linkedIm = hysteresisT(nmmagIm);
    figure('Name','Hystersis Thresholding','NumberTitle','off'),display_image(linkedIm);
    axis('image');
    colormap('gray');
    filename = strcat('Output/hystersisThreshold_',pics{1,itr},'.jpg');
    print ('-djpeg',filename);
    pause;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% END %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%