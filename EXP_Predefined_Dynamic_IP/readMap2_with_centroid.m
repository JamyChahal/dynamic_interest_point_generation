clear all
clc

figure(1)
Im = imread('mapAnodes.png');
Im = rgb2gray(Im);
BW = Im < 100;

s = regionprops(BW, Im, {'Centroid'});
imshow(BW);
hold on 
numObj = numel(s);
xx = [];
yy = [];
for k = 1 : numObj
    plot(s(k).Centroid(1), s(k).Centroid(2), 'r*')
    if s(k).Centroid(1) == 401 && s(k).Centroid(2) == 316
        disp('Detected centered')
    else
        xx = [xx s(k).Centroid(1)];
        yy = [yy s(k).Centroid(2)];
    end

end
hold off 


