% clc;    % Clear the command window.  
% workspace;  % Make sure the workspace panel is showing.
% format longg;
% format compact;
% fontSize = 20;
% Read in a standard MATLAB color demo image.
folder = fullfile('C:\Users\Nato\Documents\MATLAB\tomato_0625');
outFolder = 'C:\Users\Nato\Documents\MATLAB\tomato_0625\crop';
%baseFileName = 'peppers.png';
mkdir(outFolder);
filePattern = fullfile(folder,'*.jpg');
srcFiles = dir(filePattern);
numFiles = length(srcFiles);

%% Get the full filename, with path prepended.
%fullFileName = fullfile(folder, srcFiles);
%
for k = 1 : numFiles
    s = [srcFiles(k).folder '\' srcFiles(k).name];
    if ~exist(s, 'file')
        % Didn't find it there.  Check the search path for it.
        
        %fullFileName = baseFileName; % No path this time.
        
        if ~exist(srcFiles(k).name, 'file')
            % Still didn't find it.  Alert user.
            errorMessage = sprintf('Error: %s does not exist.', srcFiles(k).name);
            uiwait(warndlg(errorMessage));
            return;
        end
    end

    rgbImage = imread(s);
    % Get the dimensions of the image.  numberOfColorBands should be = 3.
    [rows columns numberOfColorBands] = size(rgbImage);
    % Display the original color image.
%     subplot(2, 3, 1);
%     imshow(rgbImage, []);
%     title('Original Color Image', 'FontSize', fontSize);
    % Enlarge figure to full screen.
    %set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
    % Get the rows and columns to split at,
    % Taking care to handle odd-size dimensions:
    col1 = 1;
    col2 = floor(columns/2);
    col3 = col2 + 1;
    row1 = 1;
    row2 = floor(rows/2);
    row3 = row2 + 1;
    crop = {1:4}
    % Now crop
    crop{1} = imcrop(rgbImage, [col1 row1 col2 row2]); %upperLeft
    crop{2} = imcrop(rgbImage, [col3 row1 columns - col2 row2]); %upperRight
    crop{3} = imcrop(rgbImage, [col1 row3 col2 row2]); %lowerLeft
    crop{4} = imcrop(rgbImage, [col3 row3 columns - col2 rows - row2]); %lowerRight
    
    for j= 1 : 4
        saveFile = [outFolder '\' erase(srcFiles(k).name, '.jpg')  '_' num2str(j)];
        fullFileName = fullfile(saveFile, erase(srcFiles(k).name, '.jpg'));
%         saveas(crop{j},[fullFileName '.jpg']);
        imwrite(crop{j}, [saveFile '.jpg']);
    end
    
    % Display the images.
%     subplot(2, 3, 2);
%     imshow(upperLeft);
%     subplot(2, 3, 3);
%     imshow(upperRight);
%     subplot(2, 3, 5);
%     imshow(lowerLeft);
%     subplot(2, 3, 6);
%     imshow(lowerRight);
    
end
