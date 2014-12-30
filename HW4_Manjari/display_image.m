function display_image(im)
% Display an image from a matrix

mi=max(max(im));
i=im/mi*64;
image(i);
colormap(gray);
