file1='nfkb_movie1.tif';
reader=bfGetReader(file1);

nt=reader.getSizeT;
nz=reader.getSizeZ;

MI1=[];
NU1=[];
MI2=[];
NU2=[];
  for tt=1:nt
    Ind=reader.getIndex(0,0,tt-1)+1;
    img_max=bfGetPlane(reader,Ind);
        for zz=1:nz
            Ind=reader.getIndex(zz-1,0,tt-1)+1;
            imgnow=bfGetPlane(reader,Ind);
            img_max=max(img_max,imgnow);
        end
        img_max=im2double(img_max);
    smoothbackground(img_max);%smooth & background for each timepoint
    autobinary('imsmbg.tif');%autobinary mask
    clean('BW.tif',5);
    [number,~,Int]=ffff('imsmbg.tif','BW2.tif');
    NU1=[number,NU1];
    MI1=[Int,MI1];
  end
  %channel 2
  for tt=1:nt
    Ind2=reader.getIndex(0,1,tt-1)+1;
    img_max2=bfGetPlane(reader,Ind2);
        for zz=1:nz
            Ind2=reader.getIndex(zz-1,1,tt-1)+1;
            imgnow2=bfGetPlane(reader,Ind2);
            img_max2=max(img_max2,imgnow2);
        end
        img_max2=im2double(img_max2);
    smoothbackground(img_max2);%smooth & background for each timepoint in channel 2
    autobinary('imsmbg.tif');%autobinary mask
    clean('BW.tif',5);
    [number,~,Int]=ffff('imsmbg.tif','BW2.tif');
    NU2=[number,NU2];
    MI2=[Int,MI2];
  end
%plot for movie 1-cell
plot(1:nt, NU1(1, :), 'b');
hold on;
plot(1:nt, NU2(1, :), 'r');
xlabel('Time');
ylabel('Number of cells in mask');
