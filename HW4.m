%HW4
%% 
% Problem 1. 
%GB comments:
1a 100
1b 100
1c 100
1d 50 No explanation of the results as the question asks. 
2a 75 Avi file does not display a max projection across both channels. Only 1 channel is displayed.  
2b. 70 The output avi only contains the nuclear label. 
3a. 100
3b 100
3c 100
3d 100
3e 100
4a. 100
4b. 100
 Overall = 92



% 1. Write a function to generate an 8-bit image of size 1024x1024 with a random value 
% of the intensity in each pixel. Call your image rand8bit.tif. 
function ss=f(x)
imgt=rand(1024);
imgt2=im2uint8(imgt);
imshow(imgt,'InitialMagnification','fit')
ss=imwrite(imgt2,'rand8bit.tif','tif')
end

f
% 2. Write a function that takes an integer value as input and outputs a
% 1024x1024 binary image mask containing 20 circles of that size in random
% locations
function zz=ff(a)
imgt=rand(1024);
imgt2=imgt>1000;
[xx,yy]=meshgrid(1:1024,1:1024);
imshow(imgt,'InitialMagnification','fit');
hold on;
for i=1:20
    x=randi(1024);
    y=randi(1024);
    for ii=1:numel(a)
        imgt2=imgt2|hypot(xx-x,yy-y)<=a;
    end
end
imshow(imgt2)
zz=imwrite(imgt2,'rand8bit2.tif','tif')
end

ff(21)
% 3. Write a function that takes the image from (1) and the binary mask
% from (2) and returns a vector of mean intensities of each circle (hint: use regionprops).
%
function zz=fff(im1,im2)
img1=imread(im1);
img2=imread(im2);
s=regionprops(img2,img1,'MeanIntensity');
centroids=cat(1,s.MeanIntensity);
zz=centroids;
end
fff('rand8bit.tif','rand8bit2.tif')
% 4. Plot the mean and standard deviation of the values in your output
% vector as a function of circle size. Explain your results. 
function plot1(size)
x=1:size;
a=[];
b=[];
for i=1:size
    f;
    ff(i);
    I=fff('rand8bit.tif','rand8bit2.tif');
    a(i)=mean(I);
    b(i)=std(I);
end
figure;
plot(x,a);
hold on;
plot(x,b);
hold off;
end
%%

%Problem 2. Here is some data showing an NFKB reporter in ovarian cancer
%cells. 
%https://www.dropbox.com/sh/2dnyzq8800npke8/AABoG3TI6v7yTcL_bOnKTzyja?dl=0
%There are two files, each of which have multiple timepoints, z
%slices and channels. One channel marks the cell nuclei and the other
%contains the reporter which moves into the nucleus when the pathway is
%active. 
%
%Part 1. Use Fiji to import both data files, take maximum intensity
%projections in the z direction, concatenate the files, display both
%channels together with appropriate look up tables, and save the result as
%a movie in .avi format. Put comments in this file explaining the commands
%you used and save your .avi file in your repository (low quality ok for
%space). 

%To maximum the Z direction intensity, i did Image-stacks-z-project. And
%then I used Image-stacks-tools-concatenate to concatenate 2 pictures and 2
%channels. The look up table is in the image-color-apply LUT. Then I saved file using save as function and convert the file
%into .avi format.


%Part 2. Perform the same operations as in part 1 but use MATLAB code. You don't
%need to save the result in your repository, just the code that produces
%it. 
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
    for ii=2:nz
        ind=reader.getIndex(ii-1,0,tt-1)+1;
        img_now=bfGetPlane(reader,ind);
        img_max=max(img_max,img_now);
    end
    ind1=reader.getIndex(0,1,tt-1)+1;
    img_max1=bfGetPlane(reader,ind1);
    for ii=2:nz
        ind1=reader.getIndex(ii-1,1,tt-1)+1;
        img_now1=bfGetPlane(reader,ind1);
        img_max1=max(img_max1,img_now1);
    end
    imgshow=cat(3,imadjust(img_max),imadjust(img_max1),zeros(size(img_max)));
    imwrite(imgshow,'myMultipageFile1.tif','WriteMode','append');
    A=im2double(imgshow);
    writeVideo(v,A);
    
end

file1='nfkb_movie2.tif';
reader=bfGetReader(file1);

nt=reader.getSizeT;
nz=reader.getSizeZ;
ind=reader.getIndex(0,0,0)+1;
img_max=bfGetPlane(reader,ind);
for tt=1:nt
    ind=reader.getIndex(0,0,tt-1)+1;
    img_max=bfGetPlane(reader,ind);
    for ii=2:nz
        ind=reader.getIndex(ii-1,0,tt-1)+1;
        img_now=bfGetPlane(reader,ind);
        img_max=max(img_max,img_now);
    end
    ind1=reader.getIndex(0,1,tt-1)+1;
    img_max1=bfGetPlane(reader,ind1);
    for ii=2:nz
        ind1=reader.getIndex(ii-1,1,tt-1)+1;
        img_now1=bfGetPlane(reader,ind1);
        img_max1=max(img_max1,img_now1);
    end
    imgshow=cat(3,imadjust(img_max),imadjust(img_max1),zeros(size(img_max)));
    imwrite(imgshow,'myMultipageFile1.tif','WriteMode','append');
    A=im2double(imgshow);
    writeVideo(v,A);
