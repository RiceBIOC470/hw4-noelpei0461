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
imshow(imgt2);
imgt3=im2uint8(imgt2);
imwrite(imgt3,'rand8bit2.tif','tif');
end