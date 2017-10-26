img1=imread('rand8bit.tif');
img2=imread('rand8bit2.tif');

s=regionprops(img2,img1,'Centroid','MeanIntensity');
centroids=cat(1,s.MeanIntensity)