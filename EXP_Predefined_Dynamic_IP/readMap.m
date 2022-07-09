clear all
clc

figure(1)
Im = imread('mapAnodes.png');
Im = rgb2gray(Im);

imshow(Im);
xx = [];
yy = [];
while true
    [x, y] = ginput(1);
    xx = [xx; x];
    yy = [yy; y];
    hold on
    plot(xx, yy, 'r+')
end