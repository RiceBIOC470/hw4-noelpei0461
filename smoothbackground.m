function smoothbackground(projection)
rad=4;
sigma=2;
fgauss=fspecial('gaussian',rad,sigma);
imsmooth=imfilter(projection,fgauss);
imbg=imopen(imsmooth,strel('disk',200));
imsmbg=imsubtract(imsmooth,imbg);
imshow(imsmbg,[])
imwrite(imsmbg,'imsmbg.tif','tif')
end