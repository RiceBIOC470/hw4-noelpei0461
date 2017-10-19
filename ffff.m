function [cells, area, intensity] = ffff(img, mask)
a=imread(img);
b=imread(mask);
reader = regionprops(b, a, 'Area', 'MeanIntensity');
a1 = [reader.Area];
int = [reader.MeanIntensity];
cells = length(data);
area = mean(a1);
intensity = mean(int);
end
