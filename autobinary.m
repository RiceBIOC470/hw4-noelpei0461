function autobinary(I)
I=imread(I);
level=graythresh(I);
BW=im2bw(I,level);
imwrite(BW, 'BW.tif');
end