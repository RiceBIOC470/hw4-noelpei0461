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