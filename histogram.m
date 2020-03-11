rgb = imread('C:\Users\Nato\Desktop\201605\tomato_test4\crop2\201605030500_1.jpg');
imshow(rgb)
testhist = imhist(rgb);
plot(testhist);
%% histogram of green vs. red
r = rgb(:,:,1);
g = rgb(:,:,2);
b = rgb(:,:,3);
figure(1),histogram2(r,g,'DisplayStyle','tile','ShowEmptyBins','on','XBinLimits',[0 255], 'YBinLimits',[0,255]);
axis equal
colorbar
xlabel('Red Values')
ylabel('Green Values')
title('Green vs. Red Pixel Components')
ax = gca;
ax.CLim = [0 500];

%% histogram of blue vs. red
figure(2),histogram2(r,b,'DisplayStyle','tile','ShowEmptyBins','on','XBinLimits',[0 255], 'YBinLimits',[0,255]);
axis equal
colorbar
xlabel('Red Values')
ylabel('Blue Values')
title('Blue vs. Red Pixel Components')
ax = gca;
ax.CLim = [0 500];

%% histogram of green vs. blue
figure(3),histogram2(g,b,'DisplayStyle','tile','ShowEmptyBins','on','XBinLimits',[0 255], 'YBinLimits',[0,255]);
axis equal
colorbar
xlabel('Green Values')
ylabel('Blue Values')
title('Green vs. Blue Pixel Components')
ax = gca;
ax.CLim = [0 500];

%% display all histogram together
% histogram(r,'BinMethod','integers','FaceColor','r','EdgeAlpha',0,'FaceAlpha',1);
% hold on;
% histogram(g,'BinMethod','integers','FaceColor','g','EdgeAlpha',0,'FaceAlpha',0.7);
% histogram(b,'BinMethod','integers','FaceColor','b','EdgeAlpha',0,'FaceAlpha',0.7);
% xlabel('RGB value');
% ylabel('Frequency');
% title('Color histogram in RGB color space');
% xlim([0 257]);