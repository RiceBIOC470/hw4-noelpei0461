file1='nfkb_movie1.tif';
reader=bfGetReader(file1);
a=reader.getSizeZ;
chan=1;
time=1;
zplane=a;
iplane=reader.getIndex(zplane-1,chan-1,time-1)+1;
img1=bfGetPlane(reader,iplane);
imshow(img1,[500,5000]);

file2='nfkb_movie2.tif';
reader=bfGetReader(file2);
a=reader.getSizeZ;
chan=2;
time=1;
zplane=a;
iplane=reader.getIndex(zplane-1,chan-1,time-1)+1;
img2=bfGetPlane(reader,iplane);
imshow(img2,[500,5000]);

img2show=cat(3,imadjust(img1),imadjust(img2),zeros(size(img1)));
imshow=(img2show);