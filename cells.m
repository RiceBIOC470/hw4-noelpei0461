function [num_cells, mean_area, mean_intensity] = cells(img, mask)
data = regionprops(mask, img, 'Area', 'MeanIntensity');
a = [data.Area];
int = [data.MeanIntensity];
num_cells = length(data);
mean_area = mean(a);
mean_intensity = mean(int);
end