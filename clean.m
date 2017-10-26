function clean(I, N)
I=imread(I);
img = imopen(I, strel('disk', N));
imwrite(img,'BW2.tif');
end