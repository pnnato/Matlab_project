%% read image
I = imread('brown_spot_4.jpg');
width = 300;
dim = size(I);
J = imresize(I, [width*dim(1)/dim(2) width], 'bicubic');
%hsv = rgb2hsv(J);

% G = im2bw(J);
% S = edge(G,'sobel');
figure(1),imshow(J), title('Resized Image');
G = rgb2hsv(J) 
Heq = adapthisteq(G(:,:,3));

HSV_mod = G;
HSV_mod(:,:,3) = Heq;

RGB = hsv2rgb(HSV_mod);

figure(6),imshow(RGB), title('HSV Image');

%imtool(I);
%imtool(I, [0 80]);
% J = imsharpen(I, 'Amount', 1.2, 'Threshold', 1);
% figure, imshow(J)
% title('Sharpened Image');

%close(h);

%% using imcontrast
%imshow(I);
%imcontrast;
%h1 = figure;
%imshow('blast-leaf-1.jpg');
%imcontrast(h1);

%% split histeq
% r = J(:,:,1);
% g = J(:,:,2);
% b = J(:,:,3);
% r1 = histeq(r);
% g1 = histeq(g);
% b1 = histeq(b);
% img = cat(3,r1,g1,b1);
% figure(5), imshow(img);

%% using imhist
% figure(2), subplot(1,2,1), imshow(J),subplot(1,2,2),imhist(J,64)
% title('adjust 1');
%H = histeq(img);
% H = imadjust(J);
Jdouble = im2double(J);
figure(2), subplot(1,2,1), imshow(Jdouble),subplot(1,2,2),imhist(Jdouble,64)
title('adjust 1');
figure(7), imhist(Jdouble,64);

figure(3), subplot(1,2,1), imshow(RGB),subplot(1,2,2),imhist(RGB,64)
title('adjust 2');
figure(5), imhist(RGB,64);

%% segment
segment = HSV_function2(RGB);
figure(4), imshow(segment), title('Disease Detected');
hold on;
boundaries = bwboundaries(segment);
numberOfBoundaries = size(boundaries, 1);
for k = 1 : numberOfBoundaries
	thisBoundary = boundaries{k};
	plot(thisBoundary(:,2), thisBoundary(:,1), 'r', 'LineWidth', 2);
end
hold off;

%% empty check
%A = boundaries;
%T = size(A);

%% centroid
% Ibw = im2bw(H);
% imshow(Ibw);

%% 
% Ibw = imfill(Ibw,'holes');
% imshow(Ibw);

%%
% Ilabel = bwlabel(Ibw);
% imshow(Ilabel);

%%
% stat = regionprops('table',Ibw,'centroid','MajorAxisLength', 'MinorAxisLength');
% imshow(I); hold on;
% for x = 1: numel(stat)
%     plot(stat(x).Centroid(1),stat(x).Centroid(2),'ro');
% end