end
close(v);
%%

% Problem 3. 
% Continue with the data from part 2
% 
% 1. Use your MATLAB code from Problem 2, Part 2  to generate a maximum
% intensity projection image of the first channel of the first time point
% of movie 1. 
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
% 2. Write a function which performs smoothing and background subtraction
% on an image and apply it to the image from (1). Any necessary parameters
% (e.g. smoothing radius) should be inputs to the function. Choose them
% appropriately when calling the function.
function smoothbackground(projection)
rad=4;
sigma=2;
fgauss=fspecial('gaussian',rad,sigma);
imsmooth=imfilter(projection,fgauss);
imbg=imopen(imsmooth,strel('disk',200));
imsmbg=imsubtract(imsmooth,imbg);
imwrite(imsmbg,'imsmbg.tif');
end

smoothbackground(projection);
% 3. Write  a function which automatically determines a threshold  and
% thresholds an image to make a binary mask. Apply this to your output
% image from 2. 

function autobinary(I)
I=imread(I);
level= mean(prctile(I,80)); %determine the threshold
BW=I>level;
imwrite(BW, 'BW.tif');
end

autobinary('imsmbg.tif');
% 4. Write a function that "cleans up" this binary mask - i.e. no small
% dots, or holes in nuclei. It should line up as closely as possible with
% what you perceive to be the nuclei in your image. 
function clean(I, N)
I=imread(I);
img = imopen(I, strel('disk', N));
imwrite(img,'BW2.tif');
end

clean('BW.tif',5);

% 5. Write a function that uses your image from (2) and your mask from 
% (4) to get a. the number of cells in the image. b. the mean area of the
% cells, and c. the mean intensity of the cells in channel 1. 
function [cells, area, intensity] = ffff(img, mask)
a=imread(img);
b=imread(mask);
reader = regionprops(b, a, 'Area', 'MeanIntensity');
a1 = [reader.Area];
int = [reader.MeanIntensity];
cells = length(reader)
area = mean(a1)
intensity = mean(int)
end

ffff('imsmbg.tif','BW2.tif');

cells =

    47


area =

   1.1555e+03


intensity =

   2.4255e+03
% 6. Apply your function from (2) to make a smoothed, background subtracted
% image from channel 2 that corresponds to the image we have been using
% from channel 1 (that is the max intensity projection from the same time point). Apply your
% function from 5 to get the mean intensity of the cells in this channel. 
%%
file1='nfkb_movie1.tif';
reader=bfGetReader(file1);
nz=reader.getSizeZ;
ind=reader.getIndex(0,1,0)+1;
img_max=bfGetPlane(reader,ind);

    for ii=1:nz
        ind=reader.getIndex(ii-1,1,0)+1;
        img_now=bfGetPlane(reader,ind);
        img_max=max(img_max,img_now);
    end
projection1=img_max;
imwrite(projection1, 'projection1.tif');
%projection1 is the picture from channel 2.

smoothbackground(projection1);
%smooth and background
ffff('projection1.tif', 'imsmbg.tif')
%get answers

%cells =

        4776


area =

  219.4273


intensity =

   NaN


ans =

        4776

% Problem 4. 

% 1. Write a loop that calls your functions from Problem 3 to produce binary masks
% for every time point in the two movies. Save a movie of the binary masks.
% 
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
    for ii=1:nz
        ind=reader.getIndex(ii-1,0,tt-1)+1;
        img_now=bfGetPlane(reader,ind);
        img_max=max(img_max,img_now);
    end
    smoothbackground(img_max);%smooth & background for each timepoint
    autobinary('imsmbg.tif');%autobinary mask
    clean('BW.tif',5);
    BW2=imread('BW2.tif');
    imwrite(BW2,'myMultipageFile2.tif','WriteMode','append');
    A=im2double(BW2);
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
    for ii=1:nz
        ind=reader.getIndex(ii-1,0,tt-1)+1;
        img_now=bfGetPlane(reader,ind);
        img_max=max(img_max,img_now);
    end
    smoothbackground(img_max);%smooth & background for each timepoint
    autobinary('imsmbg.tif');%autobinary mask
    clean('BW.tif',5);
    BW2=imread('BW2.tif');
    imwrite(BW2,'myMultipageFile2.tif','WriteMode','append');
    A=im2double(BW2);
    writeVideo(v,A);%write in a movie
end
close(v)

%movie1 is the desired movie.

% 2. Use a loop to call your function from problem 3, part 5 on each one of
% these masks and the corresponding images and 
% get the number of cells and the mean intensities in both
% channels as a function of time. Make plots of these with time on the
% x-axis and either number of cells or intensity on the y-axis. 
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

%movie2
file1='nfkb_movie2.tif';
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
%plot for movie 2-cell
plot(1:nt, NU1(1, :), 'b');
hold on;
plot(1:nt, NU2(1, :), 'r');
xlabel('Time');
ylabel('Number of cells in mask');
