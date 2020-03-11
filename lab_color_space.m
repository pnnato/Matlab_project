 %% show image
leaf = imread('C:\Users\Nato\Documents\MATLAB\dataset\bacterialSpot\b1.jpg');
figure(1), imshow(leaf), title('leaf');

%% calculate sample color
load regioncoordinates;

nColors = 4;
sample_regions = false([size(leaf,1) size(leaf,2) size(leaf,3) size(leaf,4) size(leaf,5)]);

for count = 1:nColors
    sample_regions(:,:,count) = roipoly(leaf, region_coordinates(:,1,count),region_coordinates(:,2,count));
end

%imshow(sample_regions(:,:,2)), title('sample region for red');

%% convet RGB to L*a*b image
lab_leaf = rgb2lab(leaf);
a = lab_leaf(:,:,2);
b = lab_leaf(:,:,3);
color_markers = zeros([nColors, 2]);

for count = 1:nColors
    color_markers(count,1) = mean2(a(sample_regions(:,:,count)));
    color_markers(count,2) = mean2(b(sample_regions(:,:,count)));
end

fprintf('[%0.3f, %0.3f] \n', color_markers(2,1), color_markers(2,2));

%% classify each pixel using the nearest neighbor rule
color_labels = 0:nColors-1;

a = double(a);
b = double(b);
distance = zeros([size(a), nColors]);

for count = 1:nColors
    distance(:,:,count) = ( (a - color_markers(count,1)).^2 + (b - color_markers(count,2)).^2 ).^0.5;
end

[~, label] = min(distance,[],3);
label = color_labels(label);
clear distance;

%% display results of nearest neighbor classification
rgb_label = repmat(label,[1 1 3]);
segmented_images = zeros([size(leaf), nColors],'uint8');

for count = 1:nColors
    color = leaf;
    color(rgb_label ~= color_labels(count)) = 0;
    segmented_images(:,:,:,count) = color;
end

figure(2), imshow(segmented_images(:,:,:,1)), title('green object');
figure(3), imshow(segmented_images(:,:,:,2)), title('dark green object');
figure(4), imshow(segmented_images(:,:,:,3)), title('white object');
figure(5), imshow(segmented_images(:,:,:,4)), title('brown object');

%% display 'a*' and 'b*' value
brown = [165/255 42/255 42/255];
dark_green = [0 100/255 0];
plot_labels = {'g',dark_green ,'w', brown};

figure
for count = 1:nColors
    plot(a(label==count-1), b(label==count-1),'.','MarkerEdgeColor', plot_labels{count}, 'MarkerFaceColor', plot_labels{count});
    hold on;
end

title('Scatterplot of the segmented pixels in ''a*b'' space');
xlabel('''a*'' values');
ylabel('''b*'' values');
