function clean(I, N)
img_open = imopen(I, strel('disk', N));
end