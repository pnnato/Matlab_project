%% Read image
folder = 'C:\Users\Nato\Desktop\201605\tomato_train4\crop';
outFolder = 'C:\Users\Nato\Desktop\201605\tomato_train4\crop\kmeans_2';
mkdir(outFolder);
filePattern = fullfile(folder,'*.jpg');
srcFiles = dir(filePattern);
numFiles = length(srcFiles);
%figure(1), imshow(img), title('tomato image');
%text(size(img,2),size(img,1)+15, 'Blast Disease on leaf image, Rice Knowledge Bank', 'FontSize',7, 'HorizontalAlignment','right');
if numFiles == 0
    message = sprintf('There are no jpg files in folder:\n%s', folder);
    uiwait(warndlg(message));
else
    fprintf('There are %d files in %s:\n', numFiles, folder);
    for k = 1 : numFiles
        
        s = [srcFiles(k).folder '\' srcFiles(k).name];
        img = imread(s);
        
        %% Convert image from RGB color space to L*a*b Color Space
        cform = makecform('srgb2lab');
        lab_img = applycform(img,cform);

        %% Classify the color in 'a*b*' space using k-means clustering
        ab = double(lab_img(:,:,2:3));
        nrows = size(ab,1);
        ncols = size(ab,2);
        ab = reshape(ab,nrows*ncols,2);

        nColors = 2;
        % repeat the clustering 3 times to avoid local minima
        [cluster_idx, cluster_center] = kmeans(ab, nColors, 'distance', 'sqEuclidean', 'Replicates', 2);

        %% Label every pixel in the image using the results from K-MEANS
        pixel_labels = reshape(cluster_idx, nrows, ncols);
        %figure(2),imshow(pixel_labels,[]), title('image labeled by cluster index');

        %% Create image that segment the disease image by color
        segmented_images = cell(1,4);
        rgb_label = repmat(pixel_labels,[1 1 3]);

        for j = 1:nColors
            color = img;
            color(rgb_label ~= j) = 0;
            segmented_images{j} = color;
        end

        %figure(3), imshow(segmented_images{1}), title('objects in cluster 1');
        %figure(4), imshow(segmented_images{2}), title('objects in cluster 2');
        
        %% Segment only the disease into a separate image
        mean_cluster_value = mean(cluster_center,2);
        [tmp, idx] = sort(mean_cluster_value);
        brown_cluster_num = idx(2); %fruit
        white_cluster_num = idx(1); %background

        L = lab_img(:,:,1); %blue
        brown_idx = find(pixel_labels == brown_cluster_num);
        white_idx = find(pixel_labels == white_cluster_num);
        L_brown = L(brown_idx);
        L_white = L(white_idx);
        is_light_brown = imbinarize(L_brown);
        is_light_white = imbinarize(L_white);

        %use the mark is_light_blue to label which pixel belong to the brown disease
        disease_labels = repmat(uint8(0), [nrows ncols]);
        disease_labels(brown_idx(is_light_brown==false | is_light_brown==true)) = 1;
        disease_labels(white_idx(is_light_white==true)) = 0;
        disease_labels = repmat(disease_labels,[1 1 3]);
        tomato_section = img;
        tomato_section(disease_labels ~= 1) = 1;

        % mark the disease spot
        % r = regionprops(brown_disease,'Eccentricity','Area','BoundingBox');
        % areas = [r=r(1).BoundingBox];

        %figure(7),imshow(brown_disease), title('blast disease');
        %%
        fullFileName = fullfile(outFolder, erase(srcFiles(k).name, '.jpg'));
        fprintf('Read %s files in %d:\n', s, k);
        %saveas(J,[fullFileName '.jpg']);
        imwrite(tomato_section, [fullFileName '.jpg']);
    end
end
