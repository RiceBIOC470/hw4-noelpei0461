function ss=f(x)
imgt=rand(1024);
imgt2=im2uint8(imgt);
imshow(imgt,'InitialMagnification','fit')
imwrite(imgt2,'rand8bit.tif','tif')
end
