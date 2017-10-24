function zz=mean(size)
img1=imread('rand8bit.tif');
ff(size);
img2=imread('rand8bit2.tif');
img2=im2uint8(img2);
s=regionprops(img2,img1,'MeanIntensity');
zz=mean(s)
end