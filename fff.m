function zz=fff(im1,im2)
img1=imread(im1);
img2=imread(im2);
s=regionprops(img2,img1,'MeanIntensity');
centroids=cat(1,s.MeanIntensity);
zz=centroids;
end