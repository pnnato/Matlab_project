%% read files
folder = 'C:\Users\Nato\Desktop\201605\tomato';
outFolder = 'C:\Users\Nato\Desktop\201605\tomato_resize';
mkdir(outFolder);
filePattern = fullfile(folder,'*.jpg');
srcFiles = dir(filePattern);
numFiles = length(srcFiles);
if numFiles == 0
    message = sprintf('There are no jpg files in folder:\n%s', folder);
    uiwait(warndlg(message));
else
    fprintf('There are %d files in %s:\n', numFiles, folder);
    for k = 1 : numFiles
        %fprintf(' %s\n', srcFiles(k).name);
        s = [srcFiles(k).folder '\' srcFiles(k).name];
        I = imread(s);
        %grayscale
        %gray = rgb2gray(I);
        %resizedImage = imresize(img, [320 480]);
%         J = imresize(I, [300 400]);
        width = 400;
        dim = size(I);
        J = imresize(I, [width*dim(1)/dim(2) width], 'bicubic');
        
        %pic = figure; imshow(J);
        
        fullFileName = fullfile(outFolder, erase(srcFiles(k).name, '.jpg'));
        %saveas(J,[fullFileName '.jpg']);
        imwrite(J, [fullFileName '.jpg']);
    end
end