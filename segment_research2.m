img = imread('tomato_pw.jpg');
figure(1), imshow(img);

%% calculate sample color
load regioncoordinates;

nColors = 4;
sample_regions = false([size(leaf,1) size(leaf,2) size(leaf,3) size(leaf,4) size(leaf,5)]);

for count = 1:nColors
    sample_regions(:,:,count) = roipoly(leaf, region_coordinates(:,1,count),region_coordinates(:,2,count));
end

%%
lab_leaf = rgb2lab(img);
a = lab_leaf(:,:,2);
b = lab_leaf(:,:,3);
color_markers = zeros([nColors, 2]);

for count = 1:nColors
    color_markers(count,1) = mean2(a(sample_regions(:,:,count)));
    color_markers(count,2) = mean2(b(sample_regions(:,:,count)));
end

fprintf('[%0.3f, %0.3f] \n', color_markers(2,1), color_markers(2,2));
figure(2), imshow(lab_leaf)