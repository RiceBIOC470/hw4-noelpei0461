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