function write_image(filename,i)
% Write an image to a raw file

fid=fopen(filename,'w');
mi=max(max(i));
i=floor(i/mi*255.99);
fwrite(fid,i','uchar');
fclose(fid);
