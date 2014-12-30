function display_imagefile(filename,columns,rows)
% Display an image from a raw file with dimensions columns and rows 

fid=fopen(filename);
i=fread(fid,columns*rows,'uchar');
fclose(fid);
mi=max(max(i));
i=reshape(i,columns,rows)'/mi*64;
image(i);
colormap(gray);
