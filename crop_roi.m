%% read files
%data = load('trainFruit0707_getresult_0713.mat');
image = trainingData
%folder = image.imageFilename{2:end}
%sprintf(folder);
outFolder = 'C:\Users\Nato\Desktop\201605\tomato_train4\crop';
mkdir(outFolder);
%filePattern = fullfile(folder,'*.jpg');
%srcFiles = dir(filePattern);
numFiles = height(image);
results1 = results;
%%
if numFiles == 0
    message = sprintf('There are no jpg files in folder:\n');
    uiwait(warndlg(message));
else
    fprintf('There are %d files \n', numFiles);
    for k = 1 : numFiles
        %fprintf(' %s\n', srcFiles(k).name);
        %s = [srcFiles(k).folder '\' srcFiles(k).name];
        I = imread(image.imageFilename{k});
        %Im = imread('ngc6543a.jpg'); %load your image
        %image(I)        
        [num_box w] = size(results1.Boxes{k})
        if num_box > 0
            for j = 1: num_box
    %             x_start = results.Boxes{1:1}(j:j,1:1); % start x
    %             x_end  = results.Boxes{1:1}(j:j,2:2); % end x
    %             y_start = results.Boxes{1:1}(j:j,3:3);; % start y
    %             y_end = results.Boxes{1:1}(j:j,4:4); % end x
                Im1 = imcrop(I, results1.Boxes{k}(j:j,1:4));
                %figure, imshow(Im1)
                [pth, name , ext] = fileparts(image.imageFilename{k})
                name = strcat(name, '_', int2str(j))
                fullFileName = fullfile(outFolder, name);
                imwrite(Im1,[fullFileName '.jpg']) % save the croped image
                fprintf('j= %d \n',j);
            end
        
        end
        
    end
end