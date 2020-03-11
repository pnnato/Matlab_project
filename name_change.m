for i = 1:height(tomatoDataset)
    %tomatoDataset.imageFilename{i} = replace(tomatoDataset.imageFilename{i}, "resized_dataset", "resized_dataset_grayscale");
    tomatoDataset.imageFilename{i} = erase(tomatoDataset.imageFilename{i}, ".png");
end
