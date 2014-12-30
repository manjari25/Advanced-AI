function i=load_image(filename,columns,rows)
% Display an image from a raw file with dimensions columns and rows h1=[1/3,1/3,1/3];

fid=fopen(filename);
i=fread(fid,columns*rows,'uchar');
fclose(fid);
mi=max(max(i));
i=reshape(i,columns,rows)'/mi*64;
