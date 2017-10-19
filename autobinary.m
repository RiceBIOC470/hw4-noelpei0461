function autobinary(I)
level=graythresh(I);
BW=im2bw(I,level);
imshow(BW,[])
end