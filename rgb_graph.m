%% read files
folder = 'C:\Users\Nato\Desktop\201605\tomato_train4\kmeans_1';
%outFolder = 'C:\Users\Nato\Desktop\201605\tomato_resize';
%mkdir(outFolder);
filePattern = fullfile(folder,'*.jpg');
srcFiles = dir(filePattern);
numFiles = length(srcFiles);
numData = length(dataReset5Copy)
if numFiles == 0
    message = sprintf('There are no jpg files in folder:\n%s', folder);
    uiwait(warndlg(message));
else
    fprintf('There are %d files in %s:\n', numData, folder);
    catStruct2 = struct([]);
    categoryStruct = struct([]);
    fid =fopen('tomatoset4_0722.csv','w');
    for i = 1 : 1
        %getImage = [srcFiles(i).folder '\' srcFiles(i).name];

        getImage = dataReset5Copy(600).Filename;
        rgbImage = imread(getImage);  % Load image
        hsvImage = rgb2hsv(rgbImage);         % Convert the image to HSV space
        hPlane = 360.*hsvImage(:, :, 1);      % Get the hue plane scaled from 0 to 360

        binEdges = 0:270;                     % Edges of histogram bins
        N = histc(hPlane(:), binEdges);       % Bin the pixel hues from above
        wavelength = 620-(170/270).*(0:269);  % Approximate wavelength
        figure
        hBar = bar(wavelength, N(1:end-1), 'histc');  % Plot the histogram

        set(hBar, 'CData', 270:-1:1, ...    % Change the color of the bars using
            'CDataMapping', 'direct', ...   %   indexed color mapping (360 colors)
            'EdgeColor', 'none');           %   and remove edge coloring
        colormap(hsv(360));                 % Change to an HSV color map with 360 points
        axis([450 620 0 max(N)]);           % Change the axes limits
        set(gca, 'Color', 'w');             % Change the axes background color
        set(gcf, 'Pos', [50 400 560 200]);  % Change the figure size
        xlabel('Wavelength (nm)');          % Add an x label
        ylabel('Bin counts');               % Add a y label 
%%         
        % Green = 0;
        % Breaker = 0;
        % Truning = 0;
        % Ponk = 0;
        % Light_Red = 0;
        % Red = 0;
         [w h] = size(wavelength)
         categories = [0 0 0 0 0 0];
% 
%         %% 
        for k = 1 : h
            if 530 <= wavelength(k) && wavelength(k) < 570
                categories(1) = categories(1) + N(k);
            elseif 570 <= wavelength(k) && wavelength(k) < 580
                categories(2) = categories(2) + N(k);
            elseif 580 <= wavelength(k) && wavelength(k) < 590
                categories(3) = categories(3) + N(k);
            elseif 590 <= wavelength(k) && wavelength(k) < 600
                categories(4) = categories(4) + N(k);
            elseif 600 <= wavelength(k) && wavelength(k) < 610
                categories(5) = categories(5) + N(k);
            elseif 610 <= wavelength(k) && wavelength(k) <= 620
                categories(6) = categories(6) + N(k);
            end
        end
        
        [M index] = max(categories);
        for r =1: 6
            if r == index
                categoryStruct(i).type(r) = 1;
            else
                categoryStruct(i).type(r) = 0;
            end
        end
        catStruct2(i).Filename = getImage;
        catStruct2(i).Wavelength = wavelength;
        catStruct2(i).BinEdges = N(1:270);
        catStruct2(i).No = N(1:270).';
        catStruct2(i).Type = index;
%         fprintf(fid, '%d', catStruct2(i).Type);
%         fprintf(fid, '\t');
%         for j=1:270
%             fprintf(fid, '%d', catStruct2(i).No(j));
%             fprintf(fid, '\t');
%         end
%         fprintf(fid, '\n');
        
    end
    data2clus = struct2table(categoryStruct);
%     fclose(fid);
end
%% count type
% countStruct = [0 0 0 0 0 0];
% dataReset6 = struct([]);
% for count = 1: length(catStruct)
%     if catStruct(count).Type == 6
%         countStruct(1) = countStruct(1) + 1
%         dataReset6(countStruct(1)).Filename = catStruct(count).Filename;
%         dataReset6(countStruct(1)).Wavelength = catStruct(count).Wavelength;
%         dataReset6(countStruct(1)).BinEdges = catStruct(count).BinEdges;
%         dataReset6(countStruct(1)).No = catStruct(count).No;
%         dataReset6(countStruct(1)).Type = catStruct(count).Type;
%     elseif catStruct(count).Type == 2
%         countStruct(2) = countStruct(2) + 1
%     elseif catStruct(count).Type == 3
%         countStruct(3) = countStruct(3) + 1
%     elseif catStruct(count).Type == 4
%         countStruct(4) = countStruct(4) + 1
%     elseif catStruct(count).Type == 5
%         countStruct(5) = countStruct(5) + 1
%     elseif catStruct(count).Type == 6
%         countStruct(6) = countStruct(6) + 1
%     end
% 
% end




%% - Create a message attachment to send with a notification
%   (optional; several message attachments can be sent with a single notification)
% sA = MakeSlackAttachment('New open task [urgent]: <link.to.website>', 'What to harvest today...', ...
%       'Let see what the tomatoes shows today!!', '#ff4500', ...
%       {'Initial Stage', '2 tomato is just set up'}, ...
%       {'Middle Stage', '5 tomatos is growing half-way'}, ...
%       {'Final Stage', 'Let harvest 4 tomatoes todat'});
% 
% % - Send the notification, with the attached message
% SendSlackNotification('https://hooks.slack.com/services/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', ...
%    'IoTomato Growth Monitoring System', '#tomato_growth', ...
%    'Tomato Today', 'http://www.icon.com/url/to/icon/image.png', [], sA);
%% HSV diagram plot
% rgbImage = imread (getImage);
% hsvImage = rgb2hsv(rgbImage);
% 
% hPlane = 360 .* hsvImage(:, :, 1); 
% binEdges = 0:360;
% hFigure = figure();
% N = histc(hPlane(:), binEdges);
% hBar = bar(binEdges(1:end-1), N(1:end-1), 'histc');
% 
% set(hBar, 'CData', 1:360, ...            % Change the color of the bars using
%           'CDataMapping', 'direct', ...  %   indexed color mapping (360 colors)
%           'EdgeColor', 'none');          %   and remove edge coloring
% colormap(hsv(360));                      % Change to an HSV color map with 360 points
% axis([0 360 0 max(N)]);                  % Change the axes limits
% set(gca, 'Color', 'k');                  % Change the axes background color
% set(hFigure, 'Pos', [50 400 560 200]);   % Change the figure size
% xlabel('HSV hue (in degrees)');          % Add an x label
% ylabel('Bin counts');                    % Add a y label
