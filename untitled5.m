file1='nfkb_movie1.tif';
reader=bfGetReader(file1);

nt=reader.getSizeT;
nz=reader.getSizeZ;
ind=reader.getIndex(0,0,0)+1;
img_max=bfGetPlane(reader,ind);
v=VideoWriter('movie1.avi','Uncompressed AVI');
open(v);
for tt=1:nt
    ind=reader.getIndex(0,0,tt-1)+1;
    img_max=bfGetPlane(reader,ind);
    smoothbackground(img_max);%smooth & background for each timepoint
    imgshow=autobinary('imsmbg.tif');%autobinary mask
    imwrite(imgshow,'myMultipageFile1.tif','WriteMode','append');
    A=im2double(imgshow);
    writeVideo(v,A);%write in a movie
end

file1='nfkb_movie2.tif';% perform the same code for the second movie
reader=bfGetReader(file1);

nt=reader.getSizeT;
nz=reader.getSizeZ;
ind=reader.getIndex(0,0,0)+1;
img_max=bfGetPlane(reader,ind);
v=VideoWriter('movie1.avi','Uncompressed AVI');
open(v);
for tt=1:nt
    ind=reader.getIndex(0,0,tt-1)+1;
    img_max=bfGetPlane(reader,ind);
    smoothbackground(img_max);%smooth & background for each timepoint
    imgshow=autobinary('imsmbg.tif');%autobinary mask
    imwrite(imgshow,'myMultipageFile1.tif','WriteMode','append');%write in a movie in tif
    A=im2double(imgshow);
    writeVideo(v,A);%write in a movie
end
close(v)