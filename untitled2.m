file1='nfkb_movie1.tif';
reader=bfGetReader(file1);
nz=reader.getSizeZ;
ind=reader.getIndex(0,0,0)+1;
img_max=bfGetPlane(reader,ind);

    for ii=1:nz
        ind=reader.getIndex(ii-1,0,0)+1;
        img_now=bfGetPlane(reader,ind);
        img_max=max(img_max,img_now);
    end
projection=img_max;

rad=4;
sigma=2;
fgauss=fspecial('gaussian',rad,sigma);
imsmooth=imfilter(projection,fgauss);
imbg=imopen(imsmooth,strel('disk',200));
imsmbg=imsubtract(imsmooth,imbg);
imshow(imsmbg,[])

I=imsmbg;
level=graythresh(I);
BW=imbinarize(I,level);
imshow(BW,[])
