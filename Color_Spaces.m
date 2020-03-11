%% Read in image
I = imread('C:\Users\Nato\Desktop\201605\tomato_test4\crop2\201605030500_1.jpg');
imshow(I);

%% RGB Color space
rmat = I(:,:,1);
gmat = I(:,:,2);
bmat = I(:,:,3);

figure;
subplot(2,2,1), imshow(rmat);
title('Red Plane');
%%
subplot(2,2,2), imshow(gmat);
title('Green Plane');
%%
subplot(2,2,3), imshow(bmat);
title('Blue Plane');
%%
subplot(2,2,4), imshow(I);
title('Original Image');