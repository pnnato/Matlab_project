% loading initial image
init_img = imread('C:\Users\Nato\Desktop\201605\tomato_test4\crop2\201605140530_12.jpg');

% rgb matrixes
r = zeros(256, 1);
g = zeros(256, 1);
b = zeros(256, 1);

%% main loop

for i = 1:size(init_img, 1)
   for j = 1:size(init_img,2)
       pix = init_img(i,j,1:3);

       r(pix(1)+1) = r(pix(1)+1) + 1;
       g(pix(2)+1) = g(pix(2)+1) + 1;
       b(pix(3)+1) = b(pix(3)+1) + 1;
   end
end

%% plot
subplot(2,1,1);
title('histogram using for loops');
hold('on');
bar(r);
bar(g);
bar(b);

%% compare data
subplot(2,1,2);
title('imhist');
hold('on');
imhist(init_img(:,:,1));
imhist(init_img(:,:,2));
imhist(init_img(:,:,3));