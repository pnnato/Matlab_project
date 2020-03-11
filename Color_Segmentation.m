%% Read in image
I = imread('C:\Users\Nato\Desktop\201605\tomato_test4\crop2\201605030500_1.jpg');
h1 = figure;
imshow(I);
%imcontrast(h1);

rmat = I(:,:,1);
gmat = I(:,:,2);
bmat = I(:,:,3);

%%Thresholding an image on each of color layer
levelr = 0.63;
levelg = 0.5;
levelb = 0.4;
i1 = im2bw(rmat, levelr);
i2 = im2bw(gmat, levelg);
i3 = im2bw(bmat, levelb);
Isum = (i1&i2&i3);

%figure;
% Plot the data
subplot(2,2,1), imshow(i1);
title('Red Plane');
subplot(2,2,2), imshow(i2);
title('Green Plane');
subplot(2,2,3), imshow(i3);
title('Blue Plane');
subplot(2,2,4), imshow(Isum);
title('Sum of all the planes');

%% Compliment Image and Fill in holes
Icomp = imcomplement(Isum);
Ifilled = imfill(Icomp, 'holes');
figure, imshow(Ifilled